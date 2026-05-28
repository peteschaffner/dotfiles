-- Tomorrow palette (matches your Ghostty theme), transparent so the terminal
-- background shows through -- no "boxed in" editor rectangle.
--
-- Light/dark tracks the system live: at startup we pick from the macOS
-- appearance, and we ask Ghostty (DEC private mode 2031) to notify us on every
-- theme change. Ghostty answers those notifications with an OSC 11 background
-- report, which we read to flip the colorscheme -- no restart, no polling.
return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000, -- load before everything else
  config = function()
    -- Check the macOS appearance at startup via AppleScript. (`defaults read
    -- -g AppleInterfaceStyle` is cached by cfprefsd and can wrongly report
    -- "does not exist" even in dark mode; osascript reads the live state.
    -- Reading vim.o.background is also unreliable here -- Neovim fills it in
    -- asynchronously from the terminal, so it can still be the default.)
    local function system_is_dark()
      local out = vim.fn.system({
        "osascript", "-e",
        'tell application "System Events" to tell appearance preferences to return dark mode',
      })
      return vim.trim(out) == "true"
    end

    -- Our look on top of base16: transparent backgrounds and a barely-there
    -- split divider. Re-applied on every :colorscheme so the tweaks stick.
    --
    -- We read colors via nvim_get_hl (the resolved, current-theme value) rather
    -- than vim.g.base16_gui* globals -- those globals are stale/nil on the live
    -- light/dark flip, which previously nil-ed out the separator and code bg.
    --
    -- The markdown code background is intentionally NOT set here: render-markdown
    -- links RenderMarkdownCode -> ColorColumn by default, which base16 already
    -- sets per-theme (#282a2e dark / #e0e0e0 light) and flips on its own.
    local function tweak()
      for _, group in ipairs({
        "Normal", "NormalNC",
        "SignColumn", "EndOfBuffer", "MsgArea", "TabLine", "TabLineFill",
        "StatusLine", "StatusLineNC", "WinBar", "WinBarNC",
        "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
      }) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
      -- base16 base02 = muted line color (the bg base16 gives Visual).
      local muted = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = muted, bg = "none" })
      -- Telescope: meld with the terminal background -- every pane uses the
      -- theme bg (opaque, so no buffer bleed-through and no dark inner row from
      -- base16's darker prompt bar), with a muted outline as the only framing
      -- and a de-redded title + prompt icon. base16's selection bar is left as
      -- the one accent inside.
      local termbg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg
      local text = vim.api.nvim_get_hl(0, { name = "Pmenu" }).fg
      for _, g in ipairs({
        "TelescopeNormal", "TelescopePromptNormal",
        "TelescopeResultsNormal", "TelescopePreviewNormal",
      }) do
        vim.api.nvim_set_hl(0, g, { fg = text, bg = termbg })
      end
      for _, g in ipairs({
        "TelescopeBorder", "TelescopePromptBorder",
        "TelescopeResultsBorder", "TelescopePreviewBorder",
      }) do
        vim.api.nvim_set_hl(0, g, { fg = muted, bg = termbg })
      end
      for _, g in ipairs({
        "TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle",
      }) do
        vim.api.nvim_set_hl(0, g, { fg = text, bg = termbg })
      end
      vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = text, bg = termbg })
      -- :colorscheme clears render-markdown's RenderMarkdownCode->ColorColumn
      -- link, and its own reload doesn't restore it. Re-link to ColorColumn
      -- (base16 sets it per-theme), so the code bg always tracks the theme.
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { link = "ColorColumn" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "ColorColumn" })
    end

    -- Re-apply our tweaks AFTER every colorscheme load. We defer with
    -- vim.schedule so this runs last -- after other plugins' ColorScheme
    -- handlers (render-markdown, lualine) that would otherwise clobber our
    -- code-block background and transparent statusline on a live flip.
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.schedule(tweak) end,
    })

    local function apply(dark)
      local want = dark and "base16-tomorrow-night" or "base16-tomorrow"
      -- Compare the loaded scheme name, not vim.o.background: Neovim updates
      -- background from the OSC 11 report before we run, which would make a
      -- background check wrongly think the variant is already correct.
      if vim.g.colors_name == want then return end
      vim.o.background = dark and "dark" or "light"
      vim.cmd.colorscheme(want)
    end

    -- Startup: synchronous, no flash.
    apply(system_is_dark())

    -- Live: Ghostty answers a theme change with an OSC 11 background report
    -- (e.g. `]11;rgb:1d1d/1f1f/2121`). Derive light/dark from its brightness.
    local function osc11_is_dark(seq)
      local r, g, b = seq:match("^\027%]11;rgb:(%x+)/(%x+)/(%x+)")
      if not r then return nil end
      local function hi(h) return tonumber(h:sub(1, 2), 16) or 0 end
      -- perceptual luminance, 0-255
      local lum = 0.299 * hi(r) + 0.587 * hi(g) + 0.114 * hi(b)
      return lum < 128
    end

    vim.api.nvim_create_autocmd("TermResponse", {
      -- nested is essential: this callback calls :colorscheme, and without
      -- nested the resulting ColorScheme event is suppressed (autocmds fired
      -- from inside an autocmd don't run unless nested) -- which silently
      -- skipped all our tweaks on the live flip.
      nested = true,
      callback = function(ev)
        local seq = type(ev.data) == "table" and ev.data.sequence or ev.data
        if type(seq) ~= "string" then return end
        local dark = osc11_is_dark(seq)
        if dark ~= nil then apply(dark) end
      end,
    })

    -- Ask Ghostty to notify us on theme changes (it replies with OSC 11).
    -- Must run after the UI is attached so nvim_ui_send has somewhere to go.
    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = function()
        pcall(vim.api.nvim_ui_send, "\027[?2031h")
      end,
    })
  end,
}

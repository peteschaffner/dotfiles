-- A whisper-thin statusline: no colored blocks, just foreground text on the
-- terminal background. Keeps the calm, un-boxed feel.
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- A fully transparent theme: every section uses the terminal background.
    local transparent = { bg = "none" }
    local mode = { a = transparent, b = transparent, c = transparent,
                   x = transparent, y = transparent, z = transparent }
    local theme = {
      normal = mode, insert = mode, visual = mode,
      replace = mode, command = mode, inactive = mode,
    }
    return {
      options = {
        theme = theme,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } }, -- path relative to cwd
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    }
  end,
}

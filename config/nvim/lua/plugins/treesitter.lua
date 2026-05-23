-- Real, fast syntax highlighting via tree-sitter.
-- Uses the `main` branch, which targets Neovim 0.11+/0.12 (the `master`
-- branch's query predicates are incompatible with 0.12 and break markdown
-- code-block injections).
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").install({
      "markdown", "markdown_inline", -- your primary writing
      "html", "css", "javascript",   -- web
      "swift", "objc", "c", "cpp",   -- apple / native
      "bash",                        -- shell scripts
      "lua", "vim", "vimdoc",        -- editing this config
      "json", "yaml", "toml",        -- config files
    })

    -- On `main`, highlighting isn't automatic: start it per buffer when a
    -- parser exists for the filetype.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

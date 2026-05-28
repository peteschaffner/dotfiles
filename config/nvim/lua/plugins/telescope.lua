-- Fuzzy finding: files, live-grep, buffers. Uses fd + ripgrep under the hood.
-- Visual styling (paper panel, muted outline, de-redded title) lives in
-- colorscheme.lua so it tracks the light/dark theme.
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "   ",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      file_ignore_patterns = { "%.git/", "node_modules/" },
    },
    pickers = {
      find_files = { hidden = true },
    },
  },
}

-- Fuzzy finding: files, live-grep, buffers. Uses fd + ripgrep under the hood.
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = " ",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      file_ignore_patterns = { "%.git/", "node_modules/" },
    },
    pickers = {
      find_files = { hidden = true },
    },
  },
}

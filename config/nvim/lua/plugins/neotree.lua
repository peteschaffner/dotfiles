-- Visual folder tree for navigating your notes structure. Toggle with <leader>e.
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- icons (rendered via Symbols Nerd Font fallback in Ghostty)
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    filesystem = {
      follow_current_file = { enabled = true }, -- reveal the file you're editing
      use_libuv_file_watcher = true,            -- live-refresh on disk changes
      filtered_items = {
        visible = true,        -- show hidden files, just dimmed
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      width = 32,              -- narrow, calm
      mappings = { ["<space>"] = "none" }, -- keep space as leader inside the tree
    },
    default_component_configs = {
      indent = { with_markers = false },       -- cleaner, less line noise
    },
  },
}

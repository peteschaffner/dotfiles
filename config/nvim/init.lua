-- ~/.config/nvim/init.lua
-- A small, calm Neovim that melds into your Ghostty Tomorrow theme.

-- Leader must be set before plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------------------------------------
-- Options
----------------------------------------------------------------------
local opt = vim.opt

opt.termguicolors = true        -- 24-bit color (matched scheme)
opt.number = true               -- line numbers (turned off for markdown, see ftplugin)
opt.mouse = "a"                 -- mouse works in all modes
opt.clipboard = "unnamedplus"   -- share the macOS system clipboard
opt.ignorecase = true           -- case-insensitive search...
opt.smartcase = true            -- ...unless you type a capital
opt.splitright = true           -- vertical splits open to the right
opt.splitbelow = true           -- horizontal splits open below
opt.scrolloff = 6               -- keep some context around the cursor
opt.signcolumn = "yes"          -- avoid text shifting when signs appear
opt.undofile = true             -- persistent undo across sessions
opt.wrap = false                -- no wrap for code (markdown turns it on)
opt.expandtab = true            -- spaces, not tabs
opt.shiftwidth = 2
opt.tabstop = 2
opt.fillchars = { eob = " " }   -- hide the ~ on empty lines (calmer)
opt.shortmess:append("I")       -- skip the intro/splash screen on launch
opt.laststatus = 3              -- one global statusline, no per-split clutter

----------------------------------------------------------------------
-- Bootstrap lazy.nvim
----------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "base16-tomorrow-night" } },
  ui = { border = "rounded" },
  change_detection = { notify = false },
})

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------
local map = vim.keymap.set

-- File tree + fuzzy finding
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Open buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Quality of life
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })

-- Window navigation between splits
map("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

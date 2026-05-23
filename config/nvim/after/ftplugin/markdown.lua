-- Calm prose defaults, applied only to markdown buffers.
local opt = vim.opt_local
opt.wrap = true          -- soft-wrap long lines
opt.linebreak = true     -- wrap at word boundaries, not mid-word
opt.breakindent = true   -- wrapped lines keep their indent
opt.number = false       -- no line numbers while writing
opt.spell = true         -- spell-check prose
opt.spelllang = "en_us"
opt.signcolumn = "no"    -- nothing in the gutter

-- Move by visual lines, so j/k feel natural in wrapped paragraphs.
vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true })
vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true })

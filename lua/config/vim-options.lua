vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

vim.o.linebreak = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- limit auto indent to 2 char spaces and replace tab with 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.smartindent = false
vim.opt.autoindent = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 999
vim.opt.sidescroll = 1
vim.opt.smoothscroll = false

-- Custom keymaps
--- =========================
-- Keymaps
-- =========================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Exit insert mode with kj
keymap("i", "kj", "<Esc>", opts)

keymap("t", "kj", [[<C-\><C-n>]], opts)

-- Close current buffer
keymap("n", "<leader>c", "<cmd>bdelete<cr>", opts)

-- Buffer navigation

keymap("n", "<leader>h", "<cmd>bprevious<cr>", opts)
keymap("n", "<leader>l", "<cmd>bnext<cr>", opts)
keymap("n", "<leader><leader>", "<cmd>b#<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Clear search highlight
keymap("n", "<leader>nh", "<cmd>nohlsearch<cr>", opts)

-- =========================
-- System Clipboard Mappings
-- =========================

-- Yank to system clipboard (normal + visual)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard (normal + visual)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true })

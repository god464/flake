local opt = vim.opt
opt.autowrite = true
opt.backup = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.encoding = "utf-8"
opt.expandtab = true
opt.fileencodings = "utf-8"
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 4
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.undofile = true
opt.virtualedit = "block"

local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "n", "'Nn'[v:searchforward].'zv'")
map("x", "n", "'Nn'[v:searchforward]")
map("o", "n", "'Nn'[v:searchforward]")
map("n", "N", "'nN'[v:searchforward].'zv'")
map("x", "N", "'nN'[v:searchforward]")
map("o", "N", "'nN'[v:searchforward]")

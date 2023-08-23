vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.relativenumber = true
vim.opt.number = true
vim.o.background = "dark"
vim.opt.clipboard = "unnamedplus"

require("hop").setup()
require("Comment").setup()
require("leap").add_default_mappings()
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	context_commentstring = { enable = true },
})
require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("which-key").setup()
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})
require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = {}, -- Adds pretty icons to your documents

		["core.dirman"] = { -- Manages Neorg workspaces
			config = { workspaces = { code = "~/notes/code" } },
		},
		["core.completion"] = { config = { engine = "nvim-cmp" } },
	},
})
vim.cmd([[colorscheme tokyonight]])
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.nil_ls.setup({})
lspconfig.bashls.setup({})
lspconfig.pyright.setup({})
lspconfig.texlab.setup({})
lspconfig.bashls.setup({})
lspconfig.denols.setup({})
lspconfig.clangd.setup({})
lspconfig.jdtls.setup({})
lspconfig.yamlls.setup({
	settings = {
		yaml = { format = { enable = true } },
	},
})
lspconfig.perlnavigator.setup({})
local cmp = require("cmp")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" } }, {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{
			name = "omni",
			option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } },
		},
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				return vim_item
			end,
		}),
	},
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "nvim_lsp_document_symbol" }, { name = "buffer" } },
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
local map = vim.keymap.set
local opt = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocallerleader = " "
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
local trouble = require("trouble")
map("n", "<leader>tx", function()
	trouble.open()
end)
map("n", "<leader>tw", function()
	trouble.open("workspace_diagnostics")
end)
map("n", "<leader>td", function()
	trouble.open("document_diagnostics")
end)
map("n", "<leader>tq", function()
	trouble.open("quickfix")
end)
map("n", "<leader>tl", function()
	trouble.open("loclist")
end)
map("n", "gR", function()
	trouble.open("lsp_references")
end)

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.clang_check,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.statix,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.eslint,
	},
})

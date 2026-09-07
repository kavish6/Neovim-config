return {

	{
		"saghen/blink.cmp",
		version = "1.*",
		lazy = false,
		opts = {
			keymap = {
				preset = "default",

				["<Tab>"] = { "select_next", "fallback" }, -- select next item, fallback if menu closed
				["<S-Tab>"] = { "select_prev", "fallback" }, -- select previous item, fallback if menu closed
				["<CR>"] = { "accept" }, -- confirm selection
			},

			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
			},

			fuzzy = { implementation = "lua" },
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"nvim-telescope/telescope.nvim",
		},

		config = function()
			--------------------------------------------------
			-- LSP Attach (Keymaps + buffer-local config)
			--------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, {
							buffer = event.buf,
							desc = "LSP: " .. desc,
						})
					end

					map("grn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
					map("gr", require("telescope.builtin").lsp_references, "References")
					map("gi", require("telescope.builtin").lsp_implementations, "Implementation")
					map("gd", require("telescope.builtin").lsp_definitions, "Definition")
					map("gD", vim.lsp.buf.declaration, "Declaration")
					map("go", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
					map("gh", vim.lsp.buf.hover, "Hover")
				end,
			})

			--------------------------------------------------
			-- Capabilities (blink.cmp)
			--------------------------------------------------
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			--------------------------------------------------
			-- LSP Servers
			-- (mason-lspconfig v2 dropped `handlers`; per-server config is
			-- now set via vim.lsp.config and enabled automatically via
			-- mason-lspconfig's automatic_enable)
			--------------------------------------------------
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			vim.lsp.config("ts_ls", {
				-- default ~4GB V8 heap OOM-crashes (SIGABRT) tsserver on large
				-- projects (e.g. orca/tarpon, 6000+ ts files), which silently
				-- breaks go-to-definition/references
				init_options = {
					maxTsServerMemory = 12288,
				},
			})

			local mason_tools = { "lua_ls", "typescript-language-server", "python-lsp-server" }

			--------------------------------------------------
			-- Mason Tool Installer
			--------------------------------------------------
			require("mason-tool-installer").setup({
				ensure_installed = mason_tools,
			})

			--------------------------------------------------
			-- Mason LSP Setup
			--------------------------------------------------
			require("mason-lspconfig").setup({
				automatic_enable = {
					exclude = { "harper_ls" },
				},
			})
		end,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
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
				map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
				map("K", vim.lsp.buf.hover, "Hover")
			end,
		})

		--------------------------------------------------
		-- Capabilities (blink.cmp)
		--------------------------------------------------
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		--------------------------------------------------
		-- LSP Servers
		--------------------------------------------------
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
			tsgo = {},
		}

		--------------------------------------------------
		-- Mason Tool Installer
		--------------------------------------------------
		require("mason-tool-installer").setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		--------------------------------------------------
		-- Mason LSP Setup
		--------------------------------------------------
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

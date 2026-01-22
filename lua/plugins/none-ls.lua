return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim", -- Extra sources
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			sources = {
				-- Formatters
				formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown",
						"markdown.mdx",
						"graphql",
						"handlebars",
					},
					-- Only use prettier if project has config file
					prefer_local = "node_modules/.bin",
				}),

				formatting.stylua, -- Lua formatting

				-- Linters/Diagnostics (optional)
				-- diagnostics.eslint_d, -- Fast ESLint
				-- require("none-ls.diagnostics.eslint_d"), -- Or from none-ls-extras
			},

			-- Format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(c)
									-- Only use null-ls for formatting
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
	keys = {
		{ "<leader>cf", vim.lsp.buf.format, desc = "Format buffer" },
	},
}

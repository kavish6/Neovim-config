return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Languages you actively use
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>v",
					node_incremental = "<leader>v",
					scope_incremental = "<leader>V",
					node_decremental = "<leader>b",
				},
			},

			fold = {
				enable = true,
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			-- Folding powered by Tree-sitter
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99
		end,
	},
}

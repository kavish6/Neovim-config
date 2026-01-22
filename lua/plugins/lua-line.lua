return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional but recommended
	},
	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		},

		sections = {
			lualine_a = { { "mode", icon = "" } },
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{ "filename", path = 1 },
			},

			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
				},
				"encoding",
				"fileformat",
				"filetype",
			},

			lualine_y = { "progress" },
			lualine_z = { "location" },
		},

		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},

		extensions = {
			"lazy",
			"mason",
			"quickfix",
			"fugitive",
			"nvim-tree",
			"toggleterm",
		},
	},
}

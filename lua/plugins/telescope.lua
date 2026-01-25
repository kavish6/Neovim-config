return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.95,
					height = 0.9,
					horizontal = {
						preview_width = 0.55,
					},
					vertical = {
						preview_width = 0.55,
					},
				},
				path_display = { "smart" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		},
		lazy = false,
		keys = {
			{ "<leader>/", false },
			{ "<leader>f", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Live grep)" },
			{ "<leader>ff", "<cmd>Telescope find_files <cr>", desc = "Find Files" },
			{
				"<leader>fp",
				function()
					-- Get git root
					local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
					if not git_root or git_root == "" then
						vim.notify("Not in a git repository", vim.log.levels.WARN)
						return
					end
					-- Find playground directory from git root
					local result = vim.fn.systemlist(
						"fd -t d -d 5 -E node_modules -E .git -E dist -E build '^playground-scripts$' " .. git_root
					)
					if #result > 0 and result[1] ~= "" then
						vim.notify("path:" .. result[1])
						require("telescope.builtin").find_files({
							cwd = result[1],
							hidden = true,
							no_ignore = true,
						})
					else
						vim.notify("Playground directory not found in project", vim.log.levels.WARN)
					end
				end,
				desc = "Find in Playground",
			},
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
		},
		config = function(_, opts)
			local actions = require("telescope.actions")

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				mappings = {
					i = {
						["<C-x>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
						["q"] = actions.close, -- Optional: if you prefer 'q' to close
					},
				},
			})
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
		end,
	},
}

local themes = {
	-- rose-pine variants
	{
		name = "rose-pine-main",
		loader = function()
			require("rose-pine").setup({ variant = "main" })
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		name = "rose-pine-moon",
		loader = function()
			require("rose-pine").setup({ variant = "moon" })
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		name = "rose-pine-dawn",
		loader = function()
			require("rose-pine").setup({ variant = "dawn" })
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- onedark styles
	{
		name = "onedark-dark",
		loader = function()
			require("onedark").setup({ style = "dark" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-darker",
		loader = function()
			require("onedark").setup({ style = "darker" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-cool",
		loader = function()
			require("onedark").setup({ style = "cool" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-deep",
		loader = function()
			require("onedark").setup({ style = "deep" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-warm",
		loader = function()
			require("onedark").setup({ style = "warm" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-warmer",
		loader = function()
			require("onedark").setup({ style = "warmer" })
			require("onedark").load()
		end,
	},
	{
		name = "onedark-light",
		loader = function()
			require("onedark").setup({ style = "light" })
			require("onedark").load()
		end,
	},
}

local function apply_theme(theme)
	local ok, err = pcall(theme.loader)
	if ok then
		vim.notify("Theme: " .. theme.name)
	else
		vim.notify("Failed to load " .. theme.name .. ": " .. err, vim.log.levels.ERROR)
	end
end

local function pick_theme()
	local has_telescope, pickers = pcall(require, "telescope.pickers")
	if not has_telescope then
		-- fallback: built-in vim.ui.select picker, no dependency needed
		vim.ui.select(themes, {
			prompt = "Select colorscheme",
			format_item = function(t)
				return t.name
			end,
		}, function(choice)
			if choice then
				apply_theme(choice)
			end
		end)
		return
	end

	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local previewers = require("telescope.previewers")

	pickers
		.new({}, {
			prompt_title = "Colorschemes",
			finder = finders.new_table({
				results = themes,
				entry_maker = function(theme)
					return {
						value = theme,
						display = theme.name,
						ordinal = theme.name,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			-- live preview as you move through the list
			previewer = previewers.new_buffer_previewer({
				title = "Preview",
				define_preview = function(self, entry)
					apply_theme(entry.value)
					local lines = { "Previewing: " .. entry.value.name }
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
				end,
			}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					local entry = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if entry then
						apply_theme(entry.value)
					end
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>ts", pick_theme, { desc = "Pick colorscheme (Telescope)" })

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({ variant = "main" })
		end,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "cool" })
		end,
	},
}

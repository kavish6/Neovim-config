return {
	"navarasu/onedark.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("onedark").setup({
			style = "darker",
		})
		require("onedark").load()

		local styles = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }
		local current = 1

		vim.keymap.set("n", "<leader>ts", function()
			current = current % #styles + 1
			require("onedark").setup({ style = styles[current] })
			require("onedark").load()
			print("Theme style:", styles[current])
		end, { desc = "Toggle OneDark style" })
	end,
}

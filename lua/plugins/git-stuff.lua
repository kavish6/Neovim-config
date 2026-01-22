return {
    {"tpope/vim-fugitive",
    event = "VeryLazy", -- Load on demand instead of immediately
    lazy = false,
    keys = {
      { "<leader>gg",  "<cmd>G<CR>",          desc = "Git status" },
      { "<leader>gb",  "<cmd>Git blame<CR>",  desc = "Git blame" },
      { "<leader>gl",  "<cmd>Gclog<CR>",      desc = "Git log" },
      { "<leader>gd",  "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gp",  "<cmd>Git push<CR>",   desc = "Git push" },
      { "<leader>gP",  "<cmd>Git pull<CR>",   desc = "Git pull" },
      { "<leader>gc",  "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gw",  "<cmd>Gwrite<CR>",     desc = "Git add current file" },
      { "<leader>gcl", "<cmd>G log<CR>",      desc = "Git log of this file" },
    }
    },
{
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      delete       = { text = '' },
      topdelete    = { text = '' },
      changedelete = { text = '▎' },
      untracked    = { text = '▎' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
  },
  keys = {
    -- Navigation
    { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
    { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk" },
    
    -- Actions
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk", mode = { "n", "v" } },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk", mode = { "n", "v" } },
    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gb", function() require('gitsigns').blame_line({full=true}) end, desc = "Blame line" },
    
    -- Toggles
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame" },
    { "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle deleted" },
    
    -- Text object
    { "ih", ":<C-U>Gitsigns select_hunk<CR>", desc = "Select hunk", mode = { "o", "x" } },
  },
}
  }

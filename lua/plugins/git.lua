return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				-- current_line_blame = true,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
        keys = {
            { "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Git open diffview panel" },
        },
        opts = function()
            -- dofile(vim.g.base46_cache .. "diffview")
            return {
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                        disable_diagnostics = true,
                        diff_binaries = false,
                    },
                },
                key_bindings = {
                    view = { q = "<cmd>DiffviewClose<CR>" },
                    file_panel = { q = "<cmd>DiffviewClose<CR>" },
                    file_history_panel = { q = "<cmd>DiffviewClose<CR>" },
                },
                hooks = {
                    -- Change local options in diff buffers
                    diff_buf_read = function()
                        vim.opt_local.wrap = false
                        vim.opt_local.list = false
                        vim.opt_local.colorcolumn = { 80 }
                    end,
                },
            }
        end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"ibhagwan/fzf-lua", -- optional
		},
		keys = {
			{ "<leader>go", ":Neogit cwd=%:p:h<CR>",               desc = "Uses the repository of the current file" },
			{ "<leader>gc", ":Neogit commit<CR>",                  desc = "Uses the repository of the current file" },
			{ "<leader>gs", ":Neogit cwd=%:p:h kind=floating<CR>", desc = "Uses the repository of the current file" },
			{ "<leader>gg", ":Neogit<CR>",                         desc = "Uses the repository of the current file" },
		},
		config = function()
			local neogit = require "neogit"
			neogit.setup({
				auto_show_console = false,
				disable_commit_confirmation = true,
				console_timeout = 10000,
			})
		end,
	}
}

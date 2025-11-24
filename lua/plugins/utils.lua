return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		config = true,
	},
	{
		"smjonas/inc-rename.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",

		event = "BufReadPre",
		config = function()
			require('nvim-ts-autotag').setup({
				opts = {

					enable_close = false,
					enable_rename = true,
					enable_close_on_slash = true
				},

			})
		end

	},
	{
		"folke/which-key.nvim",
		event = "BufReadPre",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		cmd = "RestoreSession",
		opts = {
		},
		init = function()
			vim.api.nvim_create_user_command("RestoreSession", function()
				require("persistence").load()
			end, {})
		end,
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({
			})
		end
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				display = {
					progress_ttl = 15,
				},
				lsp = {
					progress_ringbuf_size = 512,
				},
			},
			notification = {
				window = { winblend = 0 },
			},
		},
	},
	{
		"jake-stewart/multicursor.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local mc = require("multicursor-nvim")
			local map = vim.keymap.set
			mc.setup()

			map({ "n", "v" }, "<C-M-j>", function() mc.lineAddCursor(1) end)
			map({ "n", "v" }, "<C-M-k>", function() mc.lineAddCursor(-1) end)
			map({ "n", "v" }, "<C-M-n>", function() mc.matchAddCursor(1) end)
			map({ "n", "v" }, "<C-M-p>", function() mc.matchAddCursor(-1) end)
			map({ "n", "v" }, "<C-M-x>", mc.deleteCursor)
			map("n", "<C-M-i>", mc.alignCursors)
			map("n", "<C-M-leftmouse>", mc.handleMouse)
			map("n", "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					vim.cmd("noh")
					vim.lsp.buf.clear_references()
				end
			end)
		end,
	},
	{
		'mcauley-penney/visual-whitespace.nvim',
		config = true,
		event = "ModeChanged *:[vV\22]",
		opts = {},
	}
}

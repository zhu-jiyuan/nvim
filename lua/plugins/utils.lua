return {
	{
		"saghen/blink.pairs",
		version = "*",
		event = { "BufReadPost", "BufNewFile", "InsertEnter" },
		dependencies = "saghen/blink.lib",
		build = function()
			require("blink.pairs").download():pwait(60000)
		end,
		---@module 'blink.pairs'
		---@type blink.pairs.Config
		opts = {
			mappings = { enabled = true, cmdline = true },
			highlights = {
				enabled = true,
				groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
				matchparen = { enabled = true },
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufReadPre",
		opts = {
			opts = {
				enable_close = false,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/persistence.nvim",
		-- Session saving only starts once an actual file was opened.
		event = "BufReadPre",
		cmd = "RestoreSession",
		opts = {},
		init = function()
			vim.api.nvim_create_user_command("RestoreSession", function()
				require("persistence").load()
			end, {})
		end,
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").select()
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
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				ignore_empty_message = true,
				display = {
					render_limit = 3,
					done_ttl = 2,
					done_icon = "✓",
					done_style = "Comment",
					progress_icon = { pattern = "dots_pulse", period = 1 },
					progress_style = "WarningMsg",
					group_style = "Title",
					icon_style = "Question",
					format_message = function(msg)
						local message = msg.message or ""
						if msg.percentage ~= nil then
							message = string.format("%s (%.0f%%)", message, msg.percentage)
						end
						return message
					end,
				},
				lsp = {
					progress_ringbuf_size = 512,
				},
			},
			notification = {
				window = {
					winblend = 0,
					border = "rounded",
					x_padding = 1,
					y_padding = 0,
					align = "bottom",
					relative = "win",
				},
			},
		},
	},
	{
		"jake-stewart/multicursor.nvim",
		event = { "BufReadPost", "BufNewFile" },
		-- stylua: ignore
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
				else -- fallback to clear highlights
					vim.cmd("noh")
					vim.lsp.buf.clear_references()
				end
			end)
		end,
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		event = "ModeChanged *:[vV\22]",
		opts = {},
	},
}

return {
	-- cmp pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- dependencies = { "hrsh7th/nvim-cmp" },
		opts = {}, -- this is equalent to setup({}) function
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

					enable_close = false, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				--[[ per_filetype = {
            ["html"] = {
              enable_close = false
            }
          } ]]

			})
		end

	},
	-- tip key
	{
		"folke/which-key.nvim",
		event = "BufReadPre",
		-- event = "VimEnter",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		cmd = "RestoreSession",
		opts = {
			-- add any custom options here
			--
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
	-- {
	-- 	"LunarVim/bigfile.nvim",
	-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- },
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
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
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
		'mcauley-penney/visual-whitespace.nvim',
		config = true,
		event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
		opts = {},
	}
	-- {
	--     "nosduco/remote-sshfs.nvim",
	--     dependencies = "nvim-telescope/telescope.nvim",
	--     cmd = { "RemoteSSHFSConnect" },
	--     opts = {},
	-- },


	-- install without yarn or npm
	-- web markdown preview.
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	build = function() vim.fn["mkdp#util#install"]() end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>mp",
	-- 			ft = "markdown",
	-- 			"<cmd>MarkdownPreviewToggle<cr>",
	-- 			desc = "Markdown Preview",
	-- 		},
	-- 	},
	-- }

	-- nvim 0.10 is support this plugin.
	-- {
	--     'numToStr/Comment.nvim',
	--     opts = {
	--         -- add any options here
	--     },
	--     lazy = false,
	-- }
}

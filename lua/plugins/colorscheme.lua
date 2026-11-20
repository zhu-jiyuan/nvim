return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.background = "light"
			require("everforest").setup({
				background = "soft",
				transparent_background_level = 2,
				-- Floats are cards on Ghostty's notebook paper: a neutral fill a shade darker than the paper, which
				-- also stops the ruled lines inside them, a blue pencil frame, and the completion pick highlighted.
				on_highlights = function(hl, palette)
					local card, pencil = "#ebe8df", "#8ea4c6"
					hl.NormalFloat = { fg = palette.fg, bg = card }
					hl.FloatBorder = { fg = pencil, bg = card }
					hl.FloatTitle = { fg = palette.fg, bg = card, bold = true }
					hl.Pmenu = { fg = palette.fg, bg = card }
					hl.PmenuSbar = { bg = card }
					hl.PmenuThumb = { bg = pencil }
					hl.PmenuSel = { fg = palette.fg, bg = "#f8eba6", bold = true }
					hl.BlinkCmpMenuBorder = { link = "FloatBorder" }
					hl.BlinkCmpDocBorder = { link = "FloatBorder" }
					hl.BlinkCmpSignatureHelpBorder = { link = "FloatBorder" }
					hl.BlinkCmpDocSeparator = { link = "FloatBorder" }
				end,
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
	-- winbar breadcrumbs
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}

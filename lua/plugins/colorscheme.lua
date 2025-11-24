return {
    {
        "ellisonleao/gruvbox.nvim",
		enable = false,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "",
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
            vim.cmd("colorscheme gruvbox")
        end,
        opts = ...,
    },

    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
		enable = true,
        priority = 1000,
        config = function()
            vim.opt.background = "light"
            require("everforest").setup({
				background = "soft",

            })
            vim.cmd([[colorscheme everforest]])
        end,
    },
	{
		"oonamo/ef-themes.nvim",
		enable = false,
        priority = 1000,
		 config = function ()
			require("ef-themes").setup({
				light = "ef-summer",
				dark = "ef-winter",
				transparent = false,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = {},
					variables = {},
					classes = { bold = true },
					types = { bold = true },

					diagnostic = "default",
					pickers = "default",
				},

				modules = {
					blink = true,
					fzf = true,
					mini = true,
					semantic_tokens = false,
					snacks = false,
					treesitter = true,
				},

				options = {
					compile = true,
					compile_path = vim.fn.stdpath("cache") .. "/ef-themes",
				},
			})

            vim.opt.background = "light"
			vim.cmd.colorscheme("ef-theme")
		end
	},
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        event = "BufReadPost",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        opts = {},
    }
}

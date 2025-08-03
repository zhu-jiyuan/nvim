return {
    -- theme
    {
        "ellisonleao/gruvbox.nvim",
        -- priority = 1000,
		enable = false,
		-- lazy = false,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
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
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
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
        priority = 1000, -- make sure to load this before all the other start plugins
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            vim.opt.background = "light"
            require("everforest").setup({
                -- Your config here
				background = "soft",

            })
            vim.cmd([[colorscheme everforest]])
        end,
    },
	{
		"oonamo/ef-themes.nvim",
		-- lazy = false, 
		enable = false,
        priority = 1000, -- make sure to load this before all the other start plugins
		 config = function ()
			require("ef-themes").setup({
				light = "ef-summer", -- Ef-theme to select for light backgrounds
				dark = "ef-winter", -- Ef-theme to select for dark backgrounds
				transparent = false,
				styles = {
					-- Set specific styles for specific highlight groups
					-- Can be any valid attr-list value. See `:h nvim_set_hl`
					comments = { italic = true },
					keywords = { bold = true },
					functions = {},
					variables = {},
					classes = { bold = true },
					types = { bold = true },

					diagnostic = "default", -- Can be "full"
					pickers = "default", -- Can be "borderless"
				},

				modules = {
					-- Enable/Disable highlights for a module
					-- See `h: ef-themes-modules` for the list of available modules
					blink = true,
					fzf = true,
					mini = true,
					semantic_tokens = false,
					snacks = false,
					treesitter = true,
				},

				--- Override any color from the ef-theme
				---@param colors Ef-Theme
				---@param name string
				-- on_colors = function(colors, name) end,

				--- Override specific highlights
				---@param highlights table
				---@param colors Ef-Theme
				---@param name string
				---@return table
				-- on_highlights = function(highlights, colors, name)
				-- 	-- Returns a table of highlights
				-- 	-- return {
				-- 	--   Normal = { fg = colors.fg_alt, bg = colors.bg_inactive }
				-- 	--   ObscurePlugin = { fg = colors.yellow_faint }
				-- 	-- }
				-- end,

				options = {
					compile = true, -- Whether to compile a theme
					compile_path = vim.fn.stdpath("cache") .. "/ef-themes", -- Directory in which to place compiled themes
				},
			})

            vim.opt.background = "light"
			vim.cmd.colorscheme("ef-theme") -- To use the default colorscheme defined above
			-- Or choose a specific theme
			-- vim.cmd.colorscheme("ef-dream")
		end
	},
    -- top line
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        -- event = "VeryLazy",
        event = "BufReadPost",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },
    -- blanklins
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        -- event = "VeryLazy",
        opts = {},
        --     config = function()
        --         local highlight = {
        --             "RainbowRed",
        --             "RainbowYellow",
        --             "RainbowBlue",
        --             "RainbowOrange",
        --             "RainbowGreen",
        --             "RainbowViolet",
        --             "RainbowCyan",
        --         }
        --
        --         local hooks = require "ibl.hooks"
        --         -- create the highlight groups in the highlight setup hook, so they are reset
        --         -- every time the colorscheme changes
        --         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        --             vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        --             vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        --             vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        --             vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        --             vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        --             vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        --             vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        --         end)
        --
        --         require("ibl").setup { indent = { highlight = highlight } }
        --     end
        -- },
    }
}

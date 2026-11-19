return {
    -- theme
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
				transparent_background_level = 2,
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

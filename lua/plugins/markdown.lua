-- return {
-- 	{
-- 		"OXY2DEV/markview.nvim",
-- 		lazy = true, -- Recommended
-- 		ft = "markdown", -- If you decide to lazy-load anyway
--
-- 		dependencies = {
-- 			"nvim-treesitter/nvim-treesitter",
-- 			"nvim-tree/nvim-web-devicons"
-- 		}
-- 	}
-- }
return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		ft={ 'markdown' },
		opts = {
			completions = { lsp = { enabled = true } },
		},
	}
}

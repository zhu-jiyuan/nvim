return {
	{ "tpope/vim-dadbod"},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DB", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		init = function()
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			vim.g.db_ui_execute_on_save = 0
		end,
	},

	-- SQL 语法高亮/补全增强（可选）
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod" },
		ft = { "sql", "mysql", "plsql" },
	},
}

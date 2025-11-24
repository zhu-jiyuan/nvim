return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true,
		keys = function()
			local function exec_cmd_in_cur_cwd()
				local dir = vim.fn.expand("%:p:h")
				local user_cmd = vim.fn.input("Run in " .. dir .. " > ")
				require("toggleterm").exec(user_cmd, nil, nil, dir)
			end
			return {
				{ "<leader>rt", exec_cmd_in_cur_cwd, mode = { "n", "t" }, desc = "Terminal" },
			}
		end,
	}
}

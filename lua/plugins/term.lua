return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		keys = function()
			local function exec_cmd_in_cur_cwd() -- 当前文件所在目录
				local dir = vim.fn.expand("%:p:h")
				-- 弹出命令输入框
				local user_cmd = vim.fn.input("Run in " .. dir .. " > ")
				if user_cmd == "" then
					return
				end
				require("toggleterm").exec(user_cmd, nil, nil, dir)
			end
			return {
				{ "<leader>rt", exec_cmd_in_cur_cwd, desc = "Terminal" },
			}
		end,
	},
}

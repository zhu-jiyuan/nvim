local M = {}

function M.change_window_wrap()
	vim.wo.wrap = not vim.wo.wrap
end

function M.sudo_save_cur_file()
	local file = vim.fn.expand("%:p")
	local cmd = string.format("w !sudo tee %s > /dev/null", file)
	vim.cmd(cmd)
    vim.cmd('edit!')

end

return M

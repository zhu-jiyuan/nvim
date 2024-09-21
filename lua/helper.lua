local M = {}

function M.change_window_wrap()
    vim.wo.wrap = not vim.wo.wrap
end


return M

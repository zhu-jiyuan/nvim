local runners = {
	lua = { "lua" },
	python = { "uv", "run" },
	go = { "go", "run" },
	typescript = { "bun", "run" },
	javascript = { "bun", "run" },
	typescriptreact = { "bun", "run" },
	javascriptreact = { "bun", "run" },
	rust = { "cargo", "run" },
}

local filetypes = vim.tbl_keys(runners)

return {
	name = "run file",
	builder = function()
		local ft = vim.bo.filetype
		local cmd = runners[ft]
		local file = vim.fn.expand("%:p")
		if ft ~= "rust" then
			cmd = vim.list_extend(vim.deepcopy(cmd), { file })
		end
		return {
			cmd = cmd,
			cwd = vim.fn.expand("%:p:h"),
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = filetypes,
	},
}

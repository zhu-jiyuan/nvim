-- A templates/ directory only means helm inside a chart; elsewhere (ansible, jinja) keep the default filetype.
local function helm_in_chart(path)
	if vim.fs.root(path, "Chart.yaml") then
		return "helm"
	end
end

vim.filetype.add({
	pattern = {
		[".*/templates/.*%.yaml"] = helm_in_chart,
		[".*/templates/.*%.yml"] = helm_in_chart,
		[".*/templates/.*%.tpl"] = helm_in_chart,
		["helmfile%.yaml"] = "helm",
		[".*/helmfile%.yaml"] = "helm",
		[".*/helmfile%.d/.*%.yaml"] = "helm",
	},
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	-- Location-list commands (lgrep, lvimgrep, ...) fire this event too.
	pattern = "[^l]*",
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		local lsp = require("lsp_setting")
		lsp.lsp_on_attach(nil, bufnr)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/foldingRange", bufnr) then
			for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
				vim.wo[win][0].foldmethod = "expr"
				vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter-based features for supported filetypes",
	callback = function(args)
		local bufnr = args.buf
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if not (lang and vim.treesitter.language.add(lang)) then
			return
		end
		vim.treesitter.start(bufnr, lang)
		if vim.treesitter.query.get(lang, "folds") then
			for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
				vim.wo[win][0].foldmethod = "expr"
				vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end
		end
		-- Without an indents query the treesitter indentexpr returns -1 and would only mask the ftplugin's own.
		if vim.treesitter.query.get(lang, "indents") then
			vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- JS/TS projects indent with 2 spaces.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function(args)
		vim.bo[args.buf].tabstop = 2
		vim.bo[args.buf].softtabstop = 2
		vim.bo[args.buf].shiftwidth = 2
		vim.bo[args.buf].expandtab = true
	end,
})

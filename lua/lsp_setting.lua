local ensure_installed_list = {
	"lua_ls",

	"zuban",
	"zls",
	"ruff",

	"gopls",
	"clangd",
	"tsc",
	"rust_analyzer",

	-- web dev
	"eslint",
	"cssls",
	"html",
	"postgres_lsp",

	-- config
	"yamlls",
	"jsonls",
	"protols",
	"tailwindcss",
	"helm_ls",
}

local lsp_on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Same keys as Neovim's built-in LSP maps (grr, gra, gri, grt, gO), with fzf-lua as the picker.
	-- grn (rename) and grx (codelens) stay built-in.
	local fzf_lua = require("fzf-lua")
	nmap("gd", fzf_lua.lsp_definitions, "Definition")
	nmap("grr", fzf_lua.lsp_references, "References")
	nmap("gri", fzf_lua.lsp_implementations, "Implementation")
	nmap("grt", fzf_lua.lsp_typedefs, "Type definition")
	nmap("gO", fzf_lua.lsp_document_symbols, "Document symbols")
	vim.keymap.set({ "n", "x" }, "gra", fzf_lua.lsp_code_actions, { buffer = bufnr, desc = "LSP: Code action" })
	nmap("<leader>ws", fzf_lua.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("<leader>K", function()
		vim.lsp.buf.hover()
	end, "Hover Documentation")

	nmap("<leader>h", vim.lsp.buf.signature_help, "Signature Documentation")
	vim.keymap.set("i", "<C-H>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
end

return {
	ensure_installed_list = ensure_installed_list,
	lsp_on_attach = lsp_on_attach,
}

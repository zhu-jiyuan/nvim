local ensure_installed_list = {
	"lua_ls",

	"basedpyright",
	"gopls",
	"clangd",
	"ts_ls",
	"rust_analyzer",

	"eslint",
	"cssls",
	"html",

	"sqlls",

	"yamlls",
	"jsonls",
	"protols",
	"tailwindcss",
}

local lsp_on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", function()
		vim.lsp.buf.rename()
	end, "Rename")

	local fzf_lua = require("fzf-lua")
	nmap("<leader>ca", function()
		fzf_lua.lsp_code_actions()
	end, "Code Action")
	nmap("gd", fzf_lua.lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", fzf_lua.lsp_references, "[G]oto [R]eferences")
	nmap("gI", fzf_lua.lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>pd", fzf_lua.lsp_typedefs, "Type [D]efinition")
	nmap("<leader>ds", fzf_lua.lsp_document_symbols, "[D]ocument [S]ymbols")
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

	nmap("<leader>M", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, "Format current buffer")

	nmap("<leader>da", fzf_lua.lsp_workspace_diagnostics, "lsp diagnosticls")
end

return {
	ensure_installed_list = ensure_installed_list,
	lsp_on_attach = lsp_on_attach,
}

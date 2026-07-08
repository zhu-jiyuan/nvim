local helper = require "helper"

-- sudo save current file
vim.api.nvim_create_user_command("SudoSave", helper.sudo_save_cur_file, {})

-- install every LSP server declared in lsp_setting.ensure_installed_list via mason
vim.api.nvim_create_user_command("InstallEnsureLsp", function()
	local servers = require("lsp_setting").ensure_installed_list
	local registry = require("mason-registry")
	local map = require("mason-lspconfig").get_mappings().lspconfig_to_package

	registry.refresh(function()
		local triggered, present, unresolved = {}, {}, {}
		for _, server in ipairs(servers) do
			local pkg = map[server] or server
			if not registry.has_package(pkg) then
				table.insert(unresolved, server)
			elseif registry.is_installed(pkg) then
				table.insert(present, pkg)
			else
				registry.get_package(pkg):install()
				table.insert(triggered, pkg)
			end
		end

		local lines = {
			("Installing %d, already installed %d"):format(#triggered, #present),
		}
		if #triggered > 0 then
			table.insert(lines, "→ " .. table.concat(triggered, ", "))
		end
		if #unresolved > 0 then
			table.insert(lines, "skipped (no mason package): " .. table.concat(unresolved, ", "))
		end
		vim.schedule(function()
			vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "InstallEnsureLsp" })
		end)
	end)
end, { desc = "Install all LSP servers from lsp_setting.ensure_installed_list via mason" })

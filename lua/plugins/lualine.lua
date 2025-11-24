local lazy_status = require("lazy.status")
local custom = require("custom")


local function modified()
	if vim.bo.modified then
		return " "
	else
		return "󰄳 "
	end
end

local function readonly()
	if vim.bo.readonly then
		return " "
	else
		return ""
	end
end

local function recording()
	local reg = vim.fn.reg_recording()
	if reg ~= "" then
		return "recording @" .. reg
	end
	reg = vim.fn.reg_recorded()
	if reg ~= "" then
		return "recorded @" .. reg
	end

	return ""
end

local function get_lsp_text()
	local clients = vim.lsp.get_clients()
	local buf = vim.api.nvim_get_current_buf()
	clients = vim.iter(clients)
		:filter(function(client)
			return client.attached_buffers[buf]
		end)
		:filter(function(client)
			return client.name ~= "copilot"
		end)
		:map(function(client)
			return client.name
		end)
		:totable()
	local info = table.concat(clients, ", ")

	return info
end

local function get_copilot()
	local client = vim.lsp.get_clients({ name = "copilot" })[1]
	if not client then
		return " "
	end
	return " "
end


local opts = {
	options = {
		icons_enabled = true,
		disabled_filetypes = {
			"alpha",
			"TelescopePrompt",
			"mason",
		},
		always_divide_middle = true,
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				modified,
				separator = { left = "", right = "" },
				padding = { left = 1, right = 0 },
			},
			{
				"mode",
				separator = { left = "", right = "" },
				padding = { left = 0, right = 0 },
			},
		},
		lualine_b = {
			{
				"branch",
				icon = "",
			},
		},
		lualine_c = {
			{
				"filetype",
				colored = true,
				icon_only = true,
				icon = { align = "left" },
				padding = { left = 1, right = 0 },
			},
			{
				'filename',
				file_status = false,
				path = 1,

				shorting_target = 40,
			},
			{
				"diagnostics"
			},
			readonly,
		},
		lualine_x = {
			{
				"diff",
				symbols = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			},
			{
				lazy_status.updates,
				cond = lazy_status.has_updates,
				color = { fg = "#ff9e64" },
			},
			recording,
			{
				get_lsp_text,
				"lsp_status",
				icon = ' LSP:',
				color = { fg = '#fff9e64', gui = 'bold' },
			},
			{
				get_copilot,
				"copilot_status",
				icon = ' Copilot:',
				color = { fg = '#ff9e64', gui = 'bold' },
			},
		},
		lualine_y = {
			{
				"encoding",
				right_padding = 2,
			},
		},
		lualine_z = {
			{
				"location",
				padding = 0,
			},
			{
				function()
					local cursorcol = vim.fn.virtcol(".")
					if cursorcol >= 10 then
						return " · "
					else
						return "· "
					end
				end,
				padding = 0,
			},
			{
				"progress",
				icon = { "󰇽", align = "left" },
				padding = { left = 0, right = 2 },
			},
		},
	},
	extensions = {
		"oil",
		"man",
		"quickfix",
		"neo-tree",
		"symbols-outline",
		"mason",
		"lazy",
		"trouble",
		"toggleterm",
		"fzf",
	},
}
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 0
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		require("lualine").setup(opts)
	end,
}

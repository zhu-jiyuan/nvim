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
	local names = vim.iter(clients)
		:filter(function(client)
			return client.attached_buffers[buf]
		end)
		:map(function(client)
			return client.name
		end)
		:totable()
	-- Copilot is treated as just another LSP client name (e.g. "lua_ls, copilot").
	-- If copilot is attached globally but not to this buffer (rare), still surface it.
	if not vim.tbl_contains(names, "copilot") then
		if vim.lsp.get_clients({ name = "copilot" })[1] then
			table.insert(names, "copilot")
		end
	end
	return table.concat(names, ", ")
end

-- The directory whose VCS info the statusline should reflect.
-- For oil buffers this is the directory oil is currently displaying;
-- otherwise it falls back to the working directory. Critical for oil:
-- oil keeps the same buffer name prefix while the displayed directory changes
-- as you navigate, so cwd alone never reflects the path you're browsing.
local function context_dir()
	if vim.bo.filetype == "oil" then
		local ok, oil = pcall(require, "oil")
		if ok then
			local dir = oil.get_current_dir()
			if dir and dir ~= "" then
				return dir
			end
		end
	end
	return vim.fn.getcwd()
end

-- jj (jujutsu) detection and status. Cached per-dir so that navigating in
-- oil into a different repo (or out of one) re-fetches.
local jj_root_cache = {}
local function is_jj_repo()
	local dir = context_dir()
	if jj_root_cache[dir] == nil then
		jj_root_cache[dir] = (vim.fn.finddir(".jj", dir .. ";") ~= "")
	end
	return jj_root_cache[dir]
end

-- Split id (bookmark/change_id) and desc so they can be colored separately in
-- the statusline. One subprocess per cache miss; output is "<id>\t<desc>".
local jj_status_cache = {}
local function jj_fetch()
	local dir = context_dir()
	local now = os.time()
	local entry = jj_status_cache[dir]
	if entry and now - entry.time < 2 then
		return entry
	end
	local result = vim.system({
		"jj",
		"--no-pager",
		"log",
		"--no-graph",
		"-r",
		"@",
		"-T",
		[[if(bookmarks, bookmarks.map(|b| b.name()).join(",") ++ " ", "") ++ change_id.shortest(8) ++ "\t" ++ if(description, description.first_line(), "")]],
	}, { cwd = dir, text = true }):wait()
	local id, desc = "", ""
	if result.code == 0 then
		local out = result.stdout or ""
		-- Trim trailing newline only; do NOT use vim.trim because it would
		-- swallow the trailing tab when description is empty and we'd lose
		-- the separator.
		out = out:gsub("\n$", "")
		local sep = out:find("\t", 1, true)
		if sep then
			id = out:sub(1, sep - 1)
			desc = out:sub(sep + 1)
		else
			id = out
		end
	end
	entry = { id = id, desc = desc, time = now }
	jj_status_cache[dir] = entry
	return entry
end

local function jj_id()
	return jj_fetch().id
end

local function jj_desc()
	return jj_fetch().desc
end

-- Custom git branch resolver that respects context_dir() (oil-aware).
-- Lualine's built-in `branch` component reads gitsigns' buffer var, which is
-- not set on oil buffers, so it would be empty there.
local git_root_cache = {}
local function is_git_repo()
	local dir = context_dir()
	if git_root_cache[dir] == nil then
		git_root_cache[dir] = (vim.fn.finddir(".git", dir .. ";") ~= "")
			or (vim.fn.findfile(".git", dir .. ";") ~= "")
	end
	return git_root_cache[dir]
end

local git_branch_cache = {}
local function git_branch()
	local dir = context_dir()
	local now = os.time()
	local entry = git_branch_cache[dir]
	if entry and now - entry.time < 2 then
		return entry.value
	end
	local result = vim.system({
		"git", "-C", dir, "branch", "--show-current",
	}, { text = true }):wait()
	local value = ""
	if result.code == 0 then
		value = vim.trim(result.stdout or "")
	end
	git_branch_cache[dir] = { value = value, time = now }
	return value
end

local function get_copilot()
	local client = vim.lsp.get_clients({ name = "copilot" })[1]
	if not client then
		return " "
	end
	return " "
end

-- local bufline = {
--     lualine_a = {
--         {
--             "buffers",
--             cond = function()
--                 return vim.bo.filetype ~= "alpha"
--             end,
--             mode = 2,
--             section_separators = { left = "", right = "" },
--             use_mode_colors = true,
--             filetype_names = {
--                 TelescopePrompt = " Telescope",
--                 fzf = " FZF",
--                 alpha = "󰏘 Alpha",
--                 minifiles = " Mini.Files",
--                 toggleterm = "ToggleTerm",
--                 checkhealth = "󰄳 Checkhelth",
--                 oil = " Oil",
--                 Outline = "󰇽 Outline",
--                 lazy = "󰜢 Lazy",
--                 Mundo = " Mundo",
--                 MundoDiff = " MundoDiff",
--                 CompetiTest = " CompetiTest",
--                 lspinfo = " LspInfo",
--             },
--             symbols = {
--                 modified = " ●",
--                 alternate_file = "",
--                 directory = "󰉋",
--             },
--         },
--     },
--     lualine_z = {},
-- }

local opts = {
	options = {
		icons_enabled = true,
		-- theme = "everforest",
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
				separator = { left = "", right = "" },
				padding = { left = 0, right = 0 },
			},
			{
				"mode",
				separator = { left = "", right = "" },
				padding = { left = 0, right = 0 },
			},
		},
		lualine_b = {
			{
				git_branch,
				icon = "",
				cond = function()
					return is_git_repo() and not is_jj_repo()
				end,
			},
			{
				jj_id,
				cond = is_jj_repo,
				-- jj's official logo (a jellyfish-like creature) isn't a
				-- Nerd Font glyph; closest visual approximation is U+1FABC.
				icon = "\240\159\170\188",
				color = { gui = "bold" },
			},
			{
				jj_desc,
				cond = function()
					return is_jj_repo() and jj_desc() ~= ""
				end,
				color = { fg = "#928374", gui = "italic" },
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
				file_status = false, -- Displays file status (readonly status, modified status)
				path = 1,            -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				-- 4: Filename and parent dir, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
			},
			{
				"diagnostics"
				-- symbols = {
				-- 	error = custom.symbol.error,
				-- 	warn = custom.symbol.warn,
				-- 	info = custom.symbol.info,
				-- 	hint = custom.symbol.hint,
				-- },
			},
			readonly,
		},
		lualine_x = {
			{
				"diff",
				cond = function()
					return not is_jj_repo()
				end,
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
				separator = { right = "" },
				icon = { "󰇽", align = "left" },
				padding = { left = 0, right = 2 },
			},
		},
	},
	-- tabline = bufline,
	extensions = {
		-- "oil" intentionally omitted: we want the default statusline (with
		-- branch / jj / diff) to render in oil buffers too.
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
		-- { "ofseed/copilot-status.nvim" },
	},
	config = function()
		require("lualine").setup(opts)
	end,
}

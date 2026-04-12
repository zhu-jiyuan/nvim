local function run_custom_cmd()
	vim.ui.input({ prompt = "Shell command: " }, function(cmd)
		if cmd and cmd ~= "" then
			require("overseer").new_task({
				name = cmd,
				cmd = cmd,
				cwd = vim.fn.expand("%:p:h"),
			}):start()
		end
	end)
end

local function run_history()
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ unique = true })
	if #tasks == 0 then
		vim.notify("No task history", vim.log.levels.INFO)
		return
	end

	local items = {}
	for _, task in ipairs(tasks) do
		table.insert(items, task.name)
	end

	require("fzf-lua").fzf_exec(items, {
		prompt = "Task History> ",
		actions = {
			["default"] = function(selected)
				for _, task in ipairs(tasks) do
					if task.name == selected[1] then
						task:restart()
						return
					end
				end
			end,
		},
	})
end

return {
	"stevearc/overseer.nvim",
	keys = {
		{ "<leader>ri", "<cmd>OverseerRun<CR>", desc = "Run Task" },
		{ "<leader>ro", "<cmd>OverseerToggle<CR>", desc = "Toggle Overseer" },
		{ "<leader>rc", run_custom_cmd, desc = "Run Custom Command" },
		{ "<leader>rh", run_history, desc = "Run History (fzf)" },
	},
	opts = {
		strategy = "toggleterm",
		task_list = {
			direction = "bottom",
		},
		default_template_prompt = "never",
	},
}

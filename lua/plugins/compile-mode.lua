return {
	"zhu-jiyuan/compile-mode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	keys = {
		{ "<leader>x", "<cmd>Compile<cr>", desc = "Compile" },
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {
			input_word_completion = true,

		}
	end
}

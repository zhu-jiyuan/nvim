return {
	{
		"Saecki/crates.nvim",
		categories = { "lang", "rust" },
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				cmp = { enabled = true },
			},
		},
	}
}

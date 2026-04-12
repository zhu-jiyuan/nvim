return {
	filetypes = { "helm" },
	root_markers = { "Chart.yaml" },
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
}

return {
	settings = {
		yaml = {
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemas = {
				kubernetes = { "k8s/**/*.yaml", "k8s/**/*.yml" },
				["https://raw.githubusercontent.com/argoproj/argo-cd/master/assets/schemas/application.json"] = {
					"argocd/**/application*.yaml",
					"argocd/**/app-*.yaml",
				},
				["https://json.schemastore.org/helmfile.json"] = {
					"helmfile.d/**/*.yaml",
				},
			},
			validate = true,
			completion = true,
			hover = true,
			keyOrdering = false,
		},
	},
}

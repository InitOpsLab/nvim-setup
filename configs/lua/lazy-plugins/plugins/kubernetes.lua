-- ~/.config/nvim/lua/lazy-plugins/plugins/kubernetes.lua

return {
	-- Cluster interaction: logs, exec, describe, port-forward, resource tree, etc.
	{
		"Ramilito/kubectl.nvim",
		cmd = "Kubectl", -- loads only when you use :Kubectl
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local k8s_config = require("config.kubernetes")
			k8s_config.setup_kubectl()
		end,
	},

	-- YAML/CRD schema/hover info for Kubernetes resources
	{
		"diogo464/kubernetes.nvim",
		ft = { "yaml", "yml" }, -- only loads for YAML
		config = function()
			local k8s_config = require("config.kubernetes")
			k8s_config.setup_kubernetes()
		end,
	},
}

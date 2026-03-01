-- ~/.config/nvim/lua/config/licensed.lua
--
-- Toggle plugins that require a paid license or subscription.
-- Set to `true` to enable, `false` to disable.
--
-- After changing these values, restart Neovim and run :Lazy sync.

return {
	copilot = false, -- GitHub Copilot (requires subscription)
	sidekick = false, -- Sidekick.nvim / Claude CLI (requires Anthropic subscription)
	jira = false, -- Jira integration (requires Jira credentials)
}

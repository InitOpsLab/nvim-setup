-- ~/.config/nvim/lua/config/init.lua

local function safe_require(module)
	local ok, err = pcall(require, module)
	if not ok then
		vim.notify("Failed to load module: " .. module .. "\n" .. err, vim.log.levels.WARN)
	end
end

safe_require("options")
safe_require("config.toggleterm")
safe_require("config.harpoon")
safe_require("config.schemastore")
safe_require("config.markdown")
safe_require("config.treesitter")
safe_require("config.folds")
safe_require("config.filetypes")
safe_require("config.sops")
safe_require("config.ruby")
safe_require("config.conform")
safe_require("config.dap")

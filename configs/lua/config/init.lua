-- ~/.config/nvim/lua/config/init.lua

local function safe_require(module)
	local ok, err = pcall(require, module)
	if not ok and not err:match("module '%S+' not found") then
		vim.notify("Failed to load module: " .. module .. "\n" .. err, vim.log.levels.WARN)
	end
end

-- Dynamically load every lua/config/*.lua file EXCEPT init.lua
-- Note: options.lua is already loaded by init.lua before plugins
local config_dir = vim.fn.stdpath("config") .. "/lua/config"
local files = vim.fn.glob(config_dir .. "/*.lua", false, true)

for _, file in ipairs(files) do
	local name = vim.fn.fnamemodify(file, ":t:r") -- filename without extension

	-- Skip configs that are loaded by their respective plugins
	local plugin_loaded = { init = true, go = true, sidekick = true, copilot = true, kubernetes = true }
	if not plugin_loaded[name] then
		safe_require("config." .. name)
	end
end

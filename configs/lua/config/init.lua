-- ~/.config/nvim/lua/config/init.lua

local function safe_require(module)
	local ok, err = pcall(require, module)
	if not ok and not err:match("module '%S+' not found") then
		vim.notify("Failed to load module: " .. module .. "\n" .. err, vim.log.levels.WARN)
	end
end

-- 1) Load core options first (if you use lua/options.lua)
safe_require("options")

-- 2) Dynamically load every lua/config/*.lua file EXCEPT init.lua
local config_dir = vim.fn.stdpath("config") .. "/lua/config"
local files = vim.fn.glob(config_dir .. "/*.lua", false, true)

for _, file in ipairs(files) do
	local name = vim.fn.fnamemodify(file, ":t:r") -- filename without extension

	-- Skip this file itself (init.lua)
	if name ~= "init" then
		safe_require("config." .. name)
	end
end

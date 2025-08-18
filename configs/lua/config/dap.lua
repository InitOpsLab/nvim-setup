local dap = require("dap")

-- Signs like VS Code gutter icons
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignHint" })

-- Auto-load .vscode/launch.json
local ok_vscode, vscode = pcall(require, "dap.ext.vscode")
if ok_vscode then
	vscode.load_launchjs(nil, {
		["pwa-node"] = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		["python"] = { "python" },
		["codelldb"] = { "c", "cpp", "rust" },
		["delve"] = { "go" },
		["bashdb"] = { "sh", "bash" },
		["osv"] = { "lua" },
	})
end

-- UI auto open/close
local ok_dapui, dapui = pcall(require, "dapui")
if ok_dapui then
	dapui.setup({})
	dap.listeners.after.event_initialized["dapui"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui"] = function()
		dapui.close({})
	end
end

-- Keymaps (VS Code style)
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end, { desc = "DAP Continue" })
vim.keymap.set("n", "<F9>", function()
	dap.toggle_breakpoint()
end, { desc = "DAP Breakpoint" })
vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<S-F11>", function()
	dap.step_out()
end, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle({})
end, { desc = "DAP UI" })

-- Load language configs
pcall(require, "config.dap-langs")

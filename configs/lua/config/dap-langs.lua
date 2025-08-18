local dap = require("dap")

-- Python (debugpy)
local mason = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
dap.adapters.python = { type = "executable", command = mason, args = { "-m", "debugpy.adapter" } }
dap.configurations.python = {
	{ type = "python", request = "launch", name = "Launch file", program = "${file}", console = "integratedTerminal" },
}

-- Node/TS (vscode-js-debug)
for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch current file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			console = "integratedTerminal",
		},
	}
end

-- Go (delve)
dap.adapters.go = function(callback, _)
	local port = 38697
	vim.loop.spawn("dlv", { args = { "dap", "-l", "127.0.0.1:" .. port }, detached = true }, function() end)
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end
dap.configurations.go = { { type = "go", name = "Debug", request = "launch", program = "${file}" } }

-- C/C++/Rust (codelldb)
local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
dap.adapters.codelldb =
	{ type = "server", port = "${port}", executable = { command = codelldb, args = { "--port", "${port}" } } }
for _, lang in ipairs({ "c", "cpp", "rust" }) do
	dap.configurations[lang] = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
	}
end

-- Bash (bash-debug-adapter)
dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}
dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${fileDirname}",
		pathBash = "/bin/bash",
	},
}

-- Lua (Neovim plugins) via OSV
local ok_osv, _ = pcall(require, "osv")
if ok_osv then
	dap.adapters.nlua = function(cb, _)
		cb({ type = "server", host = "127.0.0.1", port = 8086 })
	end
	dap.configurations.lua =
		{ { type = "nlua", request = "attach", name = "Attach to running Neovim", host = "127.0.0.1", port = 8086 } }
end

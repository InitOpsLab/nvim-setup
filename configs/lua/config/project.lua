-- ~/.config/nvim/lua/config/project.lua
-- Native project root detection using LSP or filesystem patterns

local patterns = {
	".git",
	"go.mod",
	"go.work",
	"Makefile",
	"package.json",
	"pyproject.toml",
	"main.tf",
	"terraform.tf",
}

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Auto-detect and change to project root (LSP or fs-based)",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local name = vim.api.nvim_buf_get_name(buf)
		if name == "" then
			return
		end

		-- Prefer LSP root if available
		local clients = vim.lsp.get_clients({ bufnr = buf })
		if clients and #clients > 0 then
			local root_dir = clients[1].config.root_dir
			if root_dir and vim.fn.getcwd() ~= root_dir then
				vim.cmd("silent lcd " .. root_dir)
				return
			end
		end

		-- Fallback: find project root by file pattern
		local found = vim.fs.find(patterns, { upward = true, path = name })[1]
		if found then
			local root = vim.fs.dirname(found)
			if root and vim.fn.getcwd() ~= root then
				vim.cmd("silent lcd " .. root)
			end
		end
	end,
})

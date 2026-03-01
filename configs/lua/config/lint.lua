-- ~/.config/nvim/lua/config/lint.lua

local lint = require("lint")

lint.linters_by_ft = {
	bash = { "shellcheck" },
	sh = { "shellcheck" },
	dockerfile = { "hadolint" },
	terraform = { "tflint" },
	hcl = { "tflint" },
	yaml = { "yamllint" },
	python = { "ruff" },
	go = { "golangcilint" },
	ruby = { "rubocop" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
	callback = function()
		if vim.opt_local.modifiable:get() then
			lint.try_lint()
		end
	end,
})

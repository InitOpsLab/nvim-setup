-- ~/.config/nvim/lua/config/sidekick.lua
-- Sidekick (Claude / AI CLI) configuration tuned for a Mac laptop

local ok, sidekick = pcall(require, "sidekick")
if not ok then
	return
end

sidekick.setup({
	-- NES = Next Edit Suggestions (Copilot LSP). Disabled for now.
	nes = {
		enabled = false,
	},

	cli = {
		-- Reload buffers when the AI CLI edits files on disk
		watch = true,

		-- Use tmux/zellij for persistent sessions if available
		mux = {
			enabled = true,
			backend = "tmux", -- change to "zellij" if you prefer
		},

		-- Claude is built-in as "claude" (expects a `claude` CLI in $PATH)
		-- tools = {
		--   claude = {
		--     command = { "claude" },
		--   },
		-- },
	},
})

-- ---------------------------------------------------------------------------
-- Keymaps (Mac-friendly, centered around <leader>m)
-- ---------------------------------------------------------------------------

local cli = require("sidekick.cli")

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
	})
end

-- Global AI CLI toggle (works in normal / insert / visual / terminal)
-- Still handy even on Mac; Control is easy to reach with left pinky.
map({ "n", "t", "i", "x" }, "<C-.>", function()
	cli.toggle()
end, "AI: Toggle CLI")

-- NOTE: We avoid <leader>a… because Harpoon uses <leader>a to mark files.
-- Mac-friendly group prefix: <leader>m (Space + m)

-- Open / toggle current AI CLI (whatever tool is active)
map("n", "<leader>mm", function()
	cli.toggle()
end, "AI: Toggle CLI")

-- Claude-specific toggle (requires `claude` CLI in $PATH)
map("n", "<leader>mc", function()
	cli.toggle({
		name = "claude",
		focus = true, -- focus the Claude terminal
	})
end, "AI: Claude")

-- Select AI tool (Claude, Gemini, Copilot CLI, etc.)
map("n", "<leader>ms", function()
	cli.select()
end, "AI: Select tool")

-- Send “this” (context-aware chunk around cursor)
map({ "n", "x" }, "<leader>mt", function()
	cli.send({ msg = "{this}" })
end, "AI: Send 'this'")

-- Send current file
map("n", "<leader>mf", function()
	cli.send({ msg = "{file}" })
end, "AI: Send file")

-- Send visual selection
map("x", "<leader>mv", function()
	cli.send({ msg = "{selection}" })
end, "AI: Send visual selection")

-- Prompt picker (explain, fix, tests, etc.)
map({ "n", "x" }, "<leader>mp", function()
	cli.prompt()
end, "AI: Prompt picker")

-- Optional NES mapping if/when you enable Copilot LSP:
-- map("n", "<Tab>", function()
--   require("sidekick").nes_jump_or_apply()
-- end, "Sidekick NES: Jump / Apply")

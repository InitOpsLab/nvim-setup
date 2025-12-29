-- Jira integration for Neovim
-- Place in: ~/.config/nvim/lua/config/jira.lua
--
-- Commands:
--   :Jira submit    - Submit current buffer to Jira
--   :Jira new       - Create new ticket template
--   :Jira my        - Show my open issues
--   :Jira open      - Open issue under cursor in browser
--   :Jira view      - View issue under cursor
--   :Jira setup     - Configure credentials

local M = {}

M.opts = {
  -- Path to jira CLI (auto-detected)
  cli_path = nil,
  
  -- Config directory
  config_dir = vim.fn.expand("~/.jira"),
  
  -- Terminal direction: "float", "horizontal", "vertical"
  terminal_direction = "float",
  
  -- Float window size (percentage)
  float_width = 0.8,
  float_height = 0.6,
}

-- Find jira CLI
local function get_cli()
  if M.opts.cli_path and vim.fn.executable(M.opts.cli_path) == 1 then
    return M.opts.cli_path
  end
  
  local paths = {
    vim.fn.expand("~/.local/bin/jira"),
    vim.fn.expand("~/bin/jira"),
    "/usr/local/bin/jira",
    "jira",
  }
  
  for _, p in ipairs(paths) do
    if vim.fn.executable(p) == 1 then
      return p
    end
  end
  
  return nil
end

-- Run command in terminal
local function run_in_terminal(cmd, opts)
  opts = opts or {}
  
  -- Try toggleterm first (part of nvim-setup)
  local ok, Terminal = pcall(require, "toggleterm.terminal")
  if ok then
    local term = Terminal.Terminal:new({
      cmd = cmd,
      direction = M.opts.terminal_direction,
      close_on_exit = opts.close_on_exit or false,
      on_exit = opts.on_exit,
    })
    term:toggle()
    return
  end
  
  -- Fallback to built-in terminal
  if M.opts.terminal_direction == "float" then
    local width = math.floor(vim.o.columns * M.opts.float_width)
    local height = math.floor(vim.o.lines * M.opts.float_height)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })
    vim.fn.termopen(cmd)
    vim.cmd("startinsert")
  elseif M.opts.terminal_direction == "horizontal" then
    vim.cmd("belowright split | terminal " .. cmd)
  else
    vim.cmd("vsplit | terminal " .. cmd)
  end
end

-- Run command and get output
local function run_sync(cmd)
  return vim.fn.system(cmd)
end

-- Submit current buffer
local function submit()
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found. Install it first.", vim.log.levels.ERROR)
    return
  end
  
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  
  -- Save if modified
  if vim.bo[bufnr].modified then
    vim.cmd("write")
  end
  
  -- Check if it's a jira ticket file
  if filepath == "" then
    vim.notify("Save the buffer first", vim.log.levels.WARN)
    return
  end
  
  run_in_terminal(cli .. " submit " .. vim.fn.shellescape(filepath))
end

-- Create new ticket
local function new_ticket()
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found", vim.log.levels.ERROR)
    return
  end
  
  -- Generate ticket file path
  local timestamp = os.date("%Y%m%d-%H%M%S")
  local filepath = M.opts.config_dir .. "/ticket-" .. timestamp .. ".jira.md"
  
  -- Generate template using CLI
  local template_cmd = cli .. " new 2>/dev/null"
  
  -- Create the file manually since we want to open it in current buffer
  vim.fn.system("mkdir -p " .. M.opts.config_dir)
  
  -- Read template from CLI
  local template = run_sync(template_cmd .. " --stdout 2>/dev/null")
  if template == "" or template:match("^Error") then
    -- Fallback: run jira new which will open nvim (not ideal, just open the file)
    vim.fn.system(cli .. " new </dev/null >/dev/null 2>&1 &")
    vim.defer_fn(function()
      -- Find the newest ticket file
      local files = vim.fn.glob(M.opts.config_dir .. "/ticket-*.jira.md", false, true)
      if #files > 0 then
        table.sort(files)
        vim.cmd("edit " .. files[#files])
      end
    end, 500)
    return
  end
  
  -- Write template to file
  local f = io.open(filepath, "w")
  if f then
    f:write(template)
    f:close()
    vim.cmd("edit " .. filepath)
  end
end

-- Show my issues
local function my_issues()
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found", vim.log.levels.ERROR)
    return
  end
  
  run_in_terminal(cli .. " my")
end

-- Get issue key under cursor
local function get_issue_key()
  local word = vim.fn.expand("<cWORD>")
  if word:match("^[A-Z]+-[0-9]+$") then
    return word
  end
  
  -- Try current line
  local line = vim.api.nvim_get_current_line()
  local key = line:match("([A-Z]+%-[0-9]+)")
  return key
end

-- View issue
local function view_issue(key)
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found", vim.log.levels.ERROR)
    return
  end
  
  key = key or get_issue_key()
  if not key then
    vim.ui.input({ prompt = "Issue key: " }, function(input)
      if input and input ~= "" then
        run_in_terminal(cli .. " view " .. input)
      end
    end)
    return
  end
  
  run_in_terminal(cli .. " view " .. key)
end

-- Open issue in browser
local function open_issue(key)
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found", vim.log.levels.ERROR)
    return
  end
  
  key = key or get_issue_key()
  if not key then
    vim.ui.input({ prompt = "Issue key: " }, function(input)
      if input and input ~= "" then
        run_sync(cli .. " open " .. input)
        vim.notify("Opening " .. input, vim.log.levels.INFO)
      end
    end)
    return
  end
  
  run_sync(cli .. " open " .. key)
  vim.notify("Opening " .. key, vim.log.levels.INFO)
end

-- Setup credentials
local function setup()
  local cli = get_cli()
  if not cli then
    vim.notify("jira CLI not found. Install it to ~/.local/bin/jira", vim.log.levels.ERROR)
    return
  end
  
  run_in_terminal(cli .. " setup")
end

-- Setup syntax highlighting for jira files
local function setup_jira_syntax()
  -- Key fields (summary, bucket, epic_name - important)
  vim.cmd([[syntax match jiraKeyField /^\(summary\|bucket\|epic_name\):/ containedin=ALL]])
  
  -- Other field names
  vim.cmd([[syntax match jiraField /^\(project\|type\|labels\|sprint\|assignee\|reporter\|priority\|estimate\|parent\):/ containedin=ALL]])
  
  -- Sprint values (current, next, backlog)
  vim.cmd([[syntax match jiraSprintValue /\<\(current\|next\|backlog\)\>/ containedin=ALL]])
  
  -- Frontmatter delimiters
  vim.cmd([[syntax match jiraDelimiter /^---$/ containedin=ALL]])
  
  -- Section headers (## Description, ## DoD)
  vim.cmd([[syntax match jiraHeader /^##\s.*$/ containedin=ALL]])
  
  -- Checkboxes
  vim.cmd([[syntax match jiraCheckboxEmpty /\[ \]/ containedin=ALL]])
  vim.cmd([[syntax match jiraCheckboxDone /\[x\]/ containedin=ALL]])
  
  -- Time estimates (2h, 1d, 30m)
  vim.cmd([[syntax match jiraEstimate /\d\+[hdm]\>/ containedin=ALL]])
  
  -- Issue keys (DEVOPS-123)
  vim.cmd([[syntax match jiraIssueKey /[A-Z]\{2,10\}-[0-9]\+/ containedin=ALL]])

  -- Colors
  vim.cmd([[
    " Key fields = Yellow/Orange (stand out)
    highlight jiraKeyField    guifg=#e5c07b gui=bold ctermfg=180 cterm=bold
    
    " Other fields = Cyan
    highlight jiraField       guifg=#56b6c2 ctermfg=73
    
    " Sprint values = Green
    highlight jiraSprintValue guifg=#98c379 gui=italic ctermfg=114 cterm=italic
    
    " Delimiters = Dim
    highlight jiraDelimiter   guifg=#3e4451 ctermfg=238
    
    " Headers = Blue bold
    highlight jiraHeader      guifg=#61afef gui=bold ctermfg=75 cterm=bold
    
    " Checkboxes
    highlight jiraCheckboxEmpty guifg=#e06c75 ctermfg=168
    highlight jiraCheckboxDone  guifg=#98c379 ctermfg=114
    
    " Time estimates = Magenta
    highlight jiraEstimate    guifg=#c678dd ctermfg=176
    
    " Issue keys = Green
    highlight jiraIssueKey    guifg=#98c379 gui=bold ctermfg=114 cterm=bold
  ]])
end

-- Main :Jira command handler
local function jira_cmd(opts)
  local args = vim.split(opts.args, "%s+")
  local subcmd = args[1] or ""
  
  if subcmd == "submit" or subcmd == "s" then
    submit()
  elseif subcmd == "new" or subcmd == "n" then
    new_ticket()
  elseif subcmd == "my" or subcmd == "m" then
    my_issues()
  elseif subcmd == "view" or subcmd == "v" then
    view_issue(args[2])
  elseif subcmd == "open" or subcmd == "o" then
    open_issue(args[2])
  elseif subcmd == "setup" then
    setup()
  else
    vim.notify([[
:Jira commands:
  submit, s    Submit current buffer to Jira
  new, n       Create new ticket template
  my, m        Show my open issues
  view, v      View issue (under cursor or specify key)
  open, o      Open issue in browser
  setup        Configure credentials
]], vim.log.levels.INFO)
  end
end

-- Setup function
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  
  -- Create :Jira command
  vim.api.nvim_create_user_command("Jira", jira_cmd, {
    nargs = "*",
    complete = function(_, line)
      local commands = { "submit", "new", "my", "view", "open", "setup" }
      local args = vim.split(line, "%s+")
      if #args <= 2 then
        return vim.tbl_filter(function(cmd)
          return cmd:find(args[#args], 1, true) == 1
        end, commands)
      end
      return {}
    end,
    desc = "Jira integration commands",
  })
  
  -- Setup autocommands
  local group = vim.api.nvim_create_augroup("JiraPlugin", { clear = true })
  
  -- Filetype detection for .jira.md files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = { "*.jira.md", "*.jira" },
    callback = function()
      vim.bo.filetype = "jira"
      -- Load markdown syntax first, then apply jira highlights
      vim.cmd("runtime! syntax/markdown.vim")
      vim.defer_fn(setup_jira_syntax, 10)
    end,
  })
  
  -- Buffer-local keymaps for jira files
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "jira",
    callback = function(ev)
      local bopts = { buffer = ev.buf, silent = true }
      
      vim.keymap.set("n", "<leader>js", submit, 
        vim.tbl_extend("force", bopts, { desc = "Submit to Jira" }))
      vim.keymap.set("n", "<leader>jv", view_issue, 
        vim.tbl_extend("force", bopts, { desc = "View issue" }))
      vim.keymap.set("n", "<leader>jo", open_issue, 
        vim.tbl_extend("force", bopts, { desc = "Open in browser" }))
        
      -- Apply syntax
      setup_jira_syntax()
    end,
  })
  
  -- Highlight Jira issue keys everywhere
  vim.api.nvim_create_autocmd("Syntax", {
    group = group,
    pattern = "*",
    callback = function()
      vim.cmd([[syntax match JiraKey /\<[A-Z]\{2,10\}-[0-9]\+\>/ containedin=ALL]])
      vim.cmd([[highlight default link JiraKey Identifier]])
    end,
  })
end

return M

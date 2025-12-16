-- ~/.config/nvim/lua/config/filetypes.lua

-- Register file extensions
vim.filetype.add({
  extension = {
    mmd = "markdown",
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
  },
  pattern = {
    -- Helm templates in templates/ directory
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.yaml"] = "helm",
    [".*/templates/.*%.yml"] = "helm",
    -- Helm helpers
    [".*/_helpers%.tpl"] = "helm",
  },
})

-- Smart TPL detection for files not in templates/
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tpl",
  callback = function(args)
    -- Skip if already detected as helm by pattern above
    if vim.bo.filetype == "helm" then
      return
    end

    local lines = vim.fn.readfile(args.file, "", 50)
    local content = table.concat(lines, "\n")
    local first_line = lines[1] or ""

    -- Check for Helm-specific patterns
    if content:find("{{%-?%s*include") or content:find("{{%-?%s*template") or content:find("%.Values%.") or content:find("%.Release%.") or content:find("%.Chart%.") then
      vim.bo.filetype = "helm"

    -- JSON: starts with { or [ (common for IAM policies, configs)
    elseif first_line:match("^%s*[{%[]") then
      vim.bo.filetype = "json"

    -- XML/HTML: starts with < or has DOCTYPE
    elseif first_line:match("^%s*<") or content:find("<!DOCTYPE") then
      vim.bo.filetype = "xml"

    -- YAML: has key: value patterns, starts with ---, or has common YAML structures
    elseif first_line:match("^%-%-%-") or content:match("\n%w[%w_%-]*:%s") or first_line:match("^%w[%w_%-]*:%s") then
      vim.bo.filetype = "yaml"

    -- Terraform HCL: resource/variable/module blocks
    elseif content:find("resource%s+\"") or content:find("variable%s+\"") or content:find("module%s+\"") or content:find("data%s+\"") then
      vim.bo.filetype = "terraform"

    -- Go template syntax: {{ }}
    elseif content:find("{{.-}}") then
      vim.bo.filetype = "gotmpl"

    -- SQL: common SQL keywords
    elseif content:upper():find("SELECT%s+") or content:upper():find("INSERT%s+INTO") or content:upper():find("CREATE%s+TABLE") then
      vim.bo.filetype = "sql"

    -- Shell script: shebang or common shell patterns
    elseif first_line:match("^#!.-sh") or first_line:match("^#!/bin/bash") then
      vim.bo.filetype = "bash"

    -- Default to gotmpl
    else
      vim.bo.filetype = "gotmpl"
    end
  end,
})


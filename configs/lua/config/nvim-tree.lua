local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then return end

-- Global set of absolute paths to hide (resolved, no trailing slash)
_G.nvim_tree_content_hidden = {}

nvimtree.setup({
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  renderer = {
    symlink_destination = false,
  },
  filters = {
    enable = true,
    custom = function(absolute_path)
      local normalized = vim.fn.resolve(absolute_path):gsub("/$", "")
      return _G.nvim_tree_content_hidden[normalized] == true
    end,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Get all workspace roots from nvim-tree
    local function get_tree_roots()
      local roots = {}
      local core = require("nvim-tree.core")
      local explorer = core.get_explorer()
      if explorer and explorer.nodes then
        for _, node in ipairs(explorer.nodes) do
          if node.absolute_path then
            table.insert(roots, node.absolute_path)
          end
        end
      end
      if #roots == 0 then
        table.insert(roots, vim.fn.getcwd())
      end
      return roots
    end

    -- Normalize path: resolve symlinks, remove trailing slash, trim whitespace
    local function normalize_path(path)
      path = vim.trim(path)
      path = vim.fn.fnamemodify(path, ":p")
      path = vim.fn.resolve(path)  -- Resolve symlinks
      path = path:gsub("/$", "")
      return path
    end

    -- Search for files matching pattern across all roots
    local function find_files(pattern, with_match)
      local flag = with_match and "--files-with-matches" or "--files-without-match"
      local roots = get_tree_roots()
      local all_files = {}

      for _, root in ipairs(roots) do
        -- Use -L to follow symlinks
        local files = vim.fn.systemlist({ "rg", "-L", flag, "-F", pattern, root })
        for _, f in ipairs(files) do
          if f ~= "" and not f:match("^rg:") then
            local abs = normalize_path(f)
            all_files[abs] = true
          end
        end
      end

      return all_files
    end

    -- Hide files that CONTAIN pattern (show only files WITHOUT pattern)
    vim.keymap.set("n", "gx", function()
      vim.ui.input({ prompt = "Hide files containing: " }, function(pattern)
        if not pattern or pattern == "" then return end

        _G.nvim_tree_content_hidden = find_files(pattern, true)
        local count = vim.tbl_count(_G.nvim_tree_content_hidden)

        api.tree.reload()
        vim.notify(string.format("Hiding %d files containing '%s'", count, pattern))
      end)
    end, opts("Hide files containing pattern"))

    -- Hide files that DO NOT contain pattern (show only files WITH pattern)
    vim.keymap.set("n", "gX", function()
      vim.ui.input({ prompt = "Hide files NOT containing: " }, function(pattern)
        if not pattern or pattern == "" then return end

        _G.nvim_tree_content_hidden = find_files(pattern, false)
        local count = vim.tbl_count(_G.nvim_tree_content_hidden)

        api.tree.reload()
        vim.notify(string.format("Hiding %d files NOT containing '%s'", count, pattern))
      end)
    end, opts("Hide files NOT containing pattern"))

    -- Clear content filter
    vim.keymap.set("n", "gC", function()
      _G.nvim_tree_content_hidden = {}
      api.tree.reload()
      vim.notify("Content filter cleared")
    end, opts("Clear content filter"))

    -- Expand all from current node
    vim.keymap.set("n", "ge", function()
      local node = api.tree.get_node_under_cursor()
      if node then
        api.tree.expand_all(node)
      end
    end, opts("Expand all from cursor"))

    -- Collapse all from current node
    vim.keymap.set("n", "gE", function()
      local node = api.tree.get_node_under_cursor()
      if node then
        api.tree.collapse_all(node)
      end
    end, opts("Collapse all from cursor"))
  end,
})

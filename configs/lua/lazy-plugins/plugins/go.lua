-- go.nvim declaration only
return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft           = { "go", "gomod" },
    lazy         = true,
    config       = function()
      require("config.go")
    end,
  },
}


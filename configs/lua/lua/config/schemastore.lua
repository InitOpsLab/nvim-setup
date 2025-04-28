-- ~/.config/nvim/lua/config/schemastore.lua

local lspconfig = require("lspconfig")
local schemastore = require("schemastore")

-- JSON
lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
})

-- YAML
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = true,
    },
  },
})


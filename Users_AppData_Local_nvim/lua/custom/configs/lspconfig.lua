local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--header-insertion=never",
    "--query-driver=C:\\msys64\\mingw64\\bin\\g++.exe",
  },
})

vim.lsp.enable("clangd")

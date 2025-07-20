require("nvchad.configs.lspconfig").defaults()

local servers = {
  "pyright",
  "eslint",
  "html",
  "cssls",
  "clangd",
}

vim.lsp.enable(servers)


vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("pyproject.toml", "setup.py")(fname)
      or vim.fn.getcwd()
  end,
})


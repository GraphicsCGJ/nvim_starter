require("nvchad.configs.lspconfig").defaults()

vim.lsp.config('pyright', require("lsp.pyright"))
vim.lsp.enable('pyright')
vim.lsp.config("eslint", require("lsp.eslint"))
vim.lsp.enable('eslint')
vim.lsp.config('clangd', require("lsp.clangd"))
vim.lsp.enable('clangd')
vim.lsp.enable('solidity_ls_nomicfoundation')
vim.lsp.enable('mesonlsp')
vim.lsp.enable("vtsls")

-- vim.lsp.enable('typescript-language-server')
-- vim.lsp.enable("tsserver")



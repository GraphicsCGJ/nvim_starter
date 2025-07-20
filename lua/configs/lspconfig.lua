require("nvchad.configs.lspconfig").defaults()

local servers = {
  "pyright",
  "eslint",
  "html",
  "cssls",
  "clangd",
}

-- lspconfig.pyright.setup {
--   on_attach = on_attach,
--   settings = 
--   {
--     pyright = {
--       autoImportCompletion = true,
--     },
--     python = {
--       analysis = 
--         autoSearchPaths = true,diagnosticMode = 'openFilesOnly',useLibraryCodeForTypes = true,typeCheckingMode = 'off'
--     }
--   }
-- }

--
-- vim.lsp.config("pyright", {
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "strict",
--       },
--     },
--   },
--   root_dir = function(fname)
--     return require("lspconfig.util").root_pattern("pyproject.toml", "setup.py")(fname)
--       or vim.fn.getcwd()
--   end,
-- })
--
--
vim.lsp.enable(servers)

require('lspconfig').pyright.setup{
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern('setup.py', 'pyproject.toml')(fname)
      or vim.fn.getcwd()
  end,
  on_attach = on_attach,
  settings = 
    {
      pyright = {
        autoImportCompletion = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'off'
        }
      }
    }
}


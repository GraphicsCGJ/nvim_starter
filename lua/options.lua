require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

--------------------------------------------
--------------------------------------------
--------------------------------------------
--
-- GJ Added. for vim(nvim) configuration.
-- 
--------------------------------------------
--------------------------------------------
--------------------------------------------

vim.opt.relativenumber = true
--------------------------------------------
--------------------------------------------
--------------------------------------------
--
-- GJ Added. for LSP !! 
-- 
--------------------------------------------
--------------------------------------------
--------------------------------------------

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- FOR PYTHON 
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
require("lspconfig").pyright.setup({
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern('setup.py', 'pyproject.toml')(fname)
      or vim.fn.getcwd()
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- "off", "basic", "strict"
        diagnosticMode = "openFilesOnly", -- or "workspace"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format" }, -- ruff가 black 대체
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

require("lint").linters_by_ft = {
 python = { "ruff" },
}

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

--------------------------------------------



require("lspconfig").html.setup {
  filetypes = { "html", "htmldjango", "twig", "erb" },  -- 필요에 따라 확장
  init_options = {
    provideFormatter = true
  }
}

require("lspconfig").eslint.setup {
  on_attach = function(client, bufnr)
    -- 포맷팅을 eslint가 맡도록 설정 (선택)
    client.server_capabilities.documentFormattingProvider = true

    -- auto-fix on save 예시
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll"
    })
  end,
  settings = {
    format = { enable = true },  -- eslint로 포맷팅도 처리할 경우
  }
}

require("lspconfig").cssls.setup {}

-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.formatting.autopep8,
--   },
-- })

-- clangd configuration
require("lspconfig").clangd.setup {
  root_dir = function(fname)
    return vim.fn.getcwd()
  end
}


-- require('lspconfig').pyright.setup{
--   root_dir = function(fname)
--     return require('lspconfig.util').root_pattern('setup.py', 'pyproject.toml')(fname)
--       or vim.fn.getcwd()
--   end
-- }

-- require('lspconfig').ltex.setup{
--   settings = {
--     ltex = {
--       language = "ko-KR", -- or "ko-KR" for Korean
--     },
--   },
-- }


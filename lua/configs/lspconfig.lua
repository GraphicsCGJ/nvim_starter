local lspconfig = require("lspconfig")

-- 공통 설정
local on_attach = function(client, bufnr)
  -- 여기에 공통 키맵, 포맷 설정 등
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- 서버별 설정
local servers = {
  pyright= {
    root_dir = function(fname)
      return require('lspconfig.util').root_pattern('setup.py', 'pyproject.toml')(fname)
        or vim.fn.getcwd()
    end,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic", -- "off", "basic", "strict"
          -- diagnosticMode = "workspace", -- or "workspace"
          -- autoSearchPaths = true,
          -- useLibraryCodeForTypes = true,
        },
      },
    },
  },
  clangd = {
    root_dir = function(fname)
      return vim.fn.getcwd()
    end,
  },
  html = {
    filetypes = { "html", "htmldjango", "twig", "erb" },
    init_options = {
      provideFormatter = true,
    },
  },
  eslint = {
    on_attach = function(client, bufnr)
      -- 포맷팅 기능 켜기
      client.server_capabilities.documentFormattingProvider = true

      -- 저장 전에 eslint auto fix
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    settings = {
      format = { enable = true },
    },
  },
  cssls = {},
}

-- 서버별 설정 적용
for server, config in pairs(servers) do
  config.on_attach = config.on_attach or on_attach
  config.capabilities = config.capabilities or capabilities
  lspconfig[server].setup(config)
end

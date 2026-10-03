return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = {
      {
        lua = { "stylua" },
        python = { "autopep8" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
      },
      formatters = {
        autopep8 = {
          args = { '--max-line-length=200' }
        }
      }
    }
  },

  -- nvim-treesitter: pin to the (archived) `master` branch.
  -- lua/options.lua uses the classic `require("nvim-treesitter.configs").setup{}` API,
  -- which only exists on `master`. The repo's default branch is now `main` (a rewrite
  -- that dropped that module), so fresh installs drift to `main` and break startup.
  -- This override keeps every machine on the API this config expects.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason 도구(LSP/포매터/린터 바이너리) 자동 설치. 이 목록이 single source of truth.
  -- 도구를 추가/제거하면 아래 ensure_installed 만 고치면 된다 (README 별도 갱신 불필요).
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      local tools = {
        "bash-language-server",
        "beautysh",
        "clangd",
        "css-lsp",
        "docker-compose-language-service",
        "docker-language-server",
        "dockerfile-language-server",
        "eslint-lsp",
        "eslint_d",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "golangci-lint-langserver",
        "google-java-format",
        "gopls",
        "helm-ls",
        "html-lsp",
        "isort",
        "jdtls",
        "jinja-lsp",
        "kotlin-debug-adapter",
        "kotlin-language-server",
        "ktfmt",
        "ktlint",
        "kube-linter",
        "kubescape",
        "lua-language-server",
        "marksman",
        "mesonlsp",
        "pyright",
        "ruff",
        "rust-analyzer",
        "templ",
        "vtsls",
        "yaml-language-server",
        "yamlfix",
        "yamlfmt",
        "yamllint",
      }
      require("mason-tool-installer").setup({
        ensure_installed = tools,
        run_on_start = true,
        auto_update = false,
      })
      -- :MasonToolsDiff — :Mason 으로 직접 설치했지만 위 목록에 없는 도구(다른 머신에 동기화되지 않음)와
      -- 목록에는 있지만 아직 설치되지 않은 도구를 보여준다.
      vim.api.nvim_create_user_command("MasonToolsDiff", function()
        local wanted = {}
        for _, name in ipairs(tools) do
          wanted[name] = true
        end
        local installed = require("mason-registry").get_installed_package_names()
        local have = {}
        local extra = {}
        for _, name in ipairs(installed) do
          have[name] = true
          if not wanted[name] then
            table.insert(extra, name)
          end
        end
        local missing = {}
        for _, name in ipairs(tools) do
          if not have[name] then
            table.insert(missing, name)
          end
        end
        table.sort(extra)
        local lines = {
          "not in ensure_installed: " .. (#extra > 0 and table.concat(extra, ", ") or "(none)"),
          "not installed yet:       " .. (#missing > 0 and table.concat(missing, ", ") or "(none)"),
        }
        vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
      end, { desc = "Diff installed Mason packages against ensure_installed" })
    end,
  },

  {
    "tpope/vim-fugitive",
    -- These commands will be loaded earlier than lazy load.
    cmd = { "Git", "Gvdiffsplit", "Gdiffsplit", "Gllog", "G", "Gedit", "Gblame" },
  },

  -- ~/.config/nvim/lua/plugins/lint.lua
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lint")
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
  ,

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
        min_window_height = 0,
        line_numbers = true,
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    config = function()
      require("nvim-ts-autotag").setup({
            opts = {
              enable_close = true,
              enable_rename = true,
              enable_close_on_slash = true,
            },
      })
    end,
  },

}

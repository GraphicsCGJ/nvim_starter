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

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
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
}

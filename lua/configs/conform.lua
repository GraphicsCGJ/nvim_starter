options = {
  formatters_by_ft = {
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
    autopep8 = 
      args = { '--max-line-length=200' }
    }
  }
}
return options

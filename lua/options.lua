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
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format" },       -- ruff가 black 대체
    javascript = { "prettier" },      -- .js
    javascriptreact = { "prettier" }, -- .jsx
    typescript = { "prettier" },      -- .ts
    typescriptreact = { "prettier" }, -- .tsx
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

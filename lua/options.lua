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
require("nvim-treesitter.configs").setup({
})

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
-- formatter 설정 추가.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format" }, -- ① ruff --fix(lint 자동수정) → ② 포맷
    javascript = { "prettier" },      -- .js
    javascriptreact = { "prettier" }, -- .jsx
    typescript = { "prettier" },      -- .ts
    typescriptreact = { "prettier" }, -- .tsx
    sh = { "beautysh" },              -- .sh / bash (filetype: sh)
    java = { "google-java-format" },  -- 포맷 + 안 쓰는 import 정리/정렬까지
    go = { "goimports", "gofumpt" },  -- ① import 자동 추가/제거 → ② 엄격 포맷
    rust = { "rustfmt" },             -- rustup 의 rustfmt (cargo 동봉)
  },
  formatters = {
    beautysh = { prepend_args = { "--indent-size", "2" } }, -- 들여쓰기 2칸 (기본 4칸)
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- nvim-lint 린터 설정은 configs/lint.lua 한 곳에서 관리 (여기서 중복 정의하지 말 것)

vim.opt.relativenumber = true

--------------------------------------------

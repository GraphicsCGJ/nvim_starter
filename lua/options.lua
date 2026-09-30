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
  -- `helm` has no Vim syntax file in the runtime, so tree-sitter is the only highlighter
  -- for Helm templates / helmfile gotmpl (filetype set in ~/.config/nvim/filetype.lua).
  -- `yaml` is what `helm` injects for the non-template parts.
  ensure_installed = { "yaml", "helm" },
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
    c = { "clang_format" },           -- 아래 formatters.clang_format 설정 사용
    cpp = { "clang_format" },
    cmake = { "cmake_format" },       -- 아래 formatters.cmake_format 설정 사용
  },
  formatters = {
    beautysh = { prepend_args = { "--indent-size", "2" } }, -- 들여쓰기 2칸 (기본 4칸)
    -- C/C++ 최대 컬럼 120.
    -- --style=file 이라 프로젝트에 .clang-format 이 있으면 그쪽이 우선이고,
    -- 없을 때만 아래 fallback(LLVM + ColumnLimit 120)이 적용된다.
    clang_format = {
      prepend_args = {
        "--style=file",
        "--fallback-style={BasedOnStyle: LLVM, ColumnLimit: 120}",
      },
    },
    -- CMake: 기본값(max_pargs_hwrap=6)은 인자가 6개 이하면 한 줄에 몰아쓰기(hwrap)를
    -- 강제해서, 소스 목록을 한 줄씩 나눠 써도 매번 되돌려버린다.
    -- 2로 낮춰 인자 3개부터는 세로로 펼치게 한다.
    -- 다만 max_pargs_hwrap 만으로는 `add_library(my_lib STATIC a.cc b.cc)` 처럼
    -- 소스가 2개고 80칼럼에 들어가면 한 줄로 남는다. always_wrap 에 나열한 명령은
    -- 길이/개수와 무관하게 항상 펼쳐진다 (짧은 add_library(foo INTERFACE) 도 3줄이 됨).
    -- 주의: clang_format 의 --style=file 과 달리, cmake-format 은 CLI 플래그가
    -- 프로젝트 .cmake-format.yaml 보다 우선한다 (config 로드 후 legacy_consume 로 덮어씀).
    -- 팀 프로젝트에서 저장소 설정을 따라야 하면 이 prepend_args 를 지울 것.
    cmake_format = {
      prepend_args = {
        "--always-wrap",
        "add_library",
        "add_executable",
        "target_sources",
        "target_link_libraries",
        "--max-pargs-hwrap", "2",
        "--dangle-parens", "true",
      },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- nvim-lint 린터 설정은 configs/lint.lua 한 곳에서 관리 (여기서 중복 정의하지 말 것)

vim.opt.relativenumber = true

--------------------------------------------

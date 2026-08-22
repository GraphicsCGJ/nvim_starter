-- ~/.config/nvim/lua/configs/lint.lua
local lint = require("lint")

-- golangci-lint(v2)는 저장 중간(미완성 코드)·모듈 밖 cwd 등에서 진단(JSON)은 정상 출력하면서도
-- "인프라" 종료코드(5=NoGoFiles, 7=ErrorWasLogged)를 반환한다. nvim-lint 기본 정의는
-- 이 종료코드를 무시하지 않아 "exited with code: 7" 경고가 상태줄에 뜬다. 진단 자체는 stdout에서
-- 따로 파싱되므로, 종료코드만 무시하면 경고는 사라지고 진단은 그대로 남는다.
lint.linters.golangcilint.ignore_exitcode = true

lint.linters_by_ft = {
  python = { "ruff" },
  go     = { "golangcilint" },
  kotlin = { "ktlint" },
  yaml   = { "yamllint" },
}

-- 자동 lint 실행 (저장 후)
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- ~/.config/nvim/lua/configs/lint.lua
local lint = require("lint")

-- yamllint: 저장소의 완화된 설정(yamllint.yaml)을 사용자 전역 설정으로 지정한다.
-- yamllint 는 -c 옵션 > 프로젝트 .yamllint* > $YAMLLINT_CONFIG_FILE > ~/.config/yamllint/config 순서로
-- 설정을 찾으므로, 프로젝트에 자체 설정이 있으면 그쪽이 우선한다. 이미 지정된 환경 변수는 덮어쓰지 않는다.
if not vim.env.YAMLLINT_CONFIG_FILE then
  vim.env.YAMLLINT_CONFIG_FILE = vim.fn.stdpath("config") .. "/yamllint.yaml"
end

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

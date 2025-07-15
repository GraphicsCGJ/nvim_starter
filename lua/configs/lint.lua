-- ~/.config/nvim/lua/configs/lint.lua
local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" },
}

-- 자동 lint 실행 (저장 후)
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

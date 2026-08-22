require "nvchad.autocmds"
--
-- vim.api.nvim_create_autocmd({ "이벤트1", "이벤트2" }, {
--   pattern = "*.c",
--   callback = function()
--     -- 여기에 동작 코드
--   end
-- })

-- 순환할 레지스터 목록
local yank_regs = { "z", "x", "c", "v" }
local yank_index = 1

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- 현재 yank(0번 레지스터) 내용을 해당 레지스터에 저장
    vim.fn.setreg(yank_regs[yank_index], vim.fn.getreg("0"))

    -- 다음 인덱스로 이동 (1 → 2 → 3 → 4 → 1)
    yank_index = (yank_index % #yank_regs) + 1
  end
})

--vim.api.nvim_create_autocmd("TextYankPost", {
--  callback = function()
--   vim.fn.setreg("a", vim.fn.getreg("a") .. vim.fn.getreg("0"))
--  end
--})

-- C/C++ 은 최대 120 컬럼: 가이드선 + gq/자동 줄바꿈 기준
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.textwidth = 120
  end,
})

-- 저장 직전 공백 정리
--   1) NBSP(U+00A0) -> 일반 스페이스
--   2) trailing whitespace 제거
-- 제외: markdown(줄끝 2공백 = <br>), NBSP 가 의미를 갖는 포맷, 특수 버퍼
local no_clean_ft = {
  markdown = true,
  tex = true,
  plaintex = true,
  html = true,
  xml = true,
  csv = true,
  tsv = true,
  diff = true,
  gitcommit = false, -- 필요하면 true 로
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local bo = vim.bo[args.buf]
    if no_clean_ft[bo.filetype] or not bo.modifiable or bo.binary or bo.buftype ~= "" then
      return
    end
    local save = vim.fn.winsaveview()
    -- \s 는 space/tab 만 매칭하므로 NBSP 는 따로 처리해야 한다
    vim.cmd([[silent! keeppatterns keepjumps %s/\%u00a0/ /e]])
    vim.cmd([[silent! keeppatterns keepjumps %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

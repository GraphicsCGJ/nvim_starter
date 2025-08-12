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

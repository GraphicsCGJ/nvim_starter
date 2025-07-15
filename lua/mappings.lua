require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Into the command mode.
map("n", ";", ":", { desc = "CMD enter command mode" })
map("v", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map(Mode, Key, Action, Options)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("c", "<C-h>", "<Left>")
map("c", "<C-l>", "<Right>")

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- for git settings.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- 1. diff
map("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff with HEAD" })
map("n", "<leader>gD", function()
  vim.ui.input({ prompt = "How many commits back? (e.g. 1, 2, 3): " }, function(input)
    if input and tonumber(input) then
      local cmd = string.format("Gdiffsplit HEAD~%s:%%", input)
      vim.cmd(cmd)
    else
      print("Invalid number")
    end
  end)
end, { desc = "Git diff with N commits ago" })
-- 2. blame
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame of this file"})
-- 3. edit (open Ex version of file)
map("n", "<leader>ge", ":Gedit<CR>", { desc = "Git edit of this file"})
map("n", "<leader>gE", function()
  vim.ui.input({ prompt = "How many commits back? (e.g. 1, 2, 3): " }, function(input)
    if input and tonumber(input) then
      local cmd = string.format("Gedit HEAD~%s:%%", input)
      vim.cmd(cmd)
    else
      print("Invalid Number")
    end
  end)
end, { desc = "Git edit of this file"})
-- 4. log
map("n", "<leader>gl", ":Gllog<CR>", { desc = "Git log (current file)" })

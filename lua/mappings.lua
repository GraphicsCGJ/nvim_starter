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
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame of this file" })
-- 3. edit (open Ex version of file)
map("n", "<leader>ge", ":Gedit<CR>", { desc = "Git edit of this file" })
map("n", "<leader>gE", function()
  vim.ui.input({ prompt = "How many commits back? (e.g. 1, 2, 3): " }, function(input)
    if input and tonumber(input) then
      local cmd = string.format("Gedit HEAD~%s:%%", input)
      vim.cmd(cmd)
    else
      print("Invalid Number")
    end
  end)
end, { desc = "Git edit of this file" })
-- 4. log
map("n", "<leader>gl", ":Gllog<CR>", { desc = "Git log (current file)" })
-- 5. hunk navigation (stay in current buffer, no diff split)
map("n", "]h", function() require("gitsigns").nav_hunk("next") end, { desc = "Next git hunk" })
map("n", "[h", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev git hunk" })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk (floating)" })
map("n", "<leader>gP", function() require("gitsigns").preview_hunk_inline() end, { desc = "Preview hunk (inline)" })


-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- for register settings.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

map("n", "<leader>rs", ":reg 0 z x c v<CR>", { desc = "Show my registers" })

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- for code action settings.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- jumplist navigation
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- <C-i> is stolen by NvChad's <Tab> (buffer next) since Tab==C-i in terminals.
-- Keep Tab for buffer switching; use <C-p> for jumplist forward (pairs with <C-o> back).
map("n", "<C-p>", "<C-i>", { desc = "Jump forward (jumplist)" })

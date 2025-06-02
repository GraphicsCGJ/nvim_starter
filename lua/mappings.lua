require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map(Mode, Key, Action, Options)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("c", "<C-h>", "<Left>")
map("c", "<C-l>", "<Right>")



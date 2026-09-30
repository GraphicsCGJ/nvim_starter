vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- WSL: pin the clipboard provider so Neovim skips auto-detection. Every
-- executable() probe for a missing tool (wl-copy, xsel, win32yank.exe, ...)
-- walks the /mnt/c/* entries in $PATH, which cost 0.5s~5s at startup.
-- Mirrors what auto-detection would pick: "tmux" inside tmux, or outside tmux
-- when a tmux server is running (`tmux list-buffers` succeeds).
if vim.fn.has "wsl" == 1 and vim.fn.executable "tmux" == 1 then
  if vim.env.TMUX or vim.system({ "tmux", "list-buffers" }, { timeout = 2000 }):wait().code == 0 then
    vim.g.clipboard = "tmux"
  end
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

-- The mappings always work normally because they alwayse be loaded at last.
vim.schedule(function()
  require "mappings"
end)

-- Added to force the background color black.
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })

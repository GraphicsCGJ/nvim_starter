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

vim.opt.relativenumber = true
--------------------------------------------
--------------------------------------------
--------------------------------------------
--
-- GJ Added. for LSP !! 
-- 
--------------------------------------------
--------------------------------------------
--------------------------------------------


require('lspconfig').pyright.setup{
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern('setup.py', 'pyproject.toml')(fname)
      or vim.fn.getcwd()
  end
}

require('lspconfig').ltex.setup{
  settings = {
    ltex = {
      language = "ko-KR", -- or "ko-KR" for Korean
    },
  },
}


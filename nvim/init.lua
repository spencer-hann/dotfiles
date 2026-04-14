vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- vim.opt.runtimepath:remove("~/.config/nvim")
-- vim.opt.runtimepath:prepend("~/dotfiles/nvim")
-- vim.opt.runtimepath = vim.opt.runtimepath:get()

require('config.options')
require('config.global_keymaps')

require('config.color')
require('config.pack')
require('config.diagnostics')


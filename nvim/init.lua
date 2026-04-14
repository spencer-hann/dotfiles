vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require('config.options')
require('config.global_keymaps')

require('config.color')
require('config.pack')
-- require('config.keymaps')
require('config.diagnostics')
-- require('config.autocmds')


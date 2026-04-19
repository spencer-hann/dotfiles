vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'i' }, 'jj', '<Esc>', { desc = 'lazy <Esc>' })

-- Map Ctrl-Backspace to delete the previous word
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true })
vim.keymap.set('c', '<C-H>', '<C-w>', { noremap = true })
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>w<CR>', { desc = ':w' })
vim.keymap.set({'n', 'i'}, '<C-S>', '<cmd>wa<CR>', { desc = ':wa' })

vim.keymap.set('n', '<leader>z', '<C-z>', { desc = 'background neovim' })
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'window' })
vim.keymap.set('n', '<leader>jn', '<C-i>', { desc = '[N]ext in jump list (<C-i>)' })
vim.keymap.set('n', '<leader>jp', '<C-o>', { desc = '[P]revious in jump list (<C-o>)' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clear highlights on search when pressing <Esc> in normal mode `:h hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>lH', '<cmd>checkhealth vim.lsp<CR>', { desc = 'check[H]ealth vim.lsp' })


-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


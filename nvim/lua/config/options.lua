vim.o.number = true
vim.o.relativenumber = true

-- vim.o.autocomplete = true
-- vim.o.pummaxwidth = 40
-- vim.o.completeopt = 'menu,menuone,noselect,nearest'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- vim.o.showmode = false

vim.o.pumborder = 'rounded'
vim.o.winborder = 'rounded'

-- Every wrapped line will continue visually indented.
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'auto' -- 'number'

vim.o.timeoutlen = 500  -- cancel mapped sequence after

vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


-- Sets how neovim will display certain whitespace characters in the editor.
--  No idea why list = true is needed or why 'list' is the name for displaying whitespace.
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split' -- https://www.youtube.com/watch?v=sA3z6gsqOuw

-- Show which line your cursor is on
vim.o.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- on operation that would fail due to unsaved changes in the buffer (like `:q`),
-- raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

vim.opt.hlsearch = true


-- Highlight when yanking (copying) text -- `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- restore cursor position on reopen
-- https://www.reddit.com/r/neovim/comments/1sgu7yt/comment/ofc8atb/
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local line = vim.fn.line('\'"')
    if line > 0 and line <= vim.fn.line('$') then vim.cmd([[normal! g'"]]) end
  end,
})


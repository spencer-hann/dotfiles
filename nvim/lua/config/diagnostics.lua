-- TODO: :h diagnostic-on-jump-example

local sev = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_lines = true,  -- extra lines injected below (see <leader>td toggle keymap)
  virtual_text = true,  -- inline/end-of-line text
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [sev.ERROR] = '󰅚 ',
      [sev.WARN]  = '󰀪 ',
      [sev.INFO]  = '󰋽 ',
      [sev.HINT]  = '󰌶 ',
    } or {  -- TODO
      [sev.ERROR] = 'E',
      [sev.WARN]  = 'W',
      [sev.INFO]  = 'I',
      [sev.HINT]  = 'H',
    },
  },
})


-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set(
    'n',
    '<leader>td',
    function()
        local new_config = not vim.diagnostic.config().virtual_lines
        print("diagnostic virtual lines:", new_config)
        vim.diagnostic.config({ virtual_lines = new_config })
    end,
    { desc = '[d]iagnostic extra lines' }
)


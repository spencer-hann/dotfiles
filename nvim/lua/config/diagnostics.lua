-- TODO: :h diagnostic-on-jump-example

local sev = vim.diagnostic.severity
vim.diagnostic.config({
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


local diagnostic_mode = 2

local function cycle_diagnostic_mode()
    -- virtual_text   -> inline/end-of-line text
    -- virtual_lines  -> extra lines injected below
    if diagnostic_mode == 0 then
        vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
        require('tiny-inline-diagnostic').disable()
    elseif diagnostic_mode == 1 then
        require('tiny-inline-diagnostic').disable()
        vim.diagnostic.config({ virtual_lines = true, virtual_text = true })
    elseif diagnostic_mode == 2 then
        vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
        require('tiny-inline-diagnostic').enable()
    end
    diagnostic_mode = (diagnostic_mode + 1) % 3
end

cycle_diagnostic_mode()  -- invoke once to setup

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set(
    'n',
    '<leader>d',
    cycle_diagnostic_mode,
    { desc = 'cycle [d]iagnostic display mode' }
)


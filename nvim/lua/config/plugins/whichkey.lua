local setup_table = {
      preset = 'helix',
      -- ms between key and which-key display, independent of vim.o.timeoutlen
      delay = 400,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
}

local my_spec = {
        { '<leader>j', group = '[J]ump list' }, --, expand = vim.fn.getjumplist },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
}

-- taken from whick-key.nvim.txt:which-key.nvim-which-key-mappings example
-- these might not apply....
local doc_spec = {
        { "<leader>f", group = "file" }, -- group
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope [F]ind File", mode = "n" },
        { "<leader>fb", function() print("hello") end, desc = "Foobar" },
        -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
        { "<leader>b", group = "buffers", expand = function()
          return require("which-key.extras").expand.buf()
        end
        },
}

return function()
        local wk = require("which-key")
        wk.setup(setup_table)
        wk.add(my_spec)
        wk.add(doc_spec)
end


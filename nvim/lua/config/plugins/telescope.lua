return function()
    local telescope = require("telescope")

    -- telescope.defaults.sorting_strategy = "ascending"

    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    telescope.setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            defaults = {
              sorting_strategy = "ascending",
              -- layout_strategy = 'horizontal',
              -- layout_strategy = 'vertical',
              layout_strategy = 'flex',
              -- preview pane wider than default because hard to read on laptop
              layout_config = { width = 0.96,
                      -- preview_width = 0.5,
              },
              -- Inside telescope setup, under defaults
              mappings = {
                -- i = {
                --   -- ["<C-y>"] = function(prompt_bufnr)
                --   ["<C-l>"] = function(prompt_bufnr)
                n = {
                  ["dd"] = require("telescope.actions").delete_buffer,
                  ["<C-l>"] = function(prompt_bufnr)
                    local action_state = require("telescope.actions.state")
                    local picker = action_state.get_current_picker(prompt_bufnr)
                    picker.previewer:scroll_preview(1) -- Use -1 to scroll up
                  end,
                },
              }
            },
            extensions = {
              ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
              },
              planets = { show_moon = true, show_pluto = true },
            },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = '[J]ump list' })
    vim.keymap.set('n', '<leader>fl', builtin.loclist, { desc = '[L]ocation list' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({
                winblend = 10, previewer = false
            })
        )
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set(
        'n',
        '<leader>fo',
        function()
          builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
        end,
        { desc = '[O]pen Files' }
    )

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[N]eovim files' })
end


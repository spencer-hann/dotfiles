local function register_attach_event()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp this function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Same as <C-K>, but I find this easier to remember,
          -- and matches the behavior in the auto-complete menu
          vim.keymap.set('n', '<C-space>', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP: Open preview (hover)' })

          -- sets the mode, buffer and description for us each time.
          --- @param keys string
          --- @param auto_prefix boolean?
          local map = function(keys, func, desc, mode, auto_prefix)
            mode = mode or 'n'
            if auto_prefix or auto_prefix == nil then keys = '<leader>l' .. keys end
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local mapjmp = function(keys, func, desc, mode, auto_prefix)
            map(keys, function(opts)
              func(opts) -- or { jump_type = 'tab' })
            end, desc, mode, auto_prefix)
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('r', vim.lsp.buf.rename, '[R]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('a', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
          -- map('a', vim.lsp.buf.code_action, 'Goto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          mapjmp('gi', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          mapjmp('gd', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          mapjmp('gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('O', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('W', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          mapjmp('gt', require('telescope.builtin').lsp_type_definitions, 'Goto [T]ype Definition')

          map('co', require('telescope.builtin').lsp_outgoing_calls, 'View [O]utgoing Calls')
          map('ci', require('telescope.builtin').lsp_incoming_calls, 'View [I]ncoming Calls')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('h', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay [H]ints')
          end
        end,
      })

end

return function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
                ensure_installed = {
                        "lua_ls",
                        "stylua",
                        "basedpyright",
                        "rust-analyzer",
                }
        })

        require('which-key').add({
                {"<leader>l", group = "[L]SP" },
                {"<leader>lg", group = "[g]oto ..." },
                {"<leader>lc", group = "[c]alls ..." },
        })

        vim.lsp.config('lua_ls', {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              -- diagnostics = { globals = { 'vim' } },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
              telemetry = { enable = false },
            },
          },
        })

        register_attach_event()

        -- apparently don't need this?
        -- vim.lsp.enable({ "lua_ls" })

end


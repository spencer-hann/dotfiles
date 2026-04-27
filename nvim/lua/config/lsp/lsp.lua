---  run when an LSP attaches to a particular buffer.
---    That is to say, every time a new file is opened that is associated with
---    an lsp this function will be executed to configure the current buffer
local function lsp_attach_callback(event)
  -- sets the mode, buffer and description for us each time.
  --- @param keys string
  --- @param auto_prefix boolean?
  local map = function(keys, func, desc, mode, auto_prefix)
    mode = mode or 'n'
    if auto_prefix or auto_prefix == nil then keys = '<leader>l' .. keys end
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
  end


  -- when jump_type!='tab', jump back up 'tagstack' with <C-t>
  local mapjmp = function(keys, func, desc, mode, auto_prefix)
    map(keys, function(opts)
            opts = opts or { jump_type = 'tab' }
            opts.jump_type = 'tab'
            func(opts)
            -- func(opts or { jump_type = 'tab' })
    end, desc, mode, auto_prefix)
  end

  -- Same as <C-K>, but I find this easier to remember,
  -- and matches the behavior in the auto-complete menu
  map('<C-space>', vim.lsp.buf.hover, 'Open preview (hover)', 'n', false)
  map('d', vim.lsp.buf.hover, 'Open preview [d]ocs (hover)')

  map('R', '<cmd>lsp restart<CR>', '[R]estart')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('r', vim.lsp.buf.rename, '[r]ename')
  mapjmp('gr', require('telescope.builtin').lsp_references, 'Goto [R]eferences')
  mapjmp('gd', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
  mapjmp('gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
  mapjmp('gi', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')
  mapjmp('gt', require('telescope.builtin').lsp_type_definitions, 'Goto [T]ype Definition')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('a', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
  -- map('a', vim.lsp.buf.code_action, 'Goto Code [A]ction', { 'n', 'x' })

  -- Fuzzy find all symbols in current document, workspace/project.
  map('O', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
  map('W', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

  map('co', require('telescope.builtin').lsp_outgoing_calls, 'View [O]utgoing Calls')
  map('ci', require('telescope.builtin').lsp_incoming_calls, 'View [I]ncoming Calls')

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    local fn = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end
    map('h', fn, 'Toggle Inlay [H]ints')
    map('<leader>th', fn, 'Inlay [H]ints', 'n', false)
  end
end


local function lsp_setup_diagnostic_messaging()
      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
end


local function setup_blink_autocomplete()
    require('blink.cmp').setup({

       -- issues w/ vim.pack.add + rust binaries... maybe just wait for blink v2
       fuzzy =  { implementation = 'lua' }, --'prefer_rust_with_warning' },

       keymap = {
           -- preset = "default",
           ["<CR>"] = { "select_and_accept", "fallback" },
           ["<C-n>"] = { "show", "select_next" },
           ["<Esc>"] = { "hide", "fallback" },
           ['<Tab>'] = { "accept" },
           ['<C-l>'] = { "accept" },
           ['<C-h>'] = { "hide" },
           -- ["<C-space>"] = {},
           -- ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
           -- ["<C-n>"] = { "select_and_accept" },
           ["<C-k>"] = { "select_prev", "fallback" },
           ["<C-j>"] = { "select_next", "fallback" },
           -- ["<C-b>"] = { "scroll_documentation_down", "fallback" },
           -- ["<C-f>"] = { "scroll_documentation_up", "fallback" },
           -- ["<C-l>"] = { "snippet_forward", "fallback" },
           -- ["<C-h>"] = { "snippet_backward", "fallback" },
       },

       -- appearance = {
       --     use_nvim_cmp_as_default = true,
       --     nerd_font_variant = "normal",
       -- },

       signature = { enabled = true },
       completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },

       cmdline = {
           completion = {
               menu = { auto_show = true },
               -- ghost_text = { enabled = true },
           },
           keymap = {
               preset = 'inherit',
               ['<CR>'] = {},  -- 'accept_and_enter', 'fallback' },
           },
       },

       sources = { default = { "lsp", "path", "snippets", "buffer" } },
   })
end


local function setup_rust_analyzer()
    vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = { disabled = { "unlinked-file" }, },
            -- https://www.reddit.com/r/rust/comments/1sh12uz/comment/of9bcsq/?solution=a915e9e3dea4ae10a915e9e3dea4ae10&js_challenge=1&token=bbbe4bf1c9a2b5160829c4be34da5861984fcf6601af47bb6624dd268ce3176e&share_id=mX2GfS5QjsB9STmZ7fcLr&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=1
            --  rust-analyzer.inlayHints.chainingHints.enable
            inlayHints = { chainingHints = { enable = true }, }
          }
        }
    })
end


local function setup_lua_ls()
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          -- diagnostics = { globals = { 'vim' } },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
          telemetry = { enable = false },
        },
      },
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
                },
        })

        require('which-key').add({
                {"<leader>l", group = "[L]SP" },
                {"<leader>lg", group = "[g]oto ..." },
                {"<leader>lc", group = "function [c]alls ..." },
        })

        vim.api.nvim_create_autocmd( 'LspAttach', {
          group = vim.api.nvim_create_augroup('main-lsp-attach', { clear = true }),
          callback = lsp_attach_callback,
        })

        lsp_setup_diagnostic_messaging()

        setup_lua_ls()
        setup_rust_analyzer()
        setup_blink_autocomplete()

        -- apparently don't need this?
        -- vim.lsp.enable({ "lua_ls" })

end


---@param name string
local gh = function(name) return 'https://github.com/' .. name end

local plugins = {
        gh('folke/which-key.nvim'),
        gh('sainnhe/gruvbox-material'),
        gh('nvim-treesitter/nvim-treesitter'),

        -- telescope
        gh('nvim-lua/plenary.nvim'),  -- required by telescope, idk
        gh('nvim-telescope/telescope-fzf-native.nvim'),
        gh('nvim-telescope/telescope-ui-select.nvim'),
        gh('nvim-telescope/telescope.nvim'),

        -- LSP
        gh('neovim/nvim-lspconfig'),
        gh('mason-org/mason.nvim'),
        gh('mason-org/mason-lspconfig.nvim'),
        gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
        gh('saghen/blink.cmp'),

        gh('kawre/leetcode.nvim'),  -- https://github.com/kawre/leetcode.nvim
        gh('MunifTanjim/nui.nvim'),  -- leetcode.nvim dependency
}

if vim.g.have_nerd_font then table.insert(plugins, gh('nvim-tree/nvim-web-devicons')) end

vim.pack.add(plugins)

local names = {
        "config.plugins.whichkey",
        "config.plugins.telescope",  -- must go before lsp
        "config.lsp.lsp",
        "config.plugins.leetcode",
}
for _, name in ipairs(names) do
        package.loaded[name] = nil  -- un-cache module/package
        require(name)()
end

-- TODO: should go in its own file like others
-- INFO: formatting and syntax highlighting
-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")
require("nvim-treesitter").setup({
  auto_install = true, -- autoinstall languages that are not installed yet
})


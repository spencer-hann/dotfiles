vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/savq/melange-nvim",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/catppuccin/nvim",
})

local function _set(name)
        vim.cmd.colorscheme(name)
        print(name)
end

local function nvim_default() _set('default') end

local kana = {
	-- function() _set("kanagawa") end,  -- same as 'wave'
	function() _set("kanagawa-wave") end,
	function() _set("kanagawa-dragon") end,
	-- function() _set("kanagawa-lotus") end,  -- light mode
}

local function mela() _set("melange") end

local function gruv_setup(transparent, contrast)
        return function()
                -- -- Important!!
                -- if has('termguicolors') then
                --   set termguicolors
                -- end

                -- For dark version.
                vim.cmd("set background=dark")

                vim.g.gruvbox_material_enable_italic = 1
                vim.g.gruvbox_material_transparent_background = transparent
                -- vim.g.gruvbox_material_transparent_background = 2

                -- Set contrast.
                -- Available values: 'hard', 'medium', 'soft'
                vim.g.gruvbox_material_background = contrast

                -- For better performance
                vim.g.gruvbox_material_better_performance = 1
                -- let g:gruvbox_material_better_performance = 1

                _set("gruvbox-material")
        end  -- gruvbox
end  -- gruvbox

local gruv = {
        gruv_setup(0, "medium"),
        gruv_setup(1, "hard"),
        -- gruv_setup(2, "soft"),
}

local catpuc = {
        function() _set('catppuccin') end,  -- same as mocha?
        -- function() _set('catppuccin-latte) end,  -- light mode
        -- function() _set('catppuccin-frappe') end,
        -- function() _set('catppuccin-macchiato') end,
        -- function() _set('catppuccin-mocha') end,
        -- function() _set('habamax') end,
        -- opts = { auto_integrations = true }
}


local batches = {catpuc, kana, mela, gruv, nvim_default}
local scheme_list = vim.iter(batches):flatten():totable()

local colorscheme_iterator = (
    function()
        local i = 4
        return {
            next = function()
                i = 1 + i % #scheme_list
                scheme_list[i]()
            end,
            prev = function()
                i = (i > 1) and i - 1 or #scheme_list
                scheme_list[i]()
            end,
        }
    end
)()

gruv[1]()  -- gruvbox has special setup that needs to happen always?; unclear
colorscheme_iterator.next()  -- start off with default i+1

vim.keymap.set(
        "n",
        "<leader>c",
        colorscheme_iterator.next,
        { desc = "next [c]olorscheme" }
)
vim.keymap.set(
        "n",
        "<leader>C",
        colorscheme_iterator.prev,
        { desc = "previous [C]olorscheme" }
)


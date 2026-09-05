vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/savq/melange-nvim",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/catppuccin/nvim",
	"https://github.com/metalelf0/kintsugi-nvim",
})

local function _set(name)
        vim.cmd.colorscheme(name)
        print(name)
end

---@diagnostic disable-next-line: unused-local, unused-function
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

local kint = {
        -- function() _set("kintsugi-dark") end,
        function() _set("kintsugi-flared") end,
}


local batches = {catpuc, kana, gruv, kint, mela}
local scheme_list = vim.iter(batches):flatten():map(
    function (item)
        return type(item) == "string" and function() _set(item) end or item
    end
):totable()


---@param start number | nil
---@return table
local function create_colorscheme_iterator(start)
    local i = start or 1  -- kanagawa-wave
    return {
        current = function() scheme_list[i]() end,
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


gruv[1]()  -- gruvbox has special setup that needs to happen always?; unclear
vim.cmd("redraw")  -- redraw UI to clear command/message output


local default_color_iter = create_colorscheme_iterator()
default_color_iter.next()  -- start off with default+1

local c_color_iter = create_colorscheme_iterator(4)
local py_color_iter = create_colorscheme_iterator(2)
local lua_color_iter = create_colorscheme_iterator(2)
local md_color_iter = create_colorscheme_iterator(1)

local color_iterators = {
    py = py_color_iter,
    c = c_color_iter,
    h = c_color_iter,
    cc = c_color_iter,
    hh = c_color_iter,
    hpp = c_color_iter,
    cpp = c_color_iter,
    lua = lua_color_iter,
    md = md_color_iter,
}

local function get_color_iterator()
    local extension = vim.fn.expand('%:e')
    return color_iterators[extension] or default_color_iter
end


vim.api.nvim_create_autocmd(
        'BufEnter',
        { callback = function() get_color_iterator().current() end }
)
vim.keymap.set(
        "n",
        "<leader>c",
        function() return get_color_iterator().next() end,
        { desc = "next [c]olorscheme" }
)
vim.keymap.set(
        "n",
        "<leader>C",
        function() return get_color_iterator().prev() end,
        { desc = "previous [C]olorscheme" }
)


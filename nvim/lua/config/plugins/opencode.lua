
--- github.com/nickjvandyke/opencode.nvim ---

-- Recommended/example keymaps
local keymaps = {
    {
        modes={ "n", "v", "x" },
        key="<leader>oa",
        fn=function() require("opencode").ask("@this: ") end,
        opts={ desc = "[A]sk OpenCode…" },
    },
    {
        modes={ "n", "v", "x" },
        key="<leader>ox",
        fn=function() require("opencode").select() end,
        opts={ desc = "Select OpenCode…" },
    },
    {
        modes={ "n", "v", "x" },
        key="<leader>os",
        fn=function() return require("opencode").operator("@this") end,
        opts={ desc = "Send range to OpenCode", expr = true },
    },
    {
        modes={ "n" },
        key="<leader>ol",
        fn=function() return require("opencode").operator("@this") .. "_" end,
        opts={ desc = "Send line to OpenCode", expr = true },
    },
}


return function()

    ---@type opencode.Opts
    vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
    }

    -- TODO: github.com/folke/snacks.nvim/blob/main/docs/input.md
    require('snacks').setup({input = { enabled = true }})  -- Enhances Ask
    -- TODO: snacks.picker snacks.terminal

    for _, k in ipairs(keymaps) do
        vim.keymap.set(k.modes, k.key, k.fn, k.opts)
    end
    require('which-key').add({ '<leader>o', group = '[O]penCode', mode={'n','x', 'v'} })
end


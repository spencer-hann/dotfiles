
-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
local function client_supports_method(client, method, bufnr)
        return client:supports_method(method, bufnr)
        -- if vim.fn.has 'nvim-0.11' == 1 then
        --         return client:supports_method(method, bufnr)
        -- else
        --         return client.supports_method(method, { bufnr = bufnr })
        -- end
end

return {
        client_supports_method=client_supports_method
}


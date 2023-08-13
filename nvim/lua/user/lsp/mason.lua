local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local lsp_handlers_status_ok, lsp_handlers = pcall (require, "user.lsp.handlers")
if not lsp_handlers_status_ok then
    return
end


lsp_handlers.setup()
mason.setup()
mason_lspconfig.setup()
mason_lspconfig.setup_handlers {

    function (server_name)
        lspconfig[server_name].setup {}
    end

    ------------------------------------------------
    -- INSERT MANUAL SERVER CONFIGS HERE
    --
    -- Dedicated handlers for specific servers (override)
    -- see :h mason-lspconfig-automatic-server-setup
}

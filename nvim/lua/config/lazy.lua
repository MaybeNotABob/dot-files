local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    if vim.fn.executable("git") ~= 1 then
        error("Git is required to install lazy.nvim. Install Git and restart Neovim.")
    end

    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. result)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        import = "plugins",
    },

    install = {
        colorscheme = { "tokyonight" },
    },

    ui = {
        border = "rounded",
    },

    change_detection = {
        enabled = true,
        notify = false,
    },
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if vim.bo.modified and not vim.bo.readonly then
            vim.cmd("write")
        end
    end,
    desc = "Autosave on leaving insert mode",
})

vim.api.nvim_create_autocmd("TextChanged", {
    callback = function()
        if vim.fn.mode() == 'n' and vim.bo.modified and not vim.bo.readonly then
            vim.cmd("write")
        end
    end,
    desc = "Autosave on text change in normal mode",
})


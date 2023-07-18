vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { row, col })
        end
    end,
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        vim.cmd ':%s/\\s\\+$//e'
    end,
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
})

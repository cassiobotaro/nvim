vim.pack.add { 'https://github.com/iamcco/markdown-preview.nvim' }

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Build step for markdown-preview.nvim',
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'markdown-preview.nvim' and (args.data.kind == 'install' or args.data.kind == 'update') then
      vim.system({ 'npm', 'install' }, { cwd = args.data.path .. '/app' }, function(out)
        if out.code ~= 0 then
          vim.schedule(function()
            vim.notify('markdown-preview.nvim: npm install failed\n' .. (out.stderr or ''), vim.log.levels.ERROR)
          end)
        end
      end)
    end
  end,
})

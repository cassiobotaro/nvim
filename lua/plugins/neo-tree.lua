-- FIle explorer
return {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'NeoTree',
    branch = 'v3.x',
    keys = {
        { '<leader>ft', '<cmd>Neotree toggle<cr>', desc = 'Neotree' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
            hijack_netrw_behavior = 'open_current',
        },
    },
}

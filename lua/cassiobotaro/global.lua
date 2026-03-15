vim.g.mapleader = ' ' -- space as leader key
vim.g.maplocalleader = ' ' -- space as leader key
vim.g.copilot_enabled = true -- enable copilot
vim.g.python3_host_prog = 'python' -- set python host

-- register filetypes not built-in to Neovim
vim.filetype.add {
  filename = {
    ['go.work'] = 'gowork',
    ['go.work.sum'] = 'gowork',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
    ['.gitlab-ci.yml'] = 'yaml.gitlab',
    ['.gitlab-ci.yaml'] = 'yaml.gitlab',
  },
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    -- docker-compose files with environment suffixes (e.g. docker-compose.prod.yml)
    ['.*docker%-compose%..*%.ya?ml'] = 'yaml.docker-compose',
    -- helm values files
    ['.*/templates/.*%.ya?ml'] = 'yaml.helm-values',
    ['.*values.*%.ya?ml'] = 'yaml.helm-values',
  },
}

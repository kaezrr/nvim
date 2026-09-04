vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }

require('fzf-lua').setup()
require('fzf-lua').register_ui_select()

vim.keymap.set('n', '<leader>sh', function() FzfLua.helptags() end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function() FzfLua.keymaps() end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function() FzfLua.files() end, { desc = '[S]earch [F]iles' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() FzfLua.grep_cword() end, { desc = '[S]earch [W]ord under cursor' })
vim.keymap.set('n', '<leader>sg', function() FzfLua.live_grep() end, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sd', function() FzfLua.diagnostics_workspace() end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', function() FzfLua.resume() end, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader><leader>', function() FzfLua.buffers() end, { desc = 'List buffers' })
vim.keymap.set('n', '<leader>sn', function() FzfLua.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim config files' })

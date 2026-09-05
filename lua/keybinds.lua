-- Move selected region up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected region down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected region up' })

-- Center screen on some actions
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half-page down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half-page up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- Paste without rewriting buffer
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-c>', '<Esc>', { desc = 'Escape insert/visual mode' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- NOTE: This won't work in all terminal emulators/tmux/etc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>r', '<cmd>restart<CR>', { desc = '[R]estart neovim' })

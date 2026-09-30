--     ____  __
--    |    |/ _|____    ____ _______________
--    |      < \__  \ _/ __ \\___   /\_  __ \
--    |    |  \ / __ \\  ___/ /    /  |  | \/
--    |____|__ (____  /\___  >_____ \ |__|
--        \/    \/     \/      \/
--
--    Courtesy of kickstart.nvim !!!

-- [[ Setting options ]]
require 'options'

-- [[ Basic and high powered keybinds ]]
require 'keybinds'

-- [[ Auto commands ]]
require 'autocmd'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.pack.add {
  {
    src = 'https://github.com/rebelot/kanagawa.nvim',
    name = 'kanagawa',
  },
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range '1.*',
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    branch = 'main',
  },
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-mini/mini.nvim',
}

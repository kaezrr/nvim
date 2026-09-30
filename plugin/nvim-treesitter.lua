local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end

  vim.treesitter.start(buf, language)
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local available_parsers = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)

    if not language then return end

    -- If this is managed by nix then all grammars are already installed
    local installed_parsers = vim.g.nix and available_parsers or require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      treesitter_try_attach(buf, language)
    end
  end,
})

if not vim.g.nix then
  require('nvim-treesitter').install {
    'bash',
    'fish',
    'c',
    'cpp',
    'diff',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'rust',
    'toml',
  }
end

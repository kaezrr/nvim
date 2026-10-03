require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = {}
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,

  formatters_by_ft = {
    lua = { 'stylua' },
    cpp = { 'clang-format' },
    c = { 'clang-format' },
    sql = { 'sql_formatter' },
    python = { 'ruff_format' },
    nix = { 'nixfmt' },
    typescript = { 'biome' },
    javascript = { 'biome' },
    html = { 'biome' },
    astro = { 'biome' },
    json = { 'biome' },
    jsonc = { 'biome' },
  },
}

vim.keymap.set('n', '<leader>f', function()
  require('conform').format {
    async = true,
    lsp_format = 'fallback',
  }
end, { desc = '[F]ormat buffer' })

vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
}

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { buffer = bufnr, desc = 'Next git change' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { buffer = bufnr, desc = 'Previous git change' })

    -- Actions
    vim.keymap.set(
      'v',
      '<leader>hs',
      function()
        gitsigns.stage_hunk {
          vim.fn.line '.',
          vim.fn.line 'v',
        }
      end,
      { buffer = bufnr, desc = '[H]unk [S]tage (selection)' }
    )

    vim.keymap.set(
      'v',
      '<leader>hr',
      function()
        gitsigns.reset_hunk {
          vim.fn.line '.',
          vim.fn.line 'v',
        }
      end,
      { buffer = bufnr, desc = '[H]unk [R]eset (selection)' }
    )

    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = '[H]unk [S]tage' })
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = '[H]unk [R]eset' })
    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = '[H]unk [S]tage buffer' })
    vim.keymap.set('n', '<leader>hu', gitsigns.stage_hunk, { buffer = bufnr, desc = '[H]unk [U]ndo stage' })
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = '[H]unk [R]eset buffer' })
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = '[H]unk [P]review' })
    vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { buffer = bufnr, desc = '[H]unk [B]lame line' })
    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = '[H]unk [D]iff this' })
    vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '@' end, { buffer = bufnr, desc = '[H]unk [D]iff this (@)' })

    -- Toggles
    vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[T]oggle [B]lame line' })
    vim.keymap.set('n', '<leader>tD', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = '[T]oggle inline [D]iff preview' })
  end,
}

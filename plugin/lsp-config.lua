vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range '1.*',
  },
}

require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, mode, opts)
      mode = mode or 'n'
      opts = opts or {}
      opts.buffer = event.buf
      vim.keymap.set(mode, keys, func, opts)
    end

    map('grn', vim.lsp.buf.rename, 'n', { desc = 'LSP [R]e[N]ame' })
    map('gra', vim.lsp.buf.code_action, { 'n', 'x' }, { desc = 'LSP [R]e[A]ction (code action)' })
    map('grr', FzfLua.lsp_references, 'n', { desc = 'LSP [R]eferences' })
    map('gri', FzfLua.lsp_implementations, 'n', { desc = 'LSP [R]e[I]mplementations' })
    map('grd', FzfLua.lsp_definitions, 'n', { desc = 'LSP [R]e[D]efinitions' })
    map('grD', vim.lsp.buf.declaration, 'n', { desc = 'LSP [R]e[D]eclaration' })
    map('gsd', FzfLua.lsp_document_symbols, 'n', { desc = 'LSP [S]ymbol [D]ocument' })
    map('gsw', FzfLua.lsp_workspace_symbols, 'n', { desc = 'LSP [S]ymbol [W]orkspace' })
    map('grt', FzfLua.lsp_typedefs, 'n', { desc = 'LSP [T]ype definitions' })
    map('gl', vim.diagnostic.open_float, 'n', { desc = 'Show line diagnostics' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map(
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
        'n',
        { desc = '[T]oggle inlay [H]ints' }
      )
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = {
    title = 'Diagnostic',
    header = '',
    border = 'single',
    source = 'if_many',
    scope = 'line',
  },

  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},

  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--header-insertion=never',
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = { command = 'clippy' },
    },
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require',
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable {
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'wgsl_analyzer',
  'ty',
}

return {
  -- Nền tảng cho LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Tự động cài đặt LSP servers, formatters, linters
      { 'williamboman/mason.nvim', config = true }, -- `config = true` tự chạy setup
      'williamboman/mason-lspconfig.nvim',


      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
          require('mason-tool-installer').setup({
            ensure_installed = {
              -- Formatters
              'stylua',
              'prettier',
              'isort',
              'black',
              'goimports',
              'google-java-format',
              'clang-format',
              'eslint_d',
            }
          })
        end
      },

      -- Plugin cho autocomplete
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_lspconfig = require('mason-lspconfig')

      -- [[ Cấu hình Autocomplete (nvim-cmp) ]]
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- [[ Cấu hình LSP với vim.lsp.config (mới) ]]
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        map('gd', vim.lsp.buf.definition, 'Go to Definition')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('gr', vim.lsp.buf.references, 'Go to References')
      end

      local servers = {
        -- Web Dev (JS/TS/Svelte/Vue)
        'ts_ls',
        'svelte',
        'tailwindcss',
        'html',
        'cssls',
        -- Python
        'pyright',
        -- Go
        'gopls',
        -- 'jdtls',
        -- C++
        'clangd',
        -- Other
        'lua_ls',
        'dockerls',
        'bashls',
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
      })

      -- Sử dụng vim.lsp.config thay vì lspconfig
      for _, server_name in ipairs(servers) do
        vim.lsp.config(server_name, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.enable(server_name)
      end

      -- Cấu hình riêng cho Lua server
      vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
          },
        },
      })
    end,
  },
}
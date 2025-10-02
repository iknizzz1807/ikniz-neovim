return {
  -- Theme
  {
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },

  -- File Explorer (nhÆ° VSCode sidebar)
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons', -- Cáº§n Ä'á»ƒ cÃ³ icon Ä'áº¹p
    config = function()
      require('nvim-tree').setup {
        -- Cáº¥u hÃ¬nh cÆ¡ báº£n, báº¡n cÃ³ thá»ƒ xem thÃªm trÃªn docs
        sort_by = 'case_sensitive',
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
      -- PhÃ­m táº¯t Ä'á»ƒ báº­t/táº¯t file tree
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
    end,
  },

  -- Statusline (thanh tráº¡ng thÃ¡i á»Ÿ dÆ°á»›i)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          -- ... cÃ¡c options khÃ¡c
        },
      }
    end,
  },

  -- Auto-pairs: Tá»± Ä'á»™ng thÃªm ngoáº·c Ä'Ã³ng khi gÃµ ngoáº·c má»Ÿ
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local autopairs = require('nvim-autopairs')
      
      autopairs.setup({
        check_ts = true, -- Enable treesitter
        ts_config = {
          lua = {'string'}, -- Don't add pairs in lua string treesitter nodes
          javascript = {'template_string'},
          java = false, -- Don't check treesitter on java
        }
      })

      -- TÃ­ch há»£p vá»›i nvim-cmp (náº¿u báº¡n Ä'ang dÃ¹ng)
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  -- Treesitter cho syntax highlighting tá»'t hÆ¡n
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        -- CÃ i Ä'áº·t cÃ¡c parser cho cÃ¡c ngÃ´n ngá»¯ báº¡n dÃ¹ng
        ensure_installed = {
          'lua', 'vim', 'vimdoc', 'query',
          'javascript', 'typescript', 'tsx', -- Removed 'jsx' - JSX is handled by javascript/tsx
          'html', 'css', 'json',
          'python', 'go', 'java', 'c', 'cpp',
          'bash', 'dockerfile'
        },
        
        -- Tá»± Ä'á»™ng cÃ i Ä'áº·t parser khi má»Ÿ file
        auto_install = true,
        
        -- Enable highlighting
        highlight = {
          enable = true,
          -- Táº¯t highlighting cho cÃ¡c file lá»›n Ä'á»ƒ trÃ¡nh lag
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        
        -- Enable indentation
        indent = { enable = true },
      }
    end,
  },
}
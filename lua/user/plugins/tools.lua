return {
  -- Fuzzy Finder (Tìm kiếm file, text cực nhanh)
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6', -- Pin version cho ổn định
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep for text' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
    end,
  },

  -- Terminal tích hợp (như VSCode)
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'horizontal', 
        open_mapping = [[<c-\>]], -- Ctrl + \ để mở/đóng terminal
        shell = vim.o.shell,
      }

      -- Phím tắt để mở terminal ngang hoặc dọc
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
      vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "ToggleTerm lazygit" })

    end,
  },

  -- Auto Format on Save
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      local conform = require('conform')
      conform.setup({
        -- Map filetypes to formatters.
        -- CÁC FORMATTER NÀY SẼ ĐƯỢC CÀI TỰ ĐỘNG BỞI MASON (ở file lsp.lua)
        formatters_by_ft = {
          lua = { 'stylua' },
          -- TypeScript/JavaScript/JSON/CSS/HTML
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          svelte = { 'prettier' },
          json = { 'prettier' },
          -- Python
          python = { 'isort', 'black' },
          -- Go
          go = { 'gofmt', 'goimports' },
          -- Java - cần cài google-java-format thủ công hoặc qua Mason
          java = { 'google-java-format' },
          -- C++ - cần cài clang-format
          c = { 'clang-format' },
          cpp = { 'clang-format' },
        },
        -- Cấu hình để format khi save
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
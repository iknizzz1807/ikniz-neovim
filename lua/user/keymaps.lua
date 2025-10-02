local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- NOTE: Leader keys are now set in init.lua before lazy.nvim loads

-- [[ Normal Mode ]]
-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Di chuyển dòng/khối code lên xuống
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selected lines down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selected lines up' })

-- Resize window
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>resize +2<cr>', { desc = 'Increase window width' })

-- Thao tác với buffer
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })

-- Thao tác nhanh
-- Xóa mà không lưu vào register (không ghi đè clipboard)
map('n', '<leader>d', '"_d', { desc = 'Delete to blackhole register' })
map('v', '<leader>d', '"_d', { desc = 'Delete selection to blackhole register' })

-- Paste mà không ghi đè register (có thể paste nhiều lần cùng một nội dung)
map('v', '<leader>p', '"_dP', { desc = 'Paste without yanking' })

-- Save and Quit
map('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write (save) buffer' })
map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit window' })
map('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'Quit all windows' })

-- Mở NvimTree và tìm file hiện tại
map('n', '<leader>E', '<cmd>NvimTreeFindFileToggle<cr>', { desc = 'Toggle file explorer on current file' })

-- Comment
map('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end, { desc = 'Toggle comment' })
map('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment for selection' })
local opt = vim.opt -- for conciseness

-- [[ Line Numbers ]]
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- [[ Tabs & Indentation ]]
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- [[ Search ]]
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- [[ Appearance ]]
opt.termguicolors = true -- enable 24-bit RGB colors
opt.background = 'dark' -- tell neovim this is a dark theme
opt.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time

-- [[ Behavior ]]
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.swapfile = false -- don't create swap files
opt.undofile = true -- persistent undo
opt.updatetime = 250 -- faster completion

-- [[ Auto Save ]]
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wa",
  desc = "Save buffer on focus lost or leaving buffer",
})
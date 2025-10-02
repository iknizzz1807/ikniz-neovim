-- [[ Set leader keys BEFORE loading lazy.nvim ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--
--    NOTE: `lazypath` stores the path to the lazy.nvim installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and load plugins ]]
require('lazy').setup({
  spec = {
    -- Import all our plugin configuration files here
    { import = 'user.plugins.ui' },
    { import = 'user.plugins.lsp' },
    { import = 'user.plugins.tools' },
    { import = 'user.plugins.comment' }, 
    { import = 'user.plugins.gitsigns' },
  },
  -- Configure lazy.nvim options
  checker = {
    enabled = true, -- Automatically check for plugin updates
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- [[ Load core settings and keymaps ]]
--
--    NOTE: These should be loaded after plugins in case a plugin needs to override a setting
require('user.options')
require('user.keymaps')
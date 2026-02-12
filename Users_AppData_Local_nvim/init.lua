require "core"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.INFO]  = "I",
      [vim.diagnostic.severity.HINT]  = "H",
    },
  },
  underline = true,
  severity_sort = true,
  virtual_text = false, -- optionnel
  update_in_insert = false,
})

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

vim.api.nvim_set_keymap('n', '<C-p>', '<C-i>', { noremap = true, silent = true })

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.cmd [[
  highlight WarningMsg ctermfg=Yellow guifg=Yellow
  highlight ErrorMsg ctermfg=Red guifg=Red
  highlight CriticalMsg ctermfg=Magenta guifg=Magenta
  highlight InfoMsg ctermfg=Green guifg=Green
  highlight DebugMsg ctermfg=Blue guifg=Blue

  autocmd BufReadPost,BufWinEnter * lua vim.fn.matchadd('WarningMsg', '\\[warning\\]')
  autocmd BufReadPost,BufWinEnter * lua vim.fn.matchadd('ErrorMsg', '\\[error\\]')
  autocmd BufReadPost,BufWinEnter * lua vim.fn.matchadd('CriticalMsg', '\\[critical\\]')
  autocmd BufReadPost,BufWinEnter * lua vim.fn.matchadd('InfoMsg', '\\[info\\]')
  autocmd BufReadPost,BufWinEnter * lua vim.fn.matchadd('DebugMsg', '\\[debug\\]')
]]

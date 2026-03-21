vim.g.mapleader=" "
-- Set the characters for EasyMotion
--vim.g.easymotion_smartcase = 1             -- Enable smart case sensitivity
-- vim.g.easymotion_keys = 'asdfghjklqwertyuiop'        -- Specify the characters to use
vim.opt.number=true
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber=true
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set scrolloff=5")
vim.cmd("set lbr")
vim.cmd("set ai")
vim.cmd("set si")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', 'x', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-\\>', ':vs<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[', ':bp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ']', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, 'f', '<Plug>(easymotion-f)', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, 'F', '<Plug>(easymotion-F)', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<leader>f', '<Plug>(easymotion-w)', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<leader>b', '<Plug>(easymotion-b)', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, 'J', '<Plug>(easymotion-j)', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, 'K', '<Plug>(easymotion-k)', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>se', ':Explore<CR>', { noremap = false, silent = true })
-- vim.keymap.set('n', '<leader>f', '<Plug>CamelCaseMotion_w', { noremap = false, silent = true })
-- vim.keymap.set('n', '<leader>b', '<Plug>CamelCaseMotion_b', { noremap = false, silent = true })
-- vim.keymap.set('n', '<leader>e', '<Plug>CamelCaseMotion_e', { noremap = false, silent = true })



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local prettierSetup = {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        extra_args = { "--single-quote", "--jsx-single-quote" },
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end,
    }

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build= ":TSUpdate"},
  prettierSetup,
  { "easymotion/vim-easymotion" } ,
  { "bkad/CamelCaseMotion" } -- CamelCaseMotion plugin

}
local opts = {}

require("lazy").setup(plugins, opts)

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript"},
  highlight = { enable = true },
  indent = { enable = true }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- vim.cmd("source $VIMRUNTIME/colors/vim.lua")
-- vim.cmd("colorscheme everforest")
--require catppuccin
require("catppuccin").setup()

--set the colorscheme to it!
vim.cmd.colorscheme "catppuccin"

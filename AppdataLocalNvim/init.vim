set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number 


call plug#begin()
" LSP support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" (Optional: snippets support, if you want)
Plug 'L3MON4D3/LuaSnip'
Plug 'Mofiqul/dracula.nvim'
Plug 'mason-org/mason.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'andweeb/presence.nvim'
call plug#end()

lua << EOF
-- Mason setup (installer for LSPs)
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "clangd" }, -- add other servers here
}

-- Capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Example: Clangd setup (C/C++)
require("lspconfig").clangd.setup {
  capabilities = capabilities,
}
EOF

lua << EOF
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- If using luasnip:
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
})

EOF
nnoremap <silent> <leader>e :lua vim.diagnostic.open_float()<CR>


colorscheme dracula

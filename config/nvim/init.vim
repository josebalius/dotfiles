" =========================
" Neovim Config (Reconciled)
" =========================

" ---------- Core ----------
set nocompatible
filetype off
let mapleader=','

" ---------- UI ----------
set number
set relativenumber
set linespace=5
set mouse+=a
set cursorline
set guicursor=n-v-c-i:block
set colorcolumn=120
set termguicolors
syntax enable

" ---------- Editing / UX ----------
set nolist
set completeopt-=preview
set timeoutlen=1000
set updatetime=100
set clipboard=unnamedplus

" ---------- Performance / Files ----------
set autoread
set nofoldenable
set lazyredraw
set ttyfast
set noswapfile
set nobackup
set nowritebackup
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" ---------- Plugins ----------
call plug#begin("~/.config/nvim/bundle")

" Essentials
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'ojroques/nvim-osc52'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Files / Nav
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Treesitter / Indent
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP / Completion
Plug 'neovim/nvim-lspconfig'
Plug 'pmizio/typescript-tools.nvim'         " from remote
Plug 'Saghen/blink.cmp'                     " from local (keep)
Plug 'mason-org/mason.nvim'                 " from remote
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/conform.nvim'                " from remote

" Languages
Plug 'fatih/vim-go'
Plug 'mrcjkb/rustaceanvim'

" Themes (full set kept)
Plug 'josebalius/darcula-dark.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'robertmeta/nofrils'
Plug 'josebalius/vim-light-chromeclipse'
Plug 'lunacookies/vim-colors-xcode'
Plug 'kkga/vim-envy'
Plug 'tpope/vim-vividchalk'
Plug 'fatih/molokai'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'Verf/deepwhite.nvim'
Plug 'yazeed1s/minimal.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'chriskempson/base16-vim'
Plug 'andreasvc/vim-256noir'
Plug 'fcpg/vim-farout'
Plug 'zenbones-theme/zenbones.nvim'
Plug 'jackplus-xyz/binary.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'metalelf0/jellybeans-nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'AlexvZyl/nordic.nvim'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'felipeagc/fleet-theme-nvim'
Plug 'scottmckendry/cyberdream.nvim'
Plug 'Skardyy/makurai-nvim'

" Extras
Plug 'github/copilot.vim'

call plug#end()

" ---------- Colors ----------
let g:codedark_modern = 1
set background=dark
colorscheme base16-bright" local default; you can switch with the helper funcs below

" ---------- Filetype / Indent ----------
filetype plugin indent on

augroup INDENT_SETTINGS
  autocmd!
  autocmd Filetype typescript setlocal tabstop=4 shiftwidth=4   " local preference
  autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2
  autocmd Filetype css        setlocal tabstop=2 shiftwidth=2
  autocmd Filetype scss       setlocal tabstop=2 shiftwidth=2
  autocmd Filetype go         setlocal tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufWritePre *.rb :%s/\s\+$//e
  autocmd FileType javascript setlocal indentexpr=
augroup END

" ---------- FZF Commands ----------
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview({
      \     'dir': systemlist('git rev-parse --show-toplevel')[0],
      \     'options': ['--delimiter', ':', '--nth', '3..', '--exact'],
      \   }),
      \   <bang>0)



" ---------- Keymaps ----------
map ; :Files<CR>
noremap gg :GGrep<CR>
noremap vv :<C-u>vsplit<CR>
noremap tt :<C-u>split<CR>
noremap fi :BLines<CR>
noremap <Leader>t :<C-u>tabnew<CR>
noremap <Tab>      :<C-u>tabnext<CR>
noremap <S-Tab>    :<C-u>tabprevious<CR>
noremap <Leader>q :q<CR>
noremap <Leader>w :w<CR>
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
nnoremap <F3> :set hlsearch!<CR>
noremap <C-c> :<C-u>'<,'>Commentary<CR>

" Mouse word search
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<CR>:set hls<CR>
nnoremap <Leader>*              :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<CR>:set hls<CR>

" Go helpers (vim-go)
noremap gt :w<CR>:GoTest<CR>
noremap gf :w<CR>:GoTestFunc<CR>
noremap <Leader>b   :w<CR>:GoBuild<CR>
noremap <Leader>im  :GoImplements<CR>
noremap <Leader>ref :GoReferrers<CR>

" ---------- Helpers ----------
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" ---------- Smart Ctrl-click (LSP goto def; fallback tags) ----------
silent! unmap <C-LeftMouse>
nnoremap <silent> <C-LeftMouse> <LeftMouse><Cmd>lua _G.ctrl_click_goto_def()<CR>

" =================
" Lua Configuration
" =================
lua << EOF
-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "rust", "go", "typescript", "tsx" },
  sync_install = true,
  auto_install  = true,
  highlight = {
    enable = false,                       -- keep your local setting
    additional_vim_regex_highlighting = false,
  },
})

-- OSC52 (remote)
require('osc52').setup({
  max_length = 0,
  silent = false,
  trim = false,
  tmux_passthrough = true,
})
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

-- Mason (remote)
require("mason").setup()

-- LSP common helpers
local lspconfig = require('lspconfig')

-- Go (local kept)
lspconfig.gopls.setup({
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float(nil, { scope = "line" }) end, opts)
  end,
  settings = {
    gopls = { analyses = { unusedparams = true, shadow = true }, staticcheck = true },
  },
  flags = { debounce_text_changes = 150 },
})

-- Rust (local kept)
lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      diagnostics = { enable = true },
      cargo = { allFeatures = true, loadOutDirsFromCheck = true, runBuildScripts = true },
      procMacro = { enable = true, ignored = { leptos_macro = { "component", "server" } } },
      imports = { granularity = { group = "module" }, prefix = "self" },
      completion = { addCallArgumentSnippets = false, addCallParenthesis = false, autoimport = { enable = true } },
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.codeActionProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.execute_command({
            command = "rust-analyzer.organizeImports",
            arguments = { vim.uri_from_bufnr(bufnr) },
          })
        end,
      })
    end
  end,
})

-- TypeScript via typescript-tools (from remote; preferred over typescript.nvim)
local ts_tools = require('typescript-tools')
ts_tools.setup({
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float(nil, { scope = "line" }) end, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
})

-- Format TS/TSX on save (Conform + prettierd, from remote)
require("conform").setup({
  formatters_by_ft = {
    typescript = { "prettierd", stop_after_first = true },
    tsx        = { "prettierd", stop_after_first = true },
    typescriptreact = { "prettierd", stop_after_first = true },
    javascript = { "prettierd", stop_after_first = true },
    javascriptreact = { "prettierd", stop_after_first = true },
  },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})

-- Ctrl-click smart goto def with fallback to tags
_G.ctrl_click_goto_def = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = (vim.lsp.buf_get_clients and vim.lsp.buf_get_clients(bufnr))
               or (vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }))
               or {}
  for _, c in pairs(clients) do
    local caps = c.server_capabilities or c.resolved_capabilities
    if caps and (caps.definitionProvider or caps.goto_definition) then
      vim.lsp.buf.definition()
      return
    end
  end
  vim.cmd('normal! <C-]>')
end

-- Completion: blink.cmp (local)
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  keymap = { preset = "enter" },
  completion = { menu = { auto_show = true } },
})

-- Extra: nice Insert-mode popup menu navigation
vim.keymap.set("i", "<Down>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>" end, { expr = true, silent = true })
vim.keymap.set("i", "<Up>",   function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"   end, { expr = true, silent = true })
vim.keymap.set("i", "<Tab>",      function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"    end, { expr = true, silent = true })
vim.keymap.set("i", "<S-Tab>",    function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"  end, { expr = true, silent = true })

-- Format TS/TSX on save via LSP if conform didn't run (fallback handled above)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function() vim.lsp.buf.format({ async = false }) end,
})

vim.keymap.set('n', '<leader>yf', function()
  local path = vim.fn.expand('%:p')
  require('osc52').copy(path)
  vim.notify('osc52: copied path:\n' .. path, vim.log.levels.INFO)
end, { desc = 'Yank file path to local clipboard via OSC52' })

local osc52 = require('osc52')

-- Normal mode: copy GBrowse URL for current position
vim.keymap.set('n', '<leader>gy', function()
  -- Run :GBrowse and capture its output (the URL)
  local ok, out = pcall(vim.fn.execute, 'GBrowse!')
  if not ok then
    vim.notify('GBrowse failed: ' .. tostring(out), vim.log.levels.ERROR)
    return
  end

  local url = vim.trim(out or '')
  if url == '' then
    vim.notify('GBrowse did not return a URL', vim.log.levels.WARN)
    return
  end

  osc52.copy(url)
end, { desc = 'Yank GBrowse URL via OSC52' })

-- Visual mode: copy GBrowse URL for selected range (line anchors)
vim.keymap.set('v', '<leader>gy', function()
  -- Use the visual range with GBrowse
  local ok, out = pcall(vim.fn.execute, "'<,'>GBrowse!")
  if not ok then
    vim.notify('GBrowse (visual) failed: ' .. tostring(out), vim.log.levels.ERROR)
    return
  end

  local url = vim.trim(out or '')
  if url == '' then
    vim.notify('GBrowse (visual) did not return a URL', vim.log.levels.WARN)
    return
  end

  osc52.copy(url)
end, { desc = 'Yank GBrowse URL for selection via OSC52' })




EOF


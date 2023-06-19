set nocompatible              " be iMproved, required
filetype off                  " required

set linespace=5
set number
set relativenumber
set completeopt-=preview
set mouse+=a
set autoread
set timeoutlen=1000 ttimeoutlen=0
" set cursorline
set guicursor=i:block

syntax on 
set t_Co=256
syntax enable

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" don't render special chars (tabs, trails, ...)
set nolist
" lazy drawing
set lazyredraw
set ttyfast
set clipboard=unnamed
set colorcolumn=120
" set hlsearch
nnoremap <F3> :set hlsearch!<CR>

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

let mapleader=','

" setup Plug
call plug#begin('~/.config/nvim/bundle')

Plug 'projekt0n/github-nvim-theme'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-endwise'
Plug 'KurtPreston/vim-autoformat-rails'
Plug 'airblade/vim-gitgutter'
Plug 'mdempsky/gocode'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-test/vim-test'
Plug 'voldikss/vim-floaterm'
Plug 'vim-ruby/vim-ruby'
" Plug 'vim-airline/vim-airline'
Plug 'wojciechkepka/vim-github-dark'
Plug 'sheerun/vim-polyglot'
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'arcticicestudio/nord-vim'
Plug 'github/copilot.vim'
Plug 'doums/darcula'
Plug 'vim-airline/vim-airline-themes'
Plug 'arzg/vim-colors-xcode'
Plug 'josebalius/vim-github-colorscheme'
Plug 'YorickPeterse/vim-paper'
Plug 'morhetz/gruvbox'
Plug 'kkga/vim-envy'
Plug 'fatih/molokai'
Plug 'tpope/vim-vividchalk'
Plug 'ojroques/vim-oscyank', { 'commit': 'e6298736a7835bcb365dd45a8e8bfe86d935c1f8' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'robertmeta/nofrils'
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'owickstrom/vim-colors-paramount'
Plug 'wolverian/minimal'
Plug 'eihigh/vim-aomi-grayscale'
Plug 'yasukotelin/notelight'
Plug 'svermeulen/text-to-colorscheme.nvim'
Plug 'josebalius/vim-light-chromeclipse'


call plug#end()

filetype plugin indent on

colorscheme light-chromeclipse 
" highlight String ctermfg=246 guifg=#8B0000
let $BAT_THEME = 'GitHub'

" highlight StatusLine guibg=#FFFFFF guifg=#000000
" highlight MatchParen guibg=#74FFFF guifg=#FFFFFF


" colorscheme nofrils-dark
" highlight Normal guibg=black ctermbg=black

" lua require('github-theme').setup()
" colorscheme nord

" colorscheme paper 
" let g:airline_theme='sol'
" let $BAT_THEME = 'GitHub'


" let g:molokai_original=1
" set background=dark
" colorscheme molokai 
" let g:airline_theme='dark'

" colorscheme envy 
" let g:airline_theme='sol'
" highlight Normal ctermbg=white guibg=white

" colorscheme github
" highlight SignColumn guibg=#eeeeee

" colorscheme xcodelight
" hi MatchParen guifg=#1f1f24 guibg=#fef937 gui=NONE cterm=NONE
" let $BAT_THEME = 'GitHub'

" let g:gruvbox_contrast_light='medium'
" colorscheme gruvbox

" DARCULA
" set background=dark
" colorscheme darcula 
" let g:airline_theme='jellybeans'
" call darcula#Hi('Normal', darcula#palette.fg, ['#1A1B1E', 235])
" call darcula#Hi('LineNr', darcula#palette.lineNumber, ['#1A1B1E', 235])
" call darcula#Hi('SignColumn', darcula#palette.lineNumber, ['#1A1B1E', 235])

" set background=dark
" let g:codedark_conservative = 1
" colorscheme codedark

map ; :Files<CR>
noremap ft :Tags<CR>
noremap fd :Ag<CR>
noremap gg :GGrep<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

noremap ff :BTags<CR>
noremap vv :<C-u>vsplit<CR>
noremap tt :<C-u>split<CR>
noremap fi :BLines<CR>
noremap cl :q<CR>
noremap <C-c> :<C-u>'<,'>Commentary<CR>
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-B> <C-]>
noremap <C-T> :<C-u>tabnew<CR>
noremap <Tab> :<C-u>tabnext<CR>
noremap <S-Tab> :<C-u>tabprevious<CR>
noremap <C-l> <C-x><C-o>
vnoremap < <gv
vnoremap > >gv
au BufWrite ruby silent! call AutoFormatRails()
nmap <silent> gd <Plug>(coc-definition)
noremap tf :TestFile<CR>
noremap tn :TestNearest<CR>
noremap <F5> :GoBuild<CR>
noremap <Leader>b :w<CR>:GoBuild<CR>
noremap <Leader>q :q<CR>
noremap <Leader>t :<C-u>tabnew<CR>
noremap <Leader>w :w<CR>
noremap <Leader>im :GoImplements<CR>
noremap <Leader>c :GoCallers<CR>
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
nnoremap <Leader>* :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>


set expandtab
autocmd Filetype typescript setlocal tabstop=2
autocmd Filetype typescript setlocal shiftwidth=2
autocmd Filetype css setlocal tabstop=2
autocmd Filetype css setlocal shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2
autocmd Filetype go setlocal tabstop=4
autocmd Filetype go setlocal shiftwidth=4
autocmd Filetype scss setlocal tabstop=2
autocmd Filetype scss setlocal shiftwidth=2
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufWritePre *.rb :%s/\s\+$//e
au FileType javascript setl indentexpr=
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
let g:oscyank_term = 'tmux'

" let g:coc_global_extensions = ['coc-go', 'coc-yank']

let g:airline_section_b=''
let g:airline_section_c='%f'
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 0 

let test#strategy='floaterm'
let g:floaterm_wintype='split'
let g:go_fmt_command = "goimports"
let g:go_doc_popup_window = 1
let g:go_code_completion_enabled = 1

let g:go_highlight_extra_types = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0


lua << EOF
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require'lspconfig'.sorbet.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
EOF

" function! SetupTreeSitter()
" lua << EOF
" require 'nvim-treesitter.configs'.setup {
"   -- One of "all", "maintained" (parsers with maintainers), or a list of languages
"   ensure_installed = { "ruby", "go" },
  
"   -- Install languages synchronously (only applied to `ensure_installed`)
"   sync_install = true,

"   -- Automatically install missing parsers when entering buffer
"   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
"   auto_install = true,

"   highlight = {
"     -- disable = { "go" },
"     -- `false` will disable the whole extension
"     enable = true,
"     additional_vim_regex_highlighting = false,

"     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"     -- Using this option may slow down your editor, and you may see some duplicate highlights.
"     -- Instead of true it can also be a list of languages
"   },
" }
" EOF
" endfunction

" call SetupTreeSitter()

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


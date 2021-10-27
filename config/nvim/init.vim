set nocompatible              " be iMproved, required
filetype off                  " required

set linespace=5
set number
set relativenumber
set completeopt-=preview
set mouse+=a
set autoread
set timeoutlen=1000 ttimeoutlen=0
set cursorline
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
Plug 'vim-airline/vim-airline'
Plug 'wojciechkepka/vim-github-dark'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'arcticicestudio/nord-vim'
Plug 'github/copilot.vim'
Plug 'doums/darcula'
Plug 'vim-airline/vim-airline-themes'
Plug 'arzg/vim-colors-xcode'
Plug 'endel/vim-github-colorscheme'
Plug 'YorickPeterse/vim-paper'
Plug 'morhetz/gruvbox'
Plug 'kkga/vim-envy'
Plug 'fatih/molokai'
Plug 'tpope/vim-vividchalk'

call plug#end()

filetype plugin indent on

colorscheme vividchalk

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

" colorscheme xcodelighthc 
" hi MatchParen guifg=#1f1f24 guibg=#fef937 gui=NONE cterm=NONE

" let g:gruvbox_contrast_light='medium'
" colorscheme gruvbox

" DARCULA
" set background=dark
" colorscheme darcula 
" let g:airline_theme='jellybeans'
" call darcula#Hi('Normal', darcula#palette.fg, ['#1A1B1E', 235])
" call darcula#Hi('LineNr', darcula#palette.lineNumber, ['#1A1B1E', 235])
" call darcula#Hi('SignColumn', darcula#palette.lineNumber, ['#1A1B1E', 235])

map ; :Files<CR>
noremap ft :Tags<CR>
noremap fd :Ag<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

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

set expandtab
autocmd Filetype typescript setlocal tabstop=2
autocmd Filetype typescript setlocal shiftwidth=2
autocmd Filetype css setlocal tabstop=2
autocmd Filetype css setlocal shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2
autocmd Filetype go setlocal tabstop=2
autocmd Filetype go setlocal shiftwidth=2
autocmd Filetype scss setlocal tabstop=2
autocmd Filetype scss setlocal shiftwidth=2
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufWritePre *.rb :%s/\s\+$//e
au FileType javascript setl indentexpr=

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

set nocompatible              " be iMproved, required
filetype off                  " required

set guifont=Essential\ PragmataPro:h13
set linespace=5
set number
set relativenumber
set completeopt-=preview
set mouse+=a
set autoread
if &term =~ '^screen'
        " tmux knows the extended mouse mode
        set ttymouse=xterm2
endif
set timeoutlen=1000 ttimeoutlen=0

syntax on
" set guioptions=
" set t_Co=256
syntax enable
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors

" don't render special chars (tabs, trails, ...)
set nolist
" lazy drawing
set lazyredraw
set ttyfast
set clipboard=unnamed
set hlsearch
nnoremap <F3> :set hlsearch!<CR>
nnoremap hh :set hlsearch!<CR>

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

let mapleader=','

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'preservim/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-commentary'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'fatih/vim-go'
Plugin 'sheerun/vim-polyglot'
" Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-endwise'
Plugin 'KurtPreston/vim-autoformat-rails'
Plugin 'airblade/vim-gitgutter'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'mdempsky/gocode'
Plugin 'fatih/molokai'
" Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install'  }
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'tomasiser/vim-code-dark'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'tpope/vim-rhubarb'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'vim-test/vim-test'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tc50cal/vim-terminal'
Plugin 'morhetz/gruvbox'
Plugin 'voldikss/vim-floaterm'
Plugin 'mattn/emmet-vim'
" Plugin 'autozimu/LanguageClient-neovim', { 'do': 'bash install.sh' }


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set cursorline
" colorscheme molokai
" let g:airline_theme='light'

set background=light
" colorscheme molokai
" let g:airline_theme='codedark'

" let g:github_colors_soft = 1
" let g:github_colors_block_diffmark = 0
" colorscheme github
" let g:airline_theme='github'

let g:gruvbox_contrast_light="hard"
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

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
vnoremap < <gv
vnoremap > >gv
au BufWrite ruby silent! call AutoFormatRails()
nmap <silent> gd <Plug>(coc-definition)
noremap tf :TestFile<CR>
noremap tn :TestNearest<CR>

let g:vimrubocop_config = '~/github/github/.rubocop.yml'
let g:neocomplete#enable_at_startup = 1
let NERDTreeShowHidden=1
let g:ycm_max_num_candidates = 10
let g:ycm_key_list_stop_completion = ['<UP>', '<LeftMouse>']
let g:ycm_filetype_blacklist = { 'go': 1 }
" let g:LanguageClient_serverCommands = { 'ruby': ['~/github/github/bin/solargraph', 'stdio'] }

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

if exists('g:loaded_polyglot')
        let g:polyglot_disabled = ['go', 'javascript']
endif

let g:airline_section_b=''
let g:airline_section_c='%f'
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1 

let test#strategy='floaterm'
let g:floaterm_wintype='split'
let g:user_emmet_leader_key='<C-h>'

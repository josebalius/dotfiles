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

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

syntax on
syntax enable

" don't render special chars (tabs, trails, ...)
set nolist
" lazy drawing
set lazyredraw
set ttyfast
set clipboard=unnamed
set hlsearch
nnoremap <F3> :set hlsearch!<CR>

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

let mapleader=','
call plug#begin('~/.vim/plugged')
" Add your vim plugins here like the following:
" Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-endwise'
Plug 'KurtPreston/vim-autoformat-rails'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'mdempsky/gocode'
Plug 'fatih/molokai'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'OmniSharp/omnisharp-vim'
Plug 'rust-lang/rust.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-rhubarb'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'tc50cal/vim-terminal'
Plug 'morhetz/gruvbox'
Plug 'voldikss/vim-floaterm'
Plug 'doums/darcula'
Plug 'arcticicestudio/nord-vim'
Plug 'kkga/vim-envy'
Plug 'cocopon/iceberg.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'endel/vim-github-colorscheme'
Plug 'YorickPeterse/vim-paper'
Plug 'tpope/vim-vividchalk'

call plug#end()

" Add the rest of your vim settings here
filetype plugin indent on    " required


set cursorline
let g:codedark_conservative = 1

colorscheme vividchalk

" colorscheme paper 
" let g:airline_theme='sol'
" let $BAT_THEME = 'GitHub'
" highlight rubyDefine cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyMacro cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyClassBlock cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyControl cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyExceptionHandler cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyConditional cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyClass cterm=bold gui=bold ctermfg=black guifg=black
" highlight CursorLine cterm=none
" highlight CursorLineNr cterm=bold

" colorscheme github
" let $BAT_THEME = 'GitHub'
" highlight rubyDefine cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyMacro cterm=bold gui=bold ctermfg=black guifg=black
" highlight rubyClassBlock cterm=bold gui=bold ctermfg=black guifg=black
" highlight CursorLine cterm=none

" ENVY THEME SETTINGS
" colorscheme envy
" let g:airline_theme='sol'
" let $BAT_THEME = 'GitHub'
" highlight rubySymbol ctermfg=black guifg=black
" highlight Normal ctermbg=white guibg=white

" MOLOKAI THEME SETTINGS
" let g:molokai_original = 1
" set background=dark
" colorscheme molokai
" let g:airline_theme='codedark'
" highlight rubySymbol ctermfg=white guifg=white
" highlight rubyException ctermfg=white guifg=white
" highlight LineNr ctermfg=white guifg=white

" DARCULA
" set background=dark
" colorscheme darcula 
" let g:airline_theme='codedark'
" call darcula#Hi('Normal', darcula#palette.fg, ['#1A1B1E', 235])
" call darcula#Hi('LineNr', darcula#palette.lineNumber, ['#1A1B1E', 235])
" call darcula#Hi('SignColumn', darcula#palette.lineNumber, ['#1A1B1E', 235])

" XCODE
"colorscheme xcodelighthc 
" hi MatchParen guifg=#1f1f24 guibg=#fef937 gui=NONE cterm=NONE


" let g:github_colors_soft = 1
" let g:github_colors_block_diffmark = 0
" colorscheme github
" let g:airline_theme='github'

" let g:gruvbox_contrast_light="hard"
" let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox

map ; :Files<CR>
noremap ft :Tags<CR>
noremap fd :Ag<CR>

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
let g:airline#extensions#tabline#enabled = 0
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 0

let test#strategy='floaterm'
let g:floaterm_wintype='split'
let g:user_emmet_leader_key='<C-h>'

" call darcula#Hi('Constant', ['#9876AA', 103], ['#2B2B2B', 235])
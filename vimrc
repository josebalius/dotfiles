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
Plug 'cormacrelf/vim-colors-github'
Plug 'tpope/vim-rhubarb'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'tc50cal/vim-terminal'
Plug 'morhetz/gruvbox'
Plug 'voldikss/vim-floaterm'
Plug 'fxn/vim-monochrome'
Plug 'robertmeta/nofrils'

call plug#end()

" Add the rest of your vim settings here
filetype plugin indent on    " required

set cursorline
let g:airline_theme='dark'
let g:molokai_original = 1

set background=dark
" colorscheme molokai
" let g:airline_theme='codedark'

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

" Name: modified nofrils
" Author: adg
" URL: based on https://github.com/robertmeta/nofrils
" (see this url for latest release & screenshots)
" License: OSI approved MIT license
" Modified: 2016 Feb 26

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "nofrils-dark"

if !exists("g:nofrils_strbackgrounds") " {{{
    let g:nofrils_strbackgrounds = 0
endif " }}}

" Baseline {{{
hi Normal		term=NONE	cterm=NONE	ctermfg=white	ctermbg=black	gui=NONE	guifg=#FFFFFF	guibg=#262626
" }}}

" Faded {{{
hi ColorColumn		term=NONE	cterm=NONE	ctermfg=0	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
hi Comment		term=NONE	cterm=NONE	ctermfg=247	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi FoldColumn		term=NONE	cterm=NONE	ctermfg=0	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
hi Folded		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi LineNr		term=NONE	cterm=NONE	ctermfg=8	ctermbg=235	gui=NONE	guifg=#555555	guibg=#262626
hi NonText		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi SignColumn		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi SpecialKey		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi StatusLineNC		term=NONE	cterm=NONE	ctermfg=white	ctermbg=240	gui=NONE	guifg=#FFFFFF	guibg=#585858
hi VertSplit		term=NONE	cterm=NONE	ctermfg=black	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
" }}}

" Highlighted {{{
hi CursorIM		term=NONE	cterm=NONE	ctermfg=0	ctermbg=4	gui=NONE	guifg=#000000	guibg=#00FFFF
hi CursorLineNr		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi CursorLine		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi CursorColumn		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi Cursor		term=NONE	cterm=NONE	ctermfg=0	ctermbg=4	gui=NONE	guifg=#000000	guibg=#00FFFF
hi Directory		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi ErrorMsg		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi Error		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi ModeMsg		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi MoreMsg		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi Question		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi Search		term=NONE	cterm=NONE	ctermfg=0	ctermbg=6	gui=NONE	guifg=#000000	guibg=#00CDCD
hi StatusLine		term=NONE	cterm=NONE	ctermfg=0	ctermbg=15	gui=NONE	guifg=#000000	guibg=#FFFFFF
hi Todo		        term=NONE	cterm=NONE	ctermfg=247	ctermbg=NONE	gui=NONE	guifg=#00FF00   guibg=#000000
hi VisualNOS		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=69	gui=NONE	guifg=NONE	guibg=#5F87FF
hi WarningMsg		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
" }}}

" Reversed {{{
hi DiffText		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi IncSearch		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi MatchParen		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi Pmenu		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi TabLineSel		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi Visual		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi WildMenu		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
" }}}

" Diff {{{
hi DiffAdd		term=NONE	cterm=NONE	ctermfg=15	ctermbg=22	gui=NONE	guifg=NONE	guibg=#005F00
hi DiffChange		term=NONE	cterm=NONE	ctermfg=15	ctermbg=17	gui=NONE	guifg=NONE	guibg=#00005F
hi DiffDelete		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi DiffText		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
" }}}

" Spell {{{
hi SpellBad		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellCap		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellLocal		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellRare		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
" }}}

" Vim Features {{{
hi Menu		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuSbar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuSel		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuThumb		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Scrollbar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi TabLine		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi TabLineFill		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Tooltip		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
" }}}

" Syntax Highlighting (or lack of) {{{
hi Boolean		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Character		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Conceal		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Conditional		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Constant		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Debug		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Define		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Delimiter		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Directive		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Exception		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Float		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Format		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Function		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Identifier		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Ignore		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Include		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Keyword		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Label		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Macro		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Number		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Operator		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PreCondit		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PreProc		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Repeat		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi SpecialChar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi SpecialComment       term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Special		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Statement		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi StorageClass		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi String		term=NONE	cterm=NONE	ctermfg=251	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Structure		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Tag		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Title		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Typedef		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Type		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Underlined		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
" }}}

" Optional Syntax Features {{{
if g:nofrils_strbackgrounds
    hi String		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=233	gui=NONE	guifg=NONE	guibg=#121212
end
" }}}

"don't allow colorschemes to set a background color
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight String ctermfg=white guifg=white

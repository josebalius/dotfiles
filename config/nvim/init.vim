set nocompatible                 " be iMproved, required
filetype off                     " required

let mapleader=','                " leader key
set linespace=5                  " space between lines
set number                       " show line numbers
set relativenumber               " relative line numbers
set mouse+=a                     " enable mouse support on all modes
set autoread                     " check if file is modified outside of nvim 
set cursorline                   " line highlighting cursor position
set nofoldenable                 " don't fold blocks
set nolist                       " don't render special chars
set lazyredraw                   " be lazy drawing so we are faster
set ttyfast                      " running in fast terminal, so be fast
set clipboard=unnamed            " unnamed clipboard so we can take over it
set colorcolumn=120              " 120 line lenghts is what we like
set timeoutlen=1000              " timeout for detecting commands
syntax on                        " enable syntax
syntax enable 
set t_Co=256                     " enable 256 colors
set completeopt-=preview         " enable auto complete preview window

" backup locations
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//


" setup Plug
call plug#begin("~/.config/nvim/bundle")

Plug 'tpope/vim-fugitive'          " git utils
Plug 'tpope/vim-rhubarb'           " github utils
Plug 'tpope/vim-eunuch'            " UNIX shell commands, :Mkdir, :Move, etc
Plug 'tpope/vim-commentary'        " Comment stuff out
Plug 'tpope/vim-sensible'          " tpope knows more vim than me, sensible defaults
Plug 'fatih/vim-go'                " Go plugin
Plug 'preservim/nerdtree'          " File browser
Plug 'airblade/vim-gitgutter'      " Git gutter
Plug 'github/copilot.vim'          " Copilot
Plug 'ojroques/nvim-osc52'         " Copy to clipboard

Plug 'christoomey/vim-tmux-navigator' " tmux navigation

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter
Plug 'nvim-treesitter/playground'                           " treesitter playground
Plug 'lukas-reineke/indent-blankline.nvim'


" Themes
Plug 'josebalius/darcula-dark.nvim'      " darcula theme
Plug 'tomasiser/vim-code-dark'           " code dark theme
Plug 'robertmeta/nofrils'                " no frills theme
Plug 'josebalius/vim-light-chromeclipse' " light chromeclipse theme
Plug 'lunacookies/vim-colors-xcode'      " xcode theme
Plug 'kkga/vim-envy'                     " envy theme
" Plug 'morhetz/gruvbox'                   " gruvbox theme
Plug 'tpope/vim-vividchalk'              " vividchalk theme 
Plug 'fatih/molokai'                     " molokai theme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'Verf/deepwhite.nvim'
Plug 'yazeed1s/minimal.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'projekt0n/github-nvim-theme'



call plug#end()
" end Plug

" Theme
colorscheme darcula-dark

" Indentation
filetype plugin indent on " ensure we can configure filetype indent settings

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
autocmd FileType javascript setl indentexpr=

" Key mappings
map ; :Files<CR>
noremap gg :GGrep<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

noremap <C-c> :<C-u>'<,'>Commentary<CR>
noremap vv :<C-u>vsplit<CR>
noremap tt :<C-u>split<CR>
noremap fi :BLines<CR>
noremap <Leader>t :<C-u>tabnew<CR>
noremap <Tab> :<C-u>tabnext<CR>
noremap <S-Tab> :<C-u>tabprevious<CR>
noremap <Leader>q :q<CR>
noremap <Leader>w :w<CR>
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
nnoremap <F3> :set hlsearch!<CR>

noremap gt :w <CR>:GoTest<CR>
noremap gf :w <CR>:GoTestFunc<CR>
noremap <Leader>b :w<CR>:GoBuild<CR>
noremap <Leader>im :GoImplements<CR>
noremap <Leader>ref :GoReferrers<CR>

nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
nnoremap <Leader>* :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Tree sitter
lua << EOF
require 'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "ruby", "go" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = false,
    additional_vim_regex_highlighting = false,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
  },
}

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

require('deepwhite').setup({
    -- If you have some anti-blue light setting (f.lux, light bulb, or low blue light mode monitor),
    -- turn it on, this will set the background color to a cooler color to prevent the background from being too warm.
    low_blue_light = true
})
EOF

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! Dark()
  colorscheme nofrils-dark
  hi Normal guibg=#000000 guifg=#FFFFFF
endfun

function! Light()
  colorscheme nofrils-light
  hi Normal guibg=#F7F8F8 guifg=#000000

  hi Keyword gui=bold
  hi Conditional gui=bold 
  hi Statement gui=bold
  hi Repeat gui=bold
  hi Label gui=bold
  " hi Constant guifg=#215FB5
  " hi Type guifg=#215FB5
endfun

function! Xcode()
colorscheme xcodelight 
let $BAT_THEME="GitHub"
endfun

function! Eclipse()
colorscheme light-chromeclipse
hi Normal guibg=#F7F8F8 guifg=#000000
hi Keyword gui=bold
let $BAT_THEME="GitHub"
endfun

function! GruvboxLight()
        set background=light
        colorscheme gruvbox
        let $BAT_THEME="GitHub"
endfun

function! GruvboxDark()
        set background=dark
        colorscheme gruvbox
        let $BAT_THEME="Gruvbox"
endfun


" Go plugin settings
let g:go_fmt_command = "goimports"
let g:go_doc_popup_window = 1
let g:go_code_completion_enabled = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_fields = 0
let g:go_highlight_types = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0

call Xcode()



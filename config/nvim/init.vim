" ========================
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

" ========================
" Plugins (vim-plug)
" ========================
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
Plug 'nvim-mini/mini.indentscope'

" LSP / Completion
Plug 'neovim/nvim-lspconfig'
Plug 'pmizio/typescript-tools.nvim'
Plug 'Saghen/blink.cmp'
Plug 'mason-org/mason.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/conform.nvim'

" Languages
Plug 'fatih/vim-go'
Plug 'mrcjkb/rustaceanvim'

" Themes
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

" ========================
" Colors / Look & Feel
" ========================
let g:codedark_modern = 1
set background=dark
colorscheme base16-bright  " local default; you can switch with helper funcs below

" Make blink popup + selection visible and sane
" (Pmenu / PmenuSel are also used as fallbacks)
if has('termguicolors')
  highlight Pmenu     guibg=#2a2a2a guifg=#d0d0d0
  highlight PmenuSel  guibg=#87afff guifg=#000000 gui=bold
endif

" ========================
" Filetype / Indent
" ========================
filetype plugin indent on

augroup INDENT_SETTINGS
  autocmd!
  autocmd Filetype typescript  setlocal tabstop=4 shiftwidth=4
  autocmd Filetype javascript  setlocal tabstop=2 shiftwidth=2
  autocmd Filetype css         setlocal tabstop=2 shiftwidth=2
  autocmd Filetype scss        setlocal tabstop=2 shiftwidth=2
  autocmd Filetype go          setlocal tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufWritePre *.rb :%s/\s\+$//e
  autocmd FileType javascript setlocal indentexpr=
augroup END

" ========================
" FZF Commands
" ========================
command! -bang -nargs=* Ag call fzf#vim#ag(
      \ <q-args>,
      \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
      \ <bang>0)

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview({
      \     'dir': systemlist('git rev-parse --show-toplevel')[0],
      \     'options': ['--delimiter', ':', '--nth', '3..', '--exact'],
      \   }),
      \   <bang>0)

" ========================
" Keymaps (Vimscript)
" ========================

" -------- Navigation / Tabs / Windows --------
map ; :Files<CR>
noremap gg :GGrep<CR>
noremap vv :<C-u>vsplit<CR>
noremap tt :<C-u>split<CR>
noremap fi :BLines<CR>
noremap <Leader>t :<C-u>tabnew<CR>
noremap <Tab>      :<C-u>tabnext<CR>
noremap <S-Tab>    :<C-u>tabprevious<CR>
noremap <Leader>q :q<CR>
noremap <M-q> :q<CR>
noremap <M-u> u
noremap <M-r> <C-r>
noremap <Leader>w :w<CR>
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
nnoremap <F3> :set hlsearch!<CR>

" Commentary on visual selection
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

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Save with Ctrl-S, always end in NORMAL mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
xnoremap <C-s> <Esc>:w<CR>gv

" ---------- Copilot ----------
let g:copilot_no_tab_map = v:true
" Use Tab to accept Copilot; if nothing to accept, insert a normal Tab
inoremap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")

" ---------- Helpers ----------
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" Smart Ctrl-click (LSP goto def; fallback to tags)
silent! unmap <C-LeftMouse>
nnoremap <silent> <C-LeftMouse> <LeftMouse><Cmd>lua _G.smart_goto_def()<CR>

" Smart Ctrl-] (LSP goto def; fallback to normal tag behavior)
nnoremap <silent> <C-]> <Cmd>lua _G.smart_goto_def()<CR>

" Comment in NORMAL mode
nnoremap <C-_> :Commentary<CR>

" Comment in VISUAL mode (keep selection)
xnoremap <C-_> :Commentary<CR>gv

" -------------------------
" LSP references list UX
" - Enter or double-click jumps
" - Auto-close quickfix/loclist after jump
" -------------------------
augroup QF_UX
  autocmd!
  " When entering quickfix or location-list windows...
  autocmd FileType qf call s:setup_qf_mappings()
augroup END

function! s:setup_qf_mappings() abort
  " Jump on Enter
  nnoremap <silent><buffer> <CR> <CR>:cclose<CR>

  " Jump on double click
  nnoremap <silent><buffer> <2-LeftMouse> <CR>:cclose<CR>

  " Optional: jump on single click (if you want it)
  " nnoremap <silent><buffer> <LeftMouse> <LeftMouse><CR>:cclose<CR>
endfunction

" ==========================
" ESC closes quickfix window
" ==========================
function! s:qf_is_open() abort
  " getwininfo() includes quickfix=1 for quickfix/location-list windows
  return !empty(filter(getwininfo(), 'v:val.quickfix'))
endfunction

function! s:esc_or_close_qf() abort
  " Only intercept when not in insert mode (n/v/o/etc)
  if mode() !=# 'i' && <SID>qf_is_open()
    " Close quickfix (harmless if it's actually a location list window too)
    silent! cclose
    " Also try closing location list in case that's what opened
    silent! lclose
    return
  endif

  " Otherwise: behave like a normal <Esc>
  call feedkeys("\<Esc>", "n")
endfunction

nnoremap <silent> <Esc> :call <SID>esc_or_close_qf()<CR>
xnoremap <silent> <Esc> :call <SID>esc_or_close_qf()<CR>
onoremap <silent> <Esc> :call <SID>esc_or_close_qf()<CR>

" ==========================
" Right-click LSP actions
" ==========================
amenu PopUp.Go\ to\ References :lua vim.lsp.buf.references()<CR>
amenu PopUp.Go\ Back :normal! <C-o><CR>

" =================
" Lua Configuration
" =================
lua << EOF
-- ============
-- Core Requires
-- ============
local lspconfig          = require('lspconfig')
local ts_tools           = require('typescript-tools')
local conform            = require('conform')
local treesitter_configs = require('nvim-treesitter.configs')
local mason              = require('mason')
local blink              = require('blink.cmp')
local osc52              = require('osc52')

-- ============
-- Treesitter
-- ============
treesitter_configs.setup({
  ensure_installed = { "rust", "go", "typescript", "tsx" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = false,  -- keep your local preference
    additional_vim_regex_highlighting = false,
  },
})

-- ============
-- OSC52
-- ============
osc52.setup({
  max_length = 0,
  silent = false,
  trim = false,
  tmux_passthrough = true,
})

vim.keymap.set('n', '<leader>c',  osc52.copy_operator, { expr = true })
vim.keymap.set('n', '<leader>cc', '<leader>c_',         { remap = true })
vim.keymap.set('v', '<leader>c',  osc52.copy_visual)

-- ============
-- Mason
-- ============
mason.setup()

-- ============
-- LSP: Go
-- ============
lspconfig.gopls.setup({
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,        opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,        opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,             opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,       opts)
    vim.keymap.set("n", "<M-.>",      vim.lsp.buf.code_action,       opts)
    vim.keymap.set("n", "<leader>e",  function()
      vim.diagnostic.open_float(nil, { scope = "line" })
    end, opts)
  end,
  settings = {
    gopls = {
      analyses    = { unusedparams = true, shadow = true },
      staticcheck = true,
    },
  },
  flags = { debounce_text_changes = 150 },
})

-- ============
-- LSP: Rust
-- ============
lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      diagnostics = { enable = true },
      cargo = {
        allFeatures            = true,
        loadOutDirsFromCheck   = true,
        runBuildScripts        = true,
      },
      procMacro = {
        enable  = true,
        ignored = { leptos_macro = { "component", "server" } },
      },
      imports = {
        granularity = { group = "module" },
        prefix      = "self",
      },
      completion = {
        addCallArgumentSnippets = false,
        addCallParenthesis      = false,
        autoimport              = { enable = true },
      },
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.codeActionProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.execute_command({
            command   = "rust-analyzer.organizeImports",
            arguments = { vim.uri_from_bufnr(bufnr) },
          })
        end,
      })
    end
  end,
})

-- ============
-- LSP: TypeScript (typescript-tools)
-- ============
ts_tools.setup({
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false, noremap = true, silent = true }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,  opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,       opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,  opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<M-.>",      vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", function()
      vim.diagnostic.open_float(nil, { scope = "line" })
    end, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,      opts)
  end,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints                      = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints              = true,
      includeInlayVariableTypeHints                       = true,
      includeInlayPropertyDeclarationTypeHints            = true,
      includeInlayFunctionLikeReturnTypeHints             = true,
      includeInlayEnumMemberValueHints                    = true,
    },
  },
})

-- ============
-- Formatting: Conform
-- ============
conform.setup({
  formatters_by_ft = {
    typescript       = { "prettierd", stop_after_first = true },
    tsx              = { "prettierd", stop_after_first = true },
    typescriptreact  = { "prettierd", stop_after_first = true },
    javascript       = { "prettierd", stop_after_first = true },
    javascriptreact  = { "prettierd", stop_after_first = true },
  },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})

-- LSP-format fallback on save for TS/JS if Conform didn't run
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- ============
-- Smart goto-definition: LSP first, then normal tag jump (<C-]>)
-- ============
_G.smart_goto_def = function()
  local bufnr = vim.api.nvim_get_current_buf()

  -- New Neovim API – no deprecated calls
  local clients = {}
  if vim.lsp.get_clients then
    clients = vim.lsp.get_clients({ bufnr = bufnr })
  end

  for _, c in pairs(clients) do
    local caps = c.server_capabilities or c.resolved_capabilities
    if caps and (caps.definitionProvider or caps.goto_definition) then
      vim.lsp.buf.definition()
      return
    end
  end

  -- No LSP with definition support → fall back to built-in tag jump
  vim.cmd('normal! <C-]>')
end

-- ============
-- Completion: blink.cmp
-- ============
vim.opt.completeopt = { "menu", "menuone", "noselect" }

blink.setup({
  fuzzy = { implementation = "lua" },
  keymap = {
    preset = "enter",
    -- Enter accepts, fallback inserts newline
    ["<CR>"] = { "accept", "fallback" },
  },
  completion = {
    menu = { auto_show = true },
    list = {
      selection = {
        preselect   = true,
        auto_insert = false,
      },
    },
  },
})

-- Ensure blink highlight groups link nicely to popup menu colors
pcall(vim.api.nvim_set_hl, 0, "BlinkCmpMenu",          { link = "Pmenu" })
pcall(vim.api.nvim_set_hl, 0, "BlinkCmpMenuBorder",    { link = "Pmenu" })
pcall(vim.api.nvim_set_hl, 0, "BlinkCmpGhostText",     { link = "Pmenu" })
pcall(vim.api.nvim_set_hl, 0, "BlinkCmpMenuSelection", { link = "PmenuSel" })

-- ============
-- OSC52 extras
-- ============
vim.keymap.set('n', '<leader>yf', function()
  local path = vim.fn.expand('%:p')
  osc52.copy(path)
end, { desc = 'Yank file path to local clipboard via OSC52' })

-- Yank GBrowse URL (normal)
vim.keymap.set('n', '<leader>gy', function()
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

-- Yank GBrowse URL (visual selection)
vim.keymap.set('v', '<leader>gy', function()
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

-- Mirror all unnamed-register yanks to OSC52 (so y/p + Cmd-V "just work")
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      osc52.copy_register('"')
    end
  end,
})

local ibl = require("ibl")
local hooks = require("ibl.hooks")
-- Set indent colors using ibl's highlight hook so they aren't overridden
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  -- Inactive rails: just a tad lighter than black
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#0c0c0c" })  -- tweak this value to taste
end)

ibl.setup({
  indent = {
    char = "│",
    highlight = "IblIndent",
  },
  scope = {
    enabled = false,  -- we'll handle the active indent with mini.indentscope
  },
})

-- Active indent guide: mini.indentscope
local indentscope = require("mini.indentscope")

-- Bright color for the current indent level guide
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#303030" })

indentscope.setup({
  symbol = "│",  -- same glyph as ibl so it looks like one rail
  draw = {
    -- no animation; just snap to the current indent
    animation = indentscope.gen_animation.none(),
  },
  options = {
    try_as_border = true,
  },
})

-- ============
-- LSP: Sorbet (Ruby)
-- Only enabled when bundle is available and project has sorbet/config
-- ============
do
  local lspconfig = require("lspconfig")
  local util      = require("lspconfig.util")

  -- Only try if `bundle` exists (so `bundle exec srb` can run)
  if vim.fn.executable("bundle") == 1 then
    lspconfig.sorbet.setup({
      -- Run Sorbet in LSP mode through Bundler
      cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--disable-watchman" },

      -- Only attach in projects that look like Sorbet projects
      root_dir = util.root_pattern("sorbet/config", "Gemfile", ".git"),

      single_file_support = false,

      on_attach = function(client, bufnr)
        -- Reuse your usual LSP keymaps
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd",         vim.lsp.buf.definition,  opts)
        vim.keymap.set("n", "gr",         vim.lsp.buf.references,  opts)
        vim.keymap.set("n", "K",          vim.lsp.buf.hover,       opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<M-.>",      vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>e", function()
          vim.diagnostic.open_float(nil, { scope = "line" })
        end, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,      opts)
      end,
    })
  end
end

EOF



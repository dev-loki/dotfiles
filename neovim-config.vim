" general settings
filetype plugin on
filetype indent on
set nobackup
set nowritebackup
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set laststatus=2
set showmode
set showcmd
set cmdheight=2
set termguicolors
set number
set relativenumber
set syntax
set ignorecase
set smartcase
set hlsearch
set hidden
set incsearch
set backspace=indent,eol,start
set nostartofline
set visualbell
set confirm
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set mouse=a
set autoread
set so=5                             " always show so lines around cursor
set ruler
set whichwrap+=<,>,h,l
set undolevels=10000
set lazyredraw
set showmatch
set autoindent
set smartindent
set ffs=unix,dos,mac
set modelines=0                      " Security :/
set foldnestmax=2
set foldminlines=5
set updatetime=333
set shortmess+=c
set signcolumn=yes

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Filespecific
autocmd Filetype html setlocal ts=2 sw=2 expandtab
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" Filespecific Formatters
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css
au FileType php setlocal formatprg=phpcbf

" wildmenu stuff
set wildmenu
set wildmode=longest:full,full
set wildignore=.o,*~,*.pyc,*/.git/*  " ignore compiled files

" statusline
" set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Ctags
"set tags=./tags,./.tags,$HOME/vimtags,$HOME/.vimtags

" key remaps
nnoremap j gj
nnoremap k gk
let mapleader = ","
nmap <leader>w :w!<CR>
nmap <silent> <leader><cr> :noh<cr>
nmap <silent> <leader><space> :noh<cr>

" Splits
nmap <TAB> <C-w>w
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
noremap Q <C-w>q

" Search mappings: These will make it so that going to the next one in a search will center on the line its found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Close the current buffer
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Pasting stuff
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" Easier split pane movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" command remaps
command! W execute 'w !sudo tee % > /dev/nul' <bar> edit!

" Install vim-plug, if not yet installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
    autocmd!
    autocmd BufEnter * :syntax sync maxlines=200
augroup END

" reload init.vim automagically
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Plugin bootstrap
call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'srcery-colors/srcery-vim'

" SyntaxStuff
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" PHP
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'tommcdo/vim-fugitive-blame-ext', { 'for': 'php' }
Plug 'phpstan/vim-phpstan'
Plug 'joonty/vim-phpqa'
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'davidhalter/jedi', { 'for': 'python' }
Plug 'numirias/semshi', { 'for': 'python', 'do': ':UpdateRemotePlugins'}

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

" General Beauty Plugins
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

" Filetree
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
" Plug 'Shougo/defx.nvim' | Plug 'kristijanhusak/defx-git'

" Random stuff
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'majutsushi/tagbar'
Plug 'wellle/visual-split.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'nicwest/vim-camelsnek'
Plug 'tpope/vim-surround'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
call plug#end()

" Theme Settings
" colorscheme ayu " srcery
" let ayucolor = "dark"     " for ayu
colorscheme srcery " ayu
let g:srcery_italic = 1   " for srcery

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" php
let g:php_version_id = 70404
let g:php_var_selector_is_identifier = 1
let php_var_selector_is_identifier = 1
let g:phpqa_codesniffer_args = "--standard=PSR12"
let g:phpqa_messdetector_ruleset = "~/.phpmd.xml"

" phpactor
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorInputListStrategy = 'phpactor#input#list#fzf'
let g:phpactorQuickfixStrategy = 'phpactor#quickfix#fzf'

" php namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
let g:php_namespace_sort_after_insert = 1
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" fzf
noremap <C-f> :FZF --reverse --info=inline<CR>
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.6 } }

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible()
        \ ? "\<C-n>"
        \ : <SID>check_back_space()
            \ ? "\<TAB>"
            \ : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
let g:airline#extensions#coc#enabled = 1

" Camelsnek
let g:camelsnek_alternative_camel_commands=1

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Make startify work with nerdtree
autocmd VimEnter * if !argc() | Startify | wincmd w | endif

" vim phsptan
let g:phpstan_analyse_level = 8

" Gutentags
let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

" airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" Ale
let g:ale_linters = {
    \ 'python': ['flake8','pylint','mypy','prospector'],
    \ 'php': ['php','phpcs','phpstan','phpmd'],
    \ 'javascript': ['eslint'],
    \ 'markdown': ['prettier'],
    \ 'json': ['fixjson','jq'],
    \ 'vue': ['eslint'],
    \ 'go': ['gopls'],
    \}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['isort', 'black'],
    \ 'javascript': ['prettier', 'eslint'],
    \ 'typescript': ['prettier', 'eslint'],
    \ 'scss': ['prettier'],
    \ 'sass': ['prettier'],
    \ 'html': ['prettier', 'tidy'],
    \ 'php': ['remove_trailing_lines','trim_whitespace','phpcbf','php_cs_fixer'],
    \ 'vue': ['prettier'],
    \}
let g:ale_fix_on_save = 1
let g:ale_list_window_size = 5
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_php_phpcbf_standard='PSR12'
let g:ale_php_phpcs_standard='PSR12'
nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error

" vimwiki
let g:vimwiki_list = [{'path': '/media/c/Dokumente/vimwiki/'}]

" Defx settings (Defaults)
" autocmd FileType defx call s:defx_my_settings()
" map <F3> :Defx -split=vertical -winwidth=42 -direction=botright -toggle -columns=git:mark:filename:type<CR>
" function! s:defx_my_settings() abort
"     " Define mappings
"     nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
"     nnoremap <silent><buffer><expr> c defx#do_action('copy')
"     nnoremap <silent><buffer><expr> m defx#do_action('move')
"     nnoremap <silent><buffer><expr> p defx#do_action('paste')
"     nnoremap <silent><buffer><expr> l defx#do_action('open')
"     nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
"     nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
"     nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
"     nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
"     nnoremap <silent><buffer><expr> N defx#do_action('new_file')
"     nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
"     nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns',
"                                       \ 'mark:indent:icon:filename:type:size:time')
"     nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
"     nnoremap <silent><buffer><expr> d defx#do_action('remove')
"     nnoremap <silent><buffer><expr> r defx#do_action('rename')
"     nnoremap <silent><buffer><expr> !\ defx#do_action('execute_command')
"     nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
"     nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
"     nnoremap <silent><buffer><expr> .\ defx#do_action('toggle_ignored_files')
"     nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
"     nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
"     nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
"     nnoremap <silent><buffer><expr> q defx#do_action('quit')
"     nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
"     nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
"     nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
"     nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
"     nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
"     nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
"     nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
" endfunction

" NERDTree
map <F3> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Fzf additional commands
command! -bang ProjectDoc
    \ call fzf#vim#files('~/projects/doc-snuggles', {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" Use vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'darfink/vim-plist'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'nanotech/jellybeans.vim'
Plug 'racer-rust/vim-racer'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdtree'
Plug 'sentient-lang/vim-sentient'
Plug 'skalnik/vim-vroom'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-syntastic/syntastic'
Plug 'ap/vim-buftabline'

call plug#end()

" Load these plugins before the rest of .vimrc
runtime! plugin/sensible.vim
runtime! plugin/jellybeans.vim

" Map comma as the leader key
let mapleader=","

if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" stty -ixon
set colorcolumn=81                " Draw a vertical bar after 80 characters
set encoding=utf-8                " Use UTF-8 by default
set expandtab                     " Use spaces instead of tabs
set hlsearch                      " Highlight search matches
set ignorecase                    " Make searches case insensitive
set list                          " List invisible characters
set nobackup                      " Don't create backup files
set noswapfile                    " Don't create swap files
set nowrap                        " Don't wrap long lines
set number                        " Show line numbers
set scrolloff=5                   " Scroll the buffer before reaching the end
set shiftwidth=2                  " Auto-indent using 2 spaces
set shortmess+=I                  " Hide the welcome message
set smartcase                     " (Unless they contain a capital letter)
set sts=2                         " Backspace deletes whole tabs at the end of a line
set t_Co=256                      " Use all 256 colours
set tabstop=2                     " A tab is two spaces long
set timeoutlen=300                " Leader key timeout is 300ms
set undodir=~/.vim/undo           " Store undo files in ~/.vim
set undofile                      " Persist undos between sessions
set wildmode=list:longest,full    " Autocompletion favours longer string

" Set status line to: filename [encoding,endings][filetype] ... col,line/lines
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%h%m%r%=%c,%l/%L

" File types to ignore
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*/tmp/*
set wildignore+=*/.git/*,*/.rbx/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*.swp,*~,._*

" Set file types for various extensions
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,*.ru,*.rake} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown | set wrap
au BufRead,BufNewFile {*.json,.jshintrc,.eslintrc,*.pegjs} set ft=javascript

" Use the full window width for the quickfix list
au FileType qf wincmd J

" Quit the quickfix list with q
au FileType qf nmap <buffer> q :q<cr>

" Hide the character column in the quickfix list
au FileType qf setlocal colorcolumn=

" Remember last location in a file, unless it's a git commit message
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" Strip trailing whitespace on write
function! <SID>StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

" Use the jellybeans colorscheme with some tweaks
let g:jellybeans_background_color_256=0
silent! color jellybeans
hi Search ctermfg=black ctermbg=yellow cterm=NONE
hi ColorColumn ctermbg=234
hi StatusLine ctermfg=white ctermbg=black
hi StatusLineNC ctermfg=240 ctermbg=black
hi TabLineFill ctermbg=234
hi TabLine ctermfg=240 ctermbg=234
hi TabLineSel ctermfg=white ctermbg=black
hi QuickFixLine ctermfg=white ctermbg=234 cterm=NONE
hi SignColumn ctermbg=black
hi GitGutterAdd ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=1
hi GitGutterChangeDelete ctermfg=yellow

" Show a larger number of matches in CtrlP
let g:ctrlp_max_height = 30

" Use git to speed up CtrlP file searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Use git to speed up global search
let g:ackprg = 'git grep -H --line-number --no-color'

" Highlight matches after a global search
let g:ackhighlight = 1

" Make the file drawer a little narrower than default
let g:NERDTreeWinSize=35

" Update the location list with syntastic errors
let g:syntastic_always_populate_loc_list = 1

" Don't syntax check when closing a file
let g:syntastic_check_on_wq = 0

" Enable syntastic rust support
let g:syntastic_rust_checkers = ['cargo']

" Set racer executable path for code completion
let g:racer_cmd = "/usr/local/bin/racer"

" Show function signatures in omni completion
let g:racer_experimental_completer = 1

let g:vroom_use_dispatch = 1

let g:ack_mappings = {
              \  '<C-v>':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
              \  '<C-x>': '<C-W><CR><C-W>K' }

" Bind <C-j> to move down the completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" Bind <C-k> to move up the completion list
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Bind nerdtree to leader-n
nmap <leader>n :NERDTreeToggle<cr>

" Bind 'reveal' to leader-N
nmap <leader>N :NERDTreeFind<cr>

" Bind global search to leader-f
nmap <leader>f :set hlsearch<cr>:Ack!<space>

" Search for word under cursor
nnoremap <leader>a :Ack! <C-r><C-w><CR>

" Search for class under cursor
nnoremap <leader>c :Ack! -w 'class <C-r><C-w>'<CR>

" Search for module under cursor
nnoremap <leader>m :Ack! -w 'module <C-r><C-w>'<CR>

" Search for method under cursor
nnoremap <leader>d :Ack! -w 'def <C-r><C-w>'<CR>

" Bind foreground execution to leader-x
nmap <leader>x :Dispatch<space>

" Bind background execution to leader-X
nmap <leader>X :Dispatch!<space>

" Bind 'zero-in' on a command to leader-z
nmap <leader>z :Focus<space>

" Bind 'zero-out' of a command to leader-Z
nmap <leader>Z :Focus!<space>

" Bind vim-dispatch quickfix output to leader-Q
nmap <leader>Q :Copen<cr>

" Bind starting an interactive command to leader-s
" nmap <leader>s :Start<space>

" Bind starting an interactive command (new tab) to leader-S
nmap <leader>S :Start!<space>

" Disable ex mode
map Q <Nop>

" Copy to end of line
nnoremap Y y$

" Copying and paste to system clipboard
vmap <leader>y "*y

" Paste from temp file
nmap <leader>p "*p

" Move to the previous buffer with "."
nmap \ :bn<CR>

" Move to the next buffer with ","
nmap ; :bp<CR>

" Delete buffer but keep pane with "\;"
nmap \; :bp<bar>sp<bar>bn<bar>bd<CR>

" Switching buffers
nmap <silent> <Tab><Up> :wincmd k<CR>
nmap <silent> <Tab><Down> :wincmd j<CR>
nmap <silent> <Tab><Left> :wincmd h<CR>
nmap <silent> <Tab><Right> :wincmd l<CR>

" make ctrl w do nothing in insert mode
imap <silent> <C-w> <Nop>

" resize windows
nnoremap <silent> + :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> - :exe "vertical resize " . (winwidth(0) * 4/5)<CR>
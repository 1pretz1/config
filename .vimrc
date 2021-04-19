" Use vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdtree'
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'vim-syntastic/syntastic'
Plug 'ap/vim-buftabline'
Plug 'timakro/vim-searchant'
Plug 'tpope/vim-dispatch'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'tomtom/tcomment_vim'

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

" Store FZF history
let g:fzf_history_dir = '~/.local/share/fzf-history'

set shortmess-=S                  " report number of matches when searching / or ?
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

" Always open file from quickfix window in previously focused window on enter,
" also close qf and remove highlighting after search
autocmd FileType qf nnoremap <cr> :exe 'wincmd p \| '.line('.').'cc'<bar>:cclose<bar>:noh<cr>

" import
" Prevent random syntax highlighting from being removed by reloading it on
" every action
autocmd Syntax * :syntax sync fromstart

" Use git to speed up global search if ag isnt available
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
else
  let g:ackprg = 'git grep -H --line-number --no-color'
endif

"
" Highlight matches after a global search
let g:ackhighlight = 1

" Make the file drawer a little narrower than default
let g:NERDTreeWinSize=35

" Update the location list with syntastic errors
let g:syntastic_always_populate_loc_list = 1

" Don't syntax check when closing a file
let g:syntastic_check_on_wq = 0

" Set racer executable path for code completion
let g:racer_cmd = "/usr/local/bin/racer"

" Show function signatures in omni completion
let g:racer_experimental_completer = 1

let g:vroom_use_dispatch = 1

" Capital :W and :Q map to save and quit respectively
:command! W w
:command! Q q

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

nmap <leader>b :ID<cr>
:command ID :normal i import remote_pdb; remote_pdb.set_trace(host='0.0.0.0', port=3000)<ESC>

" Ag search
command! -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>)
"command! -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, '--color-path "1;36"', <bang>0)

" Search for word under cursor
noremap <Leader>a :<C-u>let cmd = "Ack! <C-r><C-w>"<bar>call histadd("cmd", cmd)<bar>execute cmd<CR>

" Search for method under cursor
nnoremap <leader>d :<C-u>let cmd = "Ack! -w 'def <C-r><C-w>\|def self\.<C-r><C-w>'"<bar>call histadd("cmd", cmd)<bar>execute cmd<CR>

" Search for class/module under cursor
nnoremap <leader>c :<C-u>let cmd = "Ack! -w 'class <C-r><C-w>\|module <C-r><C-w>'"<bar>call histadd("cmd", cmd)<bar>execute cmd<CR>

nnoremap <Leader>gd :Gdiff<cr>

nnoremap <Leader>o :copen<cr>

" Bind foreground execution to leader-x
nmap <leader>x :Dispatch<space>

" Bind background execution to leader-X
nmap <leader>X :Dispatch!<space>

" FZF search
nnoremap <C-p> :FZF<cr>

" Open ctrl-p in buffer mode
nmap <C-b> :Buffer<cr>

" Disable ex mode
map Q <Nop>

" Copy to end of line
nnoremap Y y$

" Dont add {} motion to jumplist
nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>

" Move to the previous buffer with "."
nmap <silent> \ :bn<CR>

" Move to the next buffer with ","
nmap <silent> ; :bp<CR>

" Delete buffer and switch to previous window
nnoremap <silent> \; :lclose<bar>b#<bar>bd #<CR>

" Switching buffers
nmap <silent> <Tab><Up> :wincmd k<CR>
nmap <silent> <Tab><Down> :wincmd j<CR>
nmap <silent> <Tab><Left> :wincmd h<CR>
nmap <silent> <Tab><Right> :wincmd l<CR>

" make ctrl w do nothing in insert mode
imap <silent> <C-w> <Nop>

" resize windows vertically
nnoremap <silent> + :exe "vertical resize +10"<CR>
nnoremap <silent> _ :exe "vertical resize -10"<CR>

" open quickfix in vim
nnoremap <silent> co :copen<CR>

" open Git blame
nnoremap <silent> gb :Gblame<cr>

" resize windows horizontally
"nnoremap <silent> \| :exe "resize +5"<CR>
"nnoremap <silent> " :exe "resize -5"<CR>

" Dont copy text on visual paste
xnoremap p pgvy

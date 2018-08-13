"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent!call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
call plug#end()

"let g:airline#extensions#tabline#enabled = 1
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
set number

" Turn on the WiLd menu
"set wildmenu

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax enable 

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf-8

set smarttab

set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Disable highlight when <leader><cr> is pressed
map <silent> ,<cr> :noh<cr>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always show the status line
set laststatus=2

" Remap VIM 0 to first non-blank character
map 0 ^

nmap <C-t> :Files<CR>
nmap ; :Buffers<CR>

" Force vim to highlight files 
augroup filetypedetect
	au BufRead,BufNewFile *.drl set filetype=xml
	au BufRead,BufNewFile *.prc set filetype=plsql
	au BufRead,BufNewFile *.fnc set filetype=plsql
augroup END

""set guifont=Inconsolata\ for\ Powerline
set guifont=monospace\ 8

" 4GL stuff
"autocmd Filetype fgl setlocal omnifunc=fglcomplete#Complete
"autocmd Filetype per setlocal omnifunc=fglcomplete#Complete
au BufNewFile,BufRead *.per setlocal filetype=per
au! Filetype fgl,per,python setl nosmartindent

let g:go_version_warning = 0
" change the cursor to line
if &term =~ '^rxvt'
	let &t_SI .= "\e[6 q"
	let &t_EI .= "\e[2 q"
endif

au BufNewFile,BufRead *.ad setlocal filetype=asciidoc
au BufNewFile,BufRead *.md setlocal filetype=markdown

" turn off max syntax columns (default 3000)
set synmaxcol=0
set encoding=utf-8

" test paste fix xfce
"set t_BE=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setup pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off 
" setup exuberant ctags for windows
if has("win32")
    let Tlist_Ctags_Cmd='D:/My\ Dropbox/vim/win/ctags58/ctags.exe'
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Sets vim not vi compatible
set nocompatible

" Set encoding to utf8
set encoding=utf-8

" Enable filetype plugin
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Easier non-interactive command insertion
nnoremap <Space> :

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim_runtime/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Always show line number
set number

" Disable backup and swapfile
set nobackup
set noswapfile

" Switch to paste mode when F2 is pressed
set pastetoggle=<F2>

" Use ; instead of :
nnoremap ; :

" Use w!! to reopen the file in sudo mode
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Gnome terminal supports 256 colors but does not advertise
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  " Maximize gvim window
  set columns=999
  set lines=50
  " Setup fonts in different OS
  if has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

set background=dark

" Use railscasets when there is 256 color support, otherwise use fallback
if &t_Co == 256
"  colorscheme railscasts2
  colorscheme xoria256
else
  colorscheme zellner
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration for different languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType python setl sw=2 sts=2 et
au FileType javascript setl sw=2 sts=2 et
au FileType html setl sw=2 sts=2 et
au FileType ruby setl sw=2 sts=2 et

" -----------------------------------------------------------------------------
" Vundle
" -----------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'rking/ag.vim'

" General
" -----------------------------------------------------------------------------
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch'
Plugin 'kien/ctrlp.vim'
Plugin 'matchit.zip'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'henrik/vim-open-url'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-markdown'

" General Programming
" -----------------------------------------------------------------------------
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tomtom/tcomment_vim'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'

" JavaScript
" -----------------------------------------------------------------------------
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'elzr/vim-json'

" HTML
" -----------------------------------------------------------------------------
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'

" CSS
" -----------------------------------------------------------------------------
Plugin 'hail2u/vim-css3-syntax'

call vundle#end()


" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
filetype plugin indent on       " automatically detect file types
syntax enable                   " enable syntax highlighting
set mouse=a                     " automatically enable mouse usage
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set shortmess+=I                " remove splash screen
set history=1000                " Store a ton of history (default is 20)
set spell                       " spell checking on
set hidden                      " allow buffer switching without saving
set autoread                    " reload files changed outside vim
set completeopt-=preview        " don't show doc preview window

" Turn off swap files and backups (legacy way of backing up files)
set noswapfile
set nobackup
set nowb

" Save undo history
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" auto-reload vimrc
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost ~/.dotfiles/vimrc source $MYVIMRC
augroup END


" -----------------------------------------------------------------------------
" UI
" -----------------------------------------------------------------------------
set t_Co=256                    " use 256 colors
let base16colorspace=256        " access colors present in 256 colorspace
colorscheme base16-ocean        " set theme
set background=dark             " dark theme variant
set number                      " show line numbers
set cursorline                  " highlight current line
set colorcolumn=81              " line to show 80 character mark
set showcmd                     " show command in bottom bar
set laststatus=2                " always show status line
set backspace=indent,eol,start  " backspace for dummies
set linespace=1                 " No extra spaces between rows
set visualbell                  " No sounds
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uppercase present
set wildmenu                    " visual autocomplete for command menu"
set scrolloff=8                 " start scrolling when 8 lines away from margins
set sidescrolloff=15            " start scrolling when 15 columns away from edge
set sidescroll=1                " more natural, incremental horizontal scrolling
set nofoldenable                " don't fold by default


" -----------------------------------------------------------------------------
" Formatting
" -----------------------------------------------------------------------------
set nowrap                      " don't wrap long lines by default
set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 2 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=2                   " an indentation every four columns
set softtabstop=2               " let backspace delete indent
set matchpairs+=<:>             " match angle brackets on '%'

" Highlight problematic whitespace
set list
set listchars=tab:\ \ ,trail:·,nbsp:.

" Remove trailing whitespaces and ^M chars on save
autocmd FileType javascript,css,html autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


" -----------------------------------------------------------------------------
" Key (re)Mappings
" -----------------------------------------------------------------------------
let mapleader = ','

" remap 'U' to undo, for ease of use
nmap U <c-r>

" Easier window splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Move between splits easily
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Preserve indentation while pasting text from the OS X clipboard
imap <leader>p  <C-O>:set paste<CR><C-r>+<C-O>:set nopaste<CR>
nmap <leader>p  "+p
vmap <leader>p  "+p

" Yank to the clipboard
vmap <leader>y  "+y
nmap <leader>yy  "+yy

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Convenience mappings for file and buffer commands
" Suspend buffer
map <leader>z <C-z>
" Quit
map <leader>q :q<CR>
" Delete current buffer
nmap <leader>x :confirm bd<CR>
" close window/split
map <leader>c :close<CR>
" save session
nnoremap <leader>s :mksession!<CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null


" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" move to beginning/end of line (easier to remember)
nnoremap B ^
nnoremap E $

" Encode HTML entities
nmap <silent> <leader>he :%!perl -p -i -e 'BEGIN { use HTML::Entities; use Encode; } $_=Encode::decode_utf8($_) unless Encode::is_utf8($_); $_=Encode::encode("ascii", $_, sub{HTML::Entities::encode_entities(chr shift)});'<cr>

" Format JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR>


" -----------------------------------------------------------------------------
" Plugin Settings
" -----------------------------------------------------------------------------

" Tern
" -----------------------------------------------------------------------------
let tern_show_signature_in_pum=1

" Airline
" -----------------------------------------------------------------------------
let g:airline_powerline_fonts=1

" ctrlP
" -----------------------------------------------------------------------------
" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

let g:ctrlp_map = ',t'
nnoremap <silent> <leader>t :CtrlPMixed<CR>

" Additional mapping for buffer search
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" NERDTree
" -----------------------------------------------------------------------------
nmap <silent> <leader>f :NERDTreeToggle<CR>

" delimitmate
" -----------------------------------------------------------------------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" surround
" -----------------------------------------------------------------------------
" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

" tcomment
" -----------------------------------------------------------------------------
call tcomment#DefineType('javascript_block', g:tcommentBlockC2)
map <leader>/ gcc
nmap <leader>/ gcc
vmap <leader>/ gc
map <leader>? :TCommentBlock<CR>

" fugitive
" -----------------------------------------------------------------------------
noremap <silent> <leader>gs :Gstatus<cr>

" Syntastic
" -----------------------------------------------------------------------------
let g:syntastic_error_symbol='●'
highlight link SyntasticErrorSign GitGutterDelete
let g:syntastic_warning_symbol='○'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting=0

" Airline
" -----------------------------------------------------------------------------
let g:airline#extensions#syntastic#enabled=1

" Ag
" -----------------------------------------------------------------------------
nnoremap <leader>a :Ag 

" Emmet
" -----------------------------------------------------------------------------
let g:user_emmet_leader_key='<c-e>'

" EasyMotion
" -----------------------------------------------------------------------------
hi EasyMotionTarget ctermfg=red
hi link EasyMotionShade  Comment

" JSDoc
" -----------------------------------------------------------------------------
let g:jsdoc_default_mapping=''


" -----------------------------------------------------------------------------
" Functions
" -----------------------------------------------------------------------------
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,ws :StripTrailingWhitespaces<CR>

" Wrapping function
function! SetupWrapping()
  set wrap! linebreak! nolist!
  if (&wrap)
    set colorcolumn=
  else
    set colorcolumn=81
  endif
  let &showbreak='  '
endfunction
command! Wrap :call SetupWrapping()
map <Leader>wl :Wrap<CR>

" Toggle between number and relativenumber
function! ToggleNumber()
  if(&relativenumber == 1)
      set norelativenumber
      set number
  else
      set relativenumber
  endif
endfunction
command! ToggleNumber :call ToggleNumber()

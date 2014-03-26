" -----------------------------------------------------------------------------
" Environment
" -----------------------------------------------------------------------------
set nocompatible        " must be first line

" Setup Bundle Support
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
" Source our bundle list
source ~/.dotfiles/vimrc.bundles


" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Make Stylus files use the default CSS syntax (vim-stylus doesn't do well
" with curly braces)
autocmd BufNewFile,BufRead *.styl set filetype=css

filetype plugin indent on       " Automatically detect file types.
syntax on                       " syntax highlighting
set mouse=a                     " automatically enable mouse usage
scriptencoding utf-8

"set clipboard=unnamed           " on mac use * register for copy-paste
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set shortmess+=I                " remove splash screen
set history=1000                " Store a ton of history (default is 20)
set spell                       " spell checking on
set hidden                      " allow buffer switching without saving
set autoread                    " reload files changed outside vim

" Turn off swap files and backups
set noswapfile
set nobackup
set nowb

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile


" -----------------------------------------------------------------------------
" Vim UI
" -----------------------------------------------------------------------------
"let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme base16-ocean

" Highlighted text is unreadable in Terminal.app because it
" does not support setting of the cursor foreground color.
if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
  if &background == 'dark'
    hi Visual term=reverse cterm=reverse ctermfg=10 ctermbg=black
  endif
endif

" Fast escape
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=1000
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" line to show 80 character mark
set colorcolumn=81

" highlight current line
set cursorline

" sexy matching brackets
hi MatchParen ctermfg=8

" change cursor shape in different modes (iTerm2)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set laststatus=2                " always show statusline
set noshowmode                  " display the current mode
set backspace=indent,eol,start  " backspace for dummies
set linespace=1                 " No extra spaces between rows
set nu                          " Line numbers on
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolloff=8                 " start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set nofoldenable                " don't fold by default
set foldmethod=indent           " fold based on indent
set list
set listchars=tab:\ \ ,trail:·,nbsp:.         " Highlight problematic whitespace
set ruler                                     " show the ruler
set rulerformat=%30(%=%l,%c%V\ %y%m%r%w\ %P%) " a ruler on steroids


" -----------------------------------------------------------------------------
" Formatting
" -----------------------------------------------------------------------------
set nowrap                      " don't wrap long lines by default
set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 2 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=2                   " an indentation every four columns
set softtabstop=2               " let backspace delete indent
set matchpairs+=<:>             " match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" Remove trailing whitespaces and ^M chars
autocmd FileType javascript,css,stylus,html autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


" -----------------------------------------------------------------------------
" Key (re)Mappings
" -----------------------------------------------------------------------------
let mapleader = ','

" Easier window splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Move between splits easily
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Preserve indentation while pasting text from the OS X clipboard
imap <Leader>p  <C-O>:set paste<CR><C-r>+<C-O>:set nopaste<CR>
nmap <Leader>p  "+p
vmap <Leader>p  "+p

" Yank to the clipboard
vmap <Leader>y  "+y
nmap <Leader>yy  "+yy

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Apple-* Highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <D-*> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Remap 'U' to undo, for ease of use
nmap U <c-r>

" Convenience mappings for file and buffer commands
" Suspend buffer
map <leader>z <C-z>
" Save file
map <leader>s :w<CR>
" Quit
map <leader>q :q<CR>
" Delete buffer
map <leader>x <Plug>Kwbd

" File browser remaps
nmap <silent> <D-\> :maca openFileBrowser:<CR>
nmap <silent> <D-]> :maca revealInFileBrowser:<CR>

" Open terminal here
nmap <silent> <D-O> :!open -a Terminal .<CR><CR>

" Quickly resize window to desired size
nmap <Leader>rs :set columns=84<CR>

" Buffer navigation
" Delete current buffer
nmap <D-X> :confirm bd<CR>
" Previous buffer
nmap <D-H> :confirm bprev<CR>
" Next buffer
nmap <D-L> :confirm bnext<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Encode HTML entities
nmap <silent> <leader>he :%!perl -p -i -e 'BEGIN { use HTML::Entities; use Encode; } $_=Encode::decode_utf8($_) unless Encode::is_utf8($_); $_=Encode::encode("ascii", $_, sub{HTML::Entities::encode_entities(chr shift)});'<cr>

" Format JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR>

" Wrap lines to 80
nmap <Leader>W :set formatoptions+=w<CR>:set tw=80<CR>gggqG<CR>


" -----------------------------------------------------------------------------
" Bundle settings
" -----------------------------------------------------------------------------
" ctrlP
" -----------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = '\.git$'
let g:ctrlp_custom_ignore = 'Build$'
let g:ctrlp_by_filename = 1

let g:ctrlp_map = ',t'
nnoremap <silent> <leader>t :CtrlPMixed<CR>

" Additional mapping for buffer search
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Clear the cache, or 'R'eload ;)
nnoremap <silent> <leader>r :ClearCtrlPCache<CR> :NERDTreeFind<CR>

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
nmap <Leader>/ gcc
imap <Leader>/ gcc
vmap <Leader>/ gc

" NERDTree
" -----------------------------------------------------------------------------
nmap <silent> <leader>f :NERDTreeToggle<CR>

" tabular
" -----------------------------------------------------------------------------
" Hit Cmd-Shift-A then type a character you want to align by
nmap <leader>T :Tabularize /
vmap <leader>T :Tabularize /

" airline
" -----------------------------------------------------------------------------
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline_enable_syntastic=0

" yankring
" -----------------------------------------------------------------------------
let g:yankring_history_file='.yankring-history'
nnoremap <leader>Y :YRShow<CR>

" fugitive
" -----------------------------------------------------------------------------
noremap <silent> <leader>gs :Gstatus<cr>

" fugitive
" -----------------------------------------------------------------------------
let g:gitgutter_enabled = 0

" Syntastic
" -----------------------------------------------------------------------------
let g:syntastic_error_symbol='✗'
let g:syntastic_enable_highlighting=1

" UltiSnips
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsSnippetDirectories=["snippets"]

" Emmet
" -----------------------------------------------------------------------------
let g:user_emmet_leader_key='<c-e>'

" EasyMotion
" -----------------------------------------------------------------------------
hi link EasyMotionTarget Special
hi link EasyMotionShade  Comment

" JSDoc
" -----------------------------------------------------------------------------
let g:jsdoc_default_mapping=''

" Indent Guides
" -----------------------------------------------------------------------------
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black


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

" Z - cd to recent / frequent directories
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'cd ' . path
  endif
endfunction

" Toggle relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <silent> <Leader>n :call NumberToggle()<cr>

" Open file in Chrome
function! OpenInChrome()
  let filePath = escape(expand("%:p"), ' ')
  exec '!open -a Google\ Chrome ' . filePath
endfunction

command! Chrome :call OpenInChrome()

" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Environment {
    " Basics {
        set nocompatible        " must be first line
        " on mac use * register for copy-paste
        "set clipboard=unnamed
    " }

    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
        " Source our bundle list
        source ~/.dotfiles/vimrc.bundles
    " }
" }

" General {
    filetype plugin indent on       " Automatically detect file types.
    syntax on                       " syntax highlighting
    set mouse=a                     " automatically enable mouse usage
    scriptencoding utf-8

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
" }

" Vim UI {
    set background=dark
    colorscheme solarized
    set t_Co=256

    " Highlighted text is unreadable in Terminal.app because it
    " does not support setting of the cursor foreground color.
    if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
         if &background == 'dark'
           " For some reason setting ctermbg to 0 doesn't work...
           " have to set it to some value that no color is assigned for???
            hi Visual term=reverse cterm=reverse ctermfg=10 ctermbg=2000
        endif
    endif
    "
    " line to show 80 character mark
    set colorcolumn=81

    " make line numbers beautiful
    hi LineNr ctermbg=NONE
    hi LineNr ctermfg=black

    " make vert splits beautiful
    hi VertSplit ctermbg=NONE
    hi VertSplit ctermfg=black

    " column color for syntactic errors/warnings
    hi SignColumn ctermbg=NONE

    " highlight current line
    set cursorline

    " change cursor shape in different modes
    "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    "let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    " Graphical interface
    if has("gui_running")
        set background=light

        set columns=84

        " make line numbers beautiful
        hi LineNr guibg=NONE
        hi LineNr guifg=#eee8d5

        " make vert splits beautiful
        hi VertSplit guibg=NONE
        hi VertSplit guifg=#eee8d5

        " Line highlight color
        hi CursorLineNr guifg=#93a1a1

        " column color for syntactic errors/warnings
        hi SignColumn guibg=NONE

        " hot pink for searching is so hawt
        hi Search guifg=#FF5E99
        hi IncSearch guifg=#ff8ab5

        " sexy matching brackets
        hi MatchParen gui=NONE guibg=#93a1a1 guifg=#eee8d5

        " pretty spelling error
        hi SpellBad gui=underline
        hi SpellCap gui=underline
        hi SpellRare gui=underline
        hi SpellLocal gui=underline

        set guifont=Inconsolata:h15     " set font/font-size

        " Disable the scrollbars
        set guioptions-=r
        set guioptions-=L
    endif

    set laststatus=2                " always show statusline
    set noshowmode                    " display the current mode
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
    set listchars=tab:\ \ ,trail:·,nbsp:. " Highlight problematic whitespace
    set ruler                       " show the ruler
    set rulerformat=%30(%=%l,%c%V\ %y%m%r%w\ %P%) " a ruler on steroids
" }

" Formatting {
    set nowrap                      " don't wrap long lines by default
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=2                " use indents of 2 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=2                   " an indentation every four columns
    set softtabstop=2               " let backspace delete indent
    set matchpairs+=<:>             " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key (re)Mappings {
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
    map <leader>x :bd<CR>

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
" }

" Bundle settings {
    " ctrlP {
        let g:ctrlp_working_path_mode = 'rw'
        let g:ctrlp_custom_ignore = '\.git$'
        let g:ctrlp_custom_ignore = 'Build$'
        let g:ctrlp_by_filename = 1

        let g:ctrlp_map = ',t'
        nnoremap <silent> <leader>t :CtrlPMixed<CR>

        " Additional mapping for buffer search
        nnoremap <silent> <leader>b :CtrlPBuffer<CR>

        " Clear the cache, or 'R'eload ;)
        nnoremap <silent> <leader>r :ClearCtrlPCache<cr>
    " }

    " delimitmate {
        let delimitMate_expand_cr = 1
        let delimitMate_expand_space = 1
    " }

    " surround {
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
    " }

    " nerdCommenter {
        " Command-/ to toggle comments
        map <leader>/ <plug>NERDCommenterToggle
        nmap <D-/> <plug>NERDCommenterToggle
        imap <D-/> <plug>NERDCommenterInsert
    " }
    "
    " NERDTree {
        nmap <silent> <leader>f :NERDTreeToggle<CR>
    " }

    " tabular {
        " Hit Cmd-Shift-A then type a character you want to align by
        nmap <D-A> :Tabularize /
        vmap <D-A> :Tabularize /
    " }

    " powerline {
        "set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
    " }
    "
    " airline {
        let g:airline_theme='solarized'
        let g:airline_powerline_fonts=1
        let g:airline_enable_syntastic=0
    " }

    " yankring {
        let g:yankring_history_file = '.yankring-history'
        nnoremap <leader>Y :YRShow<CR>
    " }

    " fugitive {
        noremap <silent> <leader>gs :Gstatus<cr>
    " }

    " neocomplcache {
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_enable_smart_case = 1

        " default # of completions is 100, that's crazy
        let g:neocomplcache_max_list = 5

        " words less than 3 letters long aren't worth completing
        let g:neocomplcache_auto_completion_start_length = 3

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
          let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
          let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'

        " Prevent hanging with python: https://github.com/skwp/dotfiles/issues/163
        let g:neocomplcache_omni_patterns['python'] = ''

        " automatically open and close the popup menu / preview window
        "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        " disable preview window entirely
        set completeopt-=preview
    " }

    " Syntastic {
        let g:syntastic_error_symbol='✗'
        let g:syntastic_enable_highlighting = 1
    " }

    " Zen coding {
        let g:user_zen_leader_key = '<c-e>'
    " }
" }

" Functions {
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

" Toggle Solarized theme
function! ToggleSolarizedTheme()
  if (&background == 'dark')
    set background=light
    hi LineNr guibg=NONE
    hi LineNr guifg=#eee8d5
    hi CursorLineNr guifg=#93a1a1
    hi SignColumn guibg=NONE
  else
    set background=dark
    hi LineNr guibg=NONE
    hi LineNr guifg=#073642
    hi CursorLineNr guifg=#586e75
    hi SignColumn guibg=NONE
  endif
endfunction
command! ToggleSolarized :call ToggleSolarizedTheme()

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
" }

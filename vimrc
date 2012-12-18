" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Environment {
    " Basics {
        set nocompatible        " must be first line
        " one mac use * register for copy-paste
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

    " Fixes {
        " fix for Shopify liquid templates loosing HTML highlighting
        "autocmd BufNewFile,BufReadPost page.*.liquid let b:liquid_subtype = 'html'
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

    " Enable omni completion.
    autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    " I prefer the Omni-Completion tip window to close when a selection is made
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

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

    " Highlighted text is unreadable in Terminal.app because it
    " does not support setting of the cursor foreground color.
    if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
         if &background == 'dark'
           " For some reason setting ctermbg to 0 doesn't work...
           " have to set it to some value that no color is assigned for???
            hi Visual term=reverse cterm=reverse ctermfg=10 ctermbg=2000
        endif
    endif

    " Graphical interface
    if has("gui_running")
        set background=light

        " line to show 80 character mark
        set colorcolumn=81
        set columns=84
        set cursorline                  " highlight current line

        " make line numbers beautiful
        hi LineNr guibg=#fdf6e3
        hi LineNr guifg=#eee8d5
        hi CursorLineNr guifg=#93a1a1
        " column color for syntactic errors/warnings
        hi SignColumn guibg=#fdf6e3

        set guifont=Inconsolata:h18     " set font/font-size

        " Disable the scrollbars
        set guioptions-=r
        set guioptions-=L

        "set laststatus=2                " always show statusline
    endif

    set showmode                    " display the current mode
    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set gcr=a:blinkon0              " Disable cursor blink
    set visualbell                  " No sounds
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
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

    "Clear current search highlight by double tapping //
    nmap <silent> // :nohlsearch<CR>

    " Apple-* Highlight all occurrences of current word (like '*' but without moving)
    " http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
    nnoremap <D-*> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

    " Remap 'U' to undo, for ease of use
    nmap U <c-r>

    " Move focus to the file browser
    nmap <silent> <D-N> :maca openFileBrowser:<CR>

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
    " Ack {
        " Shortcut for find in project (ack)
        nmap <D-F> :Ack 
    " }

    " ctrlP {
        let g:ctrlp_working_path_mode = 'rw'
        let g:ctrlp_custom_ignore = '\.git$'
        let g:ctrlp_custom_ignore = 'Build$'
        let g:ctrlp_by_filename = 1

        let g:ctrlp_map = ',t'
        nnoremap <silent> <leader>t :CtrlPMixed<CR>

        " Additional mapping for buffer search
        nnoremap <silent> <leader>b :CtrlPBuffer<CR>
        nnoremap <silent> <C-b> :CtrlPBuffer<CR>

        " Cmd-Shift-P to clear the cache
        nnoremap <silent> <D-P> :ClearCtrlPCache<cr>
    " }

    " delimitmate {
        let delimitMate_expand_cr = 1
        let delimitMate_expand_space = 1
    " }

    " surround {
        " ,# Surround a word with #{ruby interpolation}
        map <leader># ysiw#
        vmap <leader># c#{<C-R>"}<ESC>

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
        map <D-/> <plug>NERDCommenterToggle
        imap <D-/> <plug>NERDCommenterInsert
    " }

    " tabular {
        " Hit Cmd-Shift-A then type a character you want to align by
        nmap <D-A> :Tabularize /
        vmap <D-A> :Tabularize /
    " }

    " ruby {
        "let g:rubycomplete_buffer_loading = 1
        "let g:rubycomplete_classes_in_global = 1
        "let g:rubycomplete_rails = 1
    " }

      " powerline {
          let g:Powerline_colorscheme='solarized16'
          let g:Powerline_theme='solarized256'
          if has("gui_running")
            let g:Powerline_colorscheme='solarized256'
            "let g:Powerline_symbols = 'fancy'
            " so our colorscheme is always fresh
            "autocmd VimEnter * PowerlineReloadColorscheme
          endif
      " }

      " yankring {
          let g:yankring_history_file = '.yankring-history'
          nnoremap ,y :YRShow<CR>
      " }

      " supertab {
          let g:SuperTabCrMapping = 0
          let g:SuperTabDefaultCompletionType = 'context'
          let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'
          autocmd FileType *
              \ if &omnifunc != '' |
              \     call SuperTabChain(&omnifunc, '<c-p>') |
              \ endif
      " }

      " fugitive {
          noremap <silent> <leader>gs :Gstatus<cr>
      " }

      " snipmate {
          let g:snipMate = {}
          let g:snipMate.scope_aliases = {}
          let g:snipMate.scope_aliases['liquid'] = 'html,liquid'
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
    hi LineNr guibg=#fdf6e3
    hi LineNr guifg=#eee8d5
    hi CursorLineNr guifg=#93a1a1
    hi SignColumn guibg=#fdf6e3
    let g:Powerline_colorscheme='solarized'
    :PowerlineReloadColorscheme
  else
    set background=dark
    hi LineNr guibg=#002b36
    hi LineNr guifg=#073642
    hi CursorLineNr guifg=#586e75
    hi SignColumn guibg=#002b36
    let g:Powerline_colorscheme='solarized256'
    :PowerlineReloadColorscheme
  endif
endfunction
command! ToggleSolarized :call ToggleSolarizedTheme()
nmap <leader>s :ToggleSolarized<cr>

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
nmap <Leader>z :Z 

" Toggle relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <silent> <Leader>n :call NumberToggle()<cr>

" Open URL
ruby << EOF
  def open_url
    re = %r{(?i)\b((?:[a-z][\w-]+:(?:/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))*\))+(?:\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))}

    line = VIM::Buffer.current.line
    urls = line.scan(re).flatten

    if urls.empty?
      VIM::message("No URL found in line.")
    else
      system("open", *urls)
      VIM::message(urls.join(" and "))
    end
  end
EOF

function! s:OpenURL()
  ruby open_url
endfunction

command! OpenURL call <SID>OpenURL()
map <leader>u :OpenURL<CR>

" Open file in Chrome
function! OpenInChrome()
  let filePath = escape(expand("%:p"), ' ')
  exec '!open -a Google\ Chrome ' . filePath
endfunction

command! Chrome :call OpenInChrome()
" }

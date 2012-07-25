" Make it beautiful - colors, fonts & gui
if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  colorscheme solarized
  set background=dark

  " line to show 80 character mark
  set colorcolumn=81
  set columns=84

  " make line numbers beautiful
  highlight LineNr guibg=#002b36
  highlight LineNr guifg=#073642

  " Highlight selected line
  set cursorline

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set guifont=Inconsolata:h20,Monaco:h17

  " Disable the scrollbars (NERDTree)
  set guioptions-=r
  set guioptions-=L

  " Disable the macvim toolbar
  set guioptions-=T
else
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1
endif


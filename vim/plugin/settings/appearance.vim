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
  " set cursorline

  set guifont=Inconsolata:h20,Monaco:h17

  " Disable the scrollbars
  " set guioptions-=r
  set guioptions-=L

  " Disable the macvim toolbar
  set guioptions-=T
else
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1
endif


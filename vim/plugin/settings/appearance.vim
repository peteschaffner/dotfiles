" Make it beautiful - colors, fonts & gui
if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  colorscheme solarized
  set background=light

  " line to show 80 character mark
  set colorcolumn=81
  set columns=84

  " make line numbers beautiful
  highlight LineNr guibg=#fdf6e3
  highlight LineNr guifg=#eee8d5

  " Highlight selected line
  " set cursorline

  set guifont=Inconsolata:h20,Menlo:h18

  " Disable the scrollbars
  set guioptions-=r
  set guioptions-=L

else
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1
endif


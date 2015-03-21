#!/usr/bin/env zsh

# Nested->Menu Item = \033Nested\033Menu Item

# Sketch
defaults write com.bohemiancoding.sketch3 NSUserKeyEquivalents '{
  "Hide Colors" = "@$c";
  "Round to Nearest Pixel Edge" = "@~r";
  "Show Colors" = "@$c";
  "Top" = "@^k";
  "Right" = "@^l";
  "Bottom" = "@^j";
  "Left" = "@^h";
  "\033Arrange\033Align Objects\033Vertically" = "@^-";
  "\033Arrange\033Align Objects\033Horizontally" = "@^\\";
  "\033Arrange\033Distribute Objects\033Vertically" = "$@^-";
  "\033Arrange\033Distribute Objects\033Horizontally" = "$@^\\";
}'

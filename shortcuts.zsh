#!/usr/bin/env zsh

# Key:
# control => ^
# option => ~
# command => @
# shift => $
# Nested->Menu Item => \033Nested\033Menu Item

# Sketch
defaults write com.bohemiancoding.sketch3 NSUserKeyEquivalents '{
  "Hide Colors" = "@$c";
  "Show Colors" = "@$c";
  "Flatten Selection to Bitmap" = "@$f";
  "Scale..." = "@^s";
  "Round to Nearest Pixel Edge" = "@~r";
  "Top" = "@^k";
  "Right" = "@^l";
  "Bottom" = "@^j";
  "Left" = "@^h";
  "\033Arrange\033Align Objects\033Vertically" = "@^-";
  "\033Arrange\033Align Objects\033Horizontally" = "@^\\";
  "\033Arrange\033Distribute Objects\033Vertically" = "$@^-";
  "\033Arrange\033Distribute Objects\033Horizontally" = "$@^\\";
}'

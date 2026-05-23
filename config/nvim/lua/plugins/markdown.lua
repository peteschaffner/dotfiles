-- Prettify markdown directly in the buffer (headings, bullets, code blocks,
-- checkboxes) -- a calm reading view, not a separate preview window.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    heading = {
      sign = false,          -- no gutter clutter
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      backgrounds = {},       -- no colored block behind headings, just colored text
    },
    code = {
      sign = false,
      style = "normal", -- show the background block but NOT the language label line
                        -- (that label's fill is drawn with block glyphs that don't
                        -- flip cleanly on a light/dark toggle)
      width = "block",
      left_pad = 1,
      right_pad = 1,
    },
    bullet = {
      icons = { "•", "◦", "▪", "▫" },
    },
    checkbox = {
      unchecked = { icon = "☐ " },
      checked = { icon = "☑ " },
    },
    dash = { width = 60 },
  },
}

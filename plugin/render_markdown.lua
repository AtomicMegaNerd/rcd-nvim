require("render-markdown").setup({
  win_options = {
    wrap = { default = false, rendered = true },
    linebreak = { default = false, rendered = true },
    smoothscroll = { default = false, rendered = true },
    breakindent = { default = true, rendered = true },
  },
  heading = {
    border = true,
    border_virtual = true,
  },
  link = {
    -- TODO: Turn off icons?
  },
  sign = {
    enabled = false,
  },
  code = {
    border = "thick",
    language = false,
  },
})

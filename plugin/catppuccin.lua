local catppuccin = require("catppuccin")
catppuccin.setup({
  flavour = "frappe",
  no_italic = true,
  integrations = {
    grug_far = true,
    overseer = true,
    which_key = true,
    render_markdown = true,
    mini = true,
    blink_cmp = true,
    fzf = true,
  },
  -- Make comments stand out a lot more
  highlight_overrides = {
    latte = function(latte)
      return {
        Comment = { fg = latte.teal },
      }
    end,
    frappe = function(frappe)
      return {
        Comment = { fg = frappe.teal },
      }
    end,
    macchiato = function(macchiato)
      return {
        Comment = { fg = macchiato.teal },
      }
    end,
    mocha = function(mocha)
      return {
        Comment = { fg = mocha.teal },
      }
    end,
  },
})
vim.cmd.colorscheme("catppuccin-nvim")

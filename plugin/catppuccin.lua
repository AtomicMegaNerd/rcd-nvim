if vim.env.COLOR_THEME == "catppuccin" then
  local catppuccin = require("catppuccin")
  local flavor = vim.env.CATPUCCIN_FLAVOR or "frappe"
  local accent = vim.env.CATPUCCIN_ACCENT or "sapphire"
  catppuccin.setup({
    flavour = flavor,
    accent = accent,
    no_italic = true,
    integrations = {
      grug_far = true,
      overseer = true,
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
end

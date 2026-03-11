return {
  "norcalli/nvim-colorizer.lua",

  config = function()
    local utils = require("amn.utils")
    local colorizer = utils.do_import("colorizer")

    if not colorizer then
      return
    end

    colorizer.setup()
  end,
}

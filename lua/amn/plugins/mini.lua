return {
  "nvim-mini/mini.nvim",
  version = "*",

  config = function()
    local utils = require("amn.utils")

    -- The plugin and their config functions live here...
    local mini_plugins = {
      ["mini.icons"] = {},
      ["mini.surround"] = {},
      ["mini.comment"] = {},
      ["mini.statusline"] = {},
      ["mini.ai"] = {},
      ["mini.diff"] = {},
    }

    -- Iterate over each mini plugin and run setup() on it
    for plugin_str, plugin_conf in pairs(mini_plugins) do
      local plugin = utils.do_import(plugin_str)
      if not plugin then
        return
      end
      plugin.setup(plugin_conf)
    end
  end,
}

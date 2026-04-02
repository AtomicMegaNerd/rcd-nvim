return {
  cmd = {
    "lua-language-server",
    "--cachepath",
    vim.fn.stdpath("cache") .. "/lua-language-server",
  },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      -- NOTE: Use stylua for formatting
      format = { enable = false },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
    },
  },
}

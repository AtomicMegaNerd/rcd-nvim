local fzf = require("fzf-lua")
local map = vim.keymap.set

-- Config Overrides
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        appendclipped = true,
        nilness = true,
        shadow = true,
        simplifyslicing = true,
        slicesdelete = true,
        useany = true,
        unusedvariable = true,
        unusedwrite = true,
      },
      semanticTokens = true,
      staticcheck = false,
      renameMovesSubpackages = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = "Disable" },
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
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false,
      validate = false,
    },
  },
})

-- LSP's to enable
vim.lsp.enable({
  "bashls",
  "biome",
  "docker_language_server",
  "emmet_ls",
  "gopls",
  "lemminx",
  "marksman",
  "lua_ls",
  "nil_ls",
  "nushell",
  "tsgo",
  "yamlls",
  "rust-analyzer",
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Keybindings to attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- General LSP keymaps
    map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf, desc = "[C]ode [R]ename" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "[C]ode [A]ction" })
    map("n", "<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
    end, { buffer = args.buf, desc = "[C]ode Toggle Inlay [H]int" })

    map("n", "gd", fzf.lsp_definitions, { buffer = args.buf, desc = "[G]oto [D]ef" })
    map("n", "gl", fzf.lsp_declarations, { buffer = args.buf, desc = "[G]oto Dec[l]" })
    map("n", "gr", fzf.lsp_references, { buffer = args.buf, desc = "[G]oto [R]efs" })
    map("n", "gi", fzf.lsp_implementations, { buffer = args.buf, desc = "[G]oto [I]mpl" })
    map("n", "gt", fzf.lsp_typedefs, { buffer = args.buf, desc = "[G]oto [T]ype Def" })

    -- Enable document color if supported by the server
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
      vim.lsp.document_color.enable(true)
    end
  end,
})

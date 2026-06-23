local fzf = require("fzf-lua")

-- Config Overrides
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      semanticTokens = true,
      staticcheck = false,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
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

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
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
  "lua_ls",
  "nil_ls",
  "nushell",
  "pyright",
  "ruff",
  "tsgo",
  "yamlls",
})

-- Keybindings to attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- General LSP keymaps
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    vim.keymap.set("n", "<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { desc = "[C]ode Toggle Inlay [H]int" })

    vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]ef" })
    vim.keymap.set("n", "gl", fzf.lsp_declarations, { desc = "[G]oto Dec[l]" })
    vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "[G]oto [R]efs" })
    vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "[G]oto [I]mpl" })
    vim.keymap.set("n", "gt", fzf.lsp_typedefs, { desc = "[G]oto [T]ype Def" })

    -- Enable document color if supported by the server
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
      vim.lsp.document_color.enable(true)
    end
  end,
})

return {
  "neovim/nvim-lspconfig",
  config = function()
    local servers = {
      "ruff",
      "pyright",
      "lua_ls",
      "gopls",
      "docker_language_server",
      "yamlls",
      "bashls",
      "cssls",
      "jsonls",
      "emmet_ls",
      "html",
      "marksman",
    }

    for _, lsp in ipairs(servers) do
      vim.lsp.enable(lsp)
    end

    vim.lsp.config("yamlls", {
      filetypes = { "yaml" },
      settings = {
        yaml = {
          keyOrdering = false,
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

    vim.lsp.config("emmet_ls", {
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = false,
          gofumpt = true,
        },
      },
    })
  end,
}

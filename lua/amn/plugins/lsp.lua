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

    vim.lsp.config("html", {
      on_attach = function(client)
        client.server_capabilities.completionProvider = nil
      end,
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

    local utils = require("amn.utils")

    utils.nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame", "LSP")
    utils.nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", "LSP")
    utils.nmap("K", vim.lsp.buf.hover, "Hover Documentation", "LSP")
    utils.nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation", "LSP")
    utils.nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition", "LSP")
    utils.nmap("gl", vim.lsp.buf.declaration, "[G]oto Dec[l]aration", "LSP")
    utils.nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation", "LSP")
    utils.nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition", "LSP")
    utils.nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences", "LSP")
    utils.nmap("<leader>ci", vim.lsp.buf.incoming_calls, "[C]all Hierarchy [I]ncoming", "LSP")
    utils.nmap("<leader>co", vim.lsp.buf.outgoing_calls, "[C]all Hierarchy [O]utgoing", "LSP")
    utils.nmap("td", vim.diagnostic.open_float, "[T]oggle [D]iagnostic", "LSP")
    utils.nmap("tn", vim.diagnostic.goto_next, "[T]o [N]ext Diagnostic", "LSP")
    utils.nmap("tp", vim.diagnostic.goto_prev, "[T]o [P]rev Diagnostic", "LSP")
    utils.nmap("<leader>ti", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, "[T]oggle [I]nlay Hint", "LSP")
  end,
}

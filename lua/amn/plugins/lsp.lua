return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ction" },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Documentation" },
    { "gd", vim.lsp.buf.definition, desc = "[G]oto [D]efinition" },
    { "gl", vim.lsp.buf.declaration, desc = "[G]oto Dec[l]aration" },
    { "gi", vim.lsp.buf.implementation, desc = "[G]oto [I]mplementation" },
    { "gt", vim.lsp.buf.type_definition, desc = "[G]oto [T]ype Definition" },
    { "gr", vim.lsp.buf.references, desc = "[G]oto [R]eferences" },
    { "<leader>ci", vim.lsp.buf.incoming_calls, desc = "[C]all Hierarchy [I]ncoming" },
    { "<leader>co", vim.lsp.buf.outgoing_calls, desc = "[C]all Hierarchy [O]utgoing" },
    { "td", vim.diagnostic.open_float, desc = "[T]oggle [D]iagnostic" },
    { "tn", vim.diagnostic.goto_next, desc = "[T]o [N]ext Diagnostic" },
    { "tp", vim.diagnostic.goto_prev, desc = "[T]o [P]rev Diagnostic" },
    {
      "<leader>ti",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end,
      desc = "[T]oggle [I]nlay Hint",
    },
  },
  config = function()
    local servers = {
      "bashls",
      "copilot",
      "cssls",
      "docker_language_server",
      "emmet_ls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "pyright",
      "ruff",
      "yamlls",
    }

    for _, lsp in ipairs(servers) do
      vim.lsp.enable(lsp)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if
          client
          and client:supports_method(
            vim.lsp.protocol.Methods.textDocument_inlineCompletion,
            args.buf
          )
        then
          vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
          vim.keymap.set(
            "i",
            "<C-y>",
            vim.lsp.inline_completion.get,
            { desc = "Copilot: accept", buffer = args.buf }
          )
          vim.keymap.set(
            "i",
            "<C-n>",
            vim.lsp.inline_completion.select,
            { desc = "Copilot: cycle", buffer = args.buf }
          )
        end
      end,
    })

    vim.lsp.config("copilot", {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
        filetypes = {
          markdown = false,
          gitconfig = false,
        },
      },
    })

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
  end,
}

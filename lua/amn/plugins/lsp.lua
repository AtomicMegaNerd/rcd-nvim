return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    --
    -- Global defaults for all servers
    --------------------------------------------------------------------------------
    vim.lsp.config("*", {
      root_markers = { ".git" },
    })

    --
    -- Per-server configuration
    --------------------------------------------------------------------------------
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

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "Snacks" },
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      root_markers = { "go.mod" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = false,
          gofumpt = true,
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

    -- Enable all servers
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

    --
    -- Buffer-local LSP configuration on attach
    --------------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        local buf = args.buf

        -- General LSP keymaps
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "[R]e[n]ame" })
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = buf, desc = "[C]ode [A]ction" }
        )
        vim.keymap.set(
          "n",
          "<C-k>",
          vim.lsp.buf.signature_help,
          { buffer = buf, desc = "Signature Documentation" }
        )
        vim.keymap.set("n", "<leader>ti", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end, { buffer = buf, desc = "[T]oggle [I]nlay Hint" })

        -- Picker-backed LSP navigation (overrides gr* defaults)
        vim.keymap.set("n", "gd", function()
          Snacks.picker.lsp_definitions()
        end, { buffer = buf, desc = "[G]oto [D]efinition" })
        vim.keymap.set("n", "gl", function()
          Snacks.picker.lsp_declarations()
        end, { buffer = buf, desc = "[G]oto Dec[l]aration" })
        vim.keymap.set("n", "grr", function()
          Snacks.picker.lsp_references()
        end, { buffer = buf, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "gri", function()
          Snacks.picker.lsp_implementations()
        end, { buffer = buf, desc = "[G]oto [I]mplementation" })
        vim.keymap.set("n", "grt", function()
          Snacks.picker.lsp_type_definitions()
        end, { buffer = buf, desc = "[G]oto [T]ype Definition" })

        -- Disable completion for HTML since Emmet provides it
        if client.name == "html" then
          client.server_capabilities.completionProvider = nil
        end

        -- Enable document color if supported by the server
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
          vim.lsp.document_color.enable(true, { bufnr = buf })
        end

        -- Enable inline completion if supported by the server
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, buf) then
          vim.lsp.inline_completion.enable(true, { bufnr = buf })
          vim.keymap.set(
            "i",
            "<C-y>",
            vim.lsp.inline_completion.get,
            { desc = "Inline Completion: accept", buffer = buf }
          )
          vim.keymap.set(
            "i",
            "<C-n>",
            vim.lsp.inline_completion.select,
            { desc = "Inline Completion: cycle", buffer = buf }
          )
        end
      end,
    })
  end,
}

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.lsp.config("*", {
      root_markers = { ".git" },
    })

    local servers = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()

    vim.lsp.enable(servers)
  end,
})

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

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
    vim.keymap.set("n", "<leader>ti", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { buffer = buf, desc = "[T]oggle [I]nlay Hint" })

    -- Picker-backed LSP navigation (overrides gr* defaults)
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "gd", fzf.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "gl", fzf.lsp_declarations, { buffer = buf, desc = "[G]oto Dec[l]aration" })
    vim.keymap.set("n", "grr", fzf.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })
    vim.keymap.set(
      "n",
      "gri",
      fzf.lsp_implementations,
      { buffer = buf, desc = "[G]oto [I]mplementation" }
    )
    vim.keymap.set(
      "n",
      "grt",
      fzf.lsp_typedefs,
      { buffer = buf, desc = "[G]oto [T]ype Definition" }
    )

    -- Disable completion for HTML since Emmet provides it
    if client.name == "html" then
      client.server_capabilities.completionProvider = nil
    end

    -- Enable document color if supported by the server
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
      vim.lsp.document_color.enable(true, { bufnr = buf })
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    if type(value) ~= "table" or value.kind ~= "end" then
      return
    end
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or "LSP"
    vim.notify(client_name .. ": " .. (value.title or "done"))
  end,
})

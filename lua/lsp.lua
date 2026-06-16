-- Enable the following LSP's
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
  "yammls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local buf = args.buf

    -- General LSP keymaps
    vim.keymap.set(
      "n",
      "<leader>cr",
      vim.lsp.buf.rename,
      { buffer = buf, desc = "[C]ode [R]ename" }
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      vim.lsp.buf.code_action,
      { buffer = buf, desc = "[C]ode [A]ction" }
    )
    vim.keymap.set("n", "<leader>cti", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { buffer = buf, desc = "[C]ode [T]oggle [I]nlay Hint" })

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

    -- Enable document color if supported by the server
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
      vim.lsp.document_color.enable(true, { bufnr = buf })
    end
  end,
})

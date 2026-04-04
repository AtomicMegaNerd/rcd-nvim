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

-- LSP progress → Ghostty OSC 9;4 progress bar (Neovim 0.12+)
-- Bridges LspProgress events to nvim_echo progress messages, which cause
-- the TUI to emit OSC 9;4 sequences that Ghostty renders as a native progress bar.
----------------------------------------------------------------
local lsp_progress_grp = vim.api.nvim_create_augroup("LspProgressBar", { clear = true })
vim.api.nvim_create_autocmd("LspProgress", {
  group = lsp_progress_grp,
  callback = function(ev)
    local params = ev.data.params
    local value = params.value
    if type(value) ~= "table" then
      return
    end

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or "LSP"
    local id = client_name .. "." .. tostring(params.token)

    local is_done = value.kind == "end"
    vim.api.nvim_echo({}, false, {
      id = id,
      kind = "progress",
      title = value.title or client_name,
      source = client_name,
      percent = value.percentage,
      status = is_done and "success" or "running",
    })

    if is_done then
      vim.defer_fn(function()
        vim.cmd("echon ''")
      end, 0)
    end
  end,
})

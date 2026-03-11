return {
  "jinzhongjia/LspUI.nvim",
  branch = "main",
  config = function()
    local utils = require("amn.utils")
    local lspui = utils.do_import("LspUI")
    if not lspui then
      return
    end
    local lspui_api = lspui.api
    lspui.setup({
      inlay_hint = {
        enable = true,
      },
    })

    -- Key mappings
    utils.nmap("<leader>rn", lspui_api.rename, "[R]e[n]ame", "LSP")
    utils.nmap("<leader>ca", lspui_api.code_action, "[C]ode [A]ction", "LSP")
    utils.nmap("K", lspui_api.hover, "Hover Documentation", "LSP")
    utils.nmap("<C-k>", lspui_api.signature, "Signature Documentation", "LSP")
    utils.nmap("gd", lspui_api.definition, "[G]oto [d]efinition", "LSP")
    utils.nmap("gl", lspui_api.declaration, "[G]oto [D]eclaration", "LSP")
    utils.nmap("gi", lspui_api.implementation, "[G]oto [I]mplementation", "LSP")
    utils.nmap("gt", lspui_api.type_definition, "[G]oto [T]ype Definition", "LSP")
    utils.nmap("gr", lspui_api.reference, "[G]oto [R]eferences", "LSP")
    utils.nmap("gh", lspui_api.jump_history, "[G]oto [h]istory", "LSP")
    utils.nmap("gH", lspui_api.hover, "[G]oto [H]over", "LSP")
    utils.nmap("<leader>ci", function()
      lspui_api.call_hierarchy("incoming_calls")
    end, "[C]all Hierarchy [I]ncoming", "LSP")
    utils.nmap("<leader>co", function()
      lspui_api.call_hierarchy("outgoing_calls")
    end, "[C]all Hierarchy [O]utgoing", "LSP")
    utils.nmap("td", function()
      lspui_api.diagnostic("show")
    end, "[T]oggle [D]iagnostic", "LSP")
    utils.nmap("tn", function()
      lspui_api.diagnostic("next")
    end, "[T]o [N]ext Diagnostic", "LSP")
    utils.nmap("tp", function()
      lspui_api.diagnostic("prev")
    end, "[T]o [P]rev Diagnostic", "LSP")
    utils.nmap("<leader>ti", lspui_api.inlay_hint, "[T]oggle [I]inlay Hint", "LSP")
  end,
}

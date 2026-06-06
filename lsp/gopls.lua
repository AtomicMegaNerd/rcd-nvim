return {
  cmd = { "gopls" },
  root_markers = { "go.mod" },
  workspace_required = true,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      deepCompletion = true,
      matcher = "fuzzy",
      semanticTokens = true,
      staticcheck = false,
      codelenses = {
        generate = true,
        gc_details = true,
      },
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
}

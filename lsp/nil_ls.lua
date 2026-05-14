return {
  cmd = { "nil" },
  root_markers = { "flake.nix" },
  workspace_required = true,
  filetypes = { "nix" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
      nix = {
        flake = {
          autoEvalInputs = false,
        },
      },
    },
  },
}

return {
  cmd = { "nil" },
  root_markers = { "flake.nix", "default.nix", ".git" },
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

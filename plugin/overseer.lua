local overseer = require("overseer")
overseer.setup({})

overseer.register_template({
  name = "go test (current package)",
  tags = { overseer.TAG.TEST },
  condition = { filetype = { "go", "gomod" } },
  builder = function()
    return {
      cmd = { "gotestsum", "--watch=false", "--format=standard-verbose", "--", "-count=1", "." },
      cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
      components = { "default" },
    }
  end,
})

overseer.register_template({
  name = "nix",
  generator = function(search)
    local flake = vim.fs.find("flake.nix", { upward = true, path = search.dir })
    if vim.tbl_isempty(flake) then
      return {}
    end
    local root = vim.fs.dirname(flake[1])
    return {
      {
        name = "nix flake update",
        builder = function()
          return { cmd = "nix flake update", cwd = root, components = { "default" } }
        end,
      },
      {
        name = "nix flake check",
        builder = function()
          return { cmd = "nix flake check", cwd = root, components = { "default" } }
        end,
      },
      {
        name = "nh home update",
        builder = function()
          return { cmd = "nh home update .", cwd = root, components = { "default" } }
        end,
      },
      {
        name = "nh darwin update",
        builder = function()
          return { cmd = "nh darwin update .", cwd = root, components = { "default" } }
        end,
      },
      {
        name = "nh os update",
        builder = function()
          return { cmd = "nh os update .", cwd = root, components = { "default" } }
        end,
      },
    }
  end,
})

overseer.add_template_hook({}, function(task_defn, util)
  util.add_component(
    task_defn,
    { "open_output", direction = "float", on_start = "always", focus = true }
  )
end)

local map = vim.keymap.set
map("n", "<leader>vr", overseer.run_task, { desc = "Overseer [V]erseer [R]un" })
map("n", "<leader>va", overseer.open, { desc = "Overseer [V]erseer t[A]sk list" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "OverseerOutput",
  group = vim.api.nvim_create_augroup("OverseerOutput", { clear = true }),
  callback = function(args)
    map("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
    map("t", "q", "<C-\\><C-n><cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
  end,
})

local overseer = require("overseer")
overseer.setup({})

local templates = {
  { name = "go build", cmd = "go build ./...", tags = { overseer.TAG.BUILD } },
  { name = "go test", cmd = "go test ./...", tags = { overseer.TAG.TEST } },
  {
    name = "golangci-lint run",
    cmd = "golangci-lint run --color=never",
    tags = { overseer.TAG.TEST },
  },
  { name = "go mod tidy", cmd = "go mod tidy", tags = { overseer.TAG.CLEAN } },
}

overseer.register_template({
  name = "go",
  condition = { filetype = { "go", "gomod" } },
  generator = function()
    return vim.tbl_map(function(t)
      return {
        name = t.name,
        tags = t.tags,
        builder = function()
          return {
            cmd = t.cmd,
            cwd = vim.fs.root(0, { "go.mod", "go.work" }),
            components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
          }
        end,
      }
    end, templates)
  end,
})

local map = vim.keymap.set
map("n", "<leader>vr", overseer.run_task, { desc = "Overseer [V]erseer [R]un" })
map("n", "<leader>va", overseer.open, { desc = "Overseer [V]erseer t[A]sk list" })
map("n", "<leader>vc", overseer.close, { desc = "Overseer [V]erseer [C]lose" })
map("n", "<leader>vq", function()
  require("quicker").toggle({ focus = false })
end, { desc = "Overseer [V]erseer toggle [Q]uickfix" })

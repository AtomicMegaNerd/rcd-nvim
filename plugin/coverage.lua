vim.pack.add({ "https://github.com/andythigpen/nvim-coverage" })

local coverage = require("coverage")
coverage.setup({
  auto_reload = true,
  lang = {
    go = { coverage_file = "cover.out" },
  },
})

local coverage_files = { go = "cover.out", python = ".coverage" }
local coverage_group = vim.api.nvim_create_augroup("amn-coverage", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = coverage_group,
  pattern = { "go", "python" },
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    local cov_file = coverage_files[ft]
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. cov_file) == 1 then
      coverage.load()
      coverage.show()
    end
  end,
  desc = "Load and show coverage for Go and Python buffers",
})

vim.keymap.set("n", "<leader>va", function()
  coverage.load(true)
end, { desc = "Co[V]erage lo[A]d and show" })
vim.keymap.set("n", "<leader>vl", function()
  coverage.load()
end, { desc = "Co[V]erage [L]oad" })
vim.keymap.set("n", "<leader>vi", function()
  coverage.load_lcov()
end, { desc = "Co[V]erage lcov [I]mport" })
vim.keymap.set("n", "<leader>vo", function()
  coverage.show()
end, { desc = "Co[V]erage sh[O]w" })
vim.keymap.set("n", "<leader>vh", function()
  coverage.hide()
end, { desc = "Co[V]erage [H]ide" })
vim.keymap.set("n", "<leader>vt", function()
  coverage.toggle()
end, { desc = "Co[V]erage [T]oggle" })
vim.keymap.set("n", "<leader>vc", function()
  coverage.clear()
end, { desc = "Co[V]erage [C]lear" })
vim.keymap.set("n", "<leader>vs", function()
  coverage.summary()
end, { desc = "Co[V]erage [S]ummary" })

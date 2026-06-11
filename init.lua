--     ___   __                  _      __  ___                 _   __              __
--    /   | / /_____  ____ ___  (_)____/  |/  /__  ____ _____ _/ | / /__  _________/ /
--   / /| |/ __/ __ \/ __ `__ \/ / ___/ /|_/ / _ \/ __ `/ __ `/  |/ / _ \/ ___/ __  /
--  / ___ / /_/ /_/ / / / / / / / /__/ /  / /  __/ /_/ / /_/ / /|  /  __/ /  / /_/ /
-- /_/  |_\__/\____/_/ /_/ /_/_/\___/_/  /_/\___/\__, /\__,_/_/ |_/\___/_/   \__,_/
--                                              /____/
--
-- Neovim Configuration File

require("options")
require("pack")
require("autocmds")
require("keymap")
require("lsp")

-- Prepend mise shims to PATH on systems that use it
-- Make sure AMN_MISE is set to 1 in your shell
if vim.env.AMN_MISE == "1" then
  vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
end

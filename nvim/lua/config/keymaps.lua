-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

map("n", "<leader>rbp", 'orequire "pry"; binding.pry # DEBUG @kevindew<esc>', { desc = "Insert Ruby pry breakpoint" })
map("n", "<leader>rbb", 'orequire "byebug"; byebug # DEBUG @kevindew<esc>', { desc = "Insert Ruby byebug breakpoint" })
map("n", "<leader>rdb", "odebugger # DEBUG @kevindew<esc>", { desc = "Insert Ruby debugger breakpoint" })

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- editing a python file is very slow (~2s) without this to stop searching for python3 executable
vim.g.python3_host_prog = "~/.pyenv/shims/python3"

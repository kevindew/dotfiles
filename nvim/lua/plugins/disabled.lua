return {
  -- disable tree-sitter - it hasn't played nice with Ruby (maybe later switch it to only be disabled for Ruby)
  { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
  { "nvim-treesitter/playground", enabled = false },
  { "neovim/nvim-lspconfig", enabled = false },
  { "mason/mason.nvim", enabled = false },
}

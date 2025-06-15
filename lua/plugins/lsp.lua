local ensure_installed = { "lua_ls", "vue_ls@3.0.0-alpha.10", "vtsls", "tailwindcss", "eslint" }

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = ensure_installed,
    automatic_enable = false,
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
  },
}

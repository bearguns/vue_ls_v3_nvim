vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client) then
      if client:supports_method('textDocument/inlayHint') and vim.g.auto_inlay_hint then
        vim.lsp.inlay_hint.enable()
      end

      if client:supports_method('textDocument/declaration') then
        vim.keymap.set("n", "gD", function()
          vim.lsp.buf.declaration({ bufnr = args.buf })
        end)
      end

      if client:supports_method('textDocument/definition') then
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition({ buffer = args.buf })
        end)
      end

      -- -@see doc :h vim.lsp.document_color
      if client:supports_method('textDocument/documentColor') then
        if vim.lsp.document_color then
          vim.lsp.document_color.enable(true, args.buf, {
            style = 'virtual',
          })
        end
      end
    end
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded"
      })
    end, {
      buffer = args.buf,
      noremap = true,
    })
    vim.keymap.set("n", "gl", function()
      vim.diagnostic.open_float({ bufnr = args.buf, border = "rounded" })
    end, {
      buffer = args.buf,
      noremap = true,
      desc = "Open diagnostic float",
    })
  end,
})

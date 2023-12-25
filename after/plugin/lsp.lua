local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {"rust_analyzer", "r_language_server", "clangd"},
  handlers = {
    lsp_zero.default_setup,
  },
})

require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.r_language_server.setup{}

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-n>'] = cmp_action.luasnip_jump_forward(),
    ['<C-y>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

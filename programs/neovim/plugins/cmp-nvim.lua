local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),

      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping.close(),

      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
	        if not entry then
	          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	        else
	          cmp.confirm()
	        end
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {'i', 's', 'c',}),
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })
      }),
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'treesitter'},
      { name = 'luasnip' },
      }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.util.default_config.capabilies = capabilities

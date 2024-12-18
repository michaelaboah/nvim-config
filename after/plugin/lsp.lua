local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>ra", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps( { buffer = bufnr })
end)


lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 100000,
    },
    servers = {
        ['ts_ls'] = {'javascript', 'typescript'},
        ['rust_analyzer'] = {'rust'},
        ['gopls'] = {'go'},
    }

})

lsp_zero.setup()


require('mason').setup({})

require('mason-lspconfig').setup({
	ensure_installed = { 'ts_ls', 'rust_analyzer', 'gopls'},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,

        html = function()
            local config = {
                filetypes = {"html", "templ"},
            }
           require('lspconfig').html.setup(config)
        end,

        htmx = function()
            local config = {
                filetypes = {"html", "templ"},
            }
           require('lspconfig').htmx.setup(config)
        end,

        tailwindcss = function()
            local config = {
                filetypes = {"astro", "templ", "javascript", "typescript"},
                init_options = { userLanguages = { templ = "html" } },
            }
           require('lspconfig').tailwindcss.setup(config)
        end,

        clangd = function()
            local config = {
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_dir = require('lspconfig.util').root_pattern("compile_commands.json", ".git") or vim.loop.cwd,
            }
           require('lspconfig').clangd.setup(config)
        end
	}
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = 'path'},
		{ name = 'nvim_lsp'},
		{ name = 'nvim_lua'},
		{ name = 'luasnip', keyword_length = 2},
		{ name = 'buffer', keyword_length = 3},
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
		['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
		['<Enter>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
})

vim.filetype.add({ extension = { templ = "templ" } })


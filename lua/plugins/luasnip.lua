return {
-- {
--     "L3MON4D3/LuaSnip",
--     config = function()
--       require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath "config" .. "/luasnippets/" })
--       -- reload will not work because I store my snippets in a different file, the module would have to be reloaded.
--       require("luasnip").config.setup({
--         enable_autosnippets = true,
--         link_children = true, --autosnippets do not expand withing snippets
--         store_selection_keys = "<Tab>",
--       })
--       -- this caused an error for some reason
--       -- vim.cmd([[sunmap n]])
--
--       -- improvement; load math snippets for the right file types.
--       -- load_ft_func = function(bufnr)
--       --   if bufnr == "markdown" then
--       --     -- will load `react.lua` for this buffer
--       --     return { "markdown", "tex" }
--       --   else
--       --     return require("luasnip.extras.filetype_functions").from_filetype_load
--       --   end
--       -- end
--     end,
--   },
}

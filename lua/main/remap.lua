vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ':Ex<CR>')  -- Open File Viewer
vim.keymap.set("n", "<C-s>", ':w<CR>', { noremap = true, silent = true }) -- Save file



vim.keymap.set("n", "<leader>y","\"+y")
vim.keymap.set("v", "<leader>y","\"+y")
vim.keymap.set("n", "<leader>Y","\"+Y")

-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
--   callback = function()
--     if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
--       vim.api.nvim_command('silent update')
--     end
--   end,
-- })


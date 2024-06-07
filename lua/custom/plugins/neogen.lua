return {
  'danymat/neogen',
  config = function()
    require('neogen').setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'google_docstrings',
          },
        },
        lua = {
          template = {
            annotation_convention = 'emmylua', -- for a full list of annotation_conventions, see supported-languages below,
          },
        },
      },
    }
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<Leader>ng', ":lua require('neogen').generate()<CR>", opts)
  end,
}

local function set_transparent()
  local hl_groups = {
    "normal",
    "normalnc",
    "normalfloat",
    "endofbuffer",
    "vertsplit",
    "folded",
    "foldcolumn",
    "signcolumn",
    "statusline",
    "statuslinenc",
    "tabline",
    "tablinefill",
    "tablinesel",
    "winbar",
    "winbarnc",
    "cursorlinenr",
    "linenr",
    "pmenu",
  }
  for _, group in ipairs(hl_groups) do
    vim.cmd(("hi %s guibg=none ctermbg=none"):format(group))
  end
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e222a", fg = "#aaaaaa" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#20252c" })
end

vim.api.nvim_create_autocmd({ "colorscheme", "BufEnter" }, {
  pattern = "*",
  callback = set_transparent,
})

set_transparent()

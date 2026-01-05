return {
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-completion" },
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      local bufopts = { noremap = true, silent = true, desc = "" }
      local nmap = function(lhs, rhs, bufopts, desc)
        bufopts.desc = desc
        vim.keymap.set("n", lhs, rhs, bufopts)
      end

      nmap("<leader>D", vim.cmd.DBUIToggle, bufopts, "Open DBUI")
    end,
  },
}

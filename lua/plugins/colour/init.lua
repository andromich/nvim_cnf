return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { italic = false },
        variables = {},
      },
      sidebars = { "qf", "help", "packer" },
      lualine_bold = true,
      on_colors = function(colors)
        colors.bg = "#181818" -- optional override
      end,
      on_highlights = function(highlights, colors)
        highlights.Comment = { fg = "#767676", italic = true } -- optional override
      end,
    },
    config = function(_, opts)
      local eldritch = require("eldritch")

      eldritch.setup(opts)

      vim.cmd([[ colorscheme eldritch-dark ]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "eldritch" },
    },
  },

  -- { "Hoffs/omnisharp-extended-lsp.nvim" },

  -- {
  --   "nvim-mini/mini.starter",
  --   version = false,
  --   event = "VimEnter",
  --   opts = function()
  --     local dashboard = require("config.dashboards")
  --     return dashboard.dboard()
  --   end,
  -- },
}

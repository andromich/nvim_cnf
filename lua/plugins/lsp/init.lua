local home = vim.fn.expand("~")

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Keep your existing servers intact (jdtls, etc.)
      -- opts.servers.sonarlint = {
      --   cmd = {
      --     "java",
      --     "-jar",
      --     home .. "/tools/sonarlint43/target/sonarlint-language-server-4.3-SNAPSHOT.jar",
      --     "-stdio",
      --   },
      --   filetypes = { "java" },
      --   root_dir = require("lspconfig.util").root_pattern(
      --     "sonarlint.json",
      --     "sonarlint.yaml",
      --     "pom.xml",
      --     "build.gradle",
      --     ".git"
      --   ),
      --   settings = {
      --     sonarlint = {
      --       -- optional things
      --       telemetry = false,
      --       configuration = {
      --         rules = {
      --           -- ["java:S106"] = "off", -- example disable
      --         },
      --       },
      --     },
      --   },
      -- }

      -- opts.servers.lemminx = {
      --   cmd = { "lemminx" }, -- Mason puts this on your PATH
      --   filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
      --   settings = {
      --     xml = {
      --       format = { enabled = true, splitAttributes = true },
      --       catalogs = {},
      --       validation = { enabled = true },
      --       completion = { autoCloseTags = true },
      --     },
      --   },
      -- }

      opts.servers.lua_ls = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            workspace = {
              checkThirdParty = false,
              -- Only include Neovim runtime files and your config
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/vim/library",
                "${3rd}/busted/library",
              },
              ignoreDir = {
                ".git",
                "node_modules",
                "dist",
                "build",
                "__pycache__",
              },
              maxPreload = 500, -- default ~2000
              preloadFileSize = 150, -- skip huge files
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }

      opts.servers.jedi_language_server = {
        settings = {
          jedi = {
            completion = {
              enable = true,
              fuzzy = true,
            },
            diagnostics = {
              enable = true,
            },
            hover = {
              enable = true,
            },
            symbols = {
              enable = true,
            },
          },
        },
      }
      return opts
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, _)
      -- Use correct Windows path separator
      local mason_path = vim.fn.stdpath("data") .. "\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe"

      -- Check if it exists (debugging helper)
      if vim.fn.filereadable(mason_path) == 0 then
        vim.notify("debugpy Python binary not found at: " .. mason_path, vim.log.levels.ERROR)
      end

      require("dap-python").setup(mason_path)

      -- Optional: keymaps
      vim.keymap.set("n", "<leader>dt", function()
        require("dap-python").test_method()
      end, { desc = "Debug Python Test Method" })
      vim.keymap.set("n", "<leader>df", function()
        require("dap-python").test_class()
      end, { desc = "Debug Python Test Class" })
    end,
  },

  -- Java LSP support
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "mfussenegger/nvim-dap", -- debugging core
      "jay-babu/mason-nvim-dap.nvim", -- auto installs adapters
    },
  },

  {
    "epwalsh/obsidian.nvim",
    opts = {
      workspaces = { { name = "personal", path = "~/notes" } },
      completion = { nvim_cmp = true },
    },
    ft = { "markdown" },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*", -- or a specific tag
    ft = { "markdown" },
    cmd = { "RenderMarkdown", "RenderMarkdownToggle", "RenderMarkdownConfig" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- optional but gives nice icons
    },

    config = function()
      require("render-markdown").setup({
        enable = true,
        file_types = { "markdown" },

        render = {
          heading = {
            bold = true,
            sign = true,
            icons = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎰", "󰎳" },
          },
          code = {
            style = "full",
            border = "rounded",
            language = "visible",
          },
          list = {
            markers = { "•", "◦", "▪" },
            checkboxes = {
              unchecked = "",
              checked = "",
              pending = "",
            },
          },
          link = { underline = true },
          table = { border = true },
          frontmatter = { conceal = true },
        },

        performance = { max_lines = 5000 },
      })

      -- optional manual keymap
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdownToggle<CR>", { desc = "Toggle Markdown Render" })
    end,
  },

  -- {
  --   "ellisonleao/glow.nvim",
  --   ft = { "markdown" },
  --   cmd = "Glow",
  --   config = function()
  --     vim.keymap.set("n", "<leader>mp", function()
  --       vim.cmd([[ Glow ]])
  --     end, { noremap = true, silent = true, desc = "Markdown Preview (Glow)" })
  --     require("glow").setup({
  --       -- full path to the glow binary (default: use system PATH)
  --       glow_path = "C:/Users/600078/.bin/glow.exe",
  --
  --       -- style options: "dark" | "light" | "auto"
  --       style = "dark",
  --
  --       -- border style for floating window
  --       border = "rounded",
  --
  --       -- width ratio relative to editor window
  --       width_ratio = 0.9,
  --       height_ratio = 0.9,
  --       pager = true,
  --     })
  --   end,
  -- },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   verion = false,
  --   build = "cd app && npm install",
  --   cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   config = function()
  --     -- open preview in your default browser automatically
  --     vim.g.mkdp_auto_start = 0
  --     vim.g.mkdp_auto_close = 1
  --     vim.g.mkdp_refresh_slow = 0
  --     vim.g.mkdp_browser = "" -- leave empty for default system browser
  --   end,
  -- },

  {
    -- Completion engine
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      -- Snippet engine
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      { "saadparwaiz1/cmp_luasnip" },

      -- LSP completion source
      { "hrsh7th/cmp-nvim-lsp" },

      -- Common extra sources
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },

      -- Nice icons in completion menu
      { "onsails/lspkind.nvim" },

      -- Optional: autopairs on confirm (needs nvim-autopairs)
      { "windwp/nvim-autopairs" },
    },

    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "copilot" })
    end,

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load friendly‑snippets if you use them
      -- require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.setup({})

      -- Helper for tab key selection / snippet jump
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Smart tab / shift‑tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })

      -- ✅ Autopairs integration
      local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end

      -- ✅ Cmdline completions --------------------------

      -- `/` search suggestions (from current buffer)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- `:` command‑line suggestions (filesystem + commands)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },

  -- Blink.cmp for selected filetypes (super fast)
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    opts = { accept_keymap = "<CR>" },
    init = function()
      -- Disable default cmp on these filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "rust", "cpp", "c" },
        callback = function()
          vim.b.cmp_enabled = false -- Turns off nvim-cmp
          require("blink.cmp").enable() -- Enables blink.cmp in this buf
        end,
      })
    end,
  },

  -- return {
  --   "supermaven-inc/supermaven-nvim",
  --   event = "InsertEnter",
  --   opts = {
  --     keymaps = {
  --       accept_suggestion = "<C-y>",
  --       decline_suggestion = "<C-d>",
  --     },
  --     disable_filetypes = { "markdown", "txt" },
  --   },
  -- }

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true, -- <— make suggestions appear automatically
        debounce = 75, -- controls how quickly suggestions update
        keymap = {
          accept = "<C-l>", -- accept suggestion
          next = "<M-]>", -- next suggestion
          prev = "<M-[>", -- previous suggestion
          dismiss = "<C-]>", -- dismiss suggestion
        },
      },
      panel = { enabled = false },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- Optionally connect Copilot completions to nvim-cmp
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
}

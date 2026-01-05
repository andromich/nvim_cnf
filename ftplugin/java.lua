local jdtls = require("jdtls")
local home = vim.fn.expand("~")

local root_markers = { "pom.xml", ".project", ".classpath", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/java_workspace/geye/" .. project_name

local java_cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx2g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "-jar",
  "C:/Users/600078/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
  "-configuration",
  "C:/Users/600078/jdtls/config_win",
  "-data",
  workspace_dir,
}

local bundles = {}
vim.list_extend(bundles, {
  home
    .. "/AppData/Local/nvim-data/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.2.jar",
})
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(home .. "/AppData/Local/nvim-data/mason/packages/java-test/extension/server/*.jar"), "\n")
)

-- local bufopts = { noremap = true, silent = true }
-- local nmap = function(lhs, rhs, bopts, desc)
--   bopts.desc = desc
--   vim.keymap.set("n", lhs, rhs, bopts)
-- end

-- nmap("<leader>wsl", function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, bufopts, "List Workspace Folders")
-- nmap("<leader>wsa", vim.lsp.buf.add_workspace_folder, bufopts, "Add Workspace Folder")
-- nmap("<leader>wsr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove Workspace Folder")

local opts = {
  cmd = java_cmd,
  root_dir = root_dir,
  init_options = { bundles = bundles },
  on_attach = function(client, bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
  end,
  settings = {
    java = {
      home = os.getenv("JAVA_HOME"),
      configuration = {
        runtimes = {
          { name = "JavaSE-21", path = "C:/Program Files/Amazon Corretto/jdk21.0.9_10" },
        },
      },
      format = {
        enabled = true,
        settings = {
          url = "file:///C:/Users/600078/jdtls/config_win/formatter.xml",
          profile = "GoogleStyle",
        },
      },
      compile = {
        nullAnalysis = { mode = "automatic" },
      },
    },
    project = {
      exclusionPatterns = {
        "*/src/test/**",
        "**/src/test/**",
        "**/test/**",
      },
    },
    import = {
      exclusions = {
        "*/src/test/**",
        "**/src/test/**",
        "**/test/**",
      },
    },
  },
}
-- jdtls.start_or_attach(opts)

-- Add convenient user command
vim.api.nvim_create_user_command("AttachWildFly", function()
  require("dap").run({
    type = "java",
    request = "attach",
    name = "Attach to WildFly :8787",
    hostName = "127.0.0.1",
    port = 8787,
  })
end, {})

local s_or_a = function(props)
  local bufopts = { noremap = true, silent = true }
  local nmap = function(lhs, rhs, bopts, desc)
    bopts.desc = desc
    vim.keymap.set("n", lhs, rhs, bopts)
  end

  nmap("<leader>wsl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List Workspace Folders")
  nmap("<leader>wsa", vim.lsp.buf.add_workspace_folder, bufopts, "Add Workspace Folder")
  nmap("<leader>wsr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove Workspace Folder")
  -- nmap("<leader>wsp", function()
  --   jdtls.pick_java_main_class()
  -- end, bufopts, "Choose Main Class")
  nmap("<leader>wsm", function()
    jdtls.debug_picker()
  end, bufopts, "Debug Launch Main Class")

  jdtls.start_or_attach(props)

  local dap = require("dap")

  -- nvim-dap configuration for attaching to WildFly
  dap.configurations.java = dap.configurations.java or {}

  local exists = false

  for _, cfg in ipairs(dap.configurations.java) do
    if cfg.name == "Attach to WildFly :8787" then
      exists = true
    end
  end
  if not exists then
    table.insert(dap.configurations.java, {
      type = "java",
      request = "attach",
      name = "Attach to WildFly :8787",
      hostName = "127.0.0.1",
      port = 8787,
    })
  end

  nmap("<leader>wsd", function()
    vim.cmd([[ AttachWildFly ]])
  end, bufopts, "Attach to WildFly")
end

s_or_a(opts)

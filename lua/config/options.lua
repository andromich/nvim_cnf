-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight line under cursor
opt.signcolumn = "yes"
opt.termguicolors = true
opt.colorcolumn = "183" -- Colored column at this text width
opt.laststatus = 1
opt.showtabline = 1
opt.cmdheight = 1 -- Cmd-line appears only when needed
opt.showmode = false -- Hide "-- INSERT --"
opt.fillchars:append({ eob = " " }) -- No tildes on empty lines
opt.pumblend = 0 -- Popup menu transparency
opt.winblend = 0 -- Window blend
opt.cursorlineopt = "number"
opt.mouse = "a" -- Enable mouse everywhere
opt.spelllang = { "en_us" }
opt.synmaxcol = 300
opt.shortmess:append({ c = true })

-- File Encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Scrolling/Columns
opt.scrolloff = 4 -- Context lines above/below cursor
opt.sidescrolloff = 8 -- Context columns side of cursor
opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- File Handling
opt.clipboard = "unnamedplus"
opt.autoread = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.autowrite = true
opt.confirm = true

-- Completion/Popup
opt.completeopt = { "menuone", "noselect" }
opt.wildmode = "longest:full,full"
opt.wildignore:append({
  "*.o",
  "*.obj",
  "*.pyc",
  "*.class",
  "*.jpg",
  "*.png",
  "*.gif",
  "*/.git/*",
  "*/node_modules/*",
  "*/build/*",
  "*/dist/*",
})
opt.wildoptions = "pum"

-- Miscellaneous
opt.shortmess:append("c")
opt.inccommand = "split"
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.sessionoptions:append("globals")
opt.splitright = true
opt.splitbelow = false
opt.equalalways = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.expandtab = true
opt.virtualedit = "block"
opt.ignorecase = true
opt.smartcase = true
opt.redrawtime = 300
opt.updatetime = 200
opt.timeoutlen = 400
opt.diffopt:append({ "linematch:61", "algorithm:histogram", "context:4" })
-- Provider/Plugin Disabling (Miscellaneous)
-- g.loaded_perl_provider = 0
-- g.loaded_ruby_provider = 0
-- g.loaded_node_provider = 0
-- g.loaded_python3_provider = 0

-- Disable built-in plugins (Miscellaneous)
-- g.loaded_tar_plugin = 1
-- g.loaded_zipPlugin = 1
-- g.loaded_2html_plugin = 1
-- g.loaded_shade_plugin = 1
-- g.loaded_gzip = 1
-- g.loaded_tutor_mode_plugin = 1
-- g.loaded_getscript = 1
-- g.loaded_getscriptPlugin = 1
-- g.loaded_vimball = 1
-- g.loaded_vimballPlugin = 1
-- g.loaded_matchit = 1
-- g.loaded_matchparen = 1
-- g.loaded_logiPat = 1
-- g.loaded_rrhelper = 1
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.loaded_netrwSettings = 1
-- g.loaded_netrwFileHandlers = 1

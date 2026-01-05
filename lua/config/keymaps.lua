local nmap = function(lhs, rhs, bopts, desc)
  bopts.desc = desc
  vim.keymap.set("n", lhs, rhs, bopts)
end

local function imap(lhs, rhs, bopts, desc)
  bopts.desc = desc
  vim.keymap.set("i", lhs, rhs, bopts)
end

local function tmap(lhs, rhs, bopts, desc)
  bopts.desc = desc
  vim.keymap.set("t", lhs, rhs, bopts)
end
--
local bufopts = { noremap = true, silent = true }
--
nmap("<leader>we", vim.cmd.Ex, bufopts, "Netrw Explore")
nmap("<leader>wsw", vim.cmd.w, bufopts, "Write File")
nmap("<leader>wss", "<cmd>w<cr>:source %<cr>", bufopts, "Write & Source File")

nmap("<leader>sv", "<C-w>v", bufopts, "Split Vertically")
nmap("<leader>sz", "<C-w>s", bufopts, "Split Horizontally")
nmap("<leader>sx", "<C-w>q", bufopts, "Close Window")

nmap("<C-h>", "<C-w>h", bufopts, "Focus Next Window: Left")
nmap("<C-j>", "<C-w>j", bufopts, "Focus Next Window: Down")
nmap("<C-k>", "<C-w>k", bufopts, "Focus Next Window: Up")
nmap("<C-l>", "<C-w>l", bufopts, "Focus Next Window: Right")

nmap("<localleader><localleader>", "<cmd>Flowterm<cr>a", bufopts, "Open Flowterm Terminal")
tmap("<ESC><ESC>", function()
  vim.cmd([[ Flowterm ]])
end, bufopts, "Close Flowterm Terminal")
tmap("<localleader><ESC>", function()
  vim.cmd([[ bd! ]])
end, bufopts, "Close Flowterm Terminal")

nmap("<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", bufopts, "MarkdownPreview Toggle")

imap("jk", "<ESC>", bufopts, "Normal Mode")

nmap("<localleader><leader>gcd", function()
  vim.cmd([[ Copilot detach ]])
  vim.cmd([[ Copilot disable ]])
end, bufopts, "Detach & Disable Copilot")
nmap("<localleader><leader>gce", function()
  vim.cmd([[ Copilot enable ]])
  vim.cmd([[ Copilot attach ]])
end, bufopts, "Enable & Attach Copilot")

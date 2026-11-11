-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- 模糊查找插件
reload "user.telescope"
-- 快捷键
reload "user.keymaps"
-- 语法高亮、代码解析
reload "user.treesitter"
reload "user.lsp"
reload "user.nvimtree"
reload "user.plugins"
-- reload "user.lazyplugins"
-- 针对lsp signature插件，用于显示函数签名和参数信息
reload "user.signature"
-- 图标
reload "user.outlines"
-- 自动命令
reload "user.autocommands"

-- CMake
-- reload "user.cmake"
-- reload "user.chatgpt"

-- Python
reload "user.python"


lvim.log.level = "warn"
-- general 
-- vim.format_on_save.enabled = false
lvim.colorscheme = "tokyonight-moon"
-- 透明窗口
lvim.transparent_window = true
-- 共享剪贴板
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
lvim.use_icons = true

-- 仪表盘
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lunarvim内置终端插件
lvim.builtin.terminal.active = true


lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- lvim.builtin.which_key.mappings["o"] = {
--   "<cmd>lua require('dap').close()<cr>", -- 结束调试并关闭调试窗口
--   "Close Debug Session"


-- }

-- lvim.builtin.which_key.mappings["o"] = {
--   name = "+Debug",
--   c = {
--     function()
--       local dap = require("dap")
--       local dapui = require("dapui")
--       dap.terminate()
--       dap.disconnect()
--       dap.close()
--       dapui.close()
--       vim.cmd("DapVirtualTextDisable")
--     end,
--     "Close Debug Session"
--   }
-- }
--




---------------------------- 自定义debug相关 ---------------------------------------
lvim.builtin.dap.active = true

-- 自动适配 Mason 安装的 debugpy
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
  require("dap").adapters.python = {
    type = "executable",
    command = mason_path .. "packages/debugpy/venv/bin/python",
    args = { "-m", "debugpy.adapter" },
  }
end)

-- 训练脚本调试配置
local dap = require("dap")
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "🔍 Debug PyTorch Train Script",
    program = "${file}",
    console = "integratedTerminal", -- 输出太多会卡住调试 UI，建议指定控制台为终端
    justMyCode = false, -- 能追踪库代码（如 torch）内部行为
    pythonPath = function()
      return "/home/quan/miniconda3/envs/myretro/bin/python"
    end,
    env = {
      QT_QPA_PLATFORM = "offscreen", -- 防止 Qt 报错
      MPLBACKEND = "Agg",            -- matplotlib 非GUI后端
    },
  },
}

lvim.builtin.which_key.mappings["k"] = {
  name = "+Debug",
  s = { "<cmd>lua require'dap'.continue()<CR>", "🚀 Start Debug (DAP)" },
  b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "⛔ Toggle Breakpoint" },
  o = { "<cmd>lua require'dap'.step_over()<CR>", "⏭  Step Over" },
  i = { "<cmd>lua require'dap'.step_into()<CR>", "⏬ Step Into" },
  u = { "<cmd>lua require'dap'.step_out()<CR>", "⏏  Step Out" },
  r = { "<cmd>lua require'dap'.restart()<CR>", "🔁 Restart Debug" },
  q = {
    function()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.terminate()
      dap.disconnect()
      dap.close()
      dapui.close()
      vim.cmd("DapVirtualTextDisable")
    end,
    "❌ Stop Debug",
  },
}

-- -------------------------------- CMake ---------------------------------------------
-- -- 不跳过 cmake LSP
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
--   function(server) return server ~= "cmake" end,
--   lvim.lsp.automatic_configuration.skipped_servers
-- )
-- -- 配置 cmake-language-server
-- local lsp_manager = require("lvim.lsp.manager")
-- lsp_manager.setup("cmake", {
--   -- cmd = { "cmake-language-server" },
--   cmd = { vim.fn.stdpath("data") .. "/mason/bin/cmake-language-server" },
--   filetypes = { "cmake" },
--   root_dir = require("lspconfig.util").root_pattern("CMakeLists.txt", ".git", "build"),
--   init_options = {
--     buildDirectory = "build"
--   }
-- })
-- -- 确保 CMakeLists.txt 正确识别为 cmake 文件类型
-- vim.cmd [[
--   autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake
-- ]]


-------------------------------- Markdown ---------------------------------------------
vim.api.nvim_create_user_command('MDP', function(opts)
  vim.cmd('edit ' .. opts.args)  -- 加载文件到缓冲区
  vim.cmd('MarkdownPreview')     -- 启动预览
end, { nargs = 1, complete = 'file' })  -- 接受 1 个参数（文件路径）

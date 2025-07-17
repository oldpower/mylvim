-- Additional Plugins
lvim.plugins = {
  -- lsp related
  "ray-x/lsp_signature.nvim",
  -- DAP related
  "rcarriga/nvim-dap-ui",
  "mfussenegger/nvim-dap",
  "ldelossa/nvim-dap-projects",
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- markdown related
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      -- vim.g.mkdp_auto_start = 1
      vim.cmd [[
        let g:mkdp_open_to_the_world = 1
        let g:mkdp_open_ip = '124.89.81.254'
        let g:mkdp_port = 3999
        " let g:mkdp_browser = 'firefox'
        let g:mkdp_browser = '/mnt/c/Program\\ Files/Google/Chrome/Application/chrome.exe'
        " let g:mkdp_browser = 'wslview'
        function! g:EchoUrl(url)
            :echo a:url
        endfunction
        let g:mkdp_browserfunc = 'g:EchoUrl'
      ]]
    end,
  },
  -- outline related
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },

  --CMake
  -- {
  --   "stevearc/dressing.vim"
  -- },
  -- {
  --   "shatur/neovim-cmake"
  -- }

  -- -- chatGPT
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- }
  --
  {
        "Kurama622/llm.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
        cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
        config = function()
            require("llm").setup({
                -- [[ Deepseek ]]
                url = "https://api.deepseek.com/chat/completions",
                model = "deepseek-chat",
                api_type = "openai",
                max_tokens = 4096,
                temperature = 0.3,
                top_p = 0.7,

                prompt = "You are a helpful programming assistant.",

                prefix = {
                    user = { text = "😃 ", hl = "Title" },
                    assistant = { text = "  ", hl = "Added" },
                },

                history_path = "/tmp/llm-history",
                save_session = true,
                max_history = 15,
                max_history_name_length = 20,

                -- stylua: ignore
                keys = {
                    -- The keyboard mapping for the input window.
                    ["Input:Submit"]      = { mode = "n", key = "<cr>" },
                    ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
                    ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

                    -- only works when "save_session = true"
                    ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
                    ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

                    -- The keyboard mapping for the output window in "split" style.
                    ["Output:Ask"]        = { mode = "n", key = "i" },
                    ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
                    ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

                    -- The keyboard mapping for the output and input windows in "float" style.
                    ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
                    ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },

                    -- Scroll
                    ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
                    ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
                    ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
                    ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
                    ["JumpToTop"]         = { mode = "n", key = "gg" },
                    ["JumpToBottom"]      = { mode = "n", key = "G" },
                },
                -- -- code 补全 可选 暂时有问题
                -- app_handler = {
                --     Completion = {
                --         handler = require("llm.tools").completion_handler,
                --         opts = {
                --             url = "https://api.deepseek.com/beta/completions",
                --             model = "deepseek-chat",
                --             api_type = "openai",
                --             fetch_key = function()
                --                 return os.getenv("LLM_KEY")
                --             end,
                --             n_completions = 1,-- 暂时只生成1个补全结果，减少复杂度
                --             context_window = 512,
                --         },
                --     -- 添加这一行，显式指定前端和后端
                --     frontend = require("llm.common.completion.frontends.virtual_text"),
                --     backend = require("llm.common.completion.backends.llm"),
                --     },
                -- },
            })
        end,
        keys = {
            { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
            { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
            { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
            -- -- 代码补全快捷键
            -- { "<C-g>g", mode = "i", function() require("llm.tools").completion_handler() end, desc = "AI Code Completion" },
        },
    }

}

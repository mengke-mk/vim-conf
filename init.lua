-- The art of doing more with less
-- Ke Meng, 2024, nvim 0.10+ required


-------------------------------------------------------------------------------
-- Cheating sheet
-------------------------------------------------------------------------------
-- <leader>n nvimtree
-- <leader>t open terminal
-- <leader>b git-blame
-- <leader>l format
-- <leader>f telescope
-- <leader>d show definition
-- <leader>a code action
-- <leader>m outline
-- <leader>lg lazygit
-- <leader>aa ask avante
-- <leader>ae edit avante
-- <tab> completion; <cr> accept
-- [,] jump-between-errors
-- gs goto-definition
-- K show-documentation

-------------------------------------------------------------------------------
-- Sec-0: Basic settings
-------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,gbk,gb2312,gb18030,ucs-bom,cp936"
vim.opt.termguicolors = true -- enable 24-bit RGB colors
vim.opt.clipboard = "unnamedplus" -- copy to system clipboard
vim.opt.hlsearch = true -- highlight search results
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = false -- don't show relative line numbers
vim.opt.whichwrap = "b,s,h,l,<,>,[,]" -- move to next line with the same indentation
vim.opt.wrap = false -- don't wrap lines
vim.opt.swapfile = false-- don't create swap files
vim.opt.backspace = "indent,eol,start" -- allow backspacing over everything in insert mode
vim.opt.showcmd =  false -- show partial command in the last line
vim.opt.showmode = false -- don't show mode in the last line
vim.opt.autochdir = true -- change directory to the current file
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 2 -- number of spaces to use for auto-indent
vim.opt.tabstop = 2 -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2 -- number of spaces that a <Tab> key in the file counts for
vim.opt.cursorcolumn = true -- highlight the current column
vim.opt.cursorline = false -- don't highlight the current line 
vim.opt.smartindent = true -- auto-indent new lines


-------------------------------------------------------------------------------
-- Sec-1: Plugins
-------------------------------------------------------------------------------
-- Setup lazy.nvim
require("lazy").setup({
  root = vim.fn.stdpath("config") .. "/plugins",
  spec = {
    -- Spec 0: Resources
    {
      -- "sonph/onehalf",
      "folke/tokyonight.nvim",
      lazy = false,
      enabled = true,
      priority = 1000,
      config = function()
         vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {"nvim-tree/nvim-web-devicons", lazy = true},

    -- Spec 1: Navigation
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      enabled = true,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      keys = {
        {"<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree"},
      },
      opts = {}
    },
    {
      'nvim-telescope/telescope.nvim', 
      tag = '0.1.8',
      lazy = true,
      enabled = true,
      keys = {
        {"<leader>f", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Find files"},
      }
    },
    {
      'akinsho/toggleterm.nvim', 
      lazy = true,
      enabled = true,
      version = "*", 
      keys = {
        {"<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal"}
      },
      config = true
    },
    -- Spec 2: LSP
    {
      "williamboman/mason.nvim",
      lazy = false,
      enabled = true,
      config = true,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
      enabled = true,
      config = function()
        require("mason-lspconfig").setup {
          ensure_installed =  {"clangd", "pyright", "lua_ls", "tsserver"},
        }
      end,
    },
    {
      "neovim/nvim-lspconfig",
      lazy = false,
      enabled = true,
      keys = {
        {"<leader>l", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format code"},
        {"K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show documentation"},
      },
      config = function()
        require("lspconfig").clangd.setup {}
        require("lspconfig").pyright.setup {}
        require("lspconfig").lua_ls.setup {}
        require("lspconfig").tsserver.setup {}
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter", 
      lazy = false,
      enabled = true,
      build = ":TSUpdate"
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup{
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
      config = function()
        require("copilot_cmp").setup{}
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
      },
      Lazy = false,
      enabled = true,
      config = function()
        -- config cmp
        local cmp = require('cmp')
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          },
          sources = {
            { name = "copilot", group_index = 1 },
            { name = 'nvim_lsp', keyword_length = 1, group_index = 1 },
            { name = 'path', keyword_length = 1, group_index = 1 },
            { name = 'vsnip', keyword_length = 1, group_index = 2 },
            { name = 'buffer', keyword_length = 1, group_index = 2 },
          },
          sorting = {
            priority_weight = 2,
            comparators = {
              require("copilot_cmp.comparators").prioritize,
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
        })
        cmp.setup.cmdline({'/', '?'}, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          },{
            { name = 'cmdline' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
        })
        -- config nvim-lsp source
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig').clangd.setup {
          capabilities = capabilities,
        }
        require('lspconfig').pyright.setup {
          capabilities = capabilities,
        }
        require('lspconfig').lua_ls.setup {
          capabilities = capabilities,
        }
        require('lspconfig').tsserver.setup {
          capabilities = capabilities,
        }
      end,
    },
    {
      'nvimdev/lspsaga.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
      },
      event = "LspAttach",
      enabled = true,
      keys = {
        { "<leader>c", "<cmd>Lspsaga incoming_calls<cr>", desc = "Who calls this function" },
        { "<leader>a", "<cmd>Lspsaga code_action<cr>", desc = "Show code actions" },
        { "<leader>m", "<cmd>Lspsaga outline<cr>", desc = "Toggle file outline" },
      },
      config = function()
        require('lspsaga').setup({
          lightbulb = {
            sign = false,
          },
        })
      end,
    },
    -- Spec 3: Edit&Git
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    {
      'numToStr/Comment.nvim',
      lazy = false,
      enabled = true,
      opts = {}
    },
    {
      "kdheepak/lazygit.nvim",
      cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
    },
    { 
      -- because "sa" are closer than "ys"
      'echasnovski/mini.surround', 
      version = '*',
      enabled = true,
      config = function()
        require('mini.surround').setup {
          highlight_duration = 500,
          mappings = {
            add = 'sa', -- Add surrounding in Normal and Visual modes
            delete = 'sd', -- Delete surrounding
            replace = 'sr', -- Replace surrounding
          },
          -- Place surroundings on each line in blockwise mode.
          respect_selection_type = false,
          -- Whether to disable showing non-error feedback
          silent = false,
        }
      end,
    },
    {
      'FabijanZulj/blame.nvim',
      enabled = true,
      keys = {
        { "<leader>b", "<cmd>BlameToggle<cr>", desc = "Toggle Blame" }
      },
      opts = { '-w' },
    },
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      opts = {
        -- add any opts here
      },
      keys = {
        { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" } },
        { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
        { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
      },
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to setup it properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
      config = function()
        require("avante").setup {
          -- add any setup here
          provider = "openai", -- Only recommend using Claude
          openai = {
            endpoint = "https://api.gptsapi.net/v1",
            model = "gpt-4o-2024-08-06",
            temperature = 0.4,
            max_tokens = 4096,
          },
        }
      end 
    },
    -- Spec 4: Misc
    {
      'nvim-lualine/lualine.nvim',
      lazy = false,
      enabled = true,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = { theme = 'auto' },
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      --main = "ibl",
      lazy = false,
      enabled = true,
      main = "ibl",
      config = function()
        local highlight = {
            "RainbowViolet",
        }
        
        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        end)

        require("ibl").setup { 
          scope = { 
            enabled = true, 
            show_start = false, 
            highlight = highlight 
          },
        }
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- do not automatically check for plugin updates
  checker = { enabled = false },
})


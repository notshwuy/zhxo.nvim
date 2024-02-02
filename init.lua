vim.opt.cursorline = true
vim.opt.cmdheight = 1
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.path:append({ "**" })
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 600
vim.opt.title = true
vim.opt.updatetime = 1000
vim.opt.wrap = false
vim.opt.number = true
vim.opt.ruler = false
vim.opt.smarttab = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.equalalways = false
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.formatoptions:append({ "r" })
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.shell = "zsh"
vim.opt.belloff = "all"
vim.g.mapleader = ' '



local lazypath = vim.fn.stdpath("data") .. "/development/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	root = vim.fn.stdpath("data") .. "/min/lazy",
	spec = {
		"nvim-telescope/telescope.nvim",
    { "lewis6991/gitsigns.nvim", opts = {} },
		"nvim-lua/plenary.nvim",
    {
      'williamboman/mason-lspconfig.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      opts = {
        ensure_installed = {
          'tsserver'
        },
        automatic_installation = true,
      },
      dependencies = {
        'williamboman/mason.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        build = ':MasonUpdate',
        cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate', 'MasonLog' },
        opts = {
          log_level = vim.log.levels.WARN,
          max_concurrent_installers = 4,
        },
      },
    },
    {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre',
      config = function()
        local lspconfig = require 'lspconfig'
        local servers = { 'tsserver' }

        -- callback for formatting on save
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

        -- Setting up on_attach
        local on_attach = function(client, bufnr)
          local opts = { silent = true, buffer = bufnr }

          -- formatting
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                lsp_formatting(bufnr)
              end,
            })
          end
        end

        -- setup servers
        for _, server in pairs(servers) do
          Opts = {
            on_attach = on_attach,
          }

          if server == 'elixirls' then
            Opts.cmd = { 'elixir-ls' }
          end

          server = vim.split(server, '@')[1]
          lspconfig[server].setup(Opts)
        end

        -- setup up border for LspInfo
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = 'rounded',
        })

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = 'rounded',
        })

        -- Setting up lua server
        lspconfig.lua_ls.setup {
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = {
                  [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                  [vim.fn.stdpath 'config' .. '/lua'] = true,
                },
              },
              telemetry = {
                enable = false,
              },
            },
          },
        }
      end,
    },
    {
      "echasnovski/mini.hipatterns",
      version = false,
      event = 'VeryLazy',
      config = function()
        local hipatterns = require 'mini.hipatterns'

        hipatterns.setup {
          highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
          }
        }
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      config = function()
        local ts = require 'nvim-treesitter.configs'

        ts.setup {
          highlight = {
            enable = true,
            disable = {},
          },
          indent = {
            enable = true,
          },
          ensure_installed = {
            'lua',
            'vim',
            'bash',
            'javascript',
            'typescript',
            'tsx',
            'html',
            'css',
            'json',
            'go',
            'rust',
          },
          autotag = {
            enable = true,
          },
        }

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
      end,
      build = function()
        local ts_update = require('nvim-treesitter.install').update { with_sync = true }
        ts_update()
      end,
      dependencies = {
        {
          'nvim-treesitter/nvim-treesitter-context',
          opts = {},
        },
        'nvim-treesitter/playground',
      },
    },
    {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        options = {
          icons_enabled = true,
          colorscheme = "shxo",
        },
      },
    },
    {
      'NeogitOrg/neogit',
      cmd = 'Neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
      opts = {},
    },
  },
})

vim.keymap.set('i', '<C-c>', '<Esc>', opts)
vim.keymap.set('n', '<leader>gg', ':Neogit<Return>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Explore<Return><Return>', opts)
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('n', '>', ':tabnext<Return>', opts)
vim.keymap.set('n', '<', ':tabprev<Return>', opts)
local theme = require('telescope.themes').get_dropdown {}
vim.keymap.set('n', ';f', function()
  require 'telescope.builtin'.find_files(vim.tbl_deep_extend('force', {
    prompt_prefix = '   ',
    no_ignore = false,
    hidden = true,
  }, theme))
end, opts)

local theme = require("shxo/init")

theme.setup({
	transparent = false,
	italics = {
		comments = false,
		keywords = true,
		functions = true,
		strings = false,
		variables = true,
	},
})

vim.print(theme.config)

theme.colorscheme()

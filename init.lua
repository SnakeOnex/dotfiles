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

-- Basics (indentation, display of filetype)
vim.cmd("syntax on")
vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("filetype plugin indent on")

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false

-- Search settings
vim.opt.smartcase = true
vim.opt.cmdheight = 0

-- File handling options
-- vim.opt.swapfile = false  -- Commented out as per your note
vim.opt.backup = false

-- UI Settings
vim.opt.errorbells = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10  -- Good for ctrl+d and ctrl+u half screen scrolling

-- Undo directory (persistent undo)
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true

-- Buffer and history settings
vim.opt.hidden = true
vim.opt.history = 100
vim.opt.showmode = false
vim.opt.clipboard:prepend("unnamedplus")
vim.opt.compatible = false

-- Terminal colors
vim.opt.termguicolors = true

-- opening windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- escape key in terminal
vim.keymap.set('n', '<C-t>', ':terminal<CR>', {silent = true, desc = 'Open terminal'})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber scrolloff=0", -- Q: how to separate the commands? A: use a comma
})

-- tabs
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<C-' .. i .. '>', ':<C-U>tabnext ' .. i .. '<CR>', {noremap = true, silent = true})
end

vim.api.nvim_create_user_command(
  'TabLast', 
  function(opts)
    vim.cmd('tablast')
    vim.cmd('tabnew ' .. (opts.args or ''))
  end,
  { nargs = '*' }
)

vim.api.nvim_set_keymap('n', '<C-n>', ':TabLast<CR>', {noremap = true, silent = true})

-- Ensure you're in the correct mode for your mappings. Here, we use "n" for normal mode.
vim.keymap.set("n", "<leader>|", "<C-w>v", { silent = true, desc = "Open new window vertically" })
vim.keymap.set("n", "<leader>-", "<C-w>s", { silent = true, desc = "Open new window horizontally" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })

-- toggle comments
vim.keymap.set("n", "<C-_>", function()
  vim.cmd("norm gcc")
end)
vim.keymap.set("v", "<C-_>", function()
  vim.cmd("norm gc")
end)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
      {
          "vimwiki/vimwiki",
          init = function()
              vim.g.vimwiki_list = {
                  { path = "~/owncloud/vimwiki", syntax = "markdown", ext=".md" }
              }
          end
      },
      { 
          "ayu-theme/ayu-vim",
          lazy = false,
          priority = 1000,
      },
      {
          "nvim-lualine/lualine.nvim",
          dependencies = { "nvim-tree/nvim-web-devicons" },
          config = function()
            require("lualine").setup {
              options = {
                theme = "ayu_dark",
                section_separators = {"", ""}, -- This removes the separators.
                component_separators = {"", ""}, -- This removes the separators.
                icons_enabled = true, -- This enables icons.
              },
              sections = {
                lualine_a = {"mode"}, -- This sets the component of the "a" section.
                lualine_b = {"branch", "diff"}, -- This sets the component of the "b" section.
                lualine_c = {"filename"}, -- This sets the component of the "c" section.
                lualine_x = {"encoding", "filetype"}, -- This sets the components of the "x" section.
                lualine_y = {"progress"}, -- This sets the component of the "y" section.
                lualine_z = {"location"}, -- This sets the component of the "z" section.
              },
            }
          end
      },
      {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
          require("neo-tree").setup({
            window = {
                mappings = {
                    ["<C-j>"] = { "scroll_preview", config = {direction = -10} },
                    ["<C-k>"] = { "scroll_preview", config = {direction = 10} },
                    ["<C-f>"] = "close_window"
                },
            }
        })
        end,
        keys = {
          { "<C-f>", "<Cmd>Neotree toggle<CR>" },
        },
      },
      { 
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                keymap = {
                  accept = "<Tab>",
                },
            },
          })
        end,
      },
      {
        "nvim-telescope/telescope.nvim", 
        brauch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            -- Set keymaps here
            vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

        end,
      },
      {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
          local configs = require("nvim-treesitter.configs")

          configs.setup({
              ensure_installed = { "c", "lua", "vim", "python", "javascript", "html", "css", "json", "yaml" },
              sync_install = false,
              highlight = { enable = true },
              indent = { 
                  enable = true,
                  disable = { "python" },
              },
            })
        end
      },
      {
        "williamboman/mason.nvim",
        priority = 1000,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        priority = 900,
        dependencies = { "williamboman/mason.nvim" },
      },
      {
        "neovim/nvim-lspconfig",
        priority = 800,
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            -- Define keymaps and settings
            local on_attach = function(client, bufnr)
                local bufopts = { noremap=true, silent=true, buffer=bufnr }
                -- Go to definition
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                -- Hover documentation
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                -- Go to implementation
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                -- Signature help
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

            end

            -- Setup pyright
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright" },
            })
            require("lspconfig").pyright.setup({
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = false,
                            diagnosticSeverityOverrides = {
                                reportUnusedImport = "hint",
                                reportMissingImports = "hint",
                                reportUndefinedVariable = "hint",
                            }
                        }
                    }
                },
                on_attach = on_attach
            })
        end
        },
      },
      {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
      },
      {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
            vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
            vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", { desc = "Git pull" })
        end
      },
        -- lazy.nvim
      {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
          -- add any options here
          messages = {
            enabled = false,
          },
        },
        dependencies = {
          -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
          "MunifTanjim/nui.nvim",
          -- OPTIONAL:
          --   `nvim-notify` is only needed, if you want to use the notification view.
          --   If not available, we use `mini` as the fallback
          "rcarriga/nvim-notify",
          }
      },
      {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            highlight = {
                comments_only = false,
            }
            -- keywords = {
            --     FIX = {
            --         icon = "",
            --         color = "error",
            --         alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
            --     },
            --     TODO = { icon = "", color = "info" },
            --     HACK = { icon = "", color = "warning" },
            --     WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
            -- },
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      },
      {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            provider = "copilot",
            copilot = {
                endpoint = "https://api.githubcopilot.com",
                model = "gpt-4o-2024-05-13",
                proxy = nil, -- [protocol://]host[:port] Use this proxy
                allow_insecure = false, -- Allow insecure server connections
                timeout = 30000, -- Timeout in milliseconds
                temperature = 0,
                max_tokens = 4096,
          },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "stevearc/dressing.nvim",
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          --- The below dependencies are optional,
          "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
          "zbirenbaum/copilot.lua", -- for providers='copilot'
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
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
              file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
          },
        },
      },
      {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
          require("bufferline").setup{
            options = {
              mode = "tabs", -- To show tabs instead of buffers
              numbers = "ordinal", -- Shows tab numbers
              show_buffer_close_icons = false,
              show_close_icon = true,
              color_icons = false,
              max_name_length = 12,
              truncate_names = true,
              tab_size = 15,
              separator_style = "thin",
              -- Customize colors to match your theme
              -- You might need to adjust these based on your colorscheme
              indicator = {
                style = 'icon',
                icon = '', --'▎',
                buffer_close_icon = ' ',
                modified_icon = '●',
                close_icon = ' ',
                left_trunc_marker = '<-', --'',
                right_trunc_marker = '->', --'',
              },
              highlights = {
                fill = {
                  guifg = {attribute = "fg", highlight = "Normal"},
                  guibg = {attribute = "bg", highlight = "StatusLineNC"},
                },
                background = {
                  guifg = {attribute = "fg", highlight = "Normal"},
                  guibg = {attribute = "bg", highlight = "StatusLine"}
                },
                -- ... more highlight configurations
              }
            }
          }
        end
      },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd.colorscheme("ayu")
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "#555555" })


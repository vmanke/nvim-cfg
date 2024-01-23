-- vim.cmd([[
-- call plug#begin()
-- 
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'preservim/nerdtree'
-- Plug 'tomasr/molokai'
-- Plug 'cocopon/iceberg.vim'
-- " Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
-- 
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'simrat39/rust-tools.nvim'
-- 
-- Plug 'folke/lazy.nvim'
-- 
-- " Debugging
-- 
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'mfussenegger/nvim-dap'
-- call plug#end()
-- ]])

-- require("mason").setup({
--     PATH = "prepend", -- "skip" seems to cause the spawning error
-- })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

vim.g.mapleader = " "

require("lazy").setup({
	"mfussenegger/nvim-dap",
	"polirritmico/monokai-nightasty.nvim",
	"nvim-lua/plenary.nvim",
	"tomasr/molokai",
	"cocopon/iceberg.vim",
 	"folke/which-key.nvim",
 	"preservim/nerdtree",
 	"neovim/nvim-lspconfig",
 	"simrat39/rust-tools.nvim",
	"chentoast/marks.nvim",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
	},
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.5',
		dependencies = {
			'nvim-lua/plenary.nvim'
		}
	},
--	{
--		"nvim-treesitter/nvim-treesitter",
--		build = ":TSUpdate",
--		config = function () 
--			local configs = require("nvim-treesitter.configs")
--
--			configs.setup({
--				ensure_installed = {},
--				sync_install = false,
--	    			highlight = { enable = true },
--	    			indent = { enable = true },  
--	    		})
--		end
--	},
 	event = "VeryLazy",
 	init = function()
 		vim.o.timeout = true
 		vim.o.timeoutlen = 300
 	end,
 	opts = {
 		-- your configuration comes here
 		-- or leave it empty to use the default settings
 		-- refer to the configuration section below
 	}
})

require'lspconfig'.pylsp.setup{}

-- require 'nvim-treesitter.install'.compilers = { "gcc" }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("marks").setup({
	default_mappings = true,
	builtin_marks = {".", "<", ">", "^", "C"},
	cyclic = true,
	force_write_shade = false,
	refresh_interval = 250,
	sign_priority = {
		lower = 10,
		upper = 15,
		builtin = 8,
		bookmark = 20
	},
	excluded_filetypes = {},
	excluded_buftypes = {},
	bookmark_0 = {
		sign = "#",
		virt_text = "hello world",
		annotate = false,
      	},
      mappings = {}
})

require('lualine').setup {
options = {
	icons_enabled = true,
	theme = 'auto',
	component_separators = {
		left = '', 
		right = ''
	},
	section_separators = {
		left = '',
		right = ''
	},
	disabled_filetypes = {
		statusline = {},
		winbar = {},
	},
	ignore_focus = {},
	always_divide_middle = true,
	globalstatus = false,
	refresh = {
		statusline = 1000,
		tabline = 1000,
		winbar = 1000,
	}
},
sections = {
	lualine_a = {'mode'},
	lualine_b = {'branch', 'diff', 'diagnostics'},
	lualine_c = {'filename'},
	lualine_x = {'encoding', 'fileformat', 'filetype'},
	lualine_y = {'progress'},
	lualine_z = {'location'}
},
inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {'filename'},
	lualine_x = {'location'},
	lualine_y = {},
	lualine_z = {}
},
tabline = {},
winbar = {},
inactive_winbar = {},
extensions = {}
}

local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

local nvim_lsp = require('lspconfig')

local on_attach = function(client)
    require('completion').on_attach(client)
end

vim.opt.background = "dark" -- default to dark or light style

require("monokai-nightasty").setup({
    dark_style_background = "transparent", -- default, dark, transparent, #color
    light_style_background = "default", -- default, dark, transparent, #color
    terminal_colors = true, -- Set the colors used when opening a `:terminal`
    color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
    hl_styles = {
        -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        -- Background styles for sidebars (panels) and floating windows:
        floats = "default", -- default, dark, transparent
        sidebars = "default", -- default, dark, transparent
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`

    hide_inactive_statusline = false, -- Hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- Lualine headers will be bold or regular.
    lualine_style = "dark", -- "dark", "light" or "default" (Follows dark/light style)

    --- You can override specific color/highlights. Current values in `extras/palettes`

    ---@param colors ColorScheme
    on_colors = function(colors)
        colors.border = colors.grey
        colors.comment = "#2d7e79"
    end,

    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
        highlights.TelescopeNormal = { fg = colors.magenta, bg = colors.charcoal }
        highlights.WinSeparator = { fg = colors.grey }
    end,
})

-- Toggle Dark/Light styles
vim.keymap.set(
    {"n", "v"}, "<leader>tl", "<CMD>MonokaiToggleLight<CR>",
    {silent = true, desc = "Monokai-NighTasty: Toggle light/dark theme"}
)

vim.cmd([[colorscheme monokai-nightasty]])
vim.cmd([[
" COLORSCHEMES:

""" colorscheme molokai
" set background=dark
" colorscheme iceberg
" colorscheme blackops

" SETTINGS:

set number
set relativenumber
set mouse=a
set wrap
set linebreak

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  

map <C-n> :NERDTreeToggle<CR>
map <C-c> "*y
map <C-v> "*p
cmap <C-V> <C-R>+
imap <C-V> <C-r><C-P>+
noremap <C-Q> <C-V>

nnoremap , :
vnoremap , :
]])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "kzz")
vim.keymap.set("n", "<C-j>", "jzz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
	["rust-analyzer"] = {
	    imports = {
			granularity = {
			    group = "module",
			},
			prefix = "self",
	    	},
	    	cargo = {
			buildScripts = {
			    enable = true,
			},
	    	},
	    	procMacro = {
				enable = true
	    	},
		}
    }
})

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix / toggleterm / vimux
    executor = require("rust-tools.executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
}

require('rust-tools').setup(opts)

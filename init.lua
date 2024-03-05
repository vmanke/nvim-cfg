if vim.g.vscode then
    vim.g.mapleader = " "
    vim.cmd([[
    map <C-c> "*y
    map <C-v> "*p
    cmap <C-V> <C-R>+
    imap <C-V> <C-r><C-P>+
    noremap <C-Q> <C-V>

    nnoremap , :
    vnoremap , :

    nnoremap <leader>vd <cmd>vsplit term://visidata <cfile><CR>
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

    vim.keymap.set("n", "<C-k>", "kzz")
    vim.keymap.set("n", "<C-j>", "jzz")
else    
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
        -- "paulfrische/reddish.nvim",
        -- {
        --     "scottmckendry/cyberdream.nvim",
        --     lazy = false,
        --     priority = 1000,
        --     config = function()
        --         require("cyberdream").setup({
        --             -- Recommended - see "Configuring" below for more config options
        --             transparent = true,
        --             italic_comments = true,
        --             hide_fillchars = true,
        --             borderless_telescope = true,
        --         })
        --         vim.cmd("colorscheme cyberdream") -- set the colorscheme
        --     end,
        -- },
        "EvanHahn/dw_red.vim",
        {
            "iamcco/markdown-preview.nvim",
            cmd = { 
                "MarkdownPreviewToggle",
                "MarkdownPreview",
                "MarkdownPreviewStop"
            },
            ft = { "markdown" },
            build = function() 
                vim.fn["mkdp#util#install"]()
            end,
        },
        -- "vijaymarupudi/nvim-fzf",
        {
            "ellisonleao/glow.nvim", 
            config = true,
            cmd = "Glow",
        },
        {
            "nvim-focus/focus.nvim",
            version = false,
        },
        "neovim/nvim-lspconfig",
        "nvim-tree/nvim-web-devicons",
        {
            "SmiteshP/nvim-navic",
            dependencies = "neovim/nvim-lspconfig",

        },
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        {
            'akinsho/toggleterm.nvim',
            version = "*",
            opts = {
                --[[ things you want to change go here]]
            },
        },
        "ahmedkhalf/project.nvim",
        "mfussenegger/nvim-dap",
        "nvim-lua/plenary.nvim",
        "tomasr/molokai",
        "cocopon/iceberg.vim",
        "preservim/nerdtree",
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
            },          
        },
        {
            "utilyre/barbecue.nvim",
            name = "barbecue",
            version = "*",
            dependencies = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons", -- optional dependency
            },
            opts = {
                -- configurations go here
            },
        },
        {
            "debugloop/telescope-undo.nvim",
            dependencies = { -- note how they're inverted to above example
                {
                    "nvim-telescope/telescope.nvim",
                    dependencies = { "nvim-lua/plenary.nvim" },
                },
            },
            keys = {
                { -- lazy style key map
                    "<leader>u",
                    "<cmd>Telescope undo<cr>",
                    desc = "undo history",
                },
            },
            opts = {
                -- don't use `defaults = { }` here, do this in the main telescope spec
                extensions = {
                    undo = {
                    -- telescope-undo.nvim config, see below
                    },
                    -- no other extensions here, they can have their own spec too
                },
            },
            config = function(_, opts)
                -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
                -- configs for us. We won't use data, as everything is in it's own namespace (telescope
                -- defaults, as well as each extension).
                require("telescope").setup(opts)
                require("telescope").load_extension("undo")
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
        },
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
        },
        {
            'mrcjkb/rustaceanvim',
            version = '^4', -- Recommended
            ft = { 'rust' },
        },
        {
              'akinsho/flutter-tools.nvim',
              lazy = false,
              dependencies = {
                  'nvim-lua/plenary.nvim',
                  'stevearc/dressing.nvim', -- optional for vim.ui.select
              },
              config = true,
        },
        'dcampos/nvim-snippy',
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'neovim/nvim-lspconfig',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'dcampos/nvim-snippy',
                'dcampos/cmp-snippy',
            },

        }
    })

    
    vim.cmd([[
    " COLORSCHEMES:

    colorscheme molokai
    " set background = dark
    " colorscheme iceberg
    " colorscheme blackops
    ]])

    -- --------------------------------------------------------------------------------

    local rainbow_delimiters = require('rainbow-delimiters')

    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    }

--    require('nvim-treesitter.configs').setup({
--        -- A list of parser names, or "all" (the five listed parsers should always be installed)
--        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "latex", "python" },
        --
--        -- Install parsers synchronously (only applied to `ensure_installed`)
--        sync_install = false,
--
--        -- Automatically install missing parsers when entering buffer
--        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--        auto_install = true,
--
--        ignore_install = { "javascript" },
        --
--        highlight = {
--            enable = true,
--            -- disable = function(lang, buf)
--            --     local max_filesize = 100 * 1024 -- 100 KB
--            --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--            --     if ok and stats and stats.size > max_filesize then
--            --         return true
--            --     end
--            -- end,
--            additional_vim_regex_highlighting = false,
--        },
--    })

    -- --------------------------------------------------------------------------------

    local cmp = require'cmp'

    cmp.setup({
        snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
        },
        window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        }, {
        { name = 'buffer' },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
        { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
        { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
        { name = 'path' }
        }, {
        { name = 'cmdline' }
        })
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --     capabilities = capabilities
    -- }

    -- ---------------------------------------------------------------------

    require('snippy').setup({
        mappings = {
            is = {
                ['<Tab>'] = 'expand_or_advance',
                ['<S-Tab>'] = 'previous',
            },
            nx = {
                ['<leader>x'] = 'cut_text',
            },
        },
    })

--    local fzf = require("fzf")
--
--    coroutine.wrap(function()
--        local result = fzf.fzf({"choice 1", "choice 2"})
--        if result then
--            print(result[1])
--        end
--    end)()

    -- flutter:
    
    
    -- alternatively you can override the default configs
    require("flutter-tools").setup({
        ui = {
            -- the border type to use for all floating windows, the same options/formats
            -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
            border = "rounded",
            -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
            -- please note that this option is eventually going to be deprecated and users will need to
            -- depend on plugins like `nvim-notify` instead.
            notification_style = 'native'
       },
       decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = false,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = false,
                -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
                -- this will show the currently selected project configuration
                project_config = false,
            }
       },
       debugger = { -- integrate with nvim dap + install dart code debugger
            enabled = false,
            run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
            -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
            -- see |:help dap.set_exception_breakpoints()| for more info
            exception_breakpoints = {},
       },
       flutter_path = "C:\\FlutterSDK\\flutter\\bin\\flutter", -- <-- this takes priority over the lookup
       -- flutter_lookup_cmd = "which flutter", -- example "dirname $(which flutter)" or "asdf where flutter"
       root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
       fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
       widget_guides = {
            enabled = false,
       },
       closing_tags = {
            highlight = "ErrorMsg", -- highlight for the closing tag
            prefix = ">", -- character to use for close tag e.g. > Widget
            enabled = true -- set to false to disable
       },
       dev_log = {
            enabled = true,
            notify_errors = false, -- if there is an error whilst running then notify the user
            open_cmd = "tabedit", -- command to use to open the log buffer
       },
       dev_tools = {
            autostart = false, -- autostart devtools server if not detected
            auto_open_browser = false, -- Automatically opens devtools in the browser
       },
       outline = {
            open_cmd = "30vnew", -- command to use to open the outline buffer
            auto_open = false -- if true this will open the outline automatically when it is first populated
       },
       lsp = {
            color = { -- show the derived colours for dart variables
                enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                background = false, -- highlight the background
                background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
                foreground = false, -- highlight the foreground
                virtual_text = true, -- show the highlight using virtual text
                virtual_text_str = "■", -- the virtual text character to highlight
            },
            -- see the link below for details on each option:
            -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
            settings = {
                showTodos = true,
                completeFunctionCalls = true,
                renameFilesWithClasses = "prompt", -- "always"
                enableSnippets = true,
                updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
            }
       }
    })

    vim.cmd([[
        " Show hover
        nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
         " Jump to definition
        nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
         " Open code actions using the default lsp UI, if you want to change this please see the plugins above
        nnoremap <leader>ca <Cmd>lua vim.lsp.buf.code_action()<CR>
         " Open code actions for the selected visual range
        xnoremap <leader>ca <Cmd>lua vim.lsp.buf.range_code_action()<CR>
    ]])

    require("glow").setup({
        style = "dark",

    })

    require("project_nvim").setup({
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = true,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'global',

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
    })

    require("toggleterm").setup({
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        shell = vim.o.shell,
        auto_scroll = true,
        start_in_insert = true,
        persist_size =true,
        close_on_exit = true,
        -- autochdir = true,
        winbar = {
            enabled = false,
            name_formatter = function(term) --  term: Terminal
                return term.name
            end,
        },
    })

    require("focus").setup({
        enable = true, -- Enable module
        commands = true, -- Create Focus commands
        autoresize = {
            enable = true, -- Enable or disable auto-resizing of splits
            width = 0, -- Force width for the focused window
            height = 0, -- Force height for the focused window
            minwidth = 0, -- Force minimum width for the unfocused window
            minheight = 0, -- Force minimum height for the unfocused window
            height_quickfix = 10, -- Set the height of quickfix panel
        },
        split = {
            bufnew = false, -- Create blank buffer for new split windows
            tmux = false, -- Create tmux splits instead of neovim splits
        },
        ui = {
            number = false, -- Display line numbers in the focussed window only
            relativenumber = false, -- Display relative line numbers in the focussed window only
            hybridnumber = false, -- Display hybrid line numbers in the focussed window only
            absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

            cursorline = true, -- Display a cursorline in the focussed window only
            cursorcolumn = false, -- Display cursorcolumn in the focussed window only
            colorcolumn = {
                enable = false, -- Display colorcolumn in the foccused window only
                list = '+1', -- Set the comma-saperated list for the colorcolumn
            },
            signcolumn = true, -- Display signcolumn in the focussed window only
            winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
        }
    })

    require("lspconfig").pylsp.setup({})
    require('lspconfig').rust_analyzer.setup({})

    local navic = require("nvim-navic")

    navic.setup {
        icons = {
            File = ' ',
            Module = ' ',
            Namespace = ' ',
            Package = ' ',
            Class = ' ',
            Method = ' ',
            Property = ' ',
            Field = ' ',
            Constructor = ' ',
            Enum = ' ',
            Interface = ' ',
            Function = ' ',
            Variable = ' ',
            Constant = ' ',
            String = ' ',
            Number = ' ',
            Boolean = ' ',
            Array = ' ',
            Object = ' ',
            Key = ' ',
            Null = ' ',
            EnumMember = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' '
        },
        lsp = {
            auto_attach = false,
            -- preference = {"rust-analyzer",},
        },
        highlight = false,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = false,
        click = false,
        format_text = function(text)
            return text
        end,
    }

    vim.g.navic_silence = true

    -- ----------------------------------------------------------------------

    local select_one_or_multi = function(prompt_bufnr)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
            require('telescope.actions').close(prompt_bufnr)
            for _, j in pairs(multi) do
                if j.path ~= nil then
                    vim.cmd(string.format('%s %s', 'edit', j.path))
                end
            end
        else
            require('telescope.actions').select_default(prompt_bufnr)
        end
    end

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<CR>'] = select_one_or_multi,
                }
            }
        }
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find Symbols"})
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Find Word under Cursor"})
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Search Git Commits"})
    vim.keymap.set('n', '<leader>gb', builtin.git_bcommits, { desc = "Search Git Commits for Buffer"})
    vim.keymap.set('n', '<leader>fp', ":Telescope projects<CR>", { desc = "Search projects"})

    -- -----------------------------------------------------------------------------------------------------

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
        mappings = {},
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
                vim.keymap.set("n", "<Leader>g", rt.crate_graph.crate_graph, { buffer = bufnr })
            end,
        },
    })

    rt.inlay_hints.enable()

    require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
    })

    local nvim_lsp = require('lspconfig')

    local on_attach = function(client)
            require('completion').on_attach(client)
    end

    -- settings:
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.cmd([[
        set mouse=a
        set backspace=indent,eol,start
    ]])
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.signcolumn = "number"
    vim.opt.expandtab = true
    vim.opt.autoindent = true

    vim.cmd([[
    " autocmd vimenter * if !argc() | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  
    " autocmd vimenter * if !argc() | NvimTreeToggle | endif
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  

    " map <C-n> :NERDTreeToggle<CR>
    map <C-c> "*y
    map <C-v> "*p
    cmap <C-V> <C-R>+
    imap <C-V> <C-r><C-P>+
    noremap <C-Q> <C-V>

    nnoremap , :
    vnoremap , :

    nnoremap <leader>vd <cmd>vsplit term://visidata <cfile><CR>
    ]])

    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    vim.keymap.set("n", "J", "mzJ`z")
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")

    vim.keymap.set("v", "J", ":m '>+1<CR>gv = gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv = gv")

    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

    vim.keymap.set("x", "<leader>p", [["_dP]])
    vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
    vim.keymap.set("n", "<leader>Y", [["+Y]])
    vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

    vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

    vim.keymap.set("n", "<C-k>", "kzz")
    vim.keymap.set("n", "<C-j>", "jzz")

    vim.keymap.set("n", "<C-n>", "<cmd>NERDTreeToggle<CR>")
    vim.keymap.set("n", "<leader>n", ":noh<CR>")
    vim.keymap.set("v", "<leader>n", ":noh<CR>")
    -- vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
    -- vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")
    -- vim.keymap.set("v", "<leader>n", "<cmd>NvimTreeToggle<CR>")

    vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<CR>")

    -- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
    -- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
    
    vim.keymap.set("n", "<leader>s", ":wa<Bar>exe 'mksession! .nvim_sessions/session.vim'<CR>") -- .. v:this_session<CR>:so ~/.nvim_sessions/")
    vim.keymap.set("n", "<leader>S", ":so .nvim_sessions/session.vim<CR>")

    vim.keymap.set("v", "<leader>vf", "<Esc>/\\%V")      -- search within visually selected area (visual find)
    -- search word under cursor: * (fwd), # (aft)
    vim.keymap.set("v", "<leader>/", 'y/\\V<C-r>"<CR>')     -- search for visually selected text
    vim.keymap.set("n", "<leader>iw", 'yiw/\\V<C-r>"<CR>')     -- search for inner word

--    nvim_lsp.rust_analyzer.setup({
--          on_attach = on_attach,
--          settings = {
--        ["rust-analyzer"] = {
--              imports = {
--                granularity = {
--                   group = "module",
--                },
--                prefix = "self",
--                },
--                cargo = {
--                buildScripts = {
--                   enable = true,
--                },
--                },
--                procMacro = {
--                enable = true
--                },
--        }
--          }
--    })

    local rtopts = {
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
                parameter_hints_prefix = " <- ",
    
                -- prefix for all the other hints (type, chaining)
                -- default: " = >"
                other_hints_prefix = " => ",
    
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
            output = ".graph/",
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

    -- require('rust-tools').setup(rtopts)
end


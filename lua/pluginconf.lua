-- Transparency
require("transparent").setup({ -- Optional, you don't have to run setup.
    groups = {                 -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
    },
    extra_groups = {},   -- table: additional groups that should be cleared
    exclude_groups = {}, -- table: groups you don't want to clear
})

-- Telescope

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ": Telescope live_grep<CR>")

vim.diagnostic.config({
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
    },
})

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})

require("autoclose").setup()

vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {},
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            -- you can also put keymaps in here
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
        },
    },
}

vim.g.rustaceanvim = {
    server = {
        cmd = function()
            local mason_registry = require('mason-registry')
            local ra_binary = mason_registry.is_installed('rust-analyzer')
                -- This may need to be tweaked, depending on the operating system.
                and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
                or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
        end,
    },
}

require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,     -- use a classic bottom cmdline for search
        command_palette = true,   -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,       -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,   -- add a border to hover docs and signature help
    },
})

require("notify").setup({
    render = 'compact'
})

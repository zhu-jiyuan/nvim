return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            { "junegunn/fzf", build = "./install --bin" },
        },
        keys = {
            { "<leader>ff", ":FzfLua files resume=true<CR>",            desc = "find files" },
            { "<leader>fg", ":FzfLua live_grep_native resume=true<CR>", desc = "grep file" },
            { "<leader>fr", ":FzfLua resume<CR>",                       desc = "resume" },
            { "<leader>fo", ":FzfLua oldfiles<CR>",                     desc = "oldfiles" },
            { "<leader>fb", ":FzfLua buffers<CR>",                      desc = "buffers" },
            { "<leader>fh", ":FzfLua help_tags<CR>",                    desc = "help_tags" },
            { "<leader>/",  ":FzfLua lgrep_curbuf resume=true<CR>",     desc = "help_tags" },
            { "<leader>fw", ":FzfLua grep_cword<CR>",                   desc = "grep_cword" },
            { "<leader>fW", ":FzfLua grep_cWORD<CR>",                   desc = "grep_cWORD" },
            { "<leader>gst", ":FzfLua git_status<CR>",                   desc = "git_status" },
            { "<leader>gb", ":FzfLua git_branches<CR>",                   desc = "git_status" },

        },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                winopts = {
                    preview = { default = 'bat_native' }
                },
                fzf_colors = true,
                previewers = {
                    bat = {
                        cmd = "bat",
                        args = "--style=numbers,changes --color=always",
                        -- theme = "ansi",
                        -- theme = "Coldark-Dark",
                    }
                },
                -- fzf = {
                --     cursorline = {
                --         ["fg+"] = "#d41e1e",
                --         ["bg+"] = "#d41e1e"
                --     }
                -- }

            })
        end,
    },
}

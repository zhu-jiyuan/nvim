return
---@type LazySpec
{
    "mikavilpas/yazi.nvim",
    cmd = "Yazi",
    keys = {
        {
            "<leader>ra",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<leader>cw",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
        {
            '<leader>rr',
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    ---@type YaziConfig
    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = '<f1>',
        },
    },
}

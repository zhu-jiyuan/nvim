local helper = require "helper"

-- sudo save current file
vim.api.nvim_create_user_command("SudoSave", helper.sudo_save_cur_file, {})

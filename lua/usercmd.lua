local helper = require "helper"

vim.api.nvim_create_user_command("SudoSave", helper.sudo_save_cur_file, {})

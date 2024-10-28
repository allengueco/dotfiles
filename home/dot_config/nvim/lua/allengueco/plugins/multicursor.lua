return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = false,
    event = "VeryLazy",
    config = function ()
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        set("n", "<C-LeftMouse>", mc.handleMouse)
    end
}

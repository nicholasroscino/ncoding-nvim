return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- load immediately on startup
        priority = 1000, -- make sure it loads before other plugins
        -- config = function()
        --     -- Optional: choose a style: storm, night, day
        --     vim.g.tokyonight_style = "storm"

        --     -- Apply the colorscheme
        --     vim.cmd("colorscheme tokyonight")
        -- end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "frappe" -- latte, frappe, macchiato, mocha
            });

            vim.cmd("colorscheme catppuccin")
        end
    }
}

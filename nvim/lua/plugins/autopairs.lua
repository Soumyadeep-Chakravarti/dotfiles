return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    },
    config = function()
        local autopairs = require("nvim-autopairs")
        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                java = false,
            },
            fast_wrap = {
                map = "<M-e>",
            },
        })

        local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if ok then
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}

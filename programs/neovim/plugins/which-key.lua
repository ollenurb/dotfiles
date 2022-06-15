local wk = require('which-key')

wk.setup { }

wk.register({

    ["<Leader>"] = {
        f = {
            name = "find",
            f = {"<cmd>Telescope find_files<cr>", "Find File"},
            g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
            b = {"<cmd>Telescope buffers<cr>", "Find Buffers"},
            h = {"<cmd>Telescope help_tags<cr>", "Find Help Tags"},
            n = {"<cmd>enew<cr>", "New File"},
        },

        n = {
            name = "file tree",
            n = {"<cmd>NvimTreeToggle<cr>", "Toggle File Tree" },
            r = {"<cmd>NvimTreeRefresh<cr>", "Refresh File Tree" },
            f = {"<cmd>NvimTreeFindFile<cr>", "Find File in Tree" },
        },

    },

})

local wk = require('which-key')

wk.setup { }

-- Normal mode bindings
wk.register({

    ["<Leader>"] = {
        f = {
            name = "find",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
            h = { "<cmd>Telescope help_tags<cr>", "Find Help Tags" },
            n = { "<cmd>enew<cr>", "New File" },
        },

        e = {
            name = "file explorer",
            n = { "<cmd>NvimTreeToggle<cr>", "Toggle File Tree" },
            r = { "<cmd>NvimTreeRefresh<cr>", "Refresh File Tree" },
            f = { "<cmd>NvimTreeFindFile<cr>", "Find File in Tree" },
        },

    },

    -- Navigate Buffers Easily
    ["<C-l>"] = { "<cmd>bnext<cr>", "Next Buffer" },
    ["<C-h>"] = { "<cmd>bprevious<cr>", "Next Previous" },

})

-- Visual mode bindings
wk.register({

    -- Keep visual mode while indenting
    ["<"] = { "<gv", "Indent Right" },
    [">"] = { ">gv", "Indent Left" },

    -- Avoid deleting the last thing inside the clipboard register
    ["p"] = { '"_dP', "Paste Text" },

}, { mode = "v" })

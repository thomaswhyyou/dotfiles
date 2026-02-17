-- https://github.com/folke/noice.nvim
return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    messages = {
      enabled = true,
    },

    -- XXX
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },

    views = {
      cmdline_popup = {
        position = { row = "94%", col = "50%" },
        size = { width = 80, height = "auto" },
      },
    },
  },
}

-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  integrations = { "neogit" },
  hl_override = {
    -- Subtle shading for the `colorcolumn` guide (see options.lua). One step
    -- lighter than the `black` background so it reads as a hint, not a divider.
    ColorColumn = { bg = "one_bg" },
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
  },
}

return M

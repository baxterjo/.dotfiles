-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  integrations = { "neogit" },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "my_lsp", "cwd", "cursor" },
    modules = {
      my_lsp = function()
        if rawget(vim, "lsp") then
          -- TODO: Add a client aggregator, (more than one client can be active at a time.)
          local clients = ""
          local copilot = false
          for _, client in ipairs(vim.lsp.get_clients()) do
            if
              client.attached_buffers[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)]
              and client.name ~= "copilot"
            then
              if client.name == "copilot" then
                copilot = true
              else
                clients = clients .. " | " .. client.name
              end
            end
          end
          if copilot then
            clients = clients .. "| copilot"
          end
          return (vim.o.columns > 100 and "   LSP ~ " .. clients .. " ") or "   LSP "
        end

        return "   LSP ~ None "
      end,
    },
  },
}

return M

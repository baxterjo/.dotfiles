local M = {}

local group = vim.api.nvim_create_augroup("CursorHoldDiagnosticFloat", { clear = true })
local enabled = true

local function open_float()
  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end

function M.setup()
  vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = open_float,
  })
end

function M.toggle()
  enabled = not enabled
  if enabled then
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      callback = open_float,
    })
    vim.notify("Diagnostic float on hover: enabled")
  else
    vim.api.nvim_clear_autocmds({ group = group })
    vim.notify("Diagnostic float on hover: disabled")
  end
end

function M.keymap()
  vim.keymap.set("n", "<leader>td", M.toggle, { desc = "Toggle diagnostic float on hover" })
end

return M

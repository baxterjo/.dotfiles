local M = {}

function M.setup()
  local dap, dapui = require("dap"), require("dapui")

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
end

return M

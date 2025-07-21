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

function M.keymap()
  vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
  end, { desc = "Debug Continue" })

  vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
  end, { desc = "Debug Step Over" })

  vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
  end, { desc = "Debug Step Into" })

  vim.keymap.set("n", "<F12>", function()
    require("dap").step_out()
  end, { desc = "Debug Step Out" })

  vim.keymap.set("n", "<Leader>b", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Debug Toggle Breakpoint" })

  vim.keymap.set("n", "<Leader>B", function()
    require("dap").set_breakpoint()
  end, { desc = "Debug Set Breakpoint" })

  vim.keymap.set("n", "<Leader>lp", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end, { desc = "Debug Set Log Point" })

  vim.keymap.set("n", "<Leader>dr", function()
    require("dap").repl.open()
  end)

  vim.keymap.set("n", "<Leader>dl", function()
    require("dap").run_last()
  end, { desc = "Debug Run Last" })

  vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Debug Widget Hover" })

  vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
  end, { desc = "Debug Widget Preview" })

  vim.keymap.set("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
  end, { desc = "Debug Widget" })

  vim.keymap.set("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
  end)
end

return M

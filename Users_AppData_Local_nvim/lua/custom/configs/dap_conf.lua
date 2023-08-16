local dap = require("dap")
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '\\mason\\packages\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
  options = {
        detached = false
    }
}

dap.configurations.cpp = {
  {
    name = 'GDB Windows',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    MIDebuggerPath = "C:\\msys64\\mingw64\\bin\\gdb.exe",
    stopAtEntry = true,
    externalConsole = true,
    runInTerminal = true,
    cwd = '${workspaceFolder}',
    --setupCommands = {
    --        text = "-enable-pretty-printing",
    --        description = 'enable pretty printing',
    --        ignoreFailures = true
    --    },
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
    end,
  },
  ---{
  ---  name = 'GDB Server (dap_conf.txt)',
  ---  type = 'cppdbg',
  ---  request = 'launch',
  ---  MIMode = 'gdb',
  ---  miDebuggerPath = vim.fn.exepath('gdb'),
  ---  miDebuggerServerAddress = "127.0.0.1:2000",
  ---  --args = 
  ---  postRemoteConnectCommands =
  ---  {
  ---    {
  ---      text = "source ${workspaceFolder}/.gdbinit",
  ---    },
  ---  },
  ---     -- miDebuggerArgs = "",
  ---  cwd = '${workspaceFolder}',
  ---  program = function()
  ---    require"custom.configs.launch_gdb_server"
  ---    return local_bin_path..exec_name
  ---  end,
  --},
}
dap.configurations.c = dap.configurations.cpp

------ KEY MAPPING 
--vim.keymap.set('n', "<F4>", function() require('dap').run_last()end)
-------- eclipse like
--vim.keymap.set('n', "<F5>", function() require('dap').step_into()end)
--vim.keymap.set('n', "<F6>", function() require('dap').step_over()end)
--vim.keymap.set('n', "<F7>", function() require('dap').step_out()end)
----vim.keymap.set('n', "<F8>", function() require('dap').continue()end)
-------- option 
--vim.keymap.set('n', "<leader>bm", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))end)
--vim.keymap.set('n', "<leader>bc", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))end)
--vim.keymap.set('n', "<leader>bb", function() require('dap').toggle_breakpoint()end)
--vim.keymap.set('n', "<leader>cb", function() require('dap').clear_breakpoints()end)
--
--vim.keymap.set('n', '<Leader>pf', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.frames)
--end)
--vim.keymap.set('n', '<Leader>pe', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.expression)
--end)
--vim.keymap.set('n', '<Leader>ps', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.scopes)
--end)
--vim.keymap.set('n', '<Leader>pt', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.threads)
--end)r

local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<F4>"] = {
      "<cmd> :lua require('dap').run_last() <CR>",
      "Debugger : run last",
    },
    ["<F5>"] = {
      "<cmd> :lua require('dap').step_into()<CR>",
      "Debugger : step into",
    },
    ["<F6>"] = {
      "<cmd> :lua require('dap').step_over()<CR>",
      "Debugger : step over",
    },
    ["<F7>"] = {
      "<cmd> :lua require('dap').step_out()<CR>",
      "Debugger : step out",
    },
    ["<F8>"] = {
      "<cmd> :lua require('dap').continue()<CR>",
      "Debugger : continue or start",
    },
    ["<leader><enter>"] = {
      "<cmd> :lua vim.lsp.buf.code_action()<CR>",
      "Apply LSP sugestion",
    },
    ["<leader>bm"] = {
      "<cmd> :lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      "Debugger : break message",
    },
    ["<leader>bc"] = {
      "<cmd> :lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Debugger : break condition",
    },
    ["<leader>dq"] = {
        "<cmd> :lua require('dapui').close()<CR>:DapTerminate <CR>",
        "Debugger : close IHM"
    },
    ["<leader>dc"] = {
        "<cmd> :lua require('dap').clear_breakpoints()<CR>",
        "Debugger : clear all breakpoints"
    },
    ["<leader>bb"] = {
      "<cmd> :lua require('dap').toggle_breakpoint()<CR>",
      "Debugger : toggle breakpoint",
    },
    ["<leader>cb"] = {
      "<cmd> :lua require('dap').clear_breakpoints()<CR>",
      "Debugger : clear all breakpoints",
    },
    ["<leader>pf"] = {
      "<cmd> :lua require('dap.ui.widgets').centered_float(widgets.frames)<CR>",
      "Debugger : print frames",
    },
    ["<leader>pe"] = {
      "<cmd> :lua require('dap.ui.widgets').centered_float(widgets.expression)<CR>",
      "Debugger : print expression",
    },
    ["<leader>ps"] = {
      "<cmd> :lua require('dap.ui.widgets').centered_float(widgets.scopes)<CR>",
      "Debugger : print scopes",
    },
    ["<leader>pt"] = {
      "<cmd> :lua require('dap.ui.widgets').centered_float(widgets.threads)<CR>",
      "Debugger : print threads",
    },
    ["<F9>"] = {
      "<cmd> AerialToggle!<CR>",
      "List functions,vars,...",
    },
    ["<leader>pp"] = {
      "<cmd> echo expand('%:p')<CR>",
      "Print current file path",
    },
    ["<leader>ll"] = {
      "<cmd> TroubleToggle<CR>",
      "List Warnings Errors ...",
    },
    ["<leader>ml"] = {
      "<cmd>:!make -j16 2>&1 | tee make_logs.txt <CR>",
      "Make the .makefile saving errors and warnings into make_logs.txt",
    },
    ["<leader>mc"] = {
      "<cmd>:! make clean & rm make_logs.txt <CR>",
      "Make clear",
    },
    ["<leader>fx"] = {
      "<cmd> Telescope grep_string <CR>",
      "Find word under cursor",
    },
    ["<leader>fr"] = {
      "<cmd> Telescope resume <CR>",
      "Resume last search",
    },
    ["fd"] = {
      "<cmd> Telescope lsp_definitions <CR>",
      "Find LSP Definition (telescope)",
    },
    ["fr"] = {
      "<cmd> Telescope lsp_references <CR>",
      "Find LSP References (telescope)",
    },
    ["fi"] = {
      "<cmd> Telescope lsp_implementations <CR>",
      "Find LSP Implementaions (telescope)",
    },
    ["<A-Right>"] =
    {
        "<cmd>BufferMoveNext<CR> ",
        "Move tabs to the right side"
    },
    ["<A-Left>"] =
    {
        "<cmd>BufferMovePrevious<CR> ",
        "Move tabs to the left side"
    },

    -- ["<leader>dr"] = {
   --   "<cmd> DapContinue <CR>",
   --   "Start or continue the debugger",
   -- }
  }
}

return M

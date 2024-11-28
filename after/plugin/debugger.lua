local dap = require('dap')
local dapui = require("dapui")
require('nvim-dap-virtual-text').setup()
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
dap.adapters.lldb = {
    type = "executable",
    command = "/home/michaelaboah/.local/share/nvim/mason/packages/codelldb/codelldb",
    name = "lldb"
}

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/michaelaboah/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
local gdb_file = {
    name = "Launch File (gdb): ",
    type = "cppdbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,

    setupCommands = {  
        { 
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false 
        },
    }
}

local gdb_server = {
    name = 'Attach to gdbserver :3333',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:3333',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {  
        { 
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false 
        },
    },
}


-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
local lldb = {
    name = 'Launch File (lldb): ',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
}

local lldb_server = {
    name = 'Launch Server (lldb): ',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
}

dap.configurations.c = { lldb, gdb_file, gdb_server }
dap.configurations.rust = { lldb }
dap.configurations.zig = { lldb }

dapui.setup()


vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>ds", dap.step_into)
vim.keymap.set("n", "<leader>dS", dap.step_over)
vim.keymap.set("n", "<leader>da", dap.step_out)
vim.keymap.set("n", "<leader>dA", dap.step_back)
vim.keymap.set("n", "<leader>dr", dap.restart)


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

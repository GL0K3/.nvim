return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

      require('dapui').setup()
      dap.set_log_level 'TRACE'
      require('dap-go').setup()
      -- local python_path = table.concat({ vim.fn.stdpath 'data', 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
      require('dap-python').setup()
      require('dap-python').test_runner = 'pytest'

      require('nvim-dap-virtual-text').setup {}
      -- dap.adapters.python = {
      --   type = 'executable',
      --   command = 'python',
      --   args = { '-Xfrozen_modules=off', '-m', 'debugpy.adapter' },
      -- }

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = 'manage.py',
        args = { 'runserver' },
        justMyCode = true,
        django = true,
        console = 'integratedTerminal',
        projectDir = '${workspaceFolder}',
        pythonPath = 'python',
        cwd = '${workspaceFolder}',
        options = {
          detached = true,
        },
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'JustLaunch',
        program = 'test.py',
        console = 'integratedTerminal',
        projectDir = '${workspaceFolder}',
        pythonPath = 'python',
        cwd = '${workspaceFolder}',
        options = {
          detached = true,
        },
      })

      local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
      if elixir_ls_debugger ~= '' then
        dap.adapters.mix_task = {
          type = 'executable',
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = 'mix_task',
            name = 'phoenix server',
            task = 'phx.server',
            request = 'launch',
            projectDir = '${workspaceFolder}',
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
          },
        }
      end

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F13>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}

local M = {}

local scan = require "plenary.scandir"

local contains = function(tbl, str)
  for _, v in ipairs(tbl) do
    if v == str then
      return true
    end
  end
  return false
end

local exists = function(dir, file_pattern)
  local dirs = scan.scan_dir(dir, { depth = 1, search_pattern = file_pattern })
  return contains(dirs, dir .. "/" .. file_pattern)
end

function M.setup()
  local dap = require("dap")

  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/Users/lukefilewalker/temp/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
  }

  dap.adapters.lldb = {
    type = 'executable',
    -- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
    command = '/Users/lukefilewalker/.vscode/extensions/lanza.lldb-vscode-0.2.3/bin/darwin/bin/lldb-vscode',
    name = "lldb"
  }

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "/Users/lukefilewalker/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb",
      args = { "--port", "${port}" },
    }
  }

  dap.configurations.cpp = {
    {
      name = "C/C++: clang build and debug active file",
      type = "cppdbg",
      request = "launch",
      -- program = "${fileDirname}/${fileBasenameNoExtension}",
      program = function()
        -- First, check if exists CMakeLists.txt
        local cwd = vim.fn.getcwd()
        local fileName = vim.fn.expand("%:t:r")
        if (not exists(cwd, "bin")) then
          -- create this directory
          os.execute("mkdir " .. "bin")
        end
        local cmd = "!gcc -g % -o bin/" .. fileName
        -- First, compile it
        vim.cmd(cmd)
        -- Then, return it
        return "bin/" .. fileName
      end,
      --args = [],
      stopAtEntry = false,
      cwd = "${workspaceFolder}",
      -- environment = [],
      externalConsole = false,
      MIMode = "lldb",
      preLaunchTask = "C/C++: clang build active file"
    },
    {
      name = "C/C++: clang build and debug via make",
      type = "cppdbg",
      request = "launch",
      -- program = "${fileDirname}/${fileBasenameNoExtension}",
      program = function()
        local cmd = "!make debug"
        vim.cmd(cmd)

        return "./debug"
      end,
      args = {"debug"},
      stopAtEntry = false,
      cwd = "${workspaceFolder}",
      -- environment = [],
      externalConsole = false,
      MIMode = "lldb",
      preLaunchTask = "C/C++: clang build and debug via make"
    },
    {
      name = "C/C++: clang build and default make task",
      type = "cppdbg",
      request = "launch",
      -- program = "${fileDirname}/${fileBasenameNoExtension}",
      program = function()
        local cmd = "!make test"
        vim.cmd(cmd)
        local fname = vim.fn.input({prompt = "File: "})

        return "./" .. fname
      end,
      args = {},
      stopAtEntry = false,
      cwd = "${workspaceFolder}",
      -- environment = [],
      externalConsole = false,
      MIMode = "lldb",
      preLaunchTask = "C/C++: clang build and default make task"
    },
    -- {
    --   name = "Launch",
    --   type = "lldb",
    --   request = "launch",
    --   program = function()
    --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --   end,
    --   cwd = '${workspaceFolder}',
    --   stopOnEntry = false,
    --   args = {},
    --   runInTerminal = true,
    -- },
    -- {
    --   name = "C Debug And Run",
    --   type = "codelldb",
    --   request = "launch",
    --   program = function()
    --     -- First, check if exists CMakeLists.txt
    --     local cwd = vim.fn.getcwd()
    --     local fileName = vim.fn.expand("%:t:r")
    --     if (not exists(cwd, "bin")) then
    --       -- create this directory
    --       os.execute("mkdir " .. "bin")
    --     end
    --     local cmd = "!gcc -g % -o bin/" .. fileName
    --     -- First, compile it
    --     vim.cmd(cmd)
    --     -- Then, return it
    --     return "${fileDirname}/bin/" .. fileName
    --   end,
    --   cwd = "${workspaceFolder}",
    --   stopOnEntry = false
    -- },
  }

  dap.configurations.c = dap.configurations.cpp
end

function M.dapRunConfigWithArgs()
  local dap = require('dap')
  local ft = vim.bo.filetype
  if ft == "" then
    print("Filetype option is required to determine which dap configs are available")
    return
  end
  local configs = dap.configurations[ft]
  if configs == nil then
    print("Filetype \"" .. ft .. "\" has no dap configs")
    return
  end
  local mConfig = nil
  vim.ui.select(
    configs,
    {
      prompt = "Select config to run: ",
      format_item = function(config)
        return config.name
      end
    },
    function(config)
      mConfig = config
    end
  )

  -- redraw to make ui selector disappear
  vim.api.nvim_command("redraw")

  if mConfig == nil then
    return
  end
  vim.ui.input(
    {
      prompt = mConfig.name .." - with args: ",
    },
    function(input)
      if input == nil then
        return
      end
      local args = vim.split(input, ' ', true)
      mConfig.args = args
      dap.run(mConfig)
    end
  )
end

return M

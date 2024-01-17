-----------------------------------------------------------------------
-- [[ Shared functions ]]
-----------------------------------------------------------------------

local M = {}

-- Easily switch between .c and .h files
M.switch_c_h = function()
    local curFile = vim.fn.expand('%')
    local ext = string.match(curFile, ".(%w+)$")
    local name = string.sub(curFile, 0, string.len(curFile) - string.len(ext))

    if ext == "h" or ext == "hpp" then
        if (vim.fn.filereadable(name .. "c") > 0) then
            vim.cmd(":e " .. name .. "c")
        elseif (vim.fn.filereadable(name .. "cpp") > 0) then
            vim.cmd(":e " .. name .. "cpp")
        end
    end

    if ext == "c" or ext == "cpp" then
        if (vim.fn.filereadable(name .. "h") > 0) then
            vim.cmd(":e " .. name .. "h")
        elseif (vim.fn.filereadable(name .. "hpp") > 0) then
            vim.cmd(":e " .. name .. "hpp")
        end
    end
end

return M

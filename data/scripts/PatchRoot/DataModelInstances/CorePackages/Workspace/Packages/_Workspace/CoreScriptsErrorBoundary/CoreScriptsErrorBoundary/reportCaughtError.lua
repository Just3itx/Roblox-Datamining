-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local formatCaughtError = require(script.Parent.formatCaughtError)

local function reportCaughtError(arg1, arg2)
    local var1 = formatCaughtError(arg1, arg2)
    task.spawn(function()
        error(var1, 0)
    end)
end

return reportCaughtError

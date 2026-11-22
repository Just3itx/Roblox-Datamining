-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local forwardErrorToScriptContext = require(script.Parent.forwardErrorToScriptContext)

local function reportMilestoneError(arg1)
    forwardErrorToScriptContext(debug.traceback(tostring(arg1), 2))
end

local function tryMilestoneOperation(callback: (...any) -> (...any)): boolean
    return (xpcall(callback, reportMilestoneError))
end

return tryMilestoneOperation

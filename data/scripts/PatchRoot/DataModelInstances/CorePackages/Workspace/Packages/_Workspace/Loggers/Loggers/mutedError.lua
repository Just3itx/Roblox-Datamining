-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LoggersParent = script:FindFirstAncestor("Loggers").Parent

local RobloxAppEvents = require(LoggersParent.RobloxAppEvents)
local FFlagDebugUnmuteLuaErrors = require(LoggersParent.SharedFlags).Debug.FFlagDebugUnmuteLuaErrors

local function IsRunningInStudio(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetService("RunService"):IsStudio()
end

return function(str1: string, arg1)
    if type(str1) ~= "string" then
        warn("mutedError: errorMessage should be a string!")

        local success, _result = pcall(function()
            str1 = tostring(str1)
        end)

        str1 = if success then str1 else "mutedError"
    end

    if FFlagDebugUnmuteLuaErrors or IsRunningInStudio() or _G.__TESTEZ_RUNNING_TEST__ then
        error(str1)
    else
        if type(arg1) == "table" and type(arg1.stacks) == "table" then
            table.insert(arg1.stacks, debug.traceback())
        end
        RobloxAppEvents.ReportMutedError:fire(str1, debug.traceback(), script, arg1)
    end
end

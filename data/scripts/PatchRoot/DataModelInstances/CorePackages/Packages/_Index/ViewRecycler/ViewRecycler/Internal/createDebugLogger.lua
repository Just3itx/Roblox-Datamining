-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DebugFlags = require(ViewRecycler.Internal.DebugFlags)

local function createDebugLogger(str1: string)
    return function(arg1, ...)
        if not DebugFlags.shouldLog then
            return
        end

        if typeof(arg1) == "string" then
            print(`[{str1}] {string.format(arg1, ...)}`)
        else
            print(`[{str1}]`, arg1(...))
        end
    end
end

return createDebugLogger

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)

local function whenFirstTrue(func1: (...any) -> (...any), callback: (...any) -> (...any))
    local bool1 = false
    return Signals.createEffect(function(arg1)
        if bool1 or not func1(arg1) then
            return
        end

        bool1 = true
        callback()
    end)
end

return whenFirstTrue

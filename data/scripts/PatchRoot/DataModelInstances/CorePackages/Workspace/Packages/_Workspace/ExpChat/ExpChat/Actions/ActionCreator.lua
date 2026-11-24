-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Cryo = require(ExpChatParent.Cryo)

return function(type: string, func1: (...any) -> (...any))
    return function(...)
        local tbl1 = { type = type }

        local var1 = func1(...)
        return (Cryo.Dictionary.union(var1, tbl1))
    end
end

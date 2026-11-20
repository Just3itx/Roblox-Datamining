-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCallParent = script:FindFirstAncestor("RoduxCall").Parent
return require(RoduxCallParent.Rodux).makeActionCreator(script.Name, function(call)
    return {
        payload = { call = call }
    }
end)

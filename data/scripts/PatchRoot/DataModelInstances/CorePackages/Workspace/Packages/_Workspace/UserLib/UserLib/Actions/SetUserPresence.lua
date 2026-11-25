-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

return require(UserLibParent.Rodux).makeActionCreator(script.Name, function(arg1, presence, lastLocation)
    return {
        userId = tostring(arg1),
        presence = presence,
        lastLocation = lastLocation
    }
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRoduxParent = script:FindFirstAncestor("NavigationRodux").Parent

local makeActionCreator = require(NavigationRoduxParent.Rodux).makeActionCreator
local ArgCheck = require(NavigationRoduxParent.ArgCheck)

return makeActionCreator(script.Name, function(arg1)
    return {
        locked = ArgCheck.isType(arg1, "boolean", "locked")
    }
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Rodux = require(scriptParentParent.Rodux)

local Invites = require(scriptParent.Reducers.Invites)

return function(arg1)
    return Rodux.combineReducers({ Invites = Invites(arg1) })
end

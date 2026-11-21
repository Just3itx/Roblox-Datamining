-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Rodux = require(scriptParentParentParent.Rodux)
local _roduxFriendsTypes = require(scriptParentParent.roduxFriendsTypes)

return Rodux.makeActionCreator(script.Name, function(payload)
    return { payload = payload }
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking
local RoduxUserPermissions = dependencies.RoduxUserPermissions

return function()
    return Rodux.combineReducers(
        {
            UserPermissions = RoduxUserPermissions.installReducer(),
            NetworkStatus = RoduxNetworking.installReducer()
        }
    )
end

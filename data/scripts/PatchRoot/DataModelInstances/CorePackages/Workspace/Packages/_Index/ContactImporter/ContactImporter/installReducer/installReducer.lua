-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking

local Contacts = require(script.Parent.Contacts)
local ShowContactImporterParams = require(script.Parent.ShowContactImporterParams)
local RoduxUserPermissions = dependencies.RoduxUserPermissions

return function()
    return Rodux.combineReducers({
        Contacts = Contacts,
        UserPermissions = RoduxUserPermissions.installReducer(),
        NetworkStatus = RoduxNetworking.installReducer(),
        ShowContactImporterParams = ShowContactImporterParams
    })
end

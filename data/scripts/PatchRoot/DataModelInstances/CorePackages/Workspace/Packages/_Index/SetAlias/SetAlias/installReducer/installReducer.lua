-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking
local RoduxAliases = dependencies.RoduxAliases

return function()
    return Rodux.combineReducers({ Aliases = RoduxAliases.installReducer(), NetworkStatus = RoduxNetworking.installReducer() })
end

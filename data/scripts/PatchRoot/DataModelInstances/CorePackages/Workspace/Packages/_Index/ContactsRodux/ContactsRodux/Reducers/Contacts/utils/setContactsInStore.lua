-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Types = scriptParentParentParentParent.Types
local _ReducerTypes = require(Types.ReducerTypes)
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local _ActionTypes = require(Types.ActionTypes)
local Dash = require(scriptParentParentParentParentParent.Dash)

return function(arg1)
    local userContactIds = arg1.responseBody.userContactIds
    local result = ({})

    Dash.forEach(userContactIds, function(arg2)
        result[arg2] = {}
    end)

    return result
end

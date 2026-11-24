-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local Rodux = require(scriptParentParentParent.Rodux)
local GameInviteReducer = require(scriptParent.Reducers.GameInviteReducer)

return Rodux.Store.new(GameInviteReducer, nil, { Rodux.thunkMiddleware })

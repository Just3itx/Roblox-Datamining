-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local Rodux = require(ExpChatSharedParent.Rodux)

local RaiseActionAsEventMiddleware = require(script.Parent.RaiseActionAsEventMiddleware)
local Reducers = require(script.Parent.Reducers)

local function createStore(arg1)
    return Rodux.Store.new(Rodux.combineReducers(Reducers), arg1, { Rodux.thunkMiddleware, RaiseActionAsEventMiddleware })
end

return createStore

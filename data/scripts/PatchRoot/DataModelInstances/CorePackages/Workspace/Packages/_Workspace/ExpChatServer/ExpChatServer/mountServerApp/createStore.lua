-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatServerParent = script:FindFirstAncestor("ExpChatServer").Parent
local Rodux = require(ExpChatServerParent.Rodux)

local installReducer = require(script.Parent.installReducer)

local function createStore()
    return Rodux.Store.new(installReducer, nil, { Rodux.thunkMiddleware })
end

return createStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Rodux = require(AppChatParent.Rodux)

local SetAppLoaded = require(AppChat.Actions.SetAppLoaded)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetAppLoaded.name] = function(_, arg1)
    return arg1.value
end

return createReducer(false, tbl1)

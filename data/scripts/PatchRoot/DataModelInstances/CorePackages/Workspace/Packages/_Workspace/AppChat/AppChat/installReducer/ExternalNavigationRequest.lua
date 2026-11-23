-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Rodux = require(AppChatParent.Rodux)
local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)
local CompleteExternalNavigationIntoChat = require(AppChat.Actions.CompleteExternalNavigationIntoChat)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[NavigateIntoChat.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { screen = arg2.screen, params = arg2.params, requestId = arg1.requestId + 1 })
end

tbl1[CompleteExternalNavigationIntoChat.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { completedRequestId = arg2.requestId })
end

return createReducer({ screen = nil, params = nil, requestId = 0, completedRequestId = 0 }, tbl1)

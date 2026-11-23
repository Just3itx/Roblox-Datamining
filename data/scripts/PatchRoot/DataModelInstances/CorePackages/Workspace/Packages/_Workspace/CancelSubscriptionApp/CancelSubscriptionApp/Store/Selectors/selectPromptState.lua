-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")

local _Types = require(CancelSubscriptionApp.Store.Types)
local _CancelUserSubscriptionAsyncPromptStateEnum = require(CancelSubscriptionApp.Enums.CancelUserSubscriptionAsyncPromptStateEnum)

local function selectPromptState(arg1)
    return arg1.promptState
end

return selectPromptState

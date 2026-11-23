-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local Rodux = require(CancelSubscriptionAppParent.Rodux)

local CancelUserSubscriptionAsyncPromptStateEnum = require(CancelSubscriptionApp.Enums.CancelUserSubscriptionAsyncPromptStateEnum)
local CancelSubscriptionEnded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionEnded)
local CancelSubscriptionSucceeded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionSucceeded)
local CancelSubscriptionFailed = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionFailed)
local CancelSubscriptionStarted = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionStarted)
local CancelSubscriptionRequested = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionRequested)

local _Types = require(CancelSubscriptionApp.Store.Types)

local function createInitialState() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        promptState = CancelUserSubscriptionAsyncPromptStateEnum.None
    }
end

local createReducer = Rodux.createReducer
local initialState = createInitialState()
local tbl1 = {}
tbl1[CancelSubscriptionEnded.name] = function(_, _)
    return createInitialState()
end

tbl1[CancelSubscriptionSucceeded.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.subscriptionId = arg2.subscriptionId
    var1.promptState = CancelUserSubscriptionAsyncPromptStateEnum.Success
    return var1
end

tbl1[CancelSubscriptionFailed.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.errorState = arg2.errorState
    var1.subscriptionId = arg2.subscriptionId
    var1.promptState = CancelUserSubscriptionAsyncPromptStateEnum.Error
    return var1
end

tbl1[CancelSubscriptionRequested.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.subscriptionId = arg2.subscriptionId
    var1.promptState = CancelUserSubscriptionAsyncPromptStateEnum.Pending
    return var1
end

tbl1[CancelSubscriptionStarted.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.promptState = CancelUserSubscriptionAsyncPromptStateEnum.Request
    var1.subscriptionId = arg2.subscriptionId
    var1.expirationDate = arg2.expirationDate
    return var1
end

return (createReducer(initialState, tbl1))

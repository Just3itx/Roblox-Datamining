-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ChatInputBarConfigurationEnabled = require(Actions.ChatInputBarConfigurationEnabled)
local ChatTopBarButtonActivated = require(Actions.ChatTopBarButtonActivated)
local SetCoreGuiEnabledChanged = require(Actions.SetCoreGuiEnabledChanged)
local ClientAppLoaded = ExpChatShared.Actions.ClientAppLoaded
local UserInteraction = require(ExpChat.Actions.UserInteraction)
local IncomingMessageReceived = require(Actions.IncomingMessageReceived)

local tbl1 = {
    textDurationUntilFadeout = 30,
    backgroundDurationUntilFadeout = 3.5,
    lastGeneralActivityTimestamp = 0,
    lastMessageActivityTimestamp = 0,
    isTextBoxFocused = false
}

local function reset(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local now = os.clock()

    return Dictionary.join(
        tbl1,
        {
            isTextBoxFocused = tbl2.isTextBoxFocused,
            lastGeneralActivityTimestamp = now,
            lastMessageActivityTimestamp = now
        }
    )
end

local function resetTextOnly(tbl2)
    local lastMessageActivityTimestamp = os.clock()

    return Dictionary.join(
        tbl2,
        {
            isTextBoxFocused = tbl2.isTextBoxFocused,
            lastMessageActivityTimestamp = lastMessageActivityTimestamp
        }
    )
end
local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ChatInputBarConfigurationEnabled.name] = function(tbl3, arg1)
    if arg1.enabled then
        return reset(tbl3)
    end
    return tbl3
end

tbl2[ChatTopBarButtonActivated.name] = function(tbl3, arg1)
    if arg1.isVisible then
        return reset(tbl3)
    end
    return tbl3
end

tbl2[SetCoreGuiEnabledChanged.name] = function(tbl3, arg1)
    if arg1.enabled then
        return reset(tbl3)
    end
    return tbl3
end

tbl2[ClientAppLoaded.name] = function(tbl3, _)
    return reset(tbl3)
end

tbl2[UserInteraction.name] = function(tbl3, arg1)
    if arg1.interaction == "focus" then
        return Dictionary.join(reset(tbl3), { isTextBoxFocused = true })
    elseif arg1.interaction == "unfocus" then
        return Dictionary.join(reset(tbl3), { isTextBoxFocused = false })
    end

    return reset(tbl3)
end

tbl2[IncomingMessageReceived.name] = function(tbl3, _)
    return resetTextOnly(tbl3)
end

return createReducer(tbl1, tbl2)

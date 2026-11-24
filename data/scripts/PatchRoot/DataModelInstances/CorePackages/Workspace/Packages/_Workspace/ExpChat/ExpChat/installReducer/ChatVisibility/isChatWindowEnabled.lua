-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ChatWindowConfigurationEnabled = require(Actions.ChatWindowConfigurationEnabled)
local ChatTopBarButtonActivated = require(Actions.ChatTopBarButtonActivated)
local SetCoreGuiEnabledChanged = require(Actions.SetCoreGuiEnabledChanged)

local ClientAppLoaded = ExpChatShared.Actions.ClientAppLoaded

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ChatWindowConfigurationEnabled.name] = function(tbl2, arg1)
    return Dictionary.join(
        tbl2,
        {
            _propertyEnabled = arg1.enabled,
            value = tbl2._topBarVisibility and tbl2._coreGuiEnabled and arg1.enabled
        }
    )
end

tbl1[ChatTopBarButtonActivated.name] = function(tbl2, arg1)
    return Dictionary.join(
        tbl2,
        {
            _topBarVisibility = arg1.isVisible,
            value = tbl2._propertyEnabled and tbl2._coreGuiEnabled and arg1.isVisible
        }
    )
end

tbl1[SetCoreGuiEnabledChanged.name] = function(tbl2, arg1)
    return Dictionary.join(
        tbl2,
        {
            _coreGuiEnabled = arg1.enabled,
            value = tbl2._propertyEnabled and tbl2._topBarVisibility and arg1.enabled
        }
    )
end

tbl1[ClientAppLoaded.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, {
        _coreGuiEnabled = arg1.isChatCoreGuiEnabled,
        value = tbl2._propertyEnabled and tbl2._topBarVisibility and arg1.isChatCoreGuiEnabled
    })
end

return createReducer({ _propertyEnabled = true, _coreGuiEnabled = true, _topBarVisibility = true, value = true }, tbl1)

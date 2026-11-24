-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local BubbleChatSettingsChanged = require(Actions.BubbleChatSettingsChanged)
local BubbleChatChildSettingChanged = require(Actions.BubbleChatChildSettingChanged)
local BubbleChatChildRemoved = require(Actions.BubbleChatChildRemoved)

local DefaultSettings = require(script.Parent.DefaultSettings)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ConfigurationObjectsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(arg1, arg2.bubbleChatSettings)
end

tbl1[BubbleChatSettingsChanged.name] = function(arg1, arg2)
    return Dictionary.join(arg1, { [arg2.property] = arg2.value })
end

tbl1[BubbleChatChildSettingChanged.name] = function(arg1, arg2)
    local join = Dictionary.join
    local tbl2 = {
        [arg2.childName] = Dictionary.join(arg1[arg2.childName], { [arg2.property] = arg2.value })
    }
    return join(arg1, tbl2)
end

tbl1[BubbleChatChildRemoved.name] = function(arg1, arg2)
    return Dictionary.removeKey(arg1, arg2.childName)
end

return createReducer(DefaultSettings, tbl1)

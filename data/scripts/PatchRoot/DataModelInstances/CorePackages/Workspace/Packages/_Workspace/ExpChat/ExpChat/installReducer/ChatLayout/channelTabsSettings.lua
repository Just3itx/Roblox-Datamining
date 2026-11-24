-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Config = require(ExpChat.Config)

local Actions = ExpChat.Actions
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local ChannelTabsSettingsChanged = require(Actions.ChannelTabsSettingsChanged)

local tbl1 = {
    BackgroundTransparency = Config.ChannelTabsSettings.BackgroundTransparency,
    BackgroundColor3 = Config.ChannelTabsSettings.BackgroundColor3,
    HoverBackgroundColor3 = Config.ChannelTabsSettings.HoverBackgroundColor3,
    FontFace = Config.ChannelTabsSettings.FontFace,
    TextSize = Config.ChannelTabsSettings.TextSize,
    TextColor3 = Config.ChannelTabsSettings.TextColor3,
    SelectedTabTextColor3 = Config.ChannelTabsSettings.SelectedTabTextColor3,
    TextStrokeColor3 = Config.ChannelTabsSettings.TextStrokeColor3,
    TextStrokeTransparency = Config.ChannelTabsSettings.TextStrokeTransparency
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ConfigurationObjectsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(arg1, arg2.channelTabsSettings)
end

tbl2[ChannelTabsSettingsChanged.name] = function(arg1, arg2)
    if not arg1[arg2.property] then
        return arg1
    end

    return Dictionary.join(arg1, { [arg2.property] = arg2.value })
end

return createReducer(tbl1, tbl2)

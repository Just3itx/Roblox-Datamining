-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Config = require(ExpChat.Config)
local None = require(ExpChatParent.llama).None

local Actions = ExpChat.Actions
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local ChatInputBarSettingsChanged = require(Actions.ChatInputBarSettingsChanged)

local tbl1 = {
    BackgroundTransparency = Config.ChatInputBarBackgroundTransparency,
    BackgroundColor3 = Config.ChatInputBarBackgroundColor,
    TextSize = Config.ChatInputBarTextSize,
    TextColor3 = Config.ChatInputBarTextColor3,
    SpatialPanelTextSize = Config.ChatInputBarSpatialPanelTextSize,
    TextStrokeColor3 = Config.ChatInputBarTextStrokeColor,
    TextStrokeTransparency = Config.ChatInputBarTextStrokeTransparency,
    FontFace = Config.ChatInputBarFontFace,
    PlaceholderColor3 = Config.ChatInputBarPlaceholderColor,
    KeyboardKeyCode = Config.ChatInputBarDefaultFocusKeyCode,
    AutocompleteEnabled = Config.ChatInputBarDefaultAutocompleteEnabled
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ConfigurationObjectsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(arg1, arg2.chatInputBarSettings)
end

tbl2[ChatInputBarSettingsChanged.name] = function(arg1, arg2)
    local _value = arg2.value

    if arg1[arg2.property] == nil and arg2.property ~= "TextBox" then
        return arg1
    end

    local var1 = if arg2.property == "TextBox" and arg2.value == nil then None else arg2.value
    return Dictionary.join(arg1, { [arg2.property] = var1 })
end

return createReducer(tbl1, tbl2)

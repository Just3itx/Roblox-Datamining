-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Config = require(ExpChat.Config)

local Actions = ExpChat.Actions
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local ChatWindowSettingsChanged = require(Actions.ChatWindowSettingsChanged)

local tbl1 = {
    Font = Config.ChatWindowFont,
    TextColor3 = Config.ChatWindowTextColor3,
    TextSize = Config.ChatWindowTextSize,
    TextStrokeColor3 = Config.ChatWindowTextStrokeColor,
    TextStrokeTransparency = Config.ChatWindowTextStrokeTransparency,
    BackgroundColor3 = Config.ChatWindowBackgroundColor3,
    BackgroundTransparency = Config.ChatWindowBackgroundTransparency,
    HeightScale = 1,
    WidthScale = 1,
    SpatialPanelTextSize = Config.ChatWindowSpatialPanelTextSize
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ConfigurationObjectsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(arg1, arg2.chatWindowSettings)
end

tbl2[ChatWindowSettingsChanged.name] = function(arg1, arg2)
    if not arg1[arg2.property] then
        return arg1
    end

    return Dictionary.join(arg1, { [arg2.property] = arg2.value })
end

return createReducer(tbl1, tbl2)

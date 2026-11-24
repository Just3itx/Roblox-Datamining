-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local tutils = require(ExpChatParent.tutils)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local DefaultSettings = require(ExpChat.installReducer.BubbleChat.DefaultSettings)

local function createChatConfigurationStore()
    local var1 = table.clone(DefaultSettings)

    local config = require(ExpChat.Config)
    local tbl1 = {
        FontFace = config.ChatWindowFont,
        TextColor3 = config.ChatWindowTextColor3,
        TextSize = config.ChatWindowTextSize,
        TextStrokeColor3 = config.ChatWindowTextStrokeColor,
        TextStrokeTransparency = config.ChatWindowTextStrokeTransparency,
        BackgroundColor3 = config.ChatWindowBackgroundColor3,
        BackgroundTransparency = config.ChatWindowBackgroundTransparency,
        HeightScale = 1,
        WidthScale = 1,
        SpatialPanelTextSize = config.ChatWindowSpatialPanelTextSize
    }
    local tbl2 = {
        BackgroundTransparency = config.ChatInputBarBackgroundTransparency,
        BackgroundColor3 = config.ChatInputBarBackgroundColor,
        TextSize = config.ChatInputBarTextSize,
        TextColor3 = config.ChatInputBarTextColor3,
        SpatialPanelTextSize = config.ChatInputBarSpatialPanelTextSize,
        TextStrokeColor3 = config.ChatInputBarTextStrokeColor,
        TextStrokeTransparency = config.ChatInputBarTextStrokeTransparency,
        FontFace = config.ChatInputBarFontFace,
        PlaceholderColor3 = config.ChatInputBarPlaceholderColor,
        KeyboardKeyCode = config.ChatInputBarDefaultFocusKeyCode,
        AutocompleteEnabled = config.ChatInputBarDefaultAutocompleteEnabled
    }
    local tbl3 = {
        BackgroundTransparency = config.ChannelTabsSettings.BackgroundTransparency,
        BackgroundColor3 = config.ChannelTabsSettings.BackgroundColor3,
        HoverBackgroundColor3 = config.ChannelTabsSettings.HoverBackgroundColor3,
        FontFace = config.ChannelTabsSettings.FontFace,
        TextSize = config.ChannelTabsSettings.TextSize,
        TextColor3 = config.ChannelTabsSettings.TextColor3,
        SelectedTabTextColor3 = config.ChannelTabsSettings.SelectedTabTextColor3,
        TextStrokeColor3 = config.ChannelTabsSettings.TextStrokeColor3,
        TextStrokeTransparency = config.ChannelTabsSettings.TextStrokeTransparency
    }

    local getBubbleChatSettings, setBubbleChatSettings = createSignal(var1, tutils.deepEqual)
    local getChatWindowSettings, setChatWindowSettings = createSignal(tbl1, tutils.deepEqual)
    local getChatInputBarSettings, setChatInputBarSettings = createSignal(tbl2, tutils.deepEqual)
    local getChannelTabsSettings, setChannelTabsSettings = createSignal(tbl3, tutils.deepEqual)

    return {
        getBubbleChatSettings = getBubbleChatSettings,
        getChatWindowSettings = getChatWindowSettings,
        getChatInputBarSettings = getChatInputBarSettings,
        getChannelTabsSettings = getChannelTabsSettings,
        setBubbleChatSettings = setBubbleChatSettings,
        setChatWindowSettings = setChatWindowSettings,
        setChatInputBarSettings = setChatInputBarSettings,
        setChannelTabsSettings = setChannelTabsSettings,
        mergeBubbleChatSettings = function(tbl4)
            setBubbleChatSettings(function(arg1)
                local var10 = table.clone(arg1)
                for k, value in pairs(tbl4) do
                    var10[k] = value
                end
                return var10
            end)
        end,
        mergeChatWindowSettings = function(tbl4)
            setChatWindowSettings(function(arg1)
                local var10 = table.clone(arg1)
                for k, value in pairs(tbl4) do
                    var10[k] = value
                end
                return var10
            end)
        end,
        mergeChatInputBarSettings = function(tbl4)
            setChatInputBarSettings(function(arg1)
                local var10 = table.clone(arg1)
                for k, value in pairs(tbl4) do
                    var10[k] = value
                end
                return var10
            end)
        end,
        mergeChannelTabsSettings = function(tbl4)
            setChannelTabsSettings(function(arg1)
                local var10 = table.clone(arg1)
                for k, value in pairs(tbl4) do
                    var10[k] = value
                end
                return var10
            end)
        end,
        setBubbleChatProperty = function(str1: string, arg1)
            setBubbleChatSettings(function(arg2)
                local var10 = table.clone(arg2)
                var10[str1] = arg1
                return var10
            end)
        end,
        setChatWindowProperty = function(str1: string, arg1)
            setChatWindowSettings(function(arg2)
                local var10 = table.clone(arg2)
                var10[str1] = arg1
                return var10
            end)
        end,
        setChatInputBarProperty = function(str1: string, arg1)
            setChatInputBarSettings(function(arg2)
                local var10 = table.clone(arg2)
                var10[str1] = arg1
                return var10
            end)
        end,
        setChannelTabsProperty = function(str1: string, arg1)
            setChannelTabsSettings(function(arg2)
                local var10 = table.clone(arg2)
                var10[str1] = arg1
                return var10
            end)
        end,
        getIsBubbleChatEnabled = createComputed(function(arg1)
            return getBubbleChatSettings(arg1).Enabled or false
        end)
    }
end
return createChatConfigurationStore

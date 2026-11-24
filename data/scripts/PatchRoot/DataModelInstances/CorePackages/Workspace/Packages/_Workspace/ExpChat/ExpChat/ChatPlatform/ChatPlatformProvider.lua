-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SharedFlags = require(ExpChatParent.SharedFlags)
local ChatUIPrimitives = require(ExpChatParent.ChatUIPrimitives)

local Config = require(ExpChat.Config)
local ClientSettings = require(ExpChat.ClientSettings)
local ClientSettingsUtility = require(ExpChat.ClientSettings.ClientSettingsUtility)
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)

local Provider = require(ExpChatParent.ExpChatIntegration.ChatPlatformContext).Provider
local usePropSignal = ChatUIPrimitives.Hooks.usePropSignal
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore

local chatWindowSettings = {
    ChatWindowBackgroundColor3 = Config.ChatWindowBackgroundColor3,
    ChatWindowBackgroundTransparency = Config.ChatWindowBackgroundTransparency,
    ChatWindowMaxWidth = Config.ChatWindowMaxWidth,
    ChatWindowMaxHeight = Config.ChatWindowMaxHeight
}

local function makeInterpolators(arg1)
    return {
        getBackgroundColor = function(arg2)
            return ClientSettingsUtility.getBackgroundColor(arg2, arg1)
        end,
        getBackgroundTransparency = function(arg2)
            return ClientSettingsUtility.getBackgroundTransparency(arg2, arg1)
        end
    }
end

local function ChatPlatformProvider(tbl2)
    local var1 = React.useContext(ClientSettings)

    local var2 = if FFlagExpChatUseChatConfigStore then SignalsReact.useSignalState(GetChatConfigurationStore(false).getChatInputBarSettings) else useSelector(function(arg1)
        return arg1.ChatLayout.ChatInputBarSettings
    end)

    local var3 = React.useMemo(function()
        return (makeInterpolators(var1))
    end, { var1 })

    local getChatInputBarSettings = usePropSignal(var2)
    local getInterpolators = usePropSignal(var3)

    local value = React.useMemo(function()
        return {
            getChatInputBarSettings = getChatInputBarSettings,
            chatWindowSettings = chatWindowSettings,
            getInterpolators = getInterpolators,
            getTransparencyStore = GetTransparencyStore
        }
    end, { getChatInputBarSettings, getInterpolators })

    return React.createElement(Provider, { value = value }, tbl2.children)
end

return ChatPlatformProvider

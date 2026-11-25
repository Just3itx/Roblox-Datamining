-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local _Signals = require(scriptParentParent.Signals)
local ChatUIPrimitives = require(scriptParentParent.ChatUIPrimitives)
local TextChannelWindowAnalytics = require(script.Parent.TextChannelWindowAnalytics)
local useTranslationToggleAvailable = require(script.Parent.useTranslationToggleAvailable)
local useInExperienceLocalization = require(scriptParentParent.ChatUIPrimitives).Hooks.useInExperienceLocalization

local FFlagTCWTranslationSupport = ChatUIPrimitives.Flags.FFlagTCWTranslationSupport

local MessageLayoutContainer = ChatUIPrimitives.MessageLayoutContainer

return React.memo(function(tbl1) -- name: MessageListArea
    local var1 = Foundation.Hooks.useTokens()
    local var2 = useInExperienceLocalization()
    local isTranslationSettingEnabled = if FFlagTCWTranslationSupport then useTranslationToggleAvailable() else nil

    local onScroll = React.useMemo(function()
        return TextChannelWindowAnalytics.createOnScrollCallback(tbl1.windowName)
    end, { tbl1.windowName })

    local contentPadding = React.useMemo(function()
        return {
            top = UDim.new(0, var1.Size.Size_100),
            bottom = UDim.new(0, var1.Size.Size_100),
            left = UDim.new(0, var1.Size.Size_200),
            right = UDim.new(0, var1.Size.Size_1400)
        }
    end, { var1.Size.Size_100, var1.Size.Size_200, var1.Size.Size_1400 })

    if tbl1.channelState == "no-channel" then
        return React.createElement(
            Foundation.Empty,
            {
                icon = { name = "icons/status/oof_xlarge" },
                text = var2("CoreScripts.TextChat.Error.NoChannelSelected")
            }
        )
    elseif tbl1.channelState == "not-member" then
        return React.createElement(
            Foundation.Empty,
            {
                icon = { name = "icons/status/oof_xlarge" },
                text = var2("CoreScripts.TextChat.Error.NoChannelAccess")
            }
        )
    elseif tbl1.channelState ~= "member" then
        return React.createElement(
            Foundation.Empty,
            {
                icon = { name = "icons/status/oof_xlarge" },
                text = var2("CoreScripts.TextChat.InputBar.Hint.ChatUnavailable")
            }
        )
    end
    return React.createElement(MessageLayoutContainer, {
        messagesSignal = tbl1.messagesSignal,
        layoutStyle = "textLine",
        fontFace = tbl1.fontFace,
        Size = UDim2.fromScale(1, 1),
        contentPadding = contentPadding,
        onScroll = onScroll,
        selectableRows = tbl1.selectableRows,
        selectionCursor = tbl1.selectionCursor,
        isTranslationSettingEnabled = isTranslationSettingEnabled,
        onLatestUsernameChanged = tbl1.onLatestUsernameChanged
    })
end)

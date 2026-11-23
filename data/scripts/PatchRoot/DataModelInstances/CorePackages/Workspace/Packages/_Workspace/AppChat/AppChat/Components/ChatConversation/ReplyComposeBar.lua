-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local BuilderIcons = require(AppChatParent.BuilderIcons)
local ReplyComposeBarText = require(script.Parent.ReplyComposeBarText)
local useFoundationPresence = require(AppChat.Hooks.useFoundationPresence)

local tbl1 = {
    LayoutOrder = 3,
    replyingToUserText = nil,
    replyingToUserContent = nil,
    replyingToUserId = nil,
    onCloseActivated = function() end
}

function ReplyComposeBar(arg1)
    local var1 = Cryo.Dictionary.union(tbl1, arg1)
    local var2 = Foundation.Hooks.useTokens()

    local var3 = useFoundationPresence(var1.replyingToUserId)

    return React.createElement(
        Foundation.View,
        {
            tag = "row size-full-0 auto-y align-y-center gap-medium",
            LayoutOrder = var1.LayoutOrder
        },
        {
            Avatar = if var1.replyingToUserId then React.createElement(Foundation.Avatar, {
                userId = var1.replyingToUserId,
                userPresence = var3.presence,
                backgroundStyle = var2.Color.Surface.Surface_200,
                size = Foundation.Enums.InputSize.Medium,
                includeProfileFrame = FFlagAppChatUseProfileFrameThumbnail,
                LayoutOrder = 1
            })
                or nil else nil,
            Text = React.createElement(
                ReplyComposeBarText,
                {
                    layoutOrder = 2,
                    userText = var1.replyingToUserText,
                    contentText = var1.replyingToUserContent
                }
            ),
            CloseButton = React.createElement(Foundation.IconButton, {
                onActivated = var1.onCloseActivated,
                icon = BuilderIcons.Icon.X,
                variant = Foundation.Enums.ButtonVariant.Utility,
                size = Foundation.Enums.InputSize.Medium,
                isCircular = true,
                LayoutOrder = 3
            })
        }
    )
end

return React.memo(ReplyComposeBar)

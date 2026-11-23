-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local default = require(BuildExperienceParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local escapeRichText = require(BuildExperience.utils.escapeRichText)
local ChatImagePreviewList = require(script.Parent.ChatImagePreviewList)
local ChatResourceAttachmentList = require(script.Parent.ChatResourceAttachmentList)
local useTriggerFeedback = require(BuildExperienceParent.InteractionFeedback).useTriggerFeedback

local Menu = Foundation.Menu
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    affordance = StateLayerAffordance.None
}

local function useEscapedRichText(messageText: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        return escapeRichText(messageText)
    end, { messageText })
end

local function UserMessageBubble(tbl2)
    local var1 = useTokens()
    local var2 = useEscapedRichText(tbl2.messageText)

    return React.createElement(FoundationText, {
        LayoutOrder = tbl2.LayoutOrder,
        cornerRadius = UDim.new(0, var1.Size.Size_500),
        onSecondaryActivated = tbl2.onSecondaryActivated,
        stateLayer = if tbl2.onSecondaryActivated == nil then nil else tbl1,
        Text = var2,
        RichText = true,
        tag = "auto-xy padding-medium text-body-medium text-wrap text-align-x-left bg-shift-200 content-emphasis",
        testId = tbl2.testId
    })
end

local function CopyableUserMessageBubble(tbl2)
    local var1 = useLocalization({ copyText = LocalizationStrings.CHAT_COPY_TEXT })

    local isOpen, var3 = React.useState(false)
    local var4 = useTriggerFeedback()
    local items = {{
        id = "copy-text",
        icon = IconName.TwoStackedSquares,
        text = var1.copyText
    }}

    return React.createElement(Menu, {
        LayoutOrder = tbl2.LayoutOrder,
        align = PopoverAlign.End,
        isOpen = isOpen,
        items = items,
        onActivated = function(arg1)
            if arg1 == "copy-text" then
                default:setClipboardText({ context = "Build-UserMessage", text = tbl2.messageText })
            end

            var3(false)
        end,
        onPressedOutside = function()
            var3(false)
        end,
        side = PopoverSide.Bottom,
        size = InputSize.Medium
    }, {
        Bubble = React.createElement(UserMessageBubble, {
            LayoutOrder = 1,
            messageText = tbl2.messageText,
            onSecondaryActivated = function()
                var4("Default", "SecondaryActivated")
                var3(true)
            end,
            testId = "ChatUserMessage.Bubble"
        })
    })
end

return React.memo(function(tbl2) -- name: ChatUserMessage
    local text = tbl2.message.text
    local attachments = tbl2.message.resourceAttachments or {}
    local bool1 = not (tbl2.message.images == nil) and #tbl2.message.images > 0
    local bool2 = #attachments > 0

    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row gap-small size-full-0 auto-y"
    }
    local tbl4 = {
        Spacer = React.createElement(View, { LayoutOrder = 1, tag = "fill" }),
        Message = React.createElement(
            View,
            {
                LayoutOrder = 2,
                Size = UDim2.new(0.78, 0, 0, 0),
                tag = "col align-x-right gap-xsmall auto-y"
            },
            {
                ResourceAttachments = if bool2 then React.createElement(
                    ChatResourceAttachmentList,
                    {
                        alignRight = true,
                        LayoutOrder = 1,
                        attachments = attachments,
                        testId = "ChatUserMessage.ResourceAttachments"
                    }
                ) else nil,
                Images = if bool1 then React.createElement(ChatImagePreviewList, {
                    alignRight = true,
                    LayoutOrder = if bool2 then 2 else 1,
                    images = tbl2.message.images,
                    testId = "ChatUserMessage.Images"
                }) else nil,
                Bubble = if text == "" then nil else React.createElement(CopyableUserMessageBubble, { LayoutOrder = if bool2 and bool1 then 3 else 2, messageText = text })
            }
        )
    }
    return createElement(var2, tbl3, tbl4)
end)

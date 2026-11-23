-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ChatBubbleContainer = require(script.Parent.Bubble.ChatBubbleContainer)
local React = require(AppChatParent.React)
local GetTextSize = require(AppChatParent.Style).GetTextSize
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle
local Cryo = require(AppChatParent.Cryo)

local useTokens = require(AppChatParent.Foundation).Hooks.useTokens

local FFlagAppChatEnableAutotranslation = require(AppChat.Flags.FFlagAppChatEnableAutotranslation)
local FFlagAppChatBlueSentBubbles = require(AppChat.Flags.FFlagAppChatBlueSentBubbles)

local Foundation = require(AppChatParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local View = Foundation.View
local FoundationText = Foundation.Text
local Divider = Foundation.Divider
local DividerVariant = Foundation.Enums.DividerVariant

local tbl1 = {
    text = "",
    maxWidth = 0,
    innerPadding = 0,
    isIncoming = false,
    hasTail = false,
    LayoutOrder = 0,
    isPending = false,
    isUnfiltered = false,
    isRepliedTo = false,
    isPressed = false,
    isLastMessageInMessageGroup = false
}

tbl1[React.Change.AbsoluteSize] = function() end

function PlainText(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useTokens()
    local var3 = useStyle()
    local maxWidth = var1.maxWidth
    local innerPadding = var1.innerPadding
    local x = math.max(0, maxWidth - innerPadding)
    local body = var3.Font.Body
    local var4 = var1.textSize or var3.Font.BaseSize * body.RelativeSize
    local text = var1.text
    local var5 = var1.font or body.Font
    local isRepliedTo = var1.isRepliedTo
    local vector2 = Vector2.new(x, not isRepliedTo and math.huge or var4 * 3)

    local textSize = GetTextSize(text, var4, var5, vector2, { addTemporaryPadding = false })

    local isRepliedTo2 = var1.isRepliedTo

    local var6 = (var1.isUnfiltered or FFlagAppChatBlueSentBubbles) and not var1.isIncoming
    local textColor3 = if isRepliedTo2 then var3.Theme.TextDefault.Color elseif var6 then Color3.new(1, 1, 1) elseif var1.isIncoming then var2.Color.Content.Emphasis.Color3 else var2.Color.ActionEmphasis.Foreground.Color3

    local sizeConstraint = if FFlagAppChatEnableAutotranslation then React.useMemo(function()
        return {
            MinSize = Vector2.new(0, 0),
            MaxSize = Vector2.new(math.huge, not isRepliedTo and math.huge or var4 * 3)
        }
    end, { isRepliedTo, var1.textSize }) else nil

    local var7 = if FFlagAppChatEnableAutotranslation then React.useMemo(function()
        return {
            MinSize = Vector2.new(0, 0),
            MaxSize = Vector2.new(x or maxWidth, math.huge)
        }
    end, { x, maxWidth }) else nil

    if not (FFlagAppChatEnableAutotranslation and var1.translatedText) then
        local createElement = React.createElement
        local var10 = ChatBubbleContainer
        local tbl3 = {
            isIncoming = var1.isIncoming,
            hasTail = var1.hasTail,
            isPending = var1.isPending,
            isUnfiltered = var1.isUnfiltered,
            padding = {
                top = UDim.new(0, innerPadding),
                bottom = UDim.new(0, innerPadding),
                left = UDim.new(0, innerPadding + 2),
                right = UDim.new(0, innerPadding + 2)
            },
            LayoutOrder = var1.LayoutOrder,
            isRepliedTo = var1.isRepliedTo,
            isPressed = var1.isPressed,
            [React.Change.AbsoluteSize] = var1[React.Change.AbsoluteSize],
            isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
            bubbleRef = var1.bubbleRef
        }
        local tbl4 = {
            textContent = React.createElement("TextLabel", {
                Text = text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                TextColor3 = textColor3,
                AutomaticSize = Enum.AutomaticSize.XY,
                FontFace = normalizeFontFace(var5),
                TextSize = var4,
                Size = UDim2.fromOffset(math.ceil(textSize.X), math.ceil(textSize.Y)),
                TextTransparency = var1.isPending and var3.Theme.TextMuted.Transparency or 0,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextTruncate = if isRepliedTo then Enum.TextTruncate.AtEnd else nil,
                TextWrapped = true
            }, {
                SizeConstraint = React.createElement(
                    "UISizeConstraint",
                    {
                        MaxSize = Vector2.new(x or maxWidth, not isRepliedTo and math.huge or var4 * 3)
                    }
                )
            })
        }
        return createElement(var10, tbl3, tbl4)
    end

    local tbl3 = {
        TextColor3 = textColor3,
        FontFace = normalizeFontFace(var5),
        TextSize = var4,
        TextTransparency = var1.isPending and var3.Theme.TextMuted.Transparency or 0,
        sizeConstraint = sizeConstraint
    }
    return React.createElement(ChatBubbleContainer, {
        isIncoming = var1.isIncoming,
        hasTail = var1.hasTail,
        isPending = var1.isPending,
        isUnfiltered = var1.isUnfiltered,
        padding = {
            top = UDim.new(0, innerPadding),
            bottom = UDim.new(0, innerPadding),
            left = UDim.new(0, innerPadding + 2),
            right = UDim.new(0, innerPadding + 2)
        },
        LayoutOrder = var1.LayoutOrder,
        isRepliedTo = var1.isRepliedTo,
        isPressed = var1.isPressed,
        [React.Change.AbsoluteSize] = var1[React.Change.AbsoluteSize],
        isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
        bubbleRef = var1.bubbleRef
    }, {
        Wrapper = React.createElement(View, {
            tag = "auto-xy col gap-xsmall",
            sizeConstraint = var7
        }, {
            textContent = React.createElement(
                FoundationText,
                Cryo.Dictionary.union(tbl3, {
                    Text = text,
                    LayoutOrder = 1,
                    tag = {
                        ["text-align-x-left text-align-y-top auto-xy text-wrap content-muted text-body-small"] = true,
                        ["text-truncate-end"] = isRepliedTo,
                        ["text-truncate-none"] = not isRepliedTo
                    }
                })
            ),
            Divider = React.createElement(
                View,
                { tag = "size-0 self-stretch auto-y", LayoutOrder = 2 },
                React.createElement(Divider, { variant = DividerVariant.Default })
            ),
            translatedTextContent = React.createElement(
                FoundationText,
                Cryo.Dictionary.union(tbl3, {
                    Text = var1.translatedText,
                    LayoutOrder = 3,
                    tag = {
                        ["text-align-x-left text-align-y-top auto-xy text-wrap"] = true,
                        ["text-truncate-none"] = not isRepliedTo,
                        ["text-truncate-end"] = isRepliedTo
                    }
                })
            )
        })
    })
end

return PlainText

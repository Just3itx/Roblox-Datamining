-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local UIBlox = require(AppChatParent.UIBlox)
local ColorSystem = UIBlox.Common.Style.ColorSystem
local Cryo = require(AppChatParent.Cryo)
local ChatBubbleEnum = require(script.Parent.ChatBubbleEnum)
local ChatBubbleGroupable = require(script.Parent.ChatBubbleGroupable)

local useStyle = UIBlox.Core.Style.useStyle
local useSelectedTheme = require(AppChatParent.RoactUtils).Hooks.useSelectedTheme
local RepliedToMarker = require(script.Parent.RepliedToMarker)

local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local ColorMode = Foundation.Enums.ColorMode

local unfilteredMessageColorConfig = require(AppChat.Flags.unfilteredMessageColorConfig)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatBlueSentBubbles = require(AppChat.Flags.FFlagAppChatBlueSentBubbles)
local FFlagAppChatBubbleThemeTokens = require(AppChat.Flags.FFlagAppChatBubbleThemeTokens)

local BUBBLE_VARIANTS = ChatBubbleEnum.BUBBLE_VARIANTS

local tbl1 = {
    isIncoming = false,
    hasTail = false,
    padding = 12,
    LayoutOrder = 0,
    isPending = false,
    isUnfiltered = false,
    isAssetCard = false,
    isRepliedTo = false,
    isPressed = false,
    isLastMessageInMessageGroup = false
}

tbl1[React.Change.AbsoluteSize] = function(_) end

return React.memo(function(tbl2) -- name: ChatBubbleContainer
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTokens()

    local selectionImageObject = useCursor(
        FFlagAppChatConsoleFocusFixes and {
            radius = UDim.new(0, var2.Size.Size_500)
        }
            or Foundation.Enums.CursorType.RoundedSlot
    )
    local var4 = useStyle()
    local children = var1.children or {}
    local isIncoming = var1.isIncoming
    local isPending = var1.isPending
    local isUnfiltered = var1.isUnfiltered

    local var6 = useSelectedTheme()

    local var7, var8 = React.useState(var4.Theme.UIDefault)

    local function setBubbleStyle()
        local tbl3

        if var1.isRepliedTo and FFlagAppChatBubbleThemeTokens then
            tbl3 = {
                Color = var2.Color.Shift.Shift_200.Color3,
                Transparency = var2.Color.Shift.Shift_200.Transparency
            }
        elseif var1.isRepliedTo then
            tbl3 = {
                Color = if var6 == string.lower(ColorMode.Light) then ColorSystem.Gray[30] else ColorSystem.Gray[90],
                Transparency = 0
            }
        else
            tbl3 = var1.isAssetCard
                and {
                    Color = var2.Color.Shift.Shift_400.Color3,
                    Transparency = var2.Color.Shift.Shift_400.Transparency
                }
                or isIncoming and {
                    Color = var2.Color.Shift.Shift_400.Color3,
                    Transparency = var2.Color.Shift.Shift_400.Transparency
                }
                or (isUnfiltered or FFlagAppChatBlueSentBubbles)
                    and {
                        Color = var2.Color.System.Emphasis.Color3,
                        Transparency = var2.Color.System.Emphasis.Transparency
                    }
                or {
                    Color = var2.Color.Extended.Gray.Gray_600.Color3,
                    Transparency = var2.Color.Extended.Gray.Gray_600.Transparency
                }
        end

        var8(tbl3)
    end

    local function setPressedBubbleStyle()
        if var1.isRepliedTo or var1.isPending then
            return
        end

        if FFlagAppChatBubbleThemeTokens then
            local tbl3

            if isIncoming or var1.isAssetCard then
                local press = var2.Color.State.Press
                tbl3 = {
                    Color = press.Color3,
                    Transparency = press.Transparency
                }
            else
                tbl3 = (isUnfiltered or FFlagAppChatBlueSentBubbles)
                    and {
                        Color = var2.Color.Extended.Blue.Blue_1000.Color3,
                        Transparency = var2.Color.Extended.Blue.Blue_1000.Transparency
                    }
                    or {
                        Color = var2.Color.Extended.Gray.Gray_700.Color3,
                        Transparency = var2.Color.Extended.Gray.Gray_700.Transparency
                    }
            end

            var8(tbl3)
            return
        end

        local tbl3

        if isIncoming then
            tbl3 = {
                Color = if var6 == string.lower(ColorMode.Light) then ColorSystem.Gray[50] else ColorSystem.Gray[70],
                Transparency = 0.35
            }
        elseif (isUnfiltered or FFlagAppChatBlueSentBubbles) and not var1.isAssetCard then
            tbl3 = {
                Color = if var6 == ColorMode.Light then unfilteredMessageColorConfig.UnfilteredMessagePressedLightColor3 else unfilteredMessageColorConfig.UnfilteredMessagePressedDarkColor3,
                Transparency = unfilteredMessageColorConfig.UnfilteredMessageTransparency
            }
        else
            tbl3 = {
                Color = if var6 == string.lower(ColorMode.Light) then ColorSystem.Gray[50] else ColorSystem.Gray[70],
                Transparency = 0.4
            }
        end

        var8(tbl3)
    end

    React.useLayoutEffect(function()
        if var1.isPressed then
            setPressedBubbleStyle()
            return
        end
        setBubbleStyle()
    end, {
        var1.isPressed,
        var1.isRepliedTo,
        var6,
        isIncoming,
        isPending,
        isUnfiltered,
        var1.isAssetCard
    })

    local function getBubbleVariant(arg1, arg2, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg1 and arg2 or bool1 then
            return BUBBLE_VARIANTS.SINGLE
        end

        if arg1 then
            return BUBBLE_VARIANTS.TOP
        end

        if arg2 then
            return BUBBLE_VARIANTS.BOTTOM
        end

        return BUBBLE_VARIANTS.MIDDLE
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = "size-0-0 auto-xy",
        LayoutOrder = var1.LayoutOrder,
        BackgroundTransparency = 1,
        selection = {
            Selectable = not (FFlagAppChatConsoleFocusFixes and var1.isRepliedTo),
            SelectionImageObject = selectionImageObject
        },
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = isIncoming and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, ChatBubbleEnum.REPLIED_TO_MARKER_GAP)
        },
        ref = if FFlagAppChatConsoleFocusFixes then var1.bubbleRef else nil
    }
    local tbl4 = { bubble = 0, repliedToMarker = 0 }
    local createElement2 = React.createElement
    local var9 = ChatBubbleGroupable
    local tbl5 = {
        alignment = isIncoming and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right,
        children = children,
        imageStyle = {
            Color3 = var7.Color,
            Transparency = var7.Transparency
        },
        layoutOrder = 1,
        padding = var1.padding,
        variant = 0
    }
    local hasTail = var1.hasTail
    local isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup
    local isRepliedTo = var1.isRepliedTo
    tbl5.variant = if hasTail and isLastMessageInMessageGroup or isRepliedTo then getBubbleVariant(nil, nil, true) elseif hasTail then BUBBLE_VARIANTS.TOP elseif isLastMessageInMessageGroup then BUBBLE_VARIANTS.BOTTOM else BUBBLE_VARIANTS.MIDDLE
    tbl4.bubble = createElement2(var9, tbl5)

    tbl4.repliedToMarker = if var1.isRepliedTo then React.createElement(RepliedToMarker, { isIncoming = isIncoming, layoutOrder = if var1.isIncoming then 0 else 2 }) else nil
    return createElement(view, tbl3, tbl4)
end)

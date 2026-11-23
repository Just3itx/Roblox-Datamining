-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local GetTextSize = require(AppChatParent.Style).GetTextSize
local Enums = Foundation.Enums

local useMessageFtuxTooltip = require(script.Parent.useMessageFtuxTooltip)
local MessageFtuxTooltipVariant = require(script.Parent.MessageFtuxTooltipVariant)

local tbl1 = {
    variant = MessageFtuxTooltipVariant.None,
    isReversed = false
}

local function func1(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = Foundation.Hooks.useTokens()
    local var3 = useMessageFtuxTooltip(var1.variant)
    local var4, var5 = React.useState(false)
    local isOpen, var7 = React.useState(false)

    React.useEffect(function()
        local titleSmall = var2.Typography.TitleSmall
        local var8 = GetTextSize(var3.text, titleSmall.FontSize, titleSmall.Font, Vector2.new(10000, 10000)).X + var2.Padding.Small * 2
        var5(if var1.messageRef.current then var1.messageRef.current.AbsoluteSize.X < var8 else false)

        var7(true)
    end, { var3.text, var2, var1.messageRef })

    local position, offset = React.useMemo(function()
        local var8 = if var4 then if var1.isReversed then Enums.PopoverAlign.Start else Enums.PopoverAlign.End elseif var1.isReversed then Enums.PopoverAlign.End else Enums.PopoverAlign.Start

        if var4 then
            return var8, 0
        elseif var1.isReversed then
            return var8, var2.Padding.Medium
        end

        return var8, -var2.Padding.Medium
    end, { var4, var1.isReversed, var2 })

    if var3.isDismissed then
        return nil
    end

    return (React.createElement(Foundation.Popover.Root, { isOpen = isOpen }, {
        Anchor = React.createElement(Foundation.Popover.Anchor, { anchorRef = var1.messageRef }),
        Content = React.createElement(Foundation.Popover.Content, {
            side = {
                position = Foundation.Enums.PopoverSide.Bottom,
                offset = -var2.Padding.Small
            },
            align = { position = position, offset = offset },
            hasArrow = true,
            radius = Foundation.Enums.Radius.Small,
            backgroundStyle = var2.Color.Content.Emphasis,
            onPressedOutside = var3.handleDismiss
        }, {
            TooltipText = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy padding-x-small padding-y-xsmall text-title-small content-inverse-emphasis",
                    Text = var3.text
                }
            )
        })
    }))
end

return React.memo(function(tbl2)
    if (tbl2.variant or tbl1.variant) == MessageFtuxTooltipVariant.None then
        return nil
    end

    return (React.createElement(func1, tbl2))
end)

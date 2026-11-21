-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent

local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local Radius = Foundation.Enums.Radius

local tbl1 = {
    Top = UDim2.fromScale(0.5, 0),
    Bottom = UDim2.fromScale(0.5, 1),
    Left = UDim2.fromScale(0, 0.5),
    Right = UDim2.fromScale(1, 0.5)
}

return function(tbl2)
    local var1 = useTokens()

    local createElement = React.createElement
    local root = Popover.Root
    local tbl3 = {
        isOpen = tbl2.isOpen
    }
    local tbl4 = {
        AXTooltipAnchor = React.createElement(Popover.Anchor, { Position = tbl1[tbl2.popoverSide] }),
        AXTooltipContent = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl5 = {
        align = PopoverAlign.Center,
        side = tbl2.popoverSide,
        backgroundStyle = var1.Color.System.Contrast,
        radius = Radius.Medium
    }
    local tbl6 = { AXTooltipTextFrame = 0, AXTooltipOverlayButton = 0 }
    local createElement3 = React.createElement
    local view = Foundation.View
    local tbl7 = { tag = "col gap-xsmall padding-y-small padding-x-medium auto-xy" }

    local tbl8 = {
        AXTooltipTitle = React.createElement(Foundation.Text, {
            Text = tbl2.tooltipText,
            Size = if tbl2.maxWidth then UDim2.new(0, tbl2.maxWidth, 0, 0) else nil,
            tag = if tbl2.maxWidth then "auto-y text-title-medium content-inverse-emphasis" else "auto-xy text-title-medium content-inverse-emphasis",
            TextWrapped = if tbl2.maxWidth then true else nil
        })
    }
    tbl6.AXTooltipTextFrame = createElement3(view, tbl7, tbl8)

    tbl6.AXTooltipOverlayButton = React.createElement(
        "TextButton",
        {
            Transparency = 1,
            [React.Event.Activated] = tbl2.onTooltipActivated,
            Size = UDim2.fromScale(1, 1)
        }
    )
    tbl4.AXTooltipContent = createElement2(content, tbl5, tbl6)
    return createElement(root, tbl3, tbl4)
end

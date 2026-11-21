-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local Popover = Foundation.Popover
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local CompactTooltipContent = require(script.Parent.CompactTooltipContent)
local FFlagMeProfileEntryTooltipEnabled = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagMeProfileEntryTooltipEnabled

local function Tooltip(arg1)
    local var1 = useTokens()
    local var2 = FFlagMeProfileEntryTooltipEnabled and arg1.compact == true
    local position = arg1.side or PopoverSide.Right
    local var4

    if FFlagMeProfileEntryTooltipEnabled then
        var4 = React.useMemo(function()
            return {
                position = position,
                offset = var1.Size.Size_150
            }
        end, { position, var1.Size.Size_150 })
        React.useEffect(function()
            if arg1.open and arg1.onShown then
                arg1.onShown()
            end
        end, { arg1.open, arg1.onShown })
    else
        var4 = nil
    end

    local createElement = React.createElement
    local root = Popover.Root
    local tbl1 = {
        isOpen = arg1.open or false
    }
    local tbl2 = {
        Anchor = React.createElement(Popover.Anchor, {
            LayoutOrder = if FFlagMeProfileEntryTooltipEnabled then arg1.LayoutOrder else nil,
            Visible = if FFlagMeProfileEntryTooltipEnabled then arg1.Visible else nil
        }, arg1.children),
        Content = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl3 = { align = 0, side = 0, backgroundStyle = 0, radius = 0, selectionGroup = 0 }
    local align = arg1.align

    if not align then
        if var2 then
            align = PopoverAlign.Start
        else
            align = PopoverAlign.Center
        end
    end

    tbl3.align = align
    if not var2 then
        var4 = position
    end

    tbl3.side = var4
    tbl3.backgroundStyle = if var2 then var1.Inverse.Surface.Surface_0 else var1.Color.OverMedia.OverMedia_0

    local radius = arg1.radius

    if not radius then
        if var2 then
            radius = Radius.Medium
        else
            radius = Radius.Small
        end
    end

    tbl3.radius = radius
    tbl3.selectionGroup = not var2 and nil
    local element

    if var2 then
        element = React.createElement(CompactTooltipContent, { bodyText = arg1.bodyText, onDismiss = arg1.onDismiss })
    else
        element = React.createElement(Foundation.View, {
            tag = "col gap-small auto-xy padding-medium"
        }, {
            Title = if arg1.titleText then React.createElement(Foundation.Text, { Text = arg1.titleText, tag = "auto-xy text-title-medium content-emphasis" }) else nil,
            Subtitle = if arg1.bodyText then React.createElement(Foundation.Text, { Text = arg1.bodyText, tag = "auto-xy text-body-small" }) else nil
        })
    end

    tbl2.Content = createElement2(content, tbl3, element)
    return createElement(root, tbl1, tbl2)
end

return Tooltip

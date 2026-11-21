-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)

local _DescriptionWithChipsTypes = require(script.Parent.DescriptionWithChipsTypes)
local DescriptionTextBlock = require(script.Parent.DescriptionTextBlock)
local DescriptionCollapseFrame = require(script.Parent.DescriptionCollapseFrame)

local View = Foundation.View
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Skeleton = Foundation.Skeleton
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local numberSequence = NumberSequence.new(1, 0)
local stateLayer = {
    affordance = StateLayerAffordance.None
}
local vector2 = Vector2.new(0.5, 0.5)
local uDim2 = UDim2.fromScale(0.5, 0.5)

return React.forwardRef(function(tbl2, ref) -- name: DescriptionWithChipsView
    local paddingTop = tbl2.paddingTop
    local padding = React.useMemo(function()
        return {
            top = UDim.new(0, paddingTop)
        }
    end, { paddingTop })

    local canExpand = tbl2.canExpand

    local fadeColor = tbl2.fadeColor
    local backgroundStyle = React.useMemo(function()
        return { Color3 = fadeColor, Transparency = 0 }
    end, { fadeColor })

    local onContentHeightChanged = tbl2.onContentHeightChanged
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        onContentHeightChanged(arg1.AbsoluteSize.Y)
    end, { onContentHeightChanged })

    local blocks = tbl2.blocks
    local renderLink = tbl2.renderLink
    local var4 = React.useMemo(function()
        local result = ({})
        for layoutOrder, block in blocks do
            if block.kind == "link" then
                local var4 = "Link" .. layoutOrder
                local createElement = React.createElement
                local var5 = View

                local tbl3 = {
                    Chip = renderLink(block.url, layoutOrder)
                }
                result[var4] = createElement(var5, { tag = "auto-xy", LayoutOrder = layoutOrder }, tbl3)
            else
                local var4 = "Text" .. layoutOrder
                result[var4] = React.createElement(DescriptionTextBlock, { text = block.text, LayoutOrder = layoutOrder })
            end
        end

        return result
    end, { blocks, renderLink })

    if tbl2.isLoading then
        return React.createElement(
            View,
            {
                tag = "size-full-0 auto-y",
                padding = padding,
                LayoutOrder = tbl2.LayoutOrder,
                ref = ref,
                testId = "--item-description-loading"
            },
            {
                Shimmer = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, tbl2.visibleHeight + tbl2.paddingBottom) })
            }
        )
    end

    local var5 = canExpand and not tbl2.isExpanded
    local name = if tbl2.isExpanded then IconName.ChevronLargeUp else IconName.ChevronLargeDown
    local createElement = React.createElement
    local var7 = View
    local tbl3 = {
        tag = "col gap-small size-full-0 auto-y",
        padding = padding,
        LayoutOrder = tbl2.LayoutOrder,
        ref = if canExpand then nil else ref,
        testId = "--item-description"
    }
    local tbl4 = {
        Expandable = React.createElement(DescriptionCollapseFrame, {
            height = tbl2.visibleHeight + tbl2.paddingBottom,
            isExpanded = tbl2.isExpanded,
            LayoutOrder = 1,
            testId = "--item-description-content"
        }, {
            Content = React.createElement(
                View,
                {
                    tag = "col gap-small size-full-0 auto-y",
                    onAbsoluteSizeChanged = onAbsoluteSizeChanged
                },
                var4
            ),
            Fade = if var5 then React.createElement(
                View,
                {
                    tag = "position-bottom-left anchor-bottom-left size-full-800",
                    backgroundStyle = backgroundStyle,
                    ZIndex = 2,
                    testId = "--item-description-fade"
                },
                {
                    Gradient = React.createElement("UIGradient", { Rotation = 90, Transparency = numberSequence })
                }
            ) else nil
        }),
        Chevron = 0
    }
    local element

    if canExpand then
        element = React.createElement(View, {
            tag = "size-full-900",
            LayoutOrder = 2,
            onActivated = tbl2.onToggleExpanded,
            stateLayer = stateLayer,
            ref = ref,
            testId = "--item-description-expand"
        }, {
            Arrow = React.createElement(Icon, {
                AnchorPoint = vector2,
                Position = uDim2,
                name = name,
                size = IconSize.Large,
                style = tbl2.chevronStyle,
                testId = "--item-description-expand-icon"
            })
        })
    else
        element = nil
    end

    tbl4.Chevron = element
    return createElement(var7, tbl3, tbl4)
end)

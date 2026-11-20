-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local AvatarIcon = require(Foundation.Components.AvatarIcon)
local AvatarIconSize = require(Foundation.Enums.AvatarIconSize)
local Icon = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local StatusIndicator = require(Foundation.Components.StatusIndicator)
local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)
local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: NavigationBarTab
    local var1 = useTokens()
    local item = tbl1.item

    local element = nil
    if typeof(item.icon) == "table" and item.icon.type == "Avatar" then
        element = React.createElement(View, {
            tag = {
                ["auto-xy radius-circle"] = true,
                ["stroke-thick stroke-system-contrast"] = tbl1.isActive,
                ["stroke-standard stroke-emphasis"] = not tbl1.isActive
            },
            testId = `{tbl1.testId}--avatar-ring`
        }, {
            Avatar = React.createElement(
                AvatarIcon,
                {
                    userId = item.icon.userId,
                    size = AvatarIconSize.Large,
                    testId = `{tbl1.testId}--avatar`
                }
            )
        })
    elseif typeof(item.icon) == "string" then
        element = React.createElement(Icon, {
            name = item.icon,
            variant = if tbl1.isActive then BuilderIcons.IconVariant.Filled else BuilderIcons.IconVariant.Regular,
            size = IconSize.Large,
            style = var1.Color.Content.Emphasis,
            testId = `{tbl1.testId}--icon`
        })
    end

    local createElement = React.createElement
    local var2 = View

    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "fill auto-y",
        onActivated = function()
            tbl1.onActivated(item.id)
        end,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        ref = ref,
        testId = tbl1.testId
    }

    local tbl3 = { Content = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        tag = "col align-x-center gap-xxsmall size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var1.Padding.XXSmall + var1.Padding.Small),
            bottom = UDim.new(0, var1.Padding.XXSmall + var1.Padding.Small)
        },
        testId = `{tbl1.testId}--content`
    }
    local tbl5 = { Media = 0, Label = 0 }
    local createElement3 = React.createElement
    local var4 = View
    local tbl6 = { LayoutOrder = 1, tag = "size-600" }

    local tbl7 = { Icon = element, Status = 0 }
    local element2

    if item.indicator then
        element2 = React.createElement(
            StatusIndicator,
            item.indicator.value == nil
                and {
                    variant = StatusIndicatorVariant.Emphasis,
                    size = StatusIndicatorSize.Small,
                    mask = var1.Color.Common.NavigationBar,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(1, -var1.Size.Size_50, 0, var1.Size.Size_50),
                    ZIndex = 2,
                    testId = `{tbl1.testId}--status`
                }
                or {
                    value = item.indicator.value,
                    max = item.indicator.max or 99,
                    variant = StatusIndicatorVariant.Emphasis,
                    size = StatusIndicatorSize.Small,
                    mask = var1.Color.Common.NavigationBar,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(1, -var1.Size.Size_150, 0, var1.Size.Size_50),
                    ZIndex = 2,
                    testId = `{tbl1.testId}--status`
                }
        )
    else
        element2 = nil
    end

    tbl7.Status = element2
    tbl5.Media = createElement3(var4, tbl6, tbl7)

    tbl5.Label = React.createElement(Text, {
        LayoutOrder = 2,
        Text = item.text,
        tag = "size-full-0 auto-y text-caption-small text-align-x-center text-truncate-end content-emphasis",
        testId = `{tbl1.testId}--label`
    })
    tbl3.Content = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end))

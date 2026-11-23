-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local Image = Foundation.Image
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useLocalization = require(AvatarWorkshopParent.Localization).Hooks.useLocalization

local str1 = utf8.char(57344)

local function ItemCard(tbl1)
    local var1 = useLocalization({ detailsText = "Feature.Avatar.Label.DetailsButton" })
    local var2 = if tbl1.username and tbl1.hasVerifiedBadge then `{tbl1.username}{str1}` else tbl1.username
    local aspectRatio = if tbl1.vertical then 0.8 else 1

    local bool1 = tbl1.title ~= nil or var2 ~= nil or tbl1.price ~= nil

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Card = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "col gap-small size-full-0 auto-y",
        onActivated = tbl1.onActivated,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl5 = { Thumbnail = 0, Content = 0 }
    local createElement3 = React.createElement
    local var3 = Image
    local tbl6 = {
        tag = {
            ["size-full radius-medium clip bg-shift-200"] = true,
            ["stroke-system-contrast"] = tbl1.isSelected
        },
        aspectRatio = {
            AspectRatio = aspectRatio,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width
        },
        ScaleType = Enum.ScaleType.Crop,
        LayoutOrder = 1,
        Image = tbl1.image
    }
    local tbl7 = { DetailsOverlay = 0 }
    local element

    if tbl1.showDetails then
        element = React.createElement(Foundation.View, { tag = "size-full padding-xxsmall" }, {
            DetailsButton = React.createElement(Foundation.Button, {
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.fromScale(0.5, 1),
                fillBehavior = FillBehavior.Fill,
                size = InputSize.XSmall,
                text = var1.detailsText,
                variant = ButtonVariant.OverMedia,
                onActivated = tbl1.onDetailsActivated or function() end
            })
        })
    else
        element = nil
    end

    tbl7.DetailsOverlay = element
    tbl5.Thumbnail = createElement3(var3, tbl6, tbl7)
    local var4

    if bool1 then
        local createElement4 = React.createElement
        local view3 = Foundation.View
        local tbl8 = { tag = "col gap-xsmall size-full-0 auto-y", LayoutOrder = 2 }

        local tbl9 = {
            Title = if tbl1.title == nil then nil else React.createElement(Foundation.Text, {
                tag = "size-full-0 auto-y text-title-small text-align-x-left text-truncate-end content-emphasis",
                Text = tbl1.title,
                LayoutOrder = 1
            }),
            Username = if var2 == nil then nil else React.createElement(
                Foundation.Text,
                {
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end",
                    Text = var2,
                    LayoutOrder = 2
                }
            ),
            Price = 0
        }
        local var5

        if tbl1.price == nil then
            var5 = nil
        else
            local createElement5 = React.createElement
            local view4 = Foundation.View

            local tbl10 = {
                Icon = React.createElement(
                    Foundation.Icon,
                    {
                        tag = "content-emphasis",
                        name = "robux",
                        size = IconSize.Small,
                        LayoutOrder = 1
                    }
                ),
                Amount = React.createElement(Foundation.Text, {
                    tag = "auto-xy padding-x-xsmall text-body-medium text-align-x-left content-emphasis",
                    Text = tostring(tbl1.price),
                    LayoutOrder = 2
                })
            }
            var5 = createElement5(view4, { tag = "row align-y-center gap-xxsmall size-full-0 auto-y", LayoutOrder = 3 }, tbl10)
        end

        tbl9.Price = var5
        var4 = createElement4(view3, tbl8, tbl9)
    else
        var4 = nil
    end

    tbl5.Content = var4
    tbl3.Card = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return ItemCard

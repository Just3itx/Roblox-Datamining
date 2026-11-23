-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local ItemsViewHeader = require(AvatarExperienceInspectAndBuy.Components.ItemsView.ItemsViewHeader)
local AvatarItemsView = require(AvatarExperienceInspectAndBuy.Components.ItemsView.AvatarItemsView)
local BuyActionBarLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.BuyActionBarLayout)
local _SubheaderLabelPrice = require(AvatarExperienceInspectAndBuy.Components.Common.SubheaderLabelPrice)

local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)

local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local useTokens = Foundation.Hooks.useTokens

local function func1(view, arg1)
    if view == ViewType.Compact then
        return {
            left = UDim.new(0, arg1.Padding.Medium),
            right = UDim.new(0, arg1.Padding.Medium)
        }
    end

    if view == ViewType.Wide then
        return {
            top = UDim.new(0, arg1.Padding.XLarge),
            left = UDim.new(0, arg1.Margin.Large * 2),
            right = UDim.new(0, arg1.Margin.Large * 2),
            bottom = UDim.new(0, arg1.Padding.XLarge)
        }
    end

    if view ~= ViewType.WideLandscape then
        return nil
    end

    return {
        left = UDim.new(0, arg1.Padding.Small),
        right = UDim.new(0, arg1.Padding.Medium),
        top = UDim.new(0, arg1.Padding.XSmall)
    }
end

return (React.forwardRef(function(tbl1, ref)
    local view = tbl1.view
    local var1 = useTokens()
    local items = tbl1.items
    local onInspectMenuClosed = tbl1.onInspectMenuClosed

    local bool1 = tbl1.view == ViewType.Compact

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        Header = React.createElement(ItemsViewHeader, {
            view = view,
            headerHeight = var1.Size.Size_1300,
            padding = func1(view, var1),
            headerText = tbl1.headerText,
            subheaderText = tbl1.subheaderText,
            onBackButtonClick = function()
                onInspectMenuClosed()
            end,
            purchaseButtonProps = tbl1.buyActionBarProps.purchaseButtonProps
        }),
        List = React.createElement(AvatarItemsView, {
            items = items,
            view = view,
            headerHeightOffset = var1.Size.Size_1300,
            actionBarHeightOffset = var1.Size.Size_2700,
            onItemCardActivated = tbl1.onItemCardActivated,
            ref = ref
        }),
        BuyActionBarLayout = 0
    }

    local element

    if bool1 then
        element = React.createElement(BuyActionBarLayout, {
            buyActionBarProps = tbl1.buyActionBarProps,
            enableTopBorder = true,
            ZIndex = 2,
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            padding = UDim.new(0, var1.Padding.Medium),
            Size = UDim2.new(1, 0, 0, var1.Size.Size_2700)
        })
    else
        element = nil
    end

    tbl3.BuyActionBarLayout = element
    return createElement(str1, tbl2, tbl3)
end))

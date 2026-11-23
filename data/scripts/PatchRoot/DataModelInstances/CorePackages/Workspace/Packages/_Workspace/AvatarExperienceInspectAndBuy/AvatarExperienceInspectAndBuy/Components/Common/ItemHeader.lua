-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local BackButton = require(AvatarExperienceInspectAndBuy.Components.Common.BackButton)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)

local _Types = require(AvatarExperienceInspectAndBuy.Types)

local function ItemHeader(tbl1)
    local var1 = useTokens()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-xy size-full-0",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        UIPadding = if tbl1.padding then React.createElement("UIPadding", {
            PaddingLeft = tbl1.padding.left,
            PaddingRight = tbl1.padding.right,
            PaddingTop = tbl1.padding.top,
            PaddingBottom = tbl1.padding.bottom
        }) else nil,
        UIListLayout = if tbl1.purchaseButtonProps then React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
        }) else nil,
        InnerFrame = 0,
        BuyButton = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "auto-xy col align-y-center",
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl5 = {
        BackButton = if tbl1.onBackButtonClick then React.createElement(BackButton, { onBackButtonClick = tbl1.onBackButtonClick, LayoutOrder = 1 }) else nil,
        HeaderAndSubheader = React.createElement(Foundation.View, {
            tag = "auto-xy col",
            LayoutOrder = 2
        }, {
            UIPadding = if tbl1.onBackButtonClick then React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.Padding.Large) }) else nil,
            Header = if tbl1.header then tbl1.header else nil,
            Subheader = if tbl1.subheader then tbl1.subheader else nil
        })
    }
    tbl3.InnerFrame = createElement2(view2, tbl4, tbl5)
    local element

    if tbl1.purchaseButtonProps then
        element = React.createElement(Foundation.Button, {
            size = Foundation.Enums.InputSize.Medium,
            width = UDim.new(0, var1.Size.Size_3000),
            text = tbl1.purchaseButtonProps.purchaseButtonText,
            variant = tbl1.purchaseButtonProps.variant,
            isDisabled = tbl1.purchaseButtonProps.isDisabled,
            onActivated = tbl1.purchaseButtonProps.onPurchase,
            LayoutOrder = 2
        })
    else
        element = nil
    end

    tbl3.BuyButton = element
    return createElement(view, tbl2, tbl3)
end

return ItemHeader

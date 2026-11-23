-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local BackButton = require(AvatarExperienceInspectAndBuy.Components.Common.BackButton)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)
local SubheaderLabelPrice = require(AvatarExperienceInspectAndBuy.Components.Common.SubheaderLabelPrice)
local _Types = require(AvatarExperienceInspectAndBuy.Types)

local function ItemsViewHeader(tbl1)
    local var1 = useTokens()
    local bool1 = tbl1.view == ViewType.WideLandscape
    local bool2 = tbl1.view == ViewType.Compact

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, tbl1.headerHeight)
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, if bool1 or bool2 then var1.Padding.Medium else var1.Margin.Large * 2),
            HorizontalFlex = if bool1 then nil else Enum.UIFlexAlignment.SpaceBetween
        }),
        UIPadding = if tbl1.padding then React.createElement("UIPadding", {
            PaddingLeft = tbl1.padding.left,
            PaddingRight = tbl1.padding.right,
            PaddingTop = tbl1.padding.top,
            PaddingBottom = tbl1.padding.bottom
        }) else nil,
        BackButton = if bool1 then React.createElement(
            BackButton,
            {
                onBackButtonClick = tbl1.onBackButtonClick,
                Position = UDim2.new(0, var1.Padding.Small, 0, var1.Padding.Small)
            }
        ) else nil,
        HeaderTextAndSubheader = React.createElement(
            Foundation.View,
            {
                BackgroundTransparency = 1,
                tag = "size-0-full auto-x col align-y-center",
                LayoutOrder = 2
            },
            {
                HeaderText = React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 1,
                        tag = "auto-xy text-heading-small content-emphasis text-truncate-end",
                        Text = tbl1.headerText
                    }
                ),
                SubheaderText = if tbl1.subheaderText and not (bool1 or bool2) then React.createElement(SubheaderLabelPrice, { subheaderText = tbl1.subheaderText, LayoutOrder = 2 }) else nil
            }
        ),
        BuyButton = 0
    }
    local element

    if bool1 or bool2 then
        element = nil
    else
        element = React.createElement(Foundation.Button, {
            size = Foundation.Enums.InputSize.Medium,
            width = if bool2 then UDim.new(0, var1.Size.Size_2100) else UDim.new(0, var1.Size.Size_3000),
            LayoutOrder = 3,
            text = tbl1.purchaseButtonProps.purchaseButtonText,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            isDisabled = tbl1.purchaseButtonProps.isDisabled,
            onActivated = tbl1.purchaseButtonProps.onPurchase
        })
    end

    tbl3.BuyButton = element
    return createElement(view, tbl2, tbl3)
end

return ItemsViewHeader

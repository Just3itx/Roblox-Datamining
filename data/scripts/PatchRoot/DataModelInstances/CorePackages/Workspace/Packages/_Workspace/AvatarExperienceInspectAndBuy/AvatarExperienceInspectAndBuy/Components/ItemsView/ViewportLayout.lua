-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local BackButton = require(AvatarExperienceInspectAndBuy.Components.Common.BackButton)
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local BuyActionBarLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.BuyActionBarLayout)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local getTryOnBackgroundImage = require(AvatarExperienceInspectAndBuy.Utils.getTryOnBackgroundImage)

local FFlagAXInspectAndBuyAvatarBackground = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXInspectAndBuyAvatarBackground

local function ViewportLayout(tbl1)
    local bool1 = tbl1.view == ViewType.WideLandscape
    local onBackButtonClick = tbl1.backButtonProps and tbl1.backButtonProps.onBackButtonClick
    local var1 = useTokens()
    local backgroundImageUrl = if FFlagAXInspectAndBuyAvatarBackground then tbl1.backgroundImageUrl else nil
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        BackgroundTransparency = 1
    }
    local tbl3 = {
        BackButton = if bool1 or not tbl1.backButtonProps then nil else React.createElement(BackButton, {
            onBackButtonClick = onBackButtonClick,
            Position = tbl1.backButtonProps and tbl1.backButtonProps.Position or UDim2.new(0, var1.Padding.Small, 0, var1.Padding.Small)
        }),
        InnerView = 0
    }

    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl5 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalFlex = if bool1 then Enum.UIFlexAlignment.SpaceBetween else nil
        }),
        Thumbnail = 0,
        ViewportContainer = 0,
        BuyActionBarLayout = 0
    }
    local element

    if tbl1.tryOnState.isTryOnEnabled then
        element = nil
    else
        element = React.createElement(
            Foundation.View,
            {
                Size = tbl1.viewportProps and tbl1.viewportProps.Size or UDim2.new(0, 200, 0, 200),
                LayoutOrder = 1
            },
            {
                Background = if backgroundImageUrl then React.createElement(Foundation.Image, {
                    Image = backgroundImageUrl,
                    ScaleType = Enum.ScaleType.Crop,
                    tag = "size-full radius-medium",
                    ZIndex = 1,
                    testId = "inspect-and-buy-viewport-background"
                }) else nil,
                ImageLabel = React.createElement("ImageLabel", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Image = tbl1.thumbnailUrl,
                    ScaleType = tbl1.viewportProps and tbl1.viewportProps.ScaleType or Enum.ScaleType.Fit,
                    ZIndex = if backgroundImageUrl then 2 else nil
                }),
                UIFlexItem = if bool1 then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) else nil,
                UIAspectRatioConstraint = React.createElement(
                    "UIAspectRatioConstraint",
                    {
                        AspectRatio = tbl1.viewportProps and tbl1.viewportProps.AspectRatio or 1
                    }
                ),
                UIPadding = if tbl1.thumbnailPadding then React.createElement("UIPadding", {
                    PaddingLeft = tbl1.thumbnailPadding.left,
                    PaddingRight = tbl1.thumbnailPadding.right,
                    PaddingTop = tbl1.thumbnailPadding.top,
                    PaddingBottom = tbl1.thumbnailPadding.bottom
                }) else nil
            }
        )
    end

    tbl5.Thumbnail = element

    tbl5.ViewportContainer = React.createElement(Foundation.View, {
        tag = "padding-top-medium",
        Size = tbl1.viewportProps and tbl1.viewportProps.Size or UDim2.new(0, 200, 0, 200),
        LayoutOrder = 1,
        Visible = tbl1.tryOnState.isTryOnEnabled
    }, {
        UIFlexItem = if bool1 then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) else nil,
        UIAspectRatioConstraint = React.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = tbl1.viewportProps and tbl1.viewportProps.AspectRatio or 1
            }
        ),
        TryOnBackground = if FFlagAXInspectAndBuyAvatarBackground and tbl1.tryOnState.isTryOnEnabled then React.createElement(
            Foundation.Image,
            {
                Image = getTryOnBackgroundImage(tbl1.tryOnState.tryOnItem),
                ScaleType = Enum.ScaleType.Crop,
                tag = "size-full radius-medium",
                ZIndex = 0,
                testId = "inspect-and-buy-try-on-background"
            }
        ) else nil,
        Viewport = tbl1.renderTryOnViewport(tbl1.tryOnState.tryOnItem)
    })
    tbl5.BuyActionBarLayout = if bool1 and tbl1.buyActionBarProps then React.createElement(BuyActionBarLayout, {
        enableTopBorder = true,
        Size = UDim2.new(1, 0, 0, var1.Size.Size_1900),
        buyActionBarProps = tbl1.buyActionBarProps,
        purchaseButtonProps = tbl1.buyActionBarProps.purchaseButtonProps
    }) else nil
    tbl3.InnerView = createElement2(view, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return ViewportLayout

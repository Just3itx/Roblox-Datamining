-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local ImageWithSkeleton = require(Moments.Components.ImageWithSkeleton)

local FFlagMomentsHideUnavailableAvatarActionBar = require(Moments.Flags.FFlagMomentsHideUnavailableAvatarActionBar)

local function AvatarActionBar(tbl1)
    local var1 = useTokens()
    local size1000 = var1.Size.Size_1000

    if FFlagMomentsHideUnavailableAvatarActionBar and tbl1.hasLookError then
        return nil
    end

    if tbl1.isLoading then
        return React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y",
            testId = "moments-avatar-action-bar-skeleton"
        }, {
            Thumbnail = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(size1000, size1000), radius = Radius.Medium }),
            Lines = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col align-x-left align-y-center gap-xsmall auto-xy"
            }, {
                Price = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(64, var1.Size.Size_400) }),
                ItemCount = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromOffset(112, var1.Size.Size_300) })
            })
        })
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y",
        testId = "moments-avatar-action-bar"
    }

    local tbl3 = {
        Thumbnail = React.createElement(ImageWithSkeleton, {
            LayoutOrder = 1,
            Image = tbl1.thumbnailImage,
            Size = UDim2.fromOffset(size1000, size1000),
            radius = Radius.Medium,
            backgroundStyle = var1.Color.Shift.Shift_300
        }),
        Totals = 0,
        ShopButton = 0
    }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = { LayoutOrder = 2, tag = "col align-x-left align-y-center grow gap-xsmall auto-y" }

    local tbl5 = { Price = 0, ItemCount = 0 }
    local element

    if tbl1.priceText then
        element = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-x-left align-y-center gap-xsmall auto-xy"
        }, {
            RobuxIcon = React.createElement(Icon, { LayoutOrder = 1, name = IconName.Robux, size = IconSize.Small }),
            Amount = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "auto-xy text-title-medium text-align-x-left content-emphasis",
                Text = tbl1.priceText,
                testId = "moments-look-price"
            })
        })
    else
        element = nil
    end

    tbl5.Price = element

    tbl5.ItemCount = React.createElement(FoundationText, {
        LayoutOrder = 2,
        tag = "auto-xy text-body-medium text-align-x-left content-default",
        Text = tbl1.itemCountText,
        testId = "moments-look-item-count"
    })
    tbl3.Totals = createElement2(var3, tbl4, tbl5)

    tbl3.ShopButton = if tbl1.showShopButton then React.createElement(Button, {
        LayoutOrder = 3,
        isDisabled = tbl1.isShopDisabled,
        onActivated = tbl1.onShop,
        size = Foundation.Enums.InputSize.Medium,
        text = tbl1.shopText,
        testId = "moments-shop-cta",
        variant = Foundation.Enums.ButtonVariant.Emphasis
    }) else nil
    return createElement(var2, tbl2, tbl3)
end

return AvatarActionBar

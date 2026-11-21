-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local getTryOnItemReducerKey = AvatarExperienceCommon.Utils.getTryOnItemReducerKey
local Constants = AvatarExperienceCommon.Constants

local CheckoutRowItemCard = require(AvatarExperienceCatalog.Components.Checkout.CheckoutRowItemCard)
local CheckoutErrorBanner = require(AvatarExperienceCatalog.Components.Checkout.CheckoutErrorBanner)
local useTimedOptionsFtux = require(AvatarExperienceCatalog.Hooks.useTimedOptionsFtux)

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option

local function filterCartItems(cartItems, func1: (...any) -> (...any))
    local result = {}
    local num1 = 0
    for _, cartItem in cartItems do
        if func1(cartItem) then
            num1 += 1
            result[`{getTryOnItemReducerKey(cartItem.itemId, cartItem.itemType)}`] = React.createElement(CheckoutRowItemCard, Cryo.Dictionary.join(cartItem, { LayoutOrder = num1 }))
        end
    end

    return result
end

return React.memo(function(tbl1) -- name: CheckoutPageBody
    local var1 = if FFlagAXDurables2Option then useTokens() else nil
    local var2 = useLocalization({
        makeupTitle = "Feature.Catalog.Label.Makeup",
        makeupCartDescriptionText = "Feature.Catalog.Label.MakeupCartDescriptionText",
        rentalFtuxText = if FFlagAXDurables2Option then "Feature.Catalog.Title.RentalFtuxText" else nil
    })

    local var3 = nil
    local var4 = nil
    local var5

    if FFlagAXDurables2Option then
        local var6 = useTimedOptionsFtux()
        local var7
        var3, var7 = React.useState(var6.shouldShow2OptionToolTipInCheckoutPage())
        var4 = var7

        var5 = React.useCallback(function()
            var6.hide2OptionToolTipInCheckoutPage()
            var4(false)
        end, { var6 })
    else
        var5 = nil
    end

    local var6 = React.useMemo(function()
        return (filterCartItems(tbl1.cartItems, function(arg1): boolean
            return Constants.MAKEUP_LOOK_ASSET_TYPES[arg1.itemSubType] ~= nil
        end))
    end, { tbl1.cartItems })

    local var7 = React.useMemo(function()
        return (filterCartItems(tbl1.cartItems, function(arg1): boolean
            return not Constants.MAKEUP_LOOK_ASSET_TYPES[arg1.itemSubType]
        end))
    end, { tbl1.cartItems })

    local bool1 = tutils.fieldCount(var6) > 0
    local bool2 = tutils.fieldCount(var7) > 0
    local var8 = React.useMemo(function()
        for _, cartItem in tbl1.cartItems do
            if cartItem.timedOptions and (not cartItem.isOwned or cartItem.expirationTime ~= nil) then
                return true
            end
        end
        return false
    end, { tbl1.cartItems })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = if FFlagAXMISWithBlackbird then "col auto-y" else "col",
        Size = if FFlagAXMISWithBlackbird then UDim2.fromScale(1, 0) else UDim2.fromScale(1, 1)
    }
    local tbl3 = {
        CheckoutErrorBannerView = if tbl1.erroredItemCount and tbl1.erroredItemCount > 0 then React.createElement(
            Foundation.View,
            {
                tag = "auto-xy padding-x-xxlarge padding-y-medium",
                Size = UDim2.fromScale(1, 0),
                LayoutOrder = 1
            },
            {
                CheckoutErrorBanner = React.createElement(CheckoutErrorBanner, { erroredItemCount = tbl1.erroredItemCount })
            }
        ) else nil,
        Tooltip2OptionBanner = 0,
        AllItemsView = 0,
        MakeupText = 0,
        MakeupDescriptionText = 0,
        MakeupItemsView = 0
    }
    local element

    if FFlagAXDurables2Option and var3 and var8 then
        element = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y padding-x-xxlarge",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, -var1.Size.Size_1800)
        }, {
            Banner = React.createElement(Foundation.View, {
                tag = "row align-y-center gap-medium size-full-0 auto-y padding-left-xlarge padding-right-xsmall padding-y-xsmall radius-medium bg-surface-300"
            }, {
                Description = React.createElement(Foundation.Text, {
                    tag = "fill auto-y text-caption-large text-align-x-left text-truncate-end content-emphasis",
                    Text = var2.rentalFtuxText,
                    LayoutOrder = 1
                }),
                DismissIcon = React.createElement(Foundation.IconButton, {
                    icon = "icons/navigation/close",
                    size = Foundation.Enums.IconSize.Small,
                    onActivated = var5,
                    LayoutOrder = 2,
                    testId = "Checkout2OptionFtuxDismiss"
                })
            })
        })
    else
        element = nil
    end

    tbl3.Tooltip2OptionBanner = element

    tbl3.AllItemsView = if bool2 then React.createElement(
        Foundation.View,
        {
            tag = "col auto-y gap-medium padding-x-xxlarge padding-y-medium",
            Size = UDim2.fromScale(1, 0),
            LayoutOrder = 2
        },
        var7
    ) else nil

    tbl3.MakeupText = if bool1 then React.createElement(Foundation.Text, {
        tag = "auto-xy padding-x-xxlarge padding-top-medium text-title-medium content-emphasis",
        Text = var2.makeupTitle .. " (" .. tutils.fieldCount(var6) .. "/8)",
        LayoutOrder = 3
    }) else nil

    tbl3.MakeupDescriptionText = if bool1 then React.createElement(Foundation.Text, {
        tag = "auto-xy padding-x-xxlarge padding-top-xxsmall padding-bottom-medium text-body-small",
        Text = var2.makeupCartDescriptionText,
        LayoutOrder = 4
    }) else nil

    tbl3.MakeupItemsView = if bool1 then React.createElement(
        Foundation.View,
        {
            tag = "col auto-y gap-medium padding-x-xxlarge padding-y-medium",
            Size = UDim2.fromScale(1, 0),
            LayoutOrder = 5
        },
        var6
    ) else nil
    return createElement(view, tbl2, tbl3)
end, tutils.deepEqual)

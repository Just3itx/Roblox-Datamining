-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local formatNumber = require(scriptParentParent.Utility.formatNumber)

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Image = Foundation.Image
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius

local VirtualItemBadgeType = require(scriptParentParent.Enums.VirtualItemBadgeType)

local ModelViewport = require(scriptParentParent.Generic.ModelViewport)
local YellowBadge = require(scriptParentParent.Generic.YellowBadge)

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization

local useRobuxText = require(scriptParentParent.Generic.Hooks.useRobuxText)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local FFlagUnifiedPurchaseAddSkeleton = require(scriptParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseAddSkeleton

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local GetFFlagDiscountInfoForSubscriptionPurchaseModalLua = require(scriptParentParent.Parent.SharedFlags).GetFFlagDiscountInfoForSubscriptionPurchaseModalLua

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParent.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local default = require(scriptParentParentParent.LoggingProtocol).default
local VirtualItemBadgeShownCounter = require(scriptParentParent.Generic.Events.VirtualItemBadgeCounter).VirtualItemBadgeShownCounter

local function withMaxLength(itemName: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if #itemName > 50 then itemName:sub(1, 50) .. "..." else itemName
end

local _PricingTypes = require(scriptParentParent.ProductPurchase.PricingTypes)

return function(tbl1)
    local fFlagDiscountInfoForSubscriptionPurchaseModalLua = GetFFlagDiscountInfoForSubscriptionPurchaseModalLua()
    local itemPrice = tbl1.itemPrice
    local var1 = if itemPrice then itemPrice.priceInRobux else tbl1.itemRobuxCost
    local var2 = useLocalization({ Popular = "IAPExperience.RobuxUpsell.Text.PopularItem" })

    local priceSuffix = tbl1.priceSuffix

    local var3 = useTokens()
    local num1 = if tbl1.isPortrait then 128 else 72
    local var4 = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then useRobuxText(var1) else nil
    local var5 = useRobuxText(if itemPrice then itemPrice.basePriceInRobux else tbl1.itemRobuxCost)
    local var6 = itemPrice and itemPrice.basePriceInRobux > itemPrice.priceInRobux
    local var7 = if FFlagLuaAppsEnablePromptVIPServerPurchase and tbl1.includePriceSuffixOnOriginal ~= nil then tbl1.includePriceSuffixOnOriginal else fFlagDiscountInfoForSubscriptionPurchaseModalLua

    if tbl1.isCompact then
        num1 *= 0.7
    end

    local element

    if tbl1.model ~= nil then
        element = React.createElement(
            ModelViewport,
            {
                model = tbl1.model,
                Position = UDim2.fromOffset(5, 5),
                Size = UDim2.fromOffset(num1, num1)
            }
        )
    elseif FFlagUnifiedPurchaseAddSkeleton and tbl1.itemIcon == nil and tbl1.isLoading then
        element = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(num1, num1), radius = Radius.Circle })
    else
        element = React.createElement(Image, {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0, 5),
            Size = UDim2.new(0, num1, 0, num1),
            ScaleType = Enum.ScaleType.Stretch,
            Image = if tbl1.itemIcon then tbl1.itemIcon else "icons/status/imageunavailable",
            imageStyle = {
                Transparency = if tbl1.itemIcon then nil else var3.Color.Content.Default.Transparency
            }
        })
    end

    local itemBadge = if tbl1.badgeType and tbl1.badgeType == VirtualItemBadgeType.Popular then React.createElement(YellowBadge, { LayoutOrder = 3, Text = var2.Popular, Icon = "icons/menu/fire_fill" }) else nil

    React.useEffect(function()
        if not itemBadge then
            return
        end

        default:logRobloxTelemetryCounter(VirtualItemBadgeShownCounter, 1, { badgeType = tbl1.badgeType })
    end, {})
    local tag = if tbl1.isCompact then "auto-xy text-align-x-left text-wrap text-title-small content-emphasis" else "auto-xy text-align-x-left text-wrap text-title-medium content-emphasis"

    local str1 = if tbl1.isCompact then "auto-xy text-align-x-left text-wrap text-title-small content-emphasis" else "auto-xy text-align-x-left text-wrap text-title-medium content-emphasis"

    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        tag = "auto-y row gap-small align-y-center align-x-left"
    }
    local tbl3 = { ItemIcon = element, ItemDetailsFrame = 0 }
    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = {
        LayoutOrder = 2,
        Size = UDim2.new(1, -num1 - 6, 0, 0),
        tag = "col auto-y gap-small"
    }
    local tbl5 = { ItemName = 0, ItemSubtitle = 0, ItemDetails = 0 }
    local element3

    if FFlagUnifiedPurchaseAddSkeleton and tbl1.isLoading and tbl1.itemName == nil then
        element3 = React.createElement(
            Skeleton,
            {
                LayoutOrder = 1,
                Size = UDim2.fromScale(1, 0.3),
                radius = Radius.Circle,
                tag = "position-bottom-center"
            }
        )
    else
        element3 = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                Text = withMaxLength(tbl1.itemName),
                tag = tag
            }
        )
    end

    tbl5.ItemName = element3

    tbl5.ItemSubtitle = tbl1.subtitleView
    local element4

    if FFlagUnifiedPurchaseAddSkeleton and tbl1.isLoading and var1 == nil then
        element4 = React.createElement(
            Skeleton,
            {
                LayoutOrder = if tbl1.subtitleView then 3 else 2,
                Size = UDim2.fromScale(0.4, 0.3),
                radius = Radius.Circle
            }
        )
    else
        local createElement3 = React.createElement
        local var10 = View
        local tbl6 = {
            LayoutOrder = if tbl1.subtitleView then 3 else 2,
            tag = if tbl1.isPortrait then "auto-xy col gap-small align-y-center" else fFlagDiscountInfoForSubscriptionPurchaseModalLua and var6 and "row align-y-center gap-small auto-xy clip"
                or "auto-xy row gap-small align-y-center"
        }
        local tbl7 = { ItemCost = 0, OriginalPrice = 0, ItemBadge = 0 }
        local element5

        if FFlagLuaAppsEnablePromptVIPServerPurchase and tbl1.priceText then
            element5 = React.createElement(FoundationText, { LayoutOrder = 1, Text = tbl1.priceText, tag = str1, RichText = true })
        elseif var1 then
            if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
                element5 = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = var4 .. (if priceSuffix then if priceSuffix == "" then "" else "" .. priceSuffix else ""),
                    tag = str1,
                    RichText = true
                })
            else
                element5 = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, var1) .. (if priceSuffix then if priceSuffix == "" then "" else "" .. priceSuffix else ""),
                    tag = "auto-xy text-align-x-left text-wrap text-title-medium content-emphasis"
                })
            end
        elseif FFlagEnableUnifiedPurchaseFlowForDevSubs and tbl1.itemDisplayPrice then
            element5 = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.itemDisplayPrice .. (if priceSuffix then if priceSuffix == "" then "" else "" .. priceSuffix else ""),
                tag = str1
            })
        else
            element5 = nil
        end

        tbl7.ItemCost = element5

        tbl7.OriginalPrice = if var6 and var5 then React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = "<s>" .. var5 .. (if var7 then if priceSuffix then if priceSuffix == "" then "" else priceSuffix else "" else "") .. "</s>",
            tag = "auto-xy text-align-x-left text-wrap text-body-small content-default",
            RichText = true
        }) else nil

        tbl7.ItemBadge = itemBadge
        element4 = createElement3(var10, tbl6, tbl7)
    end

    tbl5.ItemDetails = element4
    tbl3.ItemDetailsFrame = createElement2(var9, tbl4, tbl5)
    return createElement(var8, tbl2, tbl3)
end

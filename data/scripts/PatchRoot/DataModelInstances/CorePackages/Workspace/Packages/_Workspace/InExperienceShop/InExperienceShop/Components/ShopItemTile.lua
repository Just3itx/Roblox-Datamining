-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local SessionService = game:GetService("SessionService")

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local SignalsReact = require(InExperienceShopParent.SignalsReact)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Enums = Foundation.Enums
local Badge = Foundation.Badge
local useTokens = Foundation.Hooks.useTokens

local IconSize = Enums.IconSize

local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local ShopItemFooter = require(InExperienceShop.Components.ShopItemFooter)
local useGamePassTrialRedemption = require(InExperienceShop.Hooks.useGamePassTrialRedemption)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local toUnifiedCategoryId = require(InExperienceShop.Analytics.toUnifiedCategoryId)
local SHOP_ITEM_MEDIA_HEIGHT_SCALE = require(InExperienceShop.Components.computeShopRowTileWidths).SHOP_ITEM_MEDIA_HEIGHT_SCALE
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagEnableCategoryLoggingInShop = require(InExperienceShop.Flags.FFlagEnableCategoryLoggingInShop)
local FFlagCategoryLoggingInShopPurchase = require(InExperienceShop.Flags.FFlagCategoryLoggingInShopPurchase)
local FFlagFixThumbnailBackgroundInExperienceShop = require(InExperienceShop.Flags.FFlagFixThumbnailBackgroundInExperienceShop)
local FFlagEnableDiscountOnInShopTile = require(InExperienceShop.Flags.FFlagEnableDiscountOnInShopTile)
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local FFlagUseOverMediaOnAllFreeTrialBadges = require(InExperienceShop.Flags.FFlagUseOverMediaOnAllFreeTrialBadges)
local FFlagEnableFreeTrialTopBarChip = require(InExperienceShop.Flags.FFlagEnableFreeTrialTopBarChip)
local FFlagEnableGamePassTrialUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableGamePassTrialUnifiedLogging)
local getIconRichText = Foundation.Utility.getIconRichText
local formatPrice = if FFlagEnableDiscountOnInShopTile then require(InExperienceShop.Utils.formatPrice) else nil
local _Types = require(InExperienceShop.Types)

local Constants = require(InExperienceShop.Constants)

local tbl1 = {
    freeTrial = "Feature.InExperienceShop.Label.FreeTrial",
    trial = "Feature.InExperienceShop.Label.Trial",
    active = "Feature.InExperienceShop.Label.Active",
    keepIt = "Feature.InExperienceShop.Label.KeepIt"
}

local function TrialBadge(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useTokens()
    local text = if tbl2.freeTrialStatus == "active" then var1.active elseif tbl2.freeTrialStatus == "redeemed" then var1.keepIt else var1.trial
    local variant = if not FFlagUseOverMediaOnAllFreeTrialBadges and tbl2.freeTrialStatus == "active" then Enums.BadgeVariant.Emphasis else Enums.BadgeVariant.OverMedia
    return React.createElement(Badge, {
        text = text,
        variant = variant,
        size = Enums.BadgeSize.Small,
        Position = UDim2.fromOffset(var2.Gap.Small, var2.Gap.Small),
        testId = "ShopItemTile-TrialBadge"
    })
end

local function FreeTrialLabel(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useTokens()

    return React.createElement(
        FoundationText,
        {
            tag = "auto-xy",
            fontStyle = var2.Typography.BodyMedium,
            Text = var1.freeTrial,
            LayoutOrder = tbl2.LayoutOrder
        }
    )
end
return React.memo(function(tbl2) -- name: ShopItemTile
    local var1 = SignalsReact.useSignalState(getInExperienceShopStore)
    local var2 = React.useRef(nil)

    local isOwned = SignalsReact.useSignalState(function(arg1)
        return var1.getOwnership(arg1)[tbl2.itemId]
    end)

    React.useEffect(function()
        if tbl2.itemType == "GamePass" then
            var1.fetchGamePassOwnership(tbl2.itemId)
        end
    end, { tbl2.itemId, tbl2.itemType, var1.fetchGamePassOwnership })

    local showTry = SignalsReact.useSignalState(function(arg1): boolean
        local available = var1.getTrialAvailabilities(arg1).available
        return if FFlagLuaAppEnableGamePassFreeTrials and tbl2.itemType == "GamePass" then available[tbl2.itemId] == true else false
    end)

    local var5 = FFlagLuaAppEnableGamePassFreeTrials and showTry and not isOwned

    local var6 = if FFlagLuaAppEnableGamePassFreeTrials then SignalsReact.useSignalState(function(arg1): boolean
        local active = var1.getTrialAvailabilities(arg1).active
        return tbl2.itemType == "GamePass" and active[tbl2.itemId] == true
    end) else false

    local var7 = if FFlagLuaAppEnableGamePassFreeTrials then SignalsReact.useSignalState(function(arg1): boolean
        local redeemed = var1.getTrialAvailabilities(arg1).redeemed
        return tbl2.itemType == "GamePass" and redeemed ~= nil and redeemed[tbl2.itemId] ~= nil
    end) else false

    local freeTrialStatus = if var5 then "available" elseif var6 and not isOwned then "active" elseif var7 then "redeemed" else nil
    local trialStatus = if FFlagEnableGamePassTrialUnifiedLogging then tbl2.itemType == "GamePass"
        and (if freeTrialStatus == "available" then "available" elseif freeTrialStatus == "active" then "Active" elseif freeTrialStatus == "redeemed" then "Redeemed" else "unavailable")
        or nil else nil

    local var10 = if FFlagEnableGamePassTrialUnifiedLogging then SignalsReact.useSignalState(function(arg1)
        local trialAvailabilityPhase = var1.getTrialAvailabilityPhase(arg1)
        return if tbl2.itemType == "GamePass" then trialAvailabilityPhase else "settled"
    end) else "settled"

    local tbl3

    if trialStatus == nil then
        tbl3 = nil
    else
        tbl3 = {
            shopPageType = tbl2.shopPageType,
            universeId = if tbl2.universeId == nil then nil else tonumber(tbl2.universeId),
            trialStatus = trialStatus
        }
    end
    React.useEffect(function()
        if not FFlagEnableInExperienceShopUnifiedLogging
            or FFlagEnableGamePassTrialUnifiedLogging and tbl2.itemType == "GamePass" and var10 ~= "settled"
        then
            return
        end

        task.defer(function()
            local avatarExperienceAnalytics = require(InExperienceShopParent.AvatarExperienceAnalytics)
            local addUnifiedEventLogging = avatarExperienceAnalytics.addUnifiedEventLogging
            local itemType = require(InExperienceShop.Utils.mapShopItemTypeToUnifiedItemType)(tbl2.itemType)
            if itemType == nil then
                return
            end

            local fFlagAxUnifiedEventStrictPayloads = avatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads
            local tbl4 = {
                universeId = if tbl2.universeId ~= nil then tonumber(tbl2.universeId) else game.GameId,
                itemId = tbl2.itemId,
                itemType = itemType,
                categoryId = if fFlagAxUnifiedEventStrictPayloads then toUnifiedCategoryId(tbl2.categoryId) else tbl2.categoryId,
                gridPositionRow = tbl2.gridPositionRow,
                gridPositionColumn = tbl2.gridPositionColumn,
                categoryType = if FFlagEnableCategoryLoggingInShop then tbl2.categoryType else nil,
                stableCategoryId = if FFlagEnableCategoryLoggingInShop then tbl2.stableCategoryId else nil,
                categoryGroup = if FFlagEnableCategoryLoggingInShop then tbl2.categoryGroup else nil,
                categoryName = if FFlagEnableCategoryLoggingInShop then tbl2.categoryName else nil
            }

            if FFlagEnableGamePassTrialUnifiedLogging and tbl2.itemType == "GamePass" then
                tbl4.trialStatus = trialStatus
                local elementsShown = if trialStatus == "available" then "try_button,trial_badge,free_trial_text" elseif trialStatus == "Redeemed" then if tbl2.price == nil then "trialed_badge" else "trialed_badge,price" elseif trialStatus == "Active" then if tbl2.price == nil then "active_badge" else "active_badge,price" else nil

                if elementsShown ~= nil then
                    tbl4.elementMetadata = game:GetService("HttpService"):JSONEncode({ elementsShown = elementsShown })
                elseif var2.current ~= nil then
                    local unifiedEventLogConstants = avatarExperienceAnalytics.UnifiedEventLogConstants
                    var2.current:SetAttribute(unifiedEventLogConstants.ATTRIBUTE_PREFIX .. "elementMetadata", nil)
                end
            end
            addUnifiedEventLogging(var2, tbl4, { sessionTagName = SessionService:GetSessionTag("level2a") })
        end)
    end, {
        tbl2.itemId,
        tbl2.itemType,
        tbl2.universeId,
        tbl2.categoryId,
        tbl2.gridPositionRow,
        tbl2.gridPositionColumn,
        if FFlagEnableCategoryLoggingInShop then tbl2.categoryType else nil,
        if FFlagEnableCategoryLoggingInShop then tbl2.stableCategoryId else nil,
        if FFlagEnableCategoryLoggingInShop then tbl2.categoryGroup else nil,
        if FFlagEnableCategoryLoggingInShop then tbl2.categoryName else nil,
        if FFlagEnableGamePassTrialUnifiedLogging then var10 else nil,
        if FFlagEnableGamePassTrialUnifiedLogging then trialStatus else nil,
        if FFlagEnableGamePassTrialUnifiedLogging then tbl2.price else nil
    })

    local onItemActivated = tbl2.onItemActivated

    local itemType = tbl2.itemType
    local var11 = React.useCallback(function()
        if onItemActivated then
            onItemActivated(tbl2.itemId, itemType)
        end
    end, { tbl2.itemId, itemType, onItemActivated })

    local var12 = nil
    local tbl4

    if FFlagCategoryLoggingInShopPurchase then
        tbl4 = {
            categoryGroup = tbl2.categoryGroup,
            categoryPosition = tbl2.categoryId,
            gridPositionRow = tbl2.gridPositionRow,
            gridPositionColumn = tbl2.gridPositionColumn,
            categoryName = tbl2.categoryName,
            stableCategoryId = tbl2.stableCategoryId
        }

        if tbl4.categoryGroup == nil
            and tbl4.categoryPosition == nil
            and tbl4.gridPositionRow == nil
            and tbl4.gridPositionColumn == nil
            and tbl4.categoryName == nil
            and tbl4.stableCategoryId == nil
        then
            tbl4 = var12
        end
    else
        tbl4 = var12
    end

    local var13 = useGamePassTrialRedemption(tbl2.itemId, {
        shopPageType = tbl2.shopPageType,
        categoryLocation = tbl4,
        universeId = if tbl3 == nil then nil else tbl3.universeId,
        trialStatus = if tbl3 == nil then nil else tbl3.trialStatus
    }, if FFlagEnableFreeTrialTopBarChip then tbl2.thumbnail else nil)

    local bool1 = FFlagEnableDiscountOnInShopTile

    if bool1 then
        if tbl2.userBasePriceInRobux == nil or tbl2.price == nil then
            bool1 = false
        else
            bool1 = tbl2.userBasePriceInRobux > tbl2.price
        end
    end

    local var14 = if bool1 and formatPrice then formatPrice(tbl2.userBasePriceInRobux) else nil
    local var15 = if bool1 and formatPrice then formatPrice(tbl2.price) else nil

    if FFlagEnableGamePassTrialUnifiedLogging and tbl2.itemType == "GamePass" and var10 ~= "settled" then
        return React.createElement(View, {
            tag = "col fill size-full-0 auto-y radius-medium clip bg-shift-200",
            LayoutOrder = tbl2.LayoutOrder,
            testId = "ShopItemTile-TrialLoading"
        }, {
            Media = React.createElement(View, {
                tag = "radius-medium bg-shift-200",
                Size = UDim2.fromScale(1, SHOP_ITEM_MEDIA_HEIGHT_SCALE),
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                LayoutOrder = 1
            }),
            TileContent = React.createElement(
                View,
                { tag = "col gap-medium size-full-0 auto-y padding-medium", LayoutOrder = 2 },
                {
                    Title = React.createElement(View, { tag = "radius-small bg-shift-200", Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 1 }),
                    Price = React.createElement(View, { tag = "radius-small bg-shift-200", Size = UDim2.new(0.4, 0, 0, 12), LayoutOrder = 2 }),
                    Button = React.createElement(View, { tag = "radius-small bg-shift-200", Size = UDim2.new(1, 0, 0, 28), LayoutOrder = 3 })
                }
            )
        })
    end

    local createElement = React.createElement
    local var16 = View
    local tbl5 = {
        tag = "col fill size-full-0 auto-y radius-medium clip bg-shift-200",
        LayoutOrder = tbl2.LayoutOrder,
        onActivated = 0,
        ref = 0
    }

    if not onItemActivated then
        var11 = nil
    end

    tbl5.onActivated = var11
    tbl5.ref = if FFlagEnableInExperienceShopUnifiedLogging then var2 else nil
    local tbl6 = {
        Media = React.createElement(Image, {
            tag = {
                ["radius-medium bg-shift-200"] = FFlagFixThumbnailBackgroundInExperienceShop,
                ["radius-medium"] = not FFlagFixThumbnailBackgroundInExperienceShop
            },
            Size = UDim2.fromScale(1, SHOP_ITEM_MEDIA_HEIGHT_SCALE),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Image = tbl2.thumbnail,
            ScaleType = Enum.ScaleType.Fit,
            LayoutOrder = 1
        }, {
            TrialBadge = if freeTrialStatus == nil then nil else React.createElement(TrialBadge, { freeTrialStatus = freeTrialStatus })
        }),
        TileContent = 0
    }

    local createElement2 = React.createElement
    local var17 = View
    local tbl7 = { tag = "col gap-medium size-full-0 auto-y padding-medium", LayoutOrder = 2 }

    local tbl8 = { ContentHeader = 0, Footer = 0 }
    local createElement3 = React.createElement
    local var18 = View
    local tbl9 = { tag = "col size-full-0 auto-y", LayoutOrder = 1 }

    local tbl10 = {
        Title = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis",
            Text = tbl2.name,
            LayoutOrder = 1
        }),
        FreeTrialLabel = if var5 then React.createElement(FreeTrialLabel, { LayoutOrder = 2 }) else nil,
        Metadata = 0
    }
    local var19

    if not tbl2.price or var5 then
        var19 = nil
    elseif FFlagEnableDiscountOnInShopTile then
        local createElement4 = React.createElement
        local var20 = View
        local tbl11 = { tag = "row align-y-center gap-xsmall auto-xy", LayoutOrder = 2 }

        local tbl12 = { SalePrice = 0, OriginalPrice = 0 }
        local createElement5 = React.createElement
        local var21 = View
        local tbl13 = { tag = "row align-y-center gap-xsmall auto-xy", LayoutOrder = 1 }

        local tbl14 = {
            SaleRobuxIcon = React.createElement(Icon, { name = Constants.ROBUX_ICON, size = IconSize.Small, LayoutOrder = 1 }),
            SalePriceLabel = 0
        }

        local createElement6 = React.createElement
        local var22 = FoundationText
        local tbl15 = {
            tag = "auto-xy text-body-medium text-truncate-end content-emphasis",
            Text = 0,
            LayoutOrder = 2
        }
        var15 = var15 or tostring(tbl2.price)
        tbl15.Text = var15
        tbl14.SalePriceLabel = createElement6(var22, tbl15)
        tbl12.SalePrice = createElement5(var21, tbl13, tbl14)

        tbl12.OriginalPrice = if bool1 and var14 then React.createElement(FoundationText, {
            tag = "auto-xy text-body-small text-truncate-end content-default",
            Text = "<s>" .. getIconRichText(Enums.IconName.Robux) .. " " .. var14 .. "</s>",
            RichText = true,
            LayoutOrder = 2
        }) else nil
        var19 = createElement4(var20, tbl11, tbl12)
    else
        local createElement4 = React.createElement
        local var20 = View

        local tbl11 = {
            RobuxIcon = React.createElement(Icon, { name = Constants.ROBUX_ICON, size = IconSize.Small, LayoutOrder = 1 }),
            PriceLabel = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium text-truncate-end content-default",
                    Text = tostring(tbl2.price),
                    LayoutOrder = 2
                }
            )
        }
        var19 = createElement4(var20, { tag = "row align-y-center gap-xsmall auto-xy", LayoutOrder = 2 }, tbl11)
    end

    tbl10.Metadata = var19
    tbl8.ContentHeader = createElement3(var18, tbl9, tbl10)

    tbl8.Footer = React.createElement(ShopItemFooter, {
        itemId = tbl2.itemId,
        itemType = tbl2.itemType,
        isOwned = isOwned,
        showTry = showTry,
        isActionLoading = var13.isActionLoading,
        isActionDisabled = var13.isActionDisabled,
        onTryActivated = var13.onTryActivated,
        price = tbl2.price,
        shopPageType = tbl2.shopPageType,
        purchaseCategoryLocation = tbl4,
        LayoutOrder = 2
    })
    tbl6.TileContent = createElement2(var17, tbl7, tbl8)
    return createElement(var16, tbl5, tbl6)
end)

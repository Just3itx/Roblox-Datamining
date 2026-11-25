-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Dash = require(ProfilePlatformParent.Dash)
local UserLib = require(ProfilePlatformParent.UserLib)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)

local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local Constants2 = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local useAvatarBackgroundFromWrapper = require(ProfilePlatform.Hooks.useAvatarBackgroundFromWrapper)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useMarketplaceAnalyticsContext = require(ProfilePlatform.Hooks.useMarketplaceAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)

local useProfileCardWidth = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)

local FFlagSocialEnableProfileInspectAndBuyAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyAnalytics
local FFlagProfileInspectAvatarBackground = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarBackground)
local FFlagProfileUnifiedPurchaseLogging = require(ProfilePlatform.Flags.FFlagProfileUnifiedPurchaseLogging)

local useInspectAvatarData = require(script.Parent.useInspectAvatarData)
local InspectAvatarUtils = require(script.Parent.InspectAvatarUtils)
local InspectAvatarSheet = require(script.Parent.InspectAvatarSheet)
local _Types = require(ProfilePlatform.Common.Types)
local _sendProfilePurchaseEvents = require(ProfilePlatform.Analytics.sendProfilePurchaseEvents)

local isItemPurchasable = InspectAvatarUtils.isItemPurchasable
local getPriceStatus = InspectAvatarUtils.getPriceStatus
local PriceStatusEnum = InspectAvatarUtils.PriceStatusEnum

local function InspectAvatarSheetContainer(tbl1)
    local var1 = useProfileWrapperContext()
    local var2 = useProfileAnalyticsContext()
    local var3 = useMarketplaceAnalyticsContext()
    local robuxBalance = RobloxAppHooks.useLocalRobuxBalance()
    local bool1 = useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide

    local profileId = var1.profileId

    local var5 = useSelector(function(arg1)
        return arg1.TopBar.statusBarHeight
    end)
    local topOffset = if bool1 then 0 else var5

    local cardWidth = useProfileCardWidth()
    local var8 = if bool1 then 400 else math.floor(cardWidth * 0.75)
    local var9 = useProfileJsonComponent(Enums.Components.UserProfileHeader)
    local username = var9.names and var9.names.username or ""

    local avatarThumbnail = getRbxthumbWithTypeSizeAndOptions(profileId, Constants.RbxthumbTypes.Avatar, Constants2.AVATAR_THUMBNAIL_SIZE)
    local var10 = if FFlagProfileInspectAvatarBackground then useAvatarBackgroundFromWrapper() else nil
    local var11 = useProfileJsonComponent(Enums.Components.CurrentlyWearing).assets or {}

    local var12 = useInspectAvatarData(var11)
    local displayItems = var12.displayItems

    local selectedItems, var14 = React.useState({})
    local var15 = React.useRef({})

    React.useEffect(function()
        if #displayItems == 0 then
            return
        end
        local tbl2 = ({})
        local bool2 = false
        for _, displayItem in displayItems do
            local id = displayItem.id
            if isItemPurchasable(displayItem) and not var15.current[id] then
                var15.current[id] = true
                tbl2[id] = true
                bool2 = true
            end
        end

        if not bool2 then
            return
        end
        var14(function(arg1)
            return Dash.join(arg1, tbl2)
        end)
    end, { displayItems })

    local onToggleItem = React.useCallback(function(str1: string)
        var14(function(arg1)
            return Dash.join(arg1, { [str1] = not arg1[str1] })
        end)
    end, {})

    local var17 = React.useMemo(function()
        local lineItems = {}
        local num1 = 0
        local num2 = 0
        local purchasedWearIds = {}
        local purchasedItemIds = {}
        local purchasedBundleIds = {}

        local purchasedItems = FFlagProfileUnifiedPurchaseLogging and {} or nil
        local tbl6 = ({})
        for _, displayItem in displayItems do
            if not displayItem.id then
                continue
            end

            local id = displayItem.id
            if not (selectedItems[id] and isItemPurchasable(displayItem)) then
                continue
            end

            local effectivePrice = InspectAvatarUtils.getEffectivePrice(displayItem)

            table.insert(lineItems, {
                collectibleProductId = if getPriceStatus(displayItem) == PriceStatusEnum.PurchaseFromResale and displayItem.collectibleItemDetails then displayItem.collectibleItemDetails.collectibleLowestAvailableResaleProductId or displayItem.collectibleProductId else displayItem.collectibleProductId,
                agreedPriceRobux = effectivePrice
            })
            num1 += effectivePrice
            num2 += 1
            table.insert(purchasedItemIds, id)
            if FFlagProfileUnifiedPurchaseLogging and purchasedItems then
                table.insert(purchasedItems, {
                    itemId = id,
                    itemType = displayItem.itemType,
                    itemSubType = tonumber(displayItem.itemSubType),
                    priceInRobux = effectivePrice
                })
            end
            if displayItem.itemType == Enums.ItemTypes.Bundle then
                table.insert(purchasedBundleIds, id)
            end

            if #displayItem.bundleAssetIds > 0 then
                for _, bundleAssetId in displayItem.bundleAssetIds do
                    if not tbl6[bundleAssetId] then
                        tbl6[bundleAssetId] = true
                        table.insert(purchasedWearIds, bundleAssetId)
                    end
                end
            else
                local var18 = tonumber(displayItem.id)
                if var18 and not tbl6[var18] then
                    tbl6[var18] = true
                    table.insert(purchasedWearIds, var18)
                end
            end
        end

        return {
            lineItems = lineItems,
            totalPrice = num1,
            count = num2,
            purchasedWearIds = purchasedWearIds,
            purchasedItemIds = purchasedItemIds,
            purchasedBundleIds = purchasedBundleIds,
            purchasedItems = purchasedItems
        }
    end, { displayItems, selectedItems })

    local wearTypeMap = React.useMemo(function()
        local result = ({})
        for _, displayItem in displayItems do
            local var18 = tonumber(displayItem.id)
            local var19 = tonumber(displayItem.itemSubType)
            if var18 and var19 then
                result[var18] = var19
            end
            if not displayItem.assetsInBundle then
                continue
            end

            for _, value in displayItem.assetsInBundle do
                local var20 = tonumber(value.id)
                local var21 = tonumber(value.assetType)
                if var20 and var21 then
                    result[var20] = var21
                end
            end
        end

        return result
    end, { displayItems })

    local useCallback = React.useCallback
    local function func1()
        if #var17.lineItems == 0 or not var12.localUserId then
            return
        end
        if FFlagSocialEnableProfileInspectAndBuyAnalytics then
            var2.fireAnalyticsEvent(EventNames.InspectAvatarBuyClicked, {
                profileSessionId = var1.profileSessionId,
                itemIds = table.concat(var17.purchasedItemIds, ","),
                totalPrice = var17.totalPrice
            })
        end

        if robuxBalance ~= nil and var17.totalPrice > robuxBalance then
            tbl1.navigation.navigate(
                Enums.Screens.InsufficientRobuxDialog,
                {
                    totalPrice = var17.totalPrice,
                    robuxBalance = robuxBalance
                }
            )
            return
        end

        tbl1.navigation.navigate(Enums.Screens.PurchaseConfirmationModal, {
            totalPrice = var17.totalPrice,
            itemCount = var17.count,
            purchasableLineItems = var17.lineItems,
            userId = var12.localUserId,
            purchasedWearIds = var17.purchasedWearIds,
            ownedAssetIds = var12.ownedAssetIds,
            purchasedItemIds = var17.purchasedItemIds,
            purchasedBundleIds = var17.purchasedBundleIds,
            purchasedItems = if FFlagProfileUnifiedPurchaseLogging then var17.purchasedItems else nil,
            wearTypeMap = wearTypeMap,
            robuxBalance = robuxBalance
        })
    end

    local localUserId = var12.localUserId
    local ownedAssetIds = var12.ownedAssetIds
    local navigation = tbl1.navigation
    local var19 = if FFlagSocialEnableProfileInspectAndBuyAnalytics then var2 else nil
    local profileSessionId = if FFlagSocialEnableProfileInspectAndBuyAnalytics then var1.profileSessionId else nil
    local onBuyAll = useCallback(
        func1,
        {
            var17,
            localUserId,
            ownedAssetIds,
            navigation,
            wearTypeMap,
            robuxBalance,
            var19,
            profileSessionId
        }
    )

    local onClose = React.useCallback(function()
        tbl1.navigation.pop()
    end, { tbl1.navigation })

    local onDismiss = React.useCallback(function()
        tbl1.navigation.pop()
        task.defer(function()
            var1.navigateTo.previousView(false)
        end)
    end, { tbl1.navigation, var1.navigateTo })

    local openItemDetails = React.useCallback(function(str1: string, str2: string, num1: number?)
        var1.navigateTo.itemOrBundleDetails(str1, str2)
        var2.fireAnalyticsEvent(
            EventNames.CatalogItemOpened,
            {
                btnContext = "InspectAvatar",
                btnUnitId = tostring(str1),
                btnSortPosition = tostring(num1)
            }
        )
        var1.externalAnalytics.catalogAnalytics.clickCatalogItemFromProfile(var3, str1, str2, "InspectAvatar", num1)
    end, {
        var1.navigateTo.itemOrBundleDetails,
        var1.externalAnalytics.catalogAnalytics,
        var2,
        var3
    })

    local createElement = React.createElement
    local var24 = InspectAvatarSheet
    local tbl2 = {
        displayItems = displayItems,
        selectedItems = selectedItems,
        isLoading = var12.isLoading,
        username = username,
        profileId = profileId,
        avatarThumbnail = avatarThumbnail,
        avatarBackgroundImage = 0,
        avatarViewportHeight = 0,
        cardWidth = 0,
        topOffset = 0,
        purchaseSummary = 0,
        onToggleItem = 0,
        onBuyAll = 0,
        onClose = 0,
        onDismiss = 0,
        openItemDetails = 0
    }

    if not FFlagProfileInspectAvatarBackground then
        var10 = nil
    end

    tbl2.avatarBackgroundImage = var10
    tbl2.avatarViewportHeight = var8
    tbl2.cardWidth = cardWidth
    tbl2.topOffset = topOffset
    tbl2.purchaseSummary = {
        totalPrice = var17.totalPrice,
        count = var17.count
    }
    tbl2.onToggleItem = onToggleItem
    tbl2.onBuyAll = onBuyAll
    tbl2.onClose = onClose
    tbl2.onDismiss = onDismiss
    tbl2.openItemDetails = openItemDetails
    return createElement(var24, tbl2)
end

return InspectAvatarSheetContainer

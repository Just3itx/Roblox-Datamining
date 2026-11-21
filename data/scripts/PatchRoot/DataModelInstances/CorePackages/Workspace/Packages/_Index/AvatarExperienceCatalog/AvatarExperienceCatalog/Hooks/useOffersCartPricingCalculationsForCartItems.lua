-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local React = require(AvatarExperienceCatalogParent.React)
local RoactUtils = require(AvatarExperienceCatalogParent.RoactUtils)
local mutedError = require(AvatarExperienceCatalogParent.Loggers).mutedError
local tutils = require(AvatarExperienceCatalogParent.tutils)
local SignalsReact = require(AvatarExperienceCatalogParent.SignalsReact)
local ToastRodux = require(AvatarExperienceCatalogParent.ToastRodux)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local postCartPricingForOffers = require(AvatarExperienceCatalog.Api.PostCartPricingForOffers.postCartPricingForOffers)
local useAXCatalogStoreContext = require(AvatarExperienceCatalog.Context.useAXCatalogStoreContext)
local decodeLuauUnicodeEscapes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.decodeLuauUnicodeEscapes)

local ToastType = ToastRodux.Enums.ToastType
local DiscountTypeEnum = AvatarExperienceCommon.Enums.DiscountTypeEnum
local useSignalState = SignalsReact.useSignalState
local useNetworking = AvatarExperienceCommon.Hooks.useNetworking
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local Constants = AvatarExperienceCommon.Constants

local bool1 = game:DefineFastFlag("AXDoNotPass356FetchCartPricing", false)

local function buildItemsForOffersCartPricingRequest(arg1)
    local itemsForOffersCartPricingRequest = {}
    for _, value in arg1 do
        local bool2 = value.selectedTimedOptionDays == nil or value.selectedTimedOptionDays == 0
        if bool1 and value.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
            continue
        end

        table.insert(itemsForOffersCartPricingRequest, {
            collectibleItemId = value.collectibleItemId,
            collectibleProductId = value.collectibleProductId,
            isPermanent = value.selectedTimedOptionDays == nil or value.selectedTimedOptionDays == 0,
            rentalDays = if bool2 then nil else value.selectedTimedOptionDays
        })
    end
    return itemsForOffersCartPricingRequest
end

local function getOffersAvailableMap(availableOffers)
    local offersAvailableMap = {}
    if availableOffers ~= nil then
        for _, availableOffer in availableOffers do
            offersAvailableMap[availableOffer.offerId] = availableOffer
            if availableOffer.localizedDescription then
                availableOffer.localizedDescription = decodeLuauUnicodeEscapes(availableOffer.localizedDescription)
            end
        end
    end
    return offersAvailableMap
end

local function calculateTotalDiscountFromSelectedOffers(items, offersAvailableMap)
    local tbl1 = {}
    for _, value in offersAvailableMap do
        if value.selected then
            tbl1[value.offerId] = true
        end
    end

    local num1 = 0
    for _, item in items do
        local discountInformation = item.discountInformation
        if discountInformation == nil or discountInformation.discounts == nil then
            continue
        end

        for _, discount in discountInformation.discounts do
            if tbl1[discount.discountCampaign] then
                num1 += discount.robuxDiscountAmount
            end
        end
    end
    return num1
end

local function getDiscountedItemsFromItemsData(items, offersAvailableMap)
    local discountedItemsFromItemsData = ({})
    for _, item in items do
        local offerIdsApplied = {}
        if item.discountInformation and item.discountInformation.discounts then
            for _, discount in item.discountInformation.discounts do
                if offersAvailableMap[discount.discountCampaign] and offersAvailableMap[discount.discountCampaign].selected then
                    table.insert(offerIdsApplied, discount.discountCampaign)
                end
            end
        end

        local collectibleItemId = item.collectibleItemId
        discountedItemsFromItemsData[collectibleItemId] = {
            collectibleItemId = item.collectibleItemId,
            priceInRobux = item.priceInRobux,
            discountInformation = item.discountInformation,
            offerIdsApplied = offerIdsApplied
        }
    end
    return discountedItemsFromItemsData
end

local function getAllDiscountSummaryEntries(items, offersAvailableMap)
    local allDiscountSummaryEntries = {}
    for _, item in items do
        local discountInformation = item.discountInformation
        if discountInformation == nil or discountInformation.discounts == nil then
            continue
        end

        for _, discount in discountInformation.discounts do
            if offersAvailableMap[discount.discountCampaign] == nil then
                continue
            end

            table.insert(allDiscountSummaryEntries, {
                type = DiscountTypeEnum.Uncategorized,
                amountInRobux = discount.robuxDiscountAmount,
                percent = discount.robuxDiscountPercentage,
                localizedDiscountAttribution = discount.localizedDiscountAttribution
            })
        end
    end
    return allDiscountSummaryEntries
end

local tbl1 = ({})

local function useOffersCartPricingCalculationsForCartItems(arg1, bool2: boolean, bool3: boolean)
    local catalogOffersBannerStore = useAXCatalogStoreContext().catalogOffersBannerStore
    local var1 = useNetworking()
    local var2 = useDispatch()

    local var3 = useSignalState(catalogOffersBannerStore.getPayload)
    local var4, var5 = React.useState(nil)
    local offersAvailable, var7 = React.useState({})
    local discountedItemsFromOffers, var9 = React.useState({})
    local totalSelectedOffersDiscount, var11 = React.useState(0)

    local discountSummaryEntriesFromOffers, var13 = React.useState({})
    local var14 = React.useRef(false)

    local itemsForOffersCartPricingRequest = buildItemsForOffersCartPricingRequest(arg1)
    local var15 = React.useRef({})

    local var16 = useLocalization({
        fetchFailed = "Feature.Catalog.Title.Checkout.OfferFailedToFetch",
        toggleFailed = "Feature.Catalog.Title.Checkout.OfferFailedToUpdate"
    })

    local var17 = React.useCallback(function(toastMessage)
        local tbl2 = {
            isLocalized = true,
            toastMessage = toastMessage,
            toastType = ToastType.NetworkingError
        }
        var2(SetCurrentToastMessage(tbl2))
    end, { var2 })

    React.useEffect(function()
        if not var3
            or not bool3
            or #itemsForOffersCartPricingRequest == 0
            or tutils.deepEqual(itemsForOffersCartPricingRequest, var15.current)
        then
            return
        end
        var15.current = itemsForOffersCartPricingRequest

        local var18, _ = postCartPricingForOffers(var1, {
            items = itemsForOffersCartPricingRequest,
            featureKey = "MARKETPLACE_CART",
            unselectedOffers = Cryo.Dictionary.keys(tbl1)
        })

        var18:andThen(function(arg2)
            if not (arg2 and arg2.items) then
                mutedError("marketplace-sales/v1/cart-pricing did not return items in payload")

                return
            end

            local offersAvailableMap = getOffersAvailableMap(arg2.availableOffers)
            var5(arg2.savingsSummary)
            var7(offersAvailableMap)
            var9((getDiscountedItemsFromItemsData(arg2.items, offersAvailableMap)))
            var11((calculateTotalDiscountFromSelectedOffers(arg2.items, offersAvailableMap)))

            var13((getAllDiscountSummaryEntries(arg2.items, offersAvailableMap)))
        end):catch(function(_)
            var17(var16.fetchFailed)
        end)
    end, {
        var1,
        itemsForOffersCartPricingRequest,
        var3,
        bool3,
        var17,
        var16
    })

    React.useEffect(function()
        if bool2 then
            return
        end

        var15.current = {}
        var5(nil)
        var7({})
        var9({})
        var11(0)
        var13({})
    end, { bool2 })

    local handleDeselectOfferId = React.useCallback(function(arg2)
        if var14.current then
            return
        end
        var14.current = true

        local var18 = table.clone(tbl1)

        if tbl1[arg2] then
            tbl1[arg2] = nil
        else
            tbl1[arg2] = true
        end

        local var19, _ = postCartPricingForOffers(var1, {
            items = itemsForOffersCartPricingRequest,
            featureKey = "MARKETPLACE_CART",
            unselectedOffers = Cryo.Dictionary.keys(tbl1)
        })

        var19:andThen(function(arg3)
            if arg3 and arg3.items then
                local offersAvailableMap = getOffersAvailableMap(arg3.availableOffers)
                var5(arg3.savingsSummary)
                var7(offersAvailableMap)
                var9((getDiscountedItemsFromItemsData(arg3.items, offersAvailableMap)))
                var11((calculateTotalDiscountFromSelectedOffers(arg3.items, offersAvailableMap)))

                var13((getAllDiscountSummaryEntries(arg3.items, offersAvailableMap)))
            else
                mutedError("marketplace-sales/v1/cart-pricing did not return items in payload")
            end

            var14.current = false
        end):catch(function(_)
            tbl1 = var18
            var17(var16.toggleFailed)

            var14.current = false
        end)
    end, {
        var1,
        itemsForOffersCartPricingRequest,
        var17,
        var16
    })

    return {
        offersAvailable = offersAvailable,
        discountedItemsFromOffers = discountedItemsFromOffers,
        totalSelectedOffersDiscount = totalSelectedOffersDiscount,
        discountSummaryEntriesFromOffers = discountSummaryEntriesFromOffers,
        savingsSummary = if var4 then decodeLuauUnicodeEscapes(var4) else nil,
        handleDeselectOfferId = handleDeselectOfferId
    }
end

return useOffersCartPricingCalculationsForCartItems

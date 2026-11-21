-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local CatalogRowItemCard = AvatarExperienceCommon.Components.CatalogItemCard.CatalogRowItemCard
local ItemCardThumbnail = require(AvatarExperienceCatalogParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local tutils = require(AvatarExperienceCatalogParent.tutils)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local _createAXShoppingCartStore = require(AvatarExperienceCatalog.Stores.createAXShoppingCartStore)
local PurchaseItemsErrorStatusMap = require(AvatarExperienceCatalog.Enums.PurchaseItemsErrorStatusMap)
local Constants = require(AvatarExperienceCatalog.Constants)

local useCheckoutRowItemCardViewModel = require(script.Parent.useCheckoutRowItemCardViewModel)

local AvatarExperienceGifting = require(AvatarExperienceCatalogParent.AvatarExperienceGifting)
local AvatarItemGiftEntryPoint = AvatarExperienceGifting.Components.AvatarItemGiftEntryPoint
local useAvatarItemGiftEligibility = AvatarExperienceGifting.Hooks.useAvatarItemGiftEligibility

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXGifting = AvatarExperienceFlags.FFlagAXGifting
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option
local FFlagAXMISOffersChip = AvatarExperienceFlags.FFlagAXMISOffersChip
local FFlagAXMISSmallUIChanges = AvatarExperienceFlags.FFlagAXMISSmallUIChanges
local FFlagAXMISWithOffers = AvatarExperienceFlags.FFlagAXMISWithOffers

local AvatarExperienceTimedOptions = require(AvatarExperienceCatalogParent.AvatarExperienceTimedOptions)
local WearTimeSelectedOptionInList = AvatarExperienceTimedOptions.WearTimeSelectedOptionInList
local WearTimeOptionButton = AvatarExperienceTimedOptions.WearTimeOptionButton

local Constants2 = AvatarExperienceCommon.Constants

local ASSET_TYPE_LOCALIZED = Constants.ASSET_TYPE_LOCALIZED
local BUNDLE_TYPE_LOCALIZED = Constants.BUNDLE_TYPE_LOCALIZED
local OFFERS_LOCALIZED = Constants.OFFERS_LOCALIZED

local tbl1 = {}
local SOLD_OUT = PurchaseItemsErrorStatusMap.SOLD_OUT
tbl1[tostring(SOLD_OUT)] = "Feature.Catalog.Label.Checkout.SoldOut"
local ALREADY_OWNED = PurchaseItemsErrorStatusMap.ALREADY_OWNED
tbl1[tostring(ALREADY_OWNED)] = "Feature.Catalog.Label.Owned"
local EXPERIENCE_LINK = PurchaseItemsErrorStatusMap.EXPERIENCE_LINK
tbl1[tostring(EXPERIENCE_LINK)] = "Feature.Catalog.Label.Checkout.InExperienceOnly"
local QUANTITY_LIMIT_EXCEEDED = PurchaseItemsErrorStatusMap.QUANTITY_LIMIT_EXCEEDED
tbl1[tostring(QUANTITY_LIMIT_EXCEEDED)] = "Feature.Catalog.Label.Checkout.LimitReached"
local NOT_AVAILABLE_FOR_PURCHASER = PurchaseItemsErrorStatusMap.NOT_AVAILABLE_FOR_PURCHASER
tbl1[tostring(NOT_AVAILABLE_FOR_PURCHASER)] = "Feature.Catalog.Label.Checkout.Unavailable"
local NOT_FOR_SALE = PurchaseItemsErrorStatusMap.NOT_FOR_SALE
tbl1[tostring(NOT_FOR_SALE)] = "Feature.Catalog.Label.Checkout.OffSale"
local PURCHASER_IS_SELLER = PurchaseItemsErrorStatusMap.PURCHASER_IS_SELLER
tbl1[tostring(PURCHASER_IS_SELLER)] = "Feature.Catalog.Label.Checkout.Unavailable"
local PURCHASE_PLACE_INVALID = PurchaseItemsErrorStatusMap.PURCHASE_PLACE_INVALID
tbl1[tostring(PURCHASE_PLACE_INVALID)] = "Feature.Catalog.Label.Checkout.InExperienceOnly"
local PRICE_MISMATCH = PurchaseItemsErrorStatusMap.PRICE_MISMATCH
tbl1[tostring(PRICE_MISMATCH)] = "Feature.Catalog.Label.Checkout.PriceChanged"
tbl1.Unvailable = "Feature.Catalog.Label.Checkout.Unavailable"

local function hasAssetTypeLocalizedString(name: string, itemSubType: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return name == Enum.AvatarItemType.Asset.Name and ASSET_TYPE_LOCALIZED[tostring(itemSubType)] ~= nil
end

local function hasBundleTypeLocalizedString(name: string, itemSubType: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return name == Enum.AvatarItemType.Bundle.Name and BUNDLE_TYPE_LOCALIZED[tostring(itemSubType)] ~= nil
end

local function getThumbnailType(name: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if name == Enum.AvatarItemType.Bundle.Name then "BundleThumbnail" else "Asset"
end

return React.memo(function(arg1) -- name: CheckoutRowItemCard
    local var1 = Foundation.Hooks.useTokens()

    local var2 = arg1.thumbnailSize or var1.Size.Size_2100

    local selectedTimedOptionPrice = nil
    local setSelectedTimedOptionPrice = nil
    local showOfferPillTooltip

    if FFlagAXDurablesForMIS then
        local var3 = useCheckoutRowItemCardViewModel(arg1)
        selectedTimedOptionPrice = var3.selectedTimedOptionPrice
        setSelectedTimedOptionPrice = var3.setSelectedTimedOptionPrice
        if FFlagAXDurables2Option then
            showOfferPillTooltip = var3.showOfferPillTooltip
        else
            showOfferPillTooltip = nil
        end
    else
        showOfferPillTooltip = nil
    end

    local var3 = useLocalization(ASSET_TYPE_LOCALIZED)
    local var4 = useLocalization(BUNDLE_TYPE_LOCALIZED)
    local var5 = useLocalization(tbl1)
    local offersLocalized = if FFlagAXMISOffersChip then useLocalization(OFFERS_LOCALIZED) else nil
    local thumbnailType = getThumbnailType(arg1.itemType)

    local itemSubType = React.useMemo(function()
        local itemType = arg1.itemType
        local itemSubType = arg1.itemSubType

        if hasAssetTypeLocalizedString(itemType, itemSubType) then
            return var3[tostring(itemSubType)]
        end

        if hasBundleTypeLocalizedString(itemType, itemSubType) then
            return var4[tostring(itemSubType)]
        end

        return ""
    end, {
        var3,
        var4,
        arg1.itemType,
        arg1.itemSubType
    })
    local useMemo = React.useMemo
    local function func1()
        local result = {}

        if arg1.status == nil then
            table.insert(result, {
                type = "price",
                price = arg1.priceInRobux,
                priceInRobuxDiscountedByOffers = if FFlagAXMISWithOffers then arg1.priceInRobuxDiscountedByOffers else nil
            })

            if arg1.discountInformation
                and (not FFlagAXMISWithOffers
                    or FFlagAXMISWithOffers
                        and arg1.discountInformation.totalDiscountAmount
                        and arg1.discountInformation.totalDiscountAmount > 0)
            then
                table.insert(result, {
                    type = "price",
                    price = arg1.discountInformation.originalPrice,
                    strikethrough = true,
                    isOriginalPrice = true,
                    shouldShowOriginalPrice = if FFlagAXMISWithOffers then arg1.priceInRobuxDiscountedByOffers ~= nil else nil
                })
                return result
            end
        elseif arg1.status == PurchaseItemsErrorStatusMap.PRICE_MISMATCH then
            if not arg1.priceMismatchMetadata then
                table.insert(result, { type = "text", text = var5[tostring(PurchaseItemsErrorStatusMap.PRICE_MISMATCH)] })
                return result
            end

            table.insert(result, {
                type = "price",
                price = arg1.priceInRobux,
                priceInRobuxDiscountedByOffers = if FFlagAXMISWithOffers then arg1.priceInRobuxDiscountedByOffers else nil,
                colorStyle = var1.Color.System.Warning
            })
            if not (FFlagAXMISWithOffers and arg1.priceInRobuxDiscountedByOffers) then
                table.insert(result, { type = "price", price = arg1.priceMismatchMetadata.oldPriceInRobux, strikethrough = true })
                return result
            end
        else
            if arg1.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED then
                table.insert(result, { type = "text", text = var5[tostring(PurchaseItemsErrorStatusMap.ALREADY_OWNED)] })
                return result
            end
            if arg1.status == PurchaseItemsErrorStatusMap.QUANTITY_LIMIT_EXCEEDED then
                table.insert(result, { type = "text", text = var5[tostring(PurchaseItemsErrorStatusMap.QUANTITY_LIMIT_EXCEEDED)] })
                return result
            end

            local tbl2 = { type = "text", text = 0, colorStyle = 0 }

            local tbl3 = tbl1
            local status = arg1.status
            local unvailable = if tbl3[tostring(status)] then var5[tostring(arg1.status)] else var5.Unvailable
            tbl2.text = unvailable

            tbl2.colorStyle = var1.Color.System.Warning
            table.insert(result, tbl2)
        end

        return result
    end

    local priceInRobux = arg1.priceInRobux
    local status = arg1.status
    local priceMismatchMetadata = arg1.priceMismatchMetadata

    local discountInformation = arg1.discountInformation
    local priceInRobuxDiscountedByOffers = if FFlagAXMISWithOffers then arg1.priceInRobuxDiscountedByOffers else nil
    local priceLineContent = useMemo(
        func1,
        {
            priceInRobux,
            status,
            priceMismatchMetadata,
            var5,
            var1,
            discountInformation,
            priceInRobuxDiscountedByOffers
        }
    )
    local element

    if FFlagAXDurables2Option then
        local var9 = React.useMemo(function()
            local result = ({})
            if arg1.timedOptions then
                for k, timedOption in arg1.timedOptions do
                    if timedOption.days ~= 3 and timedOption.days ~= 0 then
                        continue
                    end

                    local str1 = `Option{k}`
                    local createElement = React.createElement
                    local view = Foundation.View
                    local tbl2 = {
                        tag = "fill auto-y padding-top-small",
                        LayoutOrder = #arg1.timedOptions - k + 1
                    }
                    local tbl3 = { Button = 0 }
                    local createElement2 = React.createElement
                    local var9 = WearTimeOptionButton
                    local tbl4 = {
                        isFullWidth = true,
                        option = {
                            days = timedOption.days,
                            price = timedOption.price,
                            discountInformation = timedOption.discountInformation,
                            selected = if arg1.selectedTimedOptionIndexInReducer then k == arg1.selectedTimedOptionIndexInReducer else timedOption.selected,
                            priceInRobuxDiscountedByOffers = arg1.priceInRobuxDiscountedByOffers
                        },
                        onActivated = 0
                    }
                    function tbl4.onActivated()
                        local timedOption2 = arg1.timedOptions[k]
                        if not timedOption2 then
                            return
                        end

                        if setSelectedTimedOptionPrice then
                            setSelectedTimedOptionPrice(timedOption2.price)
                        end
                        if arg1.onTimedOptionPriceChanged then
                            local days = if timedOption2.days == 0 then nil else timedOption2.days
                            arg1.onTimedOptionPriceChanged(timedOption2.price, days)
                        end
                    end

                    tbl3.Button = createElement2(var9, tbl4)
                    result[str1] = createElement(view, tbl2, tbl3)
                end
            end

            return result
        end, {
            arg1.timedOptions,
            arg1.onTimedOptionPriceChanged,
            arg1.selectedTimedOptionIndexInReducer,
            setSelectedTimedOptionPrice
        })

        element = React.createElement(
            Foundation.View,
            { tag = "row gap-medium align-y-center size-full-0 auto-y", LayoutOrder = 2 },
            var9
        )
    else
        element = nil
    end

    local collectibleItemId = if FFlagAXGifting and arg1.itemId ~= Constants2.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then arg1.collectibleItemId else nil
    local element2 = if if FFlagAXGifting then useAvatarItemGiftEligibility(collectibleItemId).areItemsGiftable else false then React.createElement(
        AvatarItemGiftEntryPoint,
        {
            collectibleItemId = arg1.collectibleItemId,
            isCircular = true,
            LayoutOrder = 1
        }
    ) else nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = if FFlagAXDurables2Option then "auto-y col size-full-0 gap-xxsmall" else "auto-y row size-full-0 gap-small",
        LayoutOrder = arg1.LayoutOrder,
        testId = `CheckoutRowItemCard-{arg1.itemId}`
    }
    local tbl3 = {
        RowItemCardContainer = 0,
        RightSlot = 0,
        ItemRow = 0,
        OptionsButtonsView = 0,
        OptionsButtonsDivider = 0
    }
    local var9

    if FFlagAXDurables2Option then
        var9 = nil
    else
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = { tag = "auto-xy fill", LayoutOrder = 1 }
        local tbl5 = {
            CatalogRowItemCard = React.createElement(CatalogRowItemCard, {
                title = arg1.name,
                presentationSlot = React.createElement(
                    ItemCardThumbnail,
                    {
                        url = `rbxthumb://type={thumbnailType}&id={arg1.itemId}&w=150&h=150`
                    }
                ),
                onActivated = arg1.onActivated,
                creator = not FFlagAXMISSmallUIChanges and {
                    name = arg1.creatorName,
                    verified = arg1.creatorVerified
                } or nil,
                priceLineContent = priceLineContent,
                itemType = arg1.itemRestriction,
                itemSubType = itemSubType,
                timedOptions = if FFlagAXDurablesForMIS then arg1.timedOptions else nil,
                expirationTime = if FFlagAXDurablesForMIS then arg1.expirationTime else nil,
                isOwned = if FFlagAXDurablesForMIS then arg1.isOwned else nil,
                onTimedOptionPriceChanged = if FFlagAXDurablesForMIS then arg1.onTimedOptionPriceChanged else nil,
                selectedTimedOptionPrice = if FFlagAXDurablesForMIS then selectedTimedOptionPrice else nil,
                setSelectedTimedOptionPrice = if FFlagAXDurablesForMIS then setSelectedTimedOptionPrice else nil,
                selectedTimedOptionIndexInReducer = if FFlagAXDurablesForMIS then arg1.selectedTimedOptionIndexInReducer else nil,
                wearTimeSelectedOptionInList = if FFlagAXDurablesForMIS then WearTimeSelectedOptionInList else nil,
                headerSize = UDim2.fromOffset(var2, var2),
                footerSize = UDim2.fromScale(0, 1),
                footerAutomaticSize = Enum.AutomaticSize.XY,
                AutomaticSize = Enum.AutomaticSize.XY,
                offersLocalized = if FFlagAXMISOffersChip then offersLocalized else nil,
                offerApplied = if FFlagAXMISOffersChip then arg1.offerApplied else nil
            })
        }
        var9 = createElement2(view2, tbl4, tbl5)
    end

    tbl3.RowItemCardContainer = var9
    local element3

    if FFlagAXDurables2Option then
        element3 = nil
    else
        element3 = React.createElement(Foundation.View, {
            tag = FFlagAXGifting and {
                ["row self-center gap-small anchor-top-right auto-xy"] = true
            }
                or "auto-xy anchor-top-right self-center",
            LayoutOrder = 2
        }, {
            GiftButton = if FFlagAXGifting then element2 else nil,
            RemoveButton = if arg1.onRemove then React.createElement(Foundation.IconButton, {
                icon = "x",
                isCircular = true,
                variant = Foundation.Enums.ButtonVariant.Standard,
                onActivated = arg1.onRemove,
                LayoutOrder = if FFlagAXGifting then 2 else nil
            }) else nil
        })
    end

    tbl3.RightSlot = element3
    local var10

    if FFlagAXDurables2Option then
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = { tag = "auto-y row size-full-0 gap-small", LayoutOrder = 1 }

        local tbl5 = { RowItemCardContainer = 0 }
        local createElement3 = React.createElement
        local view3 = Foundation.View
        local tbl6 = { tag = "auto-xy fill", LayoutOrder = 1 }
        local tbl7 = { CatalogRowItemCard = 0 }
        local createElement4 = React.createElement
        local var11 = CatalogRowItemCard
        local tbl8 = {
            title = arg1.name,
            presentationSlot = React.createElement(
                ItemCardThumbnail,
                {
                    url = `rbxthumb://type={thumbnailType}&id={arg1.itemId}&w=150&h=150`
                }
            ),
            onActivated = arg1.onActivated,
            onRemove = arg1.onRemove,
            giftButton = 0,
            hideTimedOptionSelections = true,
            creator = 0,
            priceLineContent = 0,
            itemStatusInCheckout = 0,
            itemType = 0,
            itemSubType = 0,
            timedOptions = 0,
            expirationTime = 0,
            isOwned = 0,
            onTimedOptionPriceChanged = 0,
            selectedTimedOptionPrice = 0,
            setSelectedTimedOptionPrice = 0,
            selectedTimedOptionIndexInReducer = 0,
            wearTimeSelectedOptionInList = 0,
            headerSize = 0,
            footerSize = 0,
            footerAutomaticSize = 0,
            AutomaticSize = 0,
            offersLocalized = 0,
            showOfferPillTooltip = 0,
            offerApplied = 0
        }

        if not FFlagAXGifting then
            element2 = nil
        end

        tbl8.giftButton = element2

        tbl8.creator = not FFlagAXMISSmallUIChanges and {
            name = arg1.creatorName,
            verified = arg1.creatorVerified
        } or nil

        tbl8.priceLineContent = priceLineContent
        tbl8.itemStatusInCheckout = arg1.status
        tbl8.itemType = arg1.itemRestriction
        tbl8.itemSubType = itemSubType
        tbl8.timedOptions = if FFlagAXDurablesForMIS then arg1.timedOptions else nil
        tbl8.expirationTime = if FFlagAXDurablesForMIS then arg1.expirationTime else nil
        tbl8.isOwned = if FFlagAXDurablesForMIS then arg1.isOwned else nil
        tbl8.onTimedOptionPriceChanged = if FFlagAXDurablesForMIS then arg1.onTimedOptionPriceChanged else nil

        if not FFlagAXDurablesForMIS then
            selectedTimedOptionPrice = nil
        end

        tbl8.selectedTimedOptionPrice = selectedTimedOptionPrice
        tbl8.setSelectedTimedOptionPrice = if FFlagAXDurablesForMIS then setSelectedTimedOptionPrice else nil

        tbl8.selectedTimedOptionIndexInReducer = if FFlagAXDurablesForMIS then arg1.selectedTimedOptionIndexInReducer else nil

        tbl8.wearTimeSelectedOptionInList = if FFlagAXDurablesForMIS then WearTimeSelectedOptionInList else nil

        tbl8.headerSize = UDim2.fromOffset(var2, var2)
        tbl8.footerSize = UDim2.fromScale(0, 1)
        tbl8.footerAutomaticSize = Enum.AutomaticSize.XY
        tbl8.AutomaticSize = Enum.AutomaticSize.XY
        tbl8.offersLocalized = offersLocalized
        tbl8.showOfferPillTooltip = showOfferPillTooltip
        tbl8.offerApplied = arg1.offerApplied
        tbl7.CatalogRowItemCard = createElement4(var11, tbl8)
        tbl5.RowItemCardContainer = createElement3(view3, tbl6, tbl7)
        var10 = createElement2(view2, tbl4, tbl5)
    else
        var10 = nil
    end

    tbl3.ItemRow = var10

    if not FFlagAXDurables2Option or arg1.isOwned and arg1.expirationTime == nil then
        element = nil
    end

    tbl3.OptionsButtonsView = element

    tbl3.OptionsButtonsDivider = if FFlagAXDurables2Option then React.createElement(
        Foundation.View,
        { tag = "col size-full-0 auto-y padding-y-medium", LayoutOrder = 3 },
        {
            Divider = React.createElement(Foundation.Divider)
        }
    ) else nil
    return createElement(view, tbl2, tbl3)
end, tutils.deepEqual)

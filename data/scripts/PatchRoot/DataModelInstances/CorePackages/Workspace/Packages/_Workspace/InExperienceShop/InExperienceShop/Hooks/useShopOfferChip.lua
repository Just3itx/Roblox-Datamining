-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization
local FFlagHideOfferNotificationsWhenShopEmpty = require(InExperienceShopParent.SharedFlags).FFlagHideOfferNotificationsWhenShopEmpty

local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)
local useOffersForKey = InExperienceOffers.Hooks.useOffersForKey
local selectActiveOffer = InExperienceOffers.Utils.selectActiveOffer
local useRemainingTimeText = InExperienceOffers.Hooks.useRemainingTimeText
local useShopHasItems = InExperienceOffers.Hooks.useShopHasItems
local OfferDialogState = require(InExperienceShop.Components.OfferDialogs.OfferDialogState)
local useCloseOnCoreMenu = require(InExperienceShop.Hooks.useCloseOnCoreMenu)
local useOfferModalText = require(InExperienceShop.Hooks.useOfferModalText)
local FFlagShopCloseOfferDialogOnCoreMenu = require(InExperienceShop.Flags.FFlagShopCloseOfferDialogOnCoreMenu)
local FFlagShowLargerOfferBannerOnDesktop2 = require(InExperienceShop.Flags.FFlagShowLargerOfferBannerOnDesktop2)

local function useShopOfferChip(str1: string, bool1: boolean?)
    local var1 = useOffersForKey(str1)
    local var2 = React.useMemo(function()
        return selectActiveOffer(var1, "banner")
    end, { var1 })

    local banner = if var2 == nil then nil else var2.presentationData.banner
    local var3 = useRemainingTimeText(if var2 then var2.expirationTimeInUTC or nil else nil)

    local var4 = FFlagHideOfferNotificationsWhenShopEmpty and not useShopHasItems()
    local bool2 = not (var2 == nil) and var3 ~= nil

    if var4 then
        bool2 = false
    end

    local var5 = useLocalization({
        offerEndTime = {
            "Feature.InExperienceShop.Label.OfferEndTime",
            offer = if banner == nil then "" else banner.title,
            timeRemaining = var3 or ""
        }
    })
    local var6, icon

    if bool2 and banner ~= nil then
        if bool1 then
            var6 = banner.title
        else
            var6 = var5.offerEndTime
        end

        icon = banner.icon
    else
        var6 = nil
        icon = nil
    end

    local modal = if banner == nil then nil else banner.modal
    local expirationTimeInUtc = if var2 == nil then nil else var2.expirationTimeInUTC
    local tbl1

    if FFlagShowLargerOfferBannerOnDesktop2 then
        local var7 = useOfferModalText
        local var8 = if modal then modal.body else ""

        if not modal then
            var3 = nil
        end

        tbl1 = var7(var8, var3)
    else
        tbl1 = {
            bodyText = if modal then modal.body else "",
            viewTermsText = ""
        }
    end

    local offerDialog, var8 = React.useState(OfferDialogState.None)

    local onOfferChipActivated = React.useCallback(function()
        var8(OfferDialogState.Details)
    end, {})
    local onOfferViewTerms = React.useCallback(function()
        var8(OfferDialogState.Terms)
    end, {})

    local var11 = React.useCallback(function()
        var8(OfferDialogState.None)
    end, {})

    if FFlagShopCloseOfferDialogOnCoreMenu then
        useCloseOnCoreMenu(var11)
    end

    return {
        showOfferChip = bool2,
        offerChipText = var6,
        offerChipIcon = icon,
        offerModal = modal,
        offerExpirationTimeInUTC = expirationTimeInUtc,
        offerBodyText = tbl1.bodyText,
        offerViewTermsText = tbl1.viewTermsText,
        offerDialog = offerDialog,
        onOfferChipActivated = onOfferChipActivated,
        onOfferViewTerms = onOfferViewTerms,
        onOfferShopNow = var11,
        onOfferDetailsClose = var11,
        onOfferTermsClose = var11
    }
end

return useShopOfferChip

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local SafeAppStorageService = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Lib.SafeAppStorageService
local FFlagAXCatalogOffersDismissedStorageKeyFix = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogOffersDismissedStorageKeyFix
local _MarketplaceOffersBannerTypes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.MarketplaceOffersBannerTypes)
local marketplaceOffersBannerDisplay = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.marketplaceOffersBannerDisplay)
local getLocalUserId = require(script.Parent.getLocalUserId)

local getMarketplaceOffersBannerOfferDisplayId = marketplaceOffersBannerDisplay.getMarketplaceOffersBannerOfferDisplayId
local getMarketplaceOffersBannerOfferDisplayTitle = marketplaceOffersBannerDisplay.getMarketplaceOffersBannerOfferDisplayTitle

local STORAGE_KEY = if FFlagAXCatalogOffersDismissedStorageKeyFix then "AXCatalogOffersDismissed" else "AXCatalogOffersBannerDismissed"

local bool1 = game:DefineFastFlag("AXCatalogOffersBannerAppStorageUseMemStorage", false)

local function normalizeOfferId(str2: string?): string -- Luacid: Inlined by compiler; 5 call sites recovered
    return str2 or ""
end

local function offerIdMapContains(tbl1, str2: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return tbl1[str2] == true
end

local function coerceDecodedToOfferIdMapStorage(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end
    local tbl1 = ({})
    local bool2 = false
    for value, value2 in arg1 do
        if typeof(value) ~= "string" or typeof(value2) ~= "table" then
            continue
        end

        local tbl2 = ({})
        for value3, value4 in value2 do
            if typeof(value3) == "string" and value4 == true then
                tbl2[value3] = true
            end
        end
        tbl1[value] = tbl2
        bool2 = true
    end

    return if bool2 then tbl1 else nil
end

local function readStorageRecord(str2: string, func1: (...any) -> (...any))
    local item = SafeAppStorageService.getItem(str2, bool1)
    if not item or item == "" then
        return nil
    end
    local success, result = pcall(function()
        return HttpService:JSONDecode(item)
    end)
    if not success then
        return nil
    end
    return func1(result)
end

local function readDismissStorage() -- Luacid: Inlined by compiler; 2 call sites recovered
    return readStorageRecord(STORAGE_KEY, coerceDecodedToOfferIdMapStorage)
end

local function readSheetFtuxStorage() -- Luacid: Inlined by compiler; 2 call sites recovered
    return readStorageRecord("AXCatalogOffersSheetFTUX", coerceDecodedToOfferIdMapStorage)
end

local function resolveVisibleOffer(arg1)
    local localUserId = getLocalUserId(Players)

    local tbl1 = {}
    if localUserId ~= nil then
        local var1 = readDismissStorage()

        if var1 and var1[localUserId] then
            tbl1 = var1[localUserId]
        end
    end

    for _, offer in arg1.offers do
        local marketplaceOffersBannerOfferDisplayTitle = getMarketplaceOffersBannerOfferDisplayTitle(offer)
        if not marketplaceOffersBannerOfferDisplayTitle or marketplaceOffersBannerOfferDisplayTitle == "" then
            continue
        end

        local str2 = normalizeOfferId((getMarketplaceOffersBannerOfferDisplayId(offer)))

        if localUserId == nil or not offerIdMapContains(tbl1, str2) then
            return offer
        end
    end

    return nil
end

return {
    STORAGE_KEY = STORAGE_KEY,
    SHEET_FTUX_STORAGE_KEY = "AXCatalogOffersSheetFTUX",
    readDismissStorage = readDismissStorage,
    readSheetFtuxStorage = readSheetFtuxStorage,
    dismissRecordMatchesPayload = function(tbl1, tbl2): boolean
        local str2 = normalizeOfferId(tbl2.offerId)
        return not (tbl1[tbl2.userId] == nil) and not not offerIdMapContains(tbl1[tbl2.userId], str2)
    end,
    dismissedOfferIdsContains = offerIdMapContains,
    normalizeOfferIdForStorage = normalizeOfferId,
    resolveVisibleOffer = resolveVisibleOffer,
    shouldHydrateDismissed = function(arg1): boolean
        return not (getLocalUserId(Players) == nil) and resolveVisibleOffer(arg1) == nil
    end,
    shouldAutoOpenOfferSheetForCurrentOffer = function(str2: string?): boolean
        local localUserId = getLocalUserId(Players)
        if localUserId == nil then
            return false
        end

        local var1 = readSheetFtuxStorage()
        return var1 == nil or var1[localUserId] == nil or not offerIdMapContains(var1[localUserId], (normalizeOfferId(str2)))
    end,
    writeDismissedForCurrentOffer = function(str2: string?)
        local localUserId = getLocalUserId(Players)
        if localUserId == nil then
            return
        end

        local str3 = normalizeOfferId(str2)

        local input = readDismissStorage() or {}

        local tbl1 = input[localUserId]
        if tbl1 == nil then
            tbl1 = {}
            input[localUserId] = tbl1
        end
        tbl1[str3] = true
        pcall(function()
            local str4 = HttpService:JSONEncode(input)
            SafeAppStorageService.setItem(STORAGE_KEY, str4, bool1)
            SafeAppStorageService.flush()
        end)
    end,
    writeSeenOfferSheetForCurrentOffer = function(str2: string?)
        local localUserId = getLocalUserId(Players)
        if localUserId == nil then
            return
        end

        local str3 = normalizeOfferId(str2)

        local input = readSheetFtuxStorage() or {}

        local tbl1 = input[localUserId]
        if tbl1 == nil then
            tbl1 = {}
            input[localUserId] = tbl1
        end
        tbl1[str3] = true
        pcall(function()
            local str4 = HttpService:JSONEncode(input)
            SafeAppStorageService.setItem("AXCatalogOffersSheetFTUX", str4, bool1)

            SafeAppStorageService.flush()
        end)
    end
}

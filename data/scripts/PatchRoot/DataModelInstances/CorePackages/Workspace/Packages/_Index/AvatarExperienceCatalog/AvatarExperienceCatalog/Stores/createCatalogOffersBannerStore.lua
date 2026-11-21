-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Players = game:GetService("Players")

local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2
local FFlagAXCatalogOffersBannerMockApi = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogOffersBannerMockApi
local PurchasePromptLite = require(AvatarExperienceCatalogParent.PurchasePromptLite)
local Signals = require(AvatarExperienceCatalogParent.Signals)
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local Constants = require(AvatarExperienceCatalog.Constants)
local getMarketplaceOffersBanner = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.getMarketplaceOffersBanner).getMarketplaceOffersBanner
local mockGetOffersForUser = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.mockGetOffersForUser).mockGetOffersForUser
local _MarketplaceOffersBannerTypes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.MarketplaceOffersBannerTypes)
local getLocalUserId = require(AvatarExperienceCatalog.Utils.getLocalUserId)

local function createCatalogOffersBannerStore()
    local getPayload, setPayload = Signals.createSignal(nil)
    local getDismissed, setDismissed = Signals.createSignal(false)
    local getOffersFetchInProgress, var6 = Signals.createSignal(false)
    local getHasCompletedOffersFetch, var8 = Signals.createSignal(false)

    local var9 = nil

    local function fetchOffers(func1: (...any) -> (...any), arg1)
        var9 = func1
        var6(true)

        local bool1 = false
        local bool2 = false
        local var10 = nil

        local function finishOnce(bool3: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool2 then
                return
            end
            bool2 = true
            var6(false)
            if not bool3 then
                var8(true)
            end
        end

        local function cleanup()
            if bool1 then
                return
            end
            bool1 = true
            if var10 then
                var10()
            end

            finishOnce(true)
        end

        if FFlagAXCatalogOffersBannerMockApi then
            local var11, var12 = mockGetOffersForUser()
            var10 = var12

            var11:andThen(function(arg2)
                if not bool1 and arg2 then
                    sendAXCounterV2(Constants.COUNTERS.CatalogOffersBanner.fetchSucceeded)
                    setPayload(arg2)
                end
                finishOnce(bool1)
            end):catch(function(arg2)
                if not bool1 then
                    sendAXCounterV2(Constants.COUNTERS.CatalogOffersBanner.fetchFailed)
                    warn("[catalogOffersBannerStore] mock failed:", arg2)
                end
                finishOnce(bool1)
            end)
            return cleanup
        end

        local localUserId = getLocalUserId(Players)
        if localUserId == nil then
            warn("[catalogOffersBannerStore] no LocalPlayer; skipping offers fetch")
            finishOnce(false)
            return function() end
        end

        local var11, var12 = getMarketplaceOffersBanner(localUserId, func1, arg1)
        var10 = var12

        var11:andThen(function(arg2)
            if not bool1 then
                if arg2 then
                    sendAXCounterV2(Constants.COUNTERS.CatalogOffersBanner.fetchSucceeded)
                end
                setPayload(arg2)
            end
            finishOnce(bool1)
        end):catch(function(arg2)
            if not bool1 then
                sendAXCounterV2(Constants.COUNTERS.CatalogOffersBanner.fetchFailed)
                warn("[catalogOffersBannerStore] fetch failed:", arg2)
            end
            finishOnce(bool1)
        end)
        return cleanup
    end

    PurchasePromptLite.Events.purchaseCompletedEvent:Connect(function()
        if var9 and not getOffersFetchInProgress(false) then
            fetchOffers(var9, "cart")
        end
    end)

    return {
        getPayload = getPayload,
        setPayload = setPayload,
        getDismissed = getDismissed,
        setDismissed = setDismissed,
        getHasCompletedOffersFetch = getHasCompletedOffersFetch,
        getOffersFetchInProgress = getOffersFetchInProgress,
        fetchOffers = fetchOffers,
        notifyPurchaseCompleted = function() end
    }
end

return createCatalogOffersBannerStore

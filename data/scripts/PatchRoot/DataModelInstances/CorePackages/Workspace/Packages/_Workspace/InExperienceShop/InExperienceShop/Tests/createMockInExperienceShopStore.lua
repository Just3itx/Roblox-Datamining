-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local jest = require(InExperienceShopParent.Dev.JestGlobals).jest
local Promise = require(InExperienceShopParent.Promise)
local Signals = require(InExperienceShopParent.Signals)

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local _BonusPromotionEligibility = require(InExperienceShop.Api.BonusPromotionEligibility)

local function createMockInExperienceShopStore()
    local getCategories, setCategories = Signals.createSignal({})
    local getSections, setSections = Signals.createSignal({})
    local getLoading, setLoading = Signals.createSignal(false)
    local getError, setError = Signals.createSignal(nil)
    local getOwnership, setOwnership = Signals.createSignal({})

    local getTrialAvailabilities, setTrialAvailabilities = Signals.createSignal({ available = {}, active = {}, redeemed = {} })
    local getTrialAvailabilityPhase, setTrialAvailabilityPhase = Signals.createSignal("settled")
    local getTrialRedemptionInFlight, setTrialRedemptionInFlight = Signals.createSignal({})

    local getTrialRedeemThumbnail, setTrialRedeemThumbnail = Signals.createSignal(nil)
    local getTrialRedeemSuccessCount, setTrialRedeemSuccessCount = Signals.createSignal(0)
    local getNotificationFreeTrialTopBarChip, setNotificationFreeTrialTopBarChip = Signals.createSignal(false)
    local getPurchasedOwnedGamePass, setPurchasedOwnedGamePass = Signals.createSignal(nil)

    local getTrialRedemptionError, setTrialRedemptionError = Signals.createSignal(nil)

    local getBonusPromotionEligibility, setBonusPromotionEligibility = Signals.createSignal({})

    local getItemsPerRow, setItemsPerRow = Signals.createSignal(Constants.MIN_COLUMNS)
    local getShouldOpenToRobuxTab, setShouldOpenToRobuxTab = Signals.createSignal(false)
    local getOpenedFromBuyRobux, setOpenedFromBuyRobux = Signals.createSignal(false)

    local getPurchasedRobuxAmount, setPurchasedRobuxAmount = Signals.createSignal(nil)

    return {
        store = {
            getCategories = getCategories,
            getSections = getSections,
            getLoading = getLoading,
            getError = getError,
            getOwnership = getOwnership,
            getTrialAvailabilities = getTrialAvailabilities,
            getTrialAvailabilityPhase = getTrialAvailabilityPhase,
            getTrialRedemptionInFlight = getTrialRedemptionInFlight,
            getTrialRedeemThumbnail = getTrialRedeemThumbnail,
            getTrialRedeemSuccessCount = getTrialRedeemSuccessCount,
            getNotificationFreeTrialTopBarChip = getNotificationFreeTrialTopBarChip,
            getPurchasedOwnedGamePass = getPurchasedOwnedGamePass,
            getTrialRedemptionError = getTrialRedemptionError,
            dismissTrialRedemptionError = function()
                setTrialRedemptionError(nil)
            end,
            getBonusPromotionEligibility = getBonusPromotionEligibility,
            getItemsPerRow = getItemsPerRow,
            getShouldOpenToRobuxTab = getShouldOpenToRobuxTab,
            getOpenedFromBuyRobux = getOpenedFromBuyRobux,
            getPurchasedRobuxAmount = getPurchasedRobuxAmount,
            dismissRobuxPurchaseSuccess = function()
                setPurchasedRobuxAmount(nil)
            end,
            onShopOpened = jest.fn(),
            fetchAllShopData = jest.fn(),
            prefetchWidgetsOnly = jest.fn(),
            refreshShopItemInfo = jest.fn(),
            refreshRobuxWidgetsAfterPurchase = jest.fn(),
            fetchGamePassOwnership = jest.fn(),
            currentlyOwnsGamePass = jest.fn(function()
                return Promise.resolve(false)
            end),
            redeemGamePassTrial = jest.fn(),
            pollGamePassOwnership = jest.fn(),
            bonusGamePassIdForNativePurchase = jest.fn(),
            setItemsPerRow = setItemsPerRow,
            setShouldOpenToRobuxTab = setShouldOpenToRobuxTab,
            setOpenedFromBuyRobux = setOpenedFromBuyRobux
        },
        setCategories = setCategories,
        setSections = setSections,
        setLoading = setLoading,
        setError = setError,
        setOwnership = setOwnership,
        setTrialAvailabilities = setTrialAvailabilities,
        setTrialAvailabilityPhase = setTrialAvailabilityPhase,
        setTrialRedemptionInFlight = setTrialRedemptionInFlight,
        setTrialRedeemThumbnail = setTrialRedeemThumbnail,
        setTrialRedeemSuccessCount = setTrialRedeemSuccessCount,
        setNotificationFreeTrialTopBarChip = setNotificationFreeTrialTopBarChip,
        setPurchasedOwnedGamePass = setPurchasedOwnedGamePass,
        setTrialRedemptionError = setTrialRedemptionError,
        setBonusPromotionEligibility = setBonusPromotionEligibility,
        setItemsPerRow = setItemsPerRow,
        setPurchasedRobuxAmount = setPurchasedRobuxAmount
    }
end

return createMockInExperienceShopStore

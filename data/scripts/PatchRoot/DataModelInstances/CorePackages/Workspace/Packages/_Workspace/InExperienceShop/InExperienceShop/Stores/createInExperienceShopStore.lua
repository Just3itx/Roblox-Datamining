-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local SharedFlags = require(InExperienceShopParent.SharedFlags)
local Signals = require(InExperienceShopParent.Signals)
local PioneerInfo = require(InExperienceShopParent.PioneerUtils).PioneerInfo
local createSignal = Signals.createSignal
local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)
local FFlagEnableOffersPrefetch = SharedFlags.FFlagEnableOffersPrefetch
local FFlagOfferNineDotActivityIndicator = SharedFlags.FFlagOfferNineDotActivityIndicator
local FFlagOfferNotifyOnGlobalIcon = SharedFlags.FFlagOfferNotifyOnGlobalIcon
local FFlagHideOfferNotificationsWhenShopEmpty = SharedFlags.FFlagHideOfferNotificationsWhenShopEmpty

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local hasOfferEligibleCategory = require(InExperienceShop.Utils.hasOfferEligibleCategory)
local Errors = require(InExperienceShop.Api.Errors)
local fetchAllShopData = require(InExperienceShop.Api.fetchAllShopData)
local fetchShopWidgetsOnly = require(InExperienceShop.Api.fetchShopWidgetsOnly)
local fetchRobuxWidgetsAfterPurchase = require(InExperienceShop.Api.fetchRobuxWidgetsAfterPurchase)
local mergeRobuxShopData = require(InExperienceShop.Api.mergeRobuxShopData)
local multiGetProductInfo = require(InExperienceShop.Api.multiGetProductInfo)
local streamMultiGetProductInfo = require(InExperienceShop.Api.streamMultiGetProductInfo)
local logCounter = require(InExperienceShop.Internal.logCounter)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local ProductInfoFailedItemsCounter = require(InExperienceShop.Events.ProductInfoFailedItemsCounter)
local userOwnsGamePass = require(InExperienceShop.Api.userOwnsGamePass)
local userOwnsGamePassHttp = require(InExperienceShop.Api.userOwnsGamePassHttp)
local fetchGamePassTrialAvailabilities = require(InExperienceShop.Api.fetchGamePassTrialAvailabilities)
local redeemGamePassTrial = require(InExperienceShop.Api.redeemGamePassTrial)
local getPassOwnership = require(InExperienceShop.Api.getPassOwnership)
local FFlagShopUseMockData = require(InExperienceShop.Flags.FFlagShopUseMockData)
local FFlagShopUseMockUserOwnsGamePass = require(InExperienceShop.Flags.FFlagShopUseMockUserOwnsGamePass)
local FFlagShopUseMockGamePassTrialAvailabilities = require(InExperienceShop.Flags.FFlagShopUseMockGamePassTrialAvailabilities)
local FFlagShopUseMockGamePassTrialRedemption = require(InExperienceShop.Flags.FFlagShopUseMockGamePassTrialRedemption)
local FFlagMockGetGamePassOwnership = require(InExperienceShop.Flags.FFlagMockGetGamePassOwnership)
local FFlagUseGetGamePassOwnershipApi = SharedFlags.FFlagUseGetGamePassOwnershipApi
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local FFlagEnableFreeTrialTopBarChip = require(InExperienceShop.Flags.FFlagEnableFreeTrialTopBarChip)
local FFlagEnableGamePassTrialUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableGamePassTrialUnifiedLogging)
local FFlagCloseShopOnTrialRedemption = require(InExperienceShop.Flags.FFlagCloseShopOnTrialRedemption)
local FFlagShopUseMockMultiGetProductInfo = require(InExperienceShop.Flags.FFlagShopUseMockMultiGetProductInfo)
local FFlagEnableShopProductInfoRefresh = require(InExperienceShop.Flags.FFlagEnableShopProductInfoRefresh)
local FFlagEnableShopExposureLogging = require(InExperienceShop.Flags.FFlagEnableShopExposureLogging)
local FFlagEnableShopFlagLinkedExposureLogging = require(InExperienceShop.Flags.FFlagEnableShopFlagLinkedExposureLogging)
local FStringExperienceShopFlagLinkedLayer = require(InExperienceShop.Flags.FStringExperienceShopFlagLinkedLayer)
local FStringExperienceShopLayer1 = require(InExperienceShop.Flags.FStringExperienceShopLayer1)
local FStringExperienceShopLayer2 = require(InExperienceShop.Flags.FStringExperienceShopLayer2)
local FFlagRefetchRobuxWidgetAfterPurchase = require(InExperienceShop.Flags.FFlagRefetchRobuxWidgetAfterPurchase)
local FFlagRefetchShopWidgetsAfterPassPurchase = require(InExperienceShop.Flags.FFlagRefetchShopWidgetsAfterPassPurchase)
local FFlagSkipPaymentSessionForPlainRobux = require(InExperienceShop.Flags.FFlagSkipPaymentSessionForPlainRobux)
local FFlagEnablePartialDisplayInExperienceShop = require(InExperienceShop.Flags.FFlagEnablePartialDisplayInExperienceShop)
local _FFlagPromoteRobuxInTopPicks = require(InExperienceShop.Flags.FFlagPromoteRobuxInTopPicks)
local FFlagEnableRobuxInExperienceShop = SharedFlags.FFlagEnableRobuxInExperienceShop
local FFlagLuaAppEnableNativePurchaseFinishedV2Signals = SharedFlags.FFlagLuaAppEnableNativePurchaseFinishedV2Signals
local FFlagShopListenNativePurchaseFinished = require(InExperienceShop.Flags.FFlagShopListenNativePurchaseFinished)
local FFlagShopRobuxPurchaseCompletionModal = require(InExperienceShop.Flags.FFlagShopRobuxPurchaseCompletionModal)
local FIntShopOwnershipFetchMaxAttempts = require(InExperienceShop.Flags.FIntShopOwnershipFetchMaxAttempts)
local MockFetchAllShopData = require(InExperienceShop.Mocks.MockFetchAllShopData)
local MockMultiGetProductInfo = require(InExperienceShop.Mocks.MockMultiGetProductInfo)
local MockUserOwnsGamePass = require(InExperienceShop.Mocks.MockUserOwnsGamePass)
local MockGamePassTrialAvailabilities = require(InExperienceShop.Mocks.MockGamePassTrialAvailabilities)
local MockGetPassOwnership = require(InExperienceShop.Mocks.MockGetPassOwnership)
local promoteBonusRobuxPackageToTopPicks = require(InExperienceShop.Api.promoteBonusRobuxPackageToTopPicks)
local BonusPromotionEligibility = require(InExperienceShop.Api.BonusPromotionEligibility)
local sortRobuxPackagesByAmountDescending = require(InExperienceShop.Utils.sortRobuxPackagesByAmountDescending)
local findTopPicksSectionIndex = require(InExperienceShop.Utils.findTopPicksSectionIndex)
local moveItemToPositionInShop = require(InExperienceShop.Utils.moveItemToPositionInShop)
local parseGamePassTrialRedeemErrorCode = require(InExperienceShop.Utils.parseGamePassTrialRedeemErrorCode)

local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)

local FFlagInExperienceShopExpectStringMetadataValues = require(InExperienceShop.Flags.FFlagInExperienceShopExpectStringMetadataValues)

local tbl1 = { InExperienceOffers.FeatureKeys.RobloxShop }

local function isValidShopData(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return type(arg1) == "table" and type(arg1.categories) == "table" and type(arg1.sections) == "table"
end

local function isPartialDisplayEnabled() -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = FFlagEnablePartialDisplayInExperienceShop
    if typeof(var1) == "function" then
        return (var1())
    end

    return var1
end

local function createInExperienceShopStore()
    local getCategories, var2 = createSignal({})
    local getSections, var4 = createSignal({})
    local getLoading, var6 = createSignal(false)
    local getError, var8 = createSignal(nil)
    local getMetadata, var10 = createSignal(nil)
    local getGlobalIconBackendEnabled, var12 = createSignal(false)
    local getGlobalIconHasNewOffers, var14 = createSignal(false)
    local getNotificationFreeTrialTopBarChip, var16 = createSignal(false)

    local getOwnership, var18 = createSignal({})

    local getTrialAvailabilities, var20 = createSignal({ available = {}, active = {}, redeemed = {} })

    local getBonusPromotionEligibility, var22 = createSignal({})

    local getItemsPerRow, var24 = createSignal(Constants.MIN_COLUMNS)

    local getPurchasedRobuxAmount, var26 = createSignal(nil)

    local tbl2 = ({})

    local bool1 = false

    local bool2 = false

    local getTrialAvailabilityPhase, var28 = createSignal(FFlagEnableGamePassTrialUnifiedLogging and FFlagLuaAppEnableGamePassFreeTrials and "pending" or "settled")

    local bool3 = false

    local var29 = nil
    local var30 = nil
    local var31 = nil

    local tbl3 = ({})
    local bool4 = false

    local function bonusGamePassIdForNativePurchase(str1: string?, str2: string, num1: number?)
        if str2 == "" then
            ShopDebugLogger.log("bonusGamePassIdForNativePurchase: skip, empty store SKU")
            return
        end
        if FFlagRefetchRobuxWidgetAfterPurchase then
            if str1 == nil or str1 == "" then
                str1 = nil
            end

            var29 = str1
        else
            var29 = str1
        end
        var30 = str2
        if FFlagShopRobuxPurchaseCompletionModal then
            if not PioneerInfo.isDaveyBazooka() or num1 == nil or not (num1 > 0) then
                num1 = nil
            end

            var31 = num1

            var26(nil)
        end
        ShopDebugLogger.logLazy(function(): string
            return "bonusGamePassIdForNativePurchase: recorded bonusGamePassId=" .. tostring(var29) .. " storeSku=" .. str2
        end)
    end

    local bool5 = false
    local bool6 = false
    local bool7 = false
    local bool8 = false
    local num1 = 0
    local num2 = 0

    local bool9 = false

    local tbl4 = {}

    local tbl5 = {}

    local tbl6 = ({})
    local tbl7 = ({})

    local getShouldOpenToRobuxTab, setShouldOpenToRobuxTab = createSignal(false)

    local getOpenedFromBuyRobux, setOpenedFromBuyRobux = createSignal(false)

    local function commitBonusPromotionEligibility(str1: string, arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
        tbl6[str1] = arg1
        var22(table.clone(tbl6))
    end

    local function sortRobuxPackagesInSections(tbl8)
        local bool10 = false
        for _, value in tbl8 do
            local robuxPackages = value.robuxPackages
            if robuxPackages ~= nil and #robuxPackages > 1 then
                bool10 = true
                break
            end
        end

        if not bool10 then
            return tbl8
        end

        local var36 = table.clone(tbl8)
        for i, value in ipairs(tbl8) do
            local robuxPackages = value.robuxPackages
            if robuxPackages == nil or #robuxPackages <= 1 then
                continue
            end

            local tbl9 = {
                id = value.id,
                name = value.name,
                items = value.items,
                categoryType = value.categoryType,
                stableCategoryId = value.stableCategoryId,
                categoryGroup = value.categoryGroup,
                paymentSessionId = value.paymentSessionId,
                bonusJwt = value.bonusJwt,
                robuxPackages = sortRobuxPackagesByAmountDescending(robuxPackages),
                featuredRobuxPackage = value.featuredRobuxPackage
            }
            var36[i] = tbl9
        end

        return var36
    end

    local function reapplyFeaturedPromotion() -- Luacid: Inlined by compiler; 17 call sites recovered
        local var36 = promoteBonusRobuxPackageToTopPicks.promoteBonusRobuxPackageToTopPicks(tbl5, tbl6)

        var4((sortRobuxPackagesInSections(var36)))
    end

    local function bumpRedeemedTrialToTopPicks(gamePassId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local topPicksSectionIndex = findTopPicksSectionIndex(tbl5)
        if topPicksSectionIndex ~= nil then
            tbl5 = moveItemToPositionInShop(tbl5, topPicksSectionIndex, gamePassId, "GamePass", 1)
        end

        reapplyFeaturedPromotion()
    end

    local function writeOwnership(str1: string, bool10: boolean)
        local var36 = table.clone(getOwnership(false))
        var36[str1] = bool10
        var18(var36)

        if not (bool10 and FFlagEnableRobuxInExperienceShop) then
            return
        end
        local firstBonusRobuxPackage = promoteBonusRobuxPackageToTopPicks.findFirstBonusRobuxPackage(tbl5)
        local bonusGamePassId = if firstBonusRobuxPackage == nil then nil else promoteBonusRobuxPackageToTopPicks.getBonusGamePassId(firstBonusRobuxPackage)

        if bonusGamePassId == nil or bonusGamePassId ~= str1 then
            return
        end
        commitBonusPromotionEligibility(str1, BonusPromotionEligibility.Ineligible)
        reapplyFeaturedPromotion()
    end

    local function fetchOwnedGamePass(num3: number)
        if not FFlagUseGetGamePassOwnershipApi then
            return (if FFlagShopUseMockUserOwnsGamePass then MockUserOwnsGamePass else userOwnsGamePass)(num3)
        end

        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            return Promise.reject("fetchOwnedGamePass: no LocalPlayer")
        elseif FFlagMockGetGamePassOwnership then
            return MockGetPassOwnership.getPassOwnership(localPlayer, num3)
        end
        return getPassOwnership.getPassOwnership(localPlayer, num3):andThen(function(arg1): boolean
            return not (arg1 == nil) and arg1.Owned == true
        end)
    end
    local function currentlyOwnsGamePass(str1: string)
        local var36 = tonumber(str1)
        if var36 == nil then
            return Promise.resolve(false)
        end
        return fetchOwnedGamePass(var36)
    end

    local function fetchGamePassOwnership(str1: string)
        if tbl2[str1] or getOwnership(false)[str1] ~= nil then
            return
        end

        local var36 = tonumber(str1)
        if var36 == nil then
            return
        end
        tbl2[str1] = true
        fetchOwnedGamePass(var36):andThen(function(bool10: boolean)
            if getOwnership(false)[str1] ~= nil then
                return
            end
            writeOwnership(str1, bool10)
        end):catch(function(arg1)
            warn("[Shop] fetchGamePassOwnership failed", str1, tostring(arg1))
        end):finally(function()
            tbl2[str1] = nil
        end)
    end

    local hydrateGamePassTrialAvailabilities = nil

    local function retryTrialsIfRequested() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool3 and bool6 and not (bool2 or bool1) then
            hydrateGamePassTrialAvailabilities()
        end
    end

    hydrateGamePassTrialAvailabilities = function()
        if not FFlagLuaAppEnableGamePassFreeTrials or bool2 or bool1 then
            return
        end

        bool3 = false
        bool1 = true
        local fetchGamePassTrialAvailabilities2 = if FFlagShopUseMockGamePassTrialAvailabilities then MockGamePassTrialAvailabilities.fetchGamePassTrialAvailabilities else fetchGamePassTrialAvailabilities.fetchGamePassTrialAvailabilities

        fetchGamePassTrialAvailabilities2(game.GameId):andThen(function(arg1)
            var20(arg1)
            bool2 = true
            if FFlagEnableGamePassTrialUnifiedLogging then
                var28("settled")
            end
        end):catch(function(arg1)
            if typeof(arg1) == "table" and arg1.errorMessage ~= nil then
                arg1 = arg1.errorMessage
            end

            warn("[Shop] hydrateGamePassTrialAvailabilities failed", arg1)
            if FFlagEnableGamePassTrialUnifiedLogging then
                var28("settled")
            end
        end):finally(function()
            bool1 = false
            retryTrialsIfRequested()
        end)
    end

    local function applyWidgetTrialAvailabilities(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        if not FFlagLuaAppEnableGamePassFreeTrials or FFlagShopUseMockGamePassTrialAvailabilities then
            return false
        end
        local gamePassTrialAvailabilities = arg1.gamePassTrialAvailabilities
        if gamePassTrialAvailabilities == nil or bool2 or bool1 then
            return false
        end
        var20(gamePassTrialAvailabilities)
        bool2 = true
        if FFlagEnableGamePassTrialUnifiedLogging then
            var28("settled")
        end
        return true
    end

    local getTrialRedemptionInFlight, var37 = createSignal({})
    local getTrialRedeemThumbnail, var39 = createSignal(nil)
    local getPurchasedOwnedGamePass, var41 = createSignal(nil)
    local getTrialRedeemSuccessCount, var43 = createSignal(0)
    local function recordRedeemedTrialThumbnail(gamePassId: string, str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
        var39({ image = if str1 == nil then "" else str1, gamePassId = gamePassId })
    end

    local function noteTrialRedeemSucceeded() -- Luacid: Inlined by compiler; 2 call sites recovered
        var43(getTrialRedeemSuccessCount(false) + 1)
    end

    local getTrialRedemptionError, var45 = createSignal(nil)

    local function sendTrialEvent(action: number, elementName: string, itemId: string, tbl8, metadata)
        require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent).send({
            action = action,
            elementName = elementName,
            itemId = itemId,
            shopPageType = tbl8.shopPageType,
            universeId = tbl8.universeId,
            trialStatus = tbl8.trialStatus,
            metadata = metadata
        })
    end

    local function setGamePassTrialRedemptionInFlight(gamePassId: string, bool10: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var46 = table.clone(getTrialRedemptionInFlight(false))
        if bool10 then
            var46[gamePassId] = true
        else
            var46[gamePassId] = nil
        end
        var37(var46)
    end

    local function signalGamePassFreeTrialRedeemed(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            return
        end
        local marketplaceService = MarketplaceService
        local success, result = pcall(function()
            marketplaceService:SignalGamePassFreeTrialRedeemed(localPlayer, num3)
        end)
        if not success then
            warn("[Shop] SignalGamePassFreeTrialRedeemed failed", num3, result)
        end
    end

    local function markGamePassTrialActive(gamePassId: string)
        local var46 = getTrialAvailabilities(false)
        local available = table.clone(var46.available)
        local active = table.clone(var46.active)
        local redeemed = table.clone(var46.redeemed or {})
        available[gamePassId] = nil
        redeemed[gamePassId] = nil
        active[gamePassId] = true
        var20({ available = available, active = active, redeemed = redeemed })
    end

    local function getTrialRedemptionFailureReason(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local var46 = parseGamePassTrialRedeemErrorCode(arg1)
        if var46 ~= nil then
            return var46
        end
        if typeof(arg1) == "table" then
            local errorMessage = arg1.errorMessage
            if type(errorMessage) == "string" then
                return errorMessage
            end
            local responseCode = arg1.responseCode
            if responseCode ~= nil then
                return tostring(responseCode)
            end
        end
        return tostring(arg1)
    end

    local function redeemGamePassTrial2(gamePassId: string, purchaseContext, str1: string?)
        if getTrialRedemptionInFlight(false)[gamePassId] then
            return
        end

        local var46 = typeof(purchaseContext) ~= "table" and {} or purchaseContext
        if FFlagShopUseMockGamePassTrialRedemption then
            if FFlagEnableGamePassTrialUnifiedLogging then
                local sendGamePassTrialUnifiedEvent = require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent)
                sendTrialEvent(sendGamePassTrialUnifiedEvent.clickAction, sendGamePassTrialUnifiedEvent.trialElement, gamePassId, var46)
                sendTrialEvent(
                    sendGamePassTrialUnifiedEvent.successAction,
                    sendGamePassTrialUnifiedEvent.trialElement,
                    gamePassId,
                    var46,
                    { latencyMs = 0 }
                )
            end

            markGamePassTrialActive(gamePassId)
            if FFlagEnableFreeTrialTopBarChip then
                recordRedeemedTrialThumbnail(gamePassId, str1)
            end

            if FFlagCloseShopOnTrialRedemption then
                noteTrialRedeemSucceeded()
            end

            bumpRedeemedTrialToTopPicks(gamePassId)
            local var47 = tonumber(gamePassId)
            if var47 ~= nil then
                signalGamePassFreeTrialRedeemed(var47)
                return
            end

            return
        end

        local var47 = tonumber(gamePassId)
        if var47 == nil then
            warn("[Shop] redeemGamePassTrial skipped, gamePassId is not numeric", gamePassId)
            return
        end

        local bool10 = false
        local num3 = 0
        if FFlagEnableGamePassTrialUnifiedLogging then
            local sendGamePassTrialUnifiedEvent = require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent)
            bool10 = true
            num3 = os.clock()
            sendTrialEvent(sendGamePassTrialUnifiedEvent.clickAction, sendGamePassTrialUnifiedEvent.trialElement, gamePassId, var46)
        end

        setGamePassTrialRedemptionInFlight(gamePassId, true)
        local bool11 = false
        redeemGamePassTrial.redeemGamePassTrial(var47):andThen(function()
            bool11 = true
            if bool10 then
                local sendGamePassTrialUnifiedEvent = require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent)
                local latencyMs = math.floor((os.clock() - num3) * 1000)
                sendTrialEvent(
                    sendGamePassTrialUnifiedEvent.successAction,
                    sendGamePassTrialUnifiedEvent.trialElement,
                    gamePassId,
                    var46,
                    { latencyMs = latencyMs }
                )
            end
            if FFlagEnableFreeTrialTopBarChip then
                recordRedeemedTrialThumbnail(gamePassId, str1)
            end
            if FFlagCloseShopOnTrialRedemption then
                noteTrialRedeemSucceeded()
            end

            bumpRedeemedTrialToTopPicks(gamePassId)
            signalGamePassFreeTrialRedeemed(var47)

            return fetchGamePassTrialAvailabilities.fetchGamePassTrialAvailabilities(game.GameId)
        end):andThen(function(arg1)
            var20(arg1)
            bool2 = true

            if arg1.available[gamePassId] then
                markGamePassTrialActive(gamePassId)
            end
        end):catch(function(arg1)
            warn("[Shop] redeemGamePassTrial failed", gamePassId, tostring(arg1))
            if bool11 then
                markGamePassTrialActive(gamePassId)
            elseif bool10 then
                local sendGamePassTrialUnifiedEvent = require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent)
                local latencyMs = math.floor((os.clock() - num3) * 1000)
                sendTrialEvent(
                    sendGamePassTrialUnifiedEvent.failureAction,
                    sendGamePassTrialUnifiedEvent.trialElement,
                    gamePassId,
                    var46,
                    {
                        latencyMs = latencyMs,
                        failureReason = getTrialRedemptionFailureReason(arg1)
                    }
                )
            end

            if not FFlagLuaAppEnableGamePassFreeTrials or bool11 then
                return
            end

            var45(
                {
                    gamePassId = gamePassId,
                    errorCode = parseGamePassTrialRedeemErrorCode(arg1),
                    purchaseContext = purchaseContext
                }
            )
        end):finally(function()
            setGamePassTrialRedemptionInFlight(gamePassId, false)
        end)
    end

    local function fetchBonusGamePassOwnershipForPromotionId(str1: string)
        if FFlagRefetchRobuxWidgetAfterPurchase and tbl3[str1] then
            ShopDebugLogger.logLazy(function(): string
                return "fetchBonusGamePassOwnershipForPromotion: skip, poll in flight itemId=" .. str1
            end)

            return
        end

        if tbl7[str1] then
            return
        end

        commitBonusPromotionEligibility(str1, BonusPromotionEligibility.Unknown)
        reapplyFeaturedPromotion()
        local var46 = tonumber(str1)
        if var46 == nil then
            commitBonusPromotionEligibility(str1, BonusPromotionEligibility.Ineligible)
            reapplyFeaturedPromotion()
            return
        end

        tbl7[str1] = true
        fetchOwnedGamePass(var46):andThen(function(bool10: boolean)
            local str2 = str1
            local var47 = if bool10 then BonusPromotionEligibility.Ineligible else BonusPromotionEligibility.Eligible
            commitBonusPromotionEligibility(str2, var47)

            if getOwnership(false)[str1] == nil then
                writeOwnership(str1, bool10)
            end

            reapplyFeaturedPromotion()
        end):catch(function(arg1)
            warn("[Shop] fetchBonusGamePassOwnershipForPromotion failed", str1, tostring(arg1))
            commitBonusPromotionEligibility(str1, BonusPromotionEligibility.Ineligible)
            reapplyFeaturedPromotion()
        end):finally(function()
            tbl7[str1] = nil
        end)
    end

    local function fetchBonusGamePassOwnershipForPromotion(tbl8)
        if not FFlagEnableRobuxInExperienceShop then
            return
        end
        local firstBonusRobuxPackage = promoteBonusRobuxPackageToTopPicks.findFirstBonusRobuxPackage(tbl8)
        local bonusGamePassId = if firstBonusRobuxPackage == nil then nil else promoteBonusRobuxPackageToTopPicks.getBonusGamePassId(firstBonusRobuxPackage)

        for _, value in bonusGamePassId == nil and {} or { bonusGamePassId } do
            fetchBonusGamePassOwnershipForPromotionId(value)
        end
    end

    local function applySections(tbl8) -- Luacid: Inlined by compiler; 8 call sites recovered
        tbl5 = promoteBonusRobuxPackageToTopPicks.withoutFeaturedPromotion(tbl8)
        reapplyFeaturedPromotion()
        fetchBonusGamePassOwnershipForPromotion(tbl5)
    end

    local function commitShopMetadata(arg1)
        var16(arg1.notificationFreeTrialTopBarChip == true)
        if not FFlagEnableExperienceShopGlobalIcon then
            return
        end

        local metadata = arg1.metadata
        var10(metadata)
        local inExperienceGlobalIconEnabled = if metadata == nil then nil else metadata.inExperienceGlobalIconEnabled
        var12(
            if FFlagInExperienceShopExpectStringMetadataValues then inExperienceGlobalIconEnabled == "true" else inExperienceGlobalIconEnabled == true
        )
        var14(not (metadata == nil) and metadata.newOffers == true)
    end

    local function publishShopHasItems(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagHideOfferNotificationsWhenShopEmpty then
            InExperienceOffers.getOffersStore(false).setShopHasItems(hasOfferEligibleCategory(arg1.categories))
        end
    end

    local function buildProductInfoRequestsForHydration(tbl8, tbl9)
        local refreshShopItems = require(InExperienceShop.Api.refreshShopItems)
        local hydrateRobuxBonusItems = require(InExperienceShop.Api.hydrateRobuxBonusItems)
        local requestsFromSections = refreshShopItems.buildRequestsFromSections(tbl8)
        if FFlagEnableRobuxInExperienceShop then
            hydrateRobuxBonusItems.appendBonusItemRequests(requestsFromSections, tbl8)
        end
        refreshShopItems.appendFailedItemRequests(requestsFromSections, tbl9)
        return requestsFromSections
    end

    local function applyStreamingProductInfoResult(tbl8, arg1, tbl9)
        local refreshShopItems = require(InExperienceShop.Api.refreshShopItems)
        local hydrateRobuxBonusItems = require(InExperienceShop.Api.hydrateRobuxBonusItems)
        local makeRequestKey = require(InExperienceShop.Api.shopItemMapping).makeRequestKey

        local requestKey = makeRequestKey(arg1.request.id, arg1.request.infoType)
        local tbl10 = {}
        local tbl11 = {}
        for _, value in tbl9 do
            if makeRequestKey(value.id, value.infoType) == requestKey then
                table.insert(tbl10, value)
            else
                table.insert(tbl11, value)
            end
        end

        local var46 = refreshShopItems.mergeProductInfoIntoSections(tbl8, { arg1 })
        if FFlagEnableRobuxInExperienceShop then
            var46 = hydrateRobuxBonusItems.mergeBonusItemDetailsIntoSections(var46, { arg1 })
        end

        local var47, var48 = refreshShopItems.insertRecoveredItemsIntoSections(var46, { arg1 }, tbl10)

        for _, value in var48 do
            table.insert(tbl11, value)
        end

        return var47, tbl11
    end

    local function routeStreamMultiGetProductInfo(tbl8, onResult: (...any) -> (...any))
        if FFlagShopUseMockData and FFlagShopUseMockMultiGetProductInfo then
            return MockMultiGetProductInfo.streamMultiGetProductInfo(tbl8, { onResult = onResult }, 0)
        end
        return streamMultiGetProductInfo(tbl8, { onResult = onResult })
    end

    local function streamProductInfoIntoSections(tbl8, tbl9, tbl10, callback: ((...any) -> (...any))?)
        if #tbl9 == 0 then
            if callback then
                callback(tbl10)
            end
            return
        end

        bool9 = true
        local tbl11 = tbl8
        local tbl12 = tbl10
        local var46 = nil
        local bool10 = false
        local num3 = num2

        local function flushPendingSections()
            bool10 = false
            if var46 ~= nil and num3 == num2 then
                applySections(var46)
            end
            var46 = nil
        end

        local function scheduleFlush(tbl13) -- Luacid: Inlined by compiler; 1 call site recovered
            var46 = tbl13
            if bool10 then
                return
            end
            bool10 = true
            task.delay(0.05, flushPendingSections)
        end

        routeStreamMultiGetProductInfo(tbl9, function(arg1)
            tbl11, tbl12 = applyStreamingProductInfoResult(tbl11, arg1, tbl12)
            scheduleFlush(tbl11)
        end):andThen(function(_)
            bool10 = false
            if var46 ~= nil and num3 == num2 then
                applySections(var46)
            end
            var46 = nil

            if num3 ~= num2 then
                bool9 = false
                if callback then
                    callback(tbl4)
                end
                return
            end
            applySections(tbl11)
            tbl4 = tbl12
            if #tbl12 > 0 then
                logCounter(ProductInfoFailedItemsCounter, #tbl12)
            end
            bool9 = false
            if callback then
                callback(tbl12)
            end
        end):catch(function(arg1)
            warn("[Shop] streamProductInfoIntoSections failed", tostring(arg1))
            bool10 = false
            if var46 ~= nil and num3 == num2 then
                applySections(var46)
            end
            var46 = nil

            bool9 = false
            if callback then
                callback(tbl12)
            end
        end)
    end

    local function finishWidgetFetch(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        bool6 = num3 == num1
        bool8 = not bool6
    end

    local function isFailedItemOnScreen(failedItems)
        if failedItems == nil or #failedItems == 0 then
            return false
        end
        local tbl8 = {}
        for _, value in tbl5 do
            for _, item in value.items do
                tbl8[`{item.itemType}:{item.id}`] = true
            end
        end
        for _, failedItem in failedItems do
            if tbl8[`{failedItem.itemType}:{failedItem.id}`] then
                return true
            end
        end
        return false
    end

    local function runShopFetch(func1: (...any) -> (...any), func2: (...any) -> (...any), str1: string)
        if bool6 or bool5 then
            return
        end
        bool5 = true
        local bool10 = bool8
        local num3 = num1
        if not bool10 then
            var6(true)
            var8(nil)
        end

        local var46 = if FFlagShopUseMockData then func2() else func1()

        var46:andThen(function(arg1)
            if not isValidShopData(arg1) then
                return Errors.rejectSchema(string.format("createInExperienceShopStore: %s payload missing categories/sections", str1), arg1)
            elseif bool10 and isFailedItemOnScreen(arg1.failedItems) then
                warn("[Shop] stale widget refetch missing on-screen items", #arg1.failedItems)
                bool5 = false
            else
                num2 += 1
                var2(arg1.categories)
                applySections(arg1.sections)
                commitShopMetadata(arg1)
                publishShopHasItems(arg1)
                tbl4 = arg1.failedItems or {}
                var6(false)
                bool5 = false
                finishWidgetFetch(num3)

                if not applyWidgetTrialAvailabilities(arg1) then
                    hydrateGamePassTrialAvailabilities()
                end

                if not FFlagEnableOffersPrefetch then
                    InExperienceOffers.getOffersStore(false).fetchOffers(tbl1)
                end
            end
        end):catch(function(arg1)
            if bool10 then
                warn("[Shop] stale widget refetch failed", tostring(arg1))
                bool5 = false
                return
            end
            var8(arg1)
            var2({})
            var4({})

            tbl4 = {}
            var6(false)
            bool5 = false
        end)
    end

    local function runPartialDisplayShopFetch(fetchShopWidgetsOnly2: (...any) -> (...any), fetchShopWidgetsOnly3: (...any) -> (...any), str1: string)
        if bool6 or bool5 then
            return
        end
        bool5 = true
        local num3 = num1
        var6(true)
        var8(nil)
        local var46 = if FFlagShopUseMockData then fetchShopWidgetsOnly3() else fetchShopWidgetsOnly2()

        var46:andThen(function(arg1)
            if not isValidShopData(arg1) then
                return Errors.rejectSchema(string.format("createInExperienceShopStore: %s payload missing categories/sections", str1), arg1)
            end

            var2(arg1.categories)
            applySections(arg1.sections)
            commitShopMetadata(arg1)
            publishShopHasItems(arg1)
            tbl4 = arg1.failedItems or {}
            var6(false)
            bool5 = false
            finishWidgetFetch(num3)

            if not applyWidgetTrialAvailabilities(arg1) then
                hydrateGamePassTrialAvailabilities()
            end

            if not FFlagEnableOffersPrefetch then
                InExperienceOffers.getOffersStore(false).fetchOffers(tbl1)
            end

            local tbl8 = tbl5
            local productInfoRequestsForHydration = buildProductInfoRequestsForHydration(tbl8, tbl4)
            streamProductInfoIntoSections(tbl8, productInfoRequestsForHydration, tbl4, nil)
        end):catch(function(arg1)
            var8(arg1)
            var2({})
            var4({})
            tbl4 = {}
            var6(false)
            bool5 = false
        end)
    end

    local function fetchAllShopData2() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool8 then
            return
        end

        if isPartialDisplayEnabled() then
            runPartialDisplayShopFetch(fetchShopWidgetsOnly, MockFetchAllShopData.fetchShopWidgetsOnly, "fetchAllShopData")
        else
            runShopFetch(fetchAllShopData, MockFetchAllShopData.fetchAllShopData, "fetchAllShopData")
        end
    end

    local function prefetchWidgetsOnly()
        if bool8 then
            return
        end
        runShopFetch(fetchShopWidgetsOnly, MockFetchAllShopData.fetchShopWidgetsOnly, "prefetchWidgetsOnly")
    end

    local function refreshShopItemInfo()
        if not FFlagEnableShopProductInfoRefresh or not bool6 or bool7 or bool9 then
            return
        end

        local refreshShopItems = require(InExperienceShop.Api.refreshShopItems)
        local hydrateRobuxBonusItems = require(InExperienceShop.Api.hydrateRobuxBonusItems)
        local var46 = if #tbl5 > 0 then tbl5 else getSections(false)
        local requestsFromSections = refreshShopItems.buildRequestsFromSections(var46)
        if FFlagEnableRobuxInExperienceShop then
            hydrateRobuxBonusItems.appendBonusItemRequests(requestsFromSections, var46)
        end
        local tbl8 = tbl4
        refreshShopItems.appendFailedItemRequests(requestsFromSections, tbl8)
        if #requestsFromSections == 0 then
            return
        end
        bool7 = true

        if isPartialDisplayEnabled() then
            streamProductInfoIntoSections(var46, requestsFromSections, tbl8, function()
                bool7 = false
            end)
            return
        end

        local var47 = if FFlagShopUseMockData and FFlagShopUseMockMultiGetProductInfo then MockMultiGetProductInfo.multiGetProductInfo(requestsFromSections, 0) else multiGetProductInfo(requestsFromSections)
        local num3 = num2

        var47:andThen(function(arg1)
            if num3 ~= num2 then
                bool7 = false
                return
            end
            local var48 = refreshShopItems.mergeProductInfoIntoSections(var46, arg1)
            if FFlagEnableRobuxInExperienceShop then
                var48 = hydrateRobuxBonusItems.mergeBonusItemDetailsIntoSections(var48, arg1)
            end

            local var49, var50 = refreshShopItems.insertRecoveredItemsIntoSections(var48, arg1, tbl8)
            tbl4 = var50
            applySections(var49)
            bool7 = false
        end):catch(function(arg1)
            warn("[Shop] refreshShopItemInfo failed", tostring(arg1))
            bool7 = false
        end)
    end

    local function onShopOpened()
        if FFlagOfferNineDotActivityIndicator or FFlagOfferNotifyOnGlobalIcon then
            InExperienceOffers.getOffersStore(false).markInExperienceShopOpened()
        end

        if FFlagEnableShopExposureLogging then
            local ixpServiceWrapper = require(InExperienceShopParent.IxpServiceWrapper).IXPServiceWrapper
            for _, value in { FStringExperienceShopLayer1, FStringExperienceShopLayer2 } do
                if value ~= "" then
                    ixpServiceWrapper:LogUserLayerExposure(value)
                end
            end
        end
        if FFlagEnableShopFlagLinkedExposureLogging and FStringExperienceShopFlagLinkedLayer ~= "" then
            require(InExperienceShopParent.IxpServiceWrapper).IXPServiceWrapper:LogFlagLinkedUserLayerExposure(
                FStringExperienceShopFlagLinkedLayer
            )
        end

        if FFlagLuaAppEnableGamePassFreeTrials and not bool2 then
            if bool6 and not bool1 then
                hydrateGamePassTrialAvailabilities()
            else
                bool3 = true
            end
        end
        if bool8 then
            runShopFetch(fetchAllShopData, MockFetchAllShopData.fetchAllShopData, "fetchAllShopData")
        else
            fetchAllShopData2()
        end

        refreshShopItemInfo()
    end

    local function refreshRobuxWidgetsAfterPurchase()
        if not FFlagRefetchRobuxWidgetAfterPurchase then
            return Promise.resolve()
        end
        if not (bool6 or bool8) then
            return Promise.resolve()
        end
        if bool4 then
            return Promise.resolve()
        end
        bool4 = true
        ShopDebugLogger.log("refreshRobuxWidgetsAfterPurchase: start")
        local var46 = if FFlagShopUseMockData then MockFetchAllShopData.fetchRobuxWidgetsAfterPurchase(0) else fetchRobuxWidgetsAfterPurchase.fetchRobuxWidgetsAfterPurchase()

        return var46:andThen(function(arg1)
            if not isValidShopData(arg1) then
                ShopDebugLogger.log("refreshRobuxWidgetsAfterPurchase: skip, invalid payload")
                return
            end

            local var47, var48 = mergeRobuxShopData(getCategories(false), tbl5, arg1)
            var2(var47)
            applySections(var48)
        end):catch(function(arg1)
            ShopDebugLogger.logLazy(function(): string
                return "refreshRobuxWidgetsAfterPurchase: failed err=" .. tostring(arg1)
            end)
        end):finally(function()
            bool4 = false
        end)
    end

    local function markWidgetDataStale() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
        if bool6 then
            bool6 = false
            bool8 = true
        end
    end

    local function pollOwnershipUntilTrue(func1: (...any) -> (...any), num3: number, num4: number, num5: number)
        return func1(num3):andThen(function(bool10: boolean)
            if bool10 then
                return true
            elseif num4 <= 1 then
                return false
            end
            return Promise.delay(num5):andThen(function()
                return pollOwnershipUntilTrue(func1, num3, num4 - 1, num5 * Constants.POLL_BACKOFF_MULTIPLIER)
            end)
        end):catch(function(arg1)
            if not (num4 <= 1) then
                return Promise.delay(num5):andThen(function()
                    return pollOwnershipUntilTrue(func1, num3, num4 - 1, num5 * Constants.POLL_BACKOFF_MULTIPLIER)
                end)
            end

            warn("[Shop] pollOwnershipUntilTrue exhausted with engine error", num3, tostring(arg1))
            return nil
        end)
    end

    local function pollGamePassOwnershipAfterPurchase(str1: string, num3: number, func1: (...any) -> (...any), bool10: boolean?, callback: ((...any) -> (...any))?)
        if tbl3[str1] then
            ShopDebugLogger.logLazy(function(): string
                return "pollGamePassOwnership: already in flight itemId=" .. str1
            end)
            return
        end
        local gamePassId = tonumber(str1)
        if gamePassId == nil then
            ShopDebugLogger.logLazy(function(): string
                return "pollGamePassOwnership: skip invalid itemId=" .. str1
            end)
            return
        end

        tbl3[str1] = true
        ShopDebugLogger.logLazy(function(): string
            return "pollGamePassOwnership: start itemId=" .. str1 .. " maxAttempts=" .. tostring(num3) .. " signalOnSuccess=" .. tostring(bool10 == true)
        end)

        local function startPoll()
            pollOwnershipUntilTrue(func1, gamePassId, num3, Constants.POLL_INITIAL_DELAY_SECONDS):andThen(function(bool11: boolean?)
                ShopDebugLogger.logLazy(function(): string
                    return "pollGamePassOwnership: result itemId=" .. str1 .. " owned=" .. tostring(bool11)
                end)
                if bool11 ~= true then
                    return
                end
                writeOwnership(str1, bool11)
                if FFlagRefetchShopWidgetsAfterPassPurchase then
                    markWidgetDataStale()
                end

                if callback ~= nil then
                    callback(str1)
                end

                if not bool10 then
                    return
                end

                local localPlayer = Players.LocalPlayer
                if localPlayer ~= nil then
                    ShopDebugLogger.logLazy(function(): string
                        return "pollGamePassOwnership: SignalPromptGamePassPurchaseFinished itemId=" .. str1
                    end)
                    MarketplaceService:SignalPromptGamePassPurchaseFinished(localPlayer, gamePassId, true)
                end
            end):finally(function()
                tbl3[str1] = nil
            end)
        end

        Promise.delay(Constants.POLL_INITIAL_DELAY_SECONDS):andThen(startPoll)
    end

    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamePassId: number, wasPurchased: boolean)
        if not wasPurchased then
            return
        end
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil or player.UserId ~= localPlayer.UserId then
            return
        end

        local var46 = FFlagEnableFreeTrialTopBarChip and function(gamePassId2: string)
            var41({ gamePassId = gamePassId2 })
        end or nil

        pollGamePassOwnershipAfterPurchase(
            tostring(gamePassId),
            FIntShopOwnershipFetchMaxAttempts,
            fetchOwnedGamePass,
            nil,
            var46
        )
    end)

    if FFlagShopListenNativePurchaseFinished and FFlagEnableRobuxInExperienceShop then
        local function pollBonusOwnershipAfterNativeRobuxPurchase(bool10: boolean, arg1, arg2)
            if arg2 ~= nil then
                local localPlayer = Players.LocalPlayer
                if localPlayer == nil or arg2.UserId ~= localPlayer.UserId then
                    ShopDebugLogger.log("NativePurchaseFinished: ignored, not local player")
                    return
                end
            end
            local var46 = var29
            local var47 = var30
            local var48 = var31
            if var47 == nil
                or not FFlagRefetchRobuxWidgetAfterPurchase
                    and var46 == nil
                    and (not FFlagShopRobuxPurchaseCompletionModal or var48 == nil)
            then
                ShopDebugLogger.log("NativePurchaseFinished: skip, no pending shop Robux purchase")
                return
            end

            if tostring(arg1) ~= var47 then
                ShopDebugLogger.logLazy(function()
                    return "NativePurchaseFinished: skip, sku mismatch productId=" .. tostring(arg1) .. " pendingStoreSku=" .. var47
                end)

                return
            end

            var29 = nil
            var30 = nil
            var31 = nil
            if not bool10 then
                ShopDebugLogger.logLazy(function(): string
                    return "NativePurchaseFinished: skip, not purchased bonusGamePassId=" .. tostring(var46)
                end)
                return
            end
            if FFlagShopRobuxPurchaseCompletionModal and var48 ~= nil then
                var26(var48)
            end
            if var46 ~= nil then
                ShopDebugLogger.logLazy(function()
                    return "NativePurchaseFinished: polling bonusGamePassId=" .. var46
                end)

                pollGamePassOwnershipAfterPurchase(
                    var46,
                    FIntShopOwnershipFetchMaxAttempts,
                    if FFlagShopUseMockUserOwnsGamePass then MockUserOwnsGamePass else userOwnsGamePassHttp,
                    true
                )
            end

            if FFlagRefetchRobuxWidgetAfterPurchase and (var46 ~= nil or not FFlagSkipPaymentSessionForPlainRobux) then
                refreshRobuxWidgetsAfterPurchase()
            end
        end

        local function onNativePurchaseFinished(arg1, arg2, bool10: boolean, str1: string?)
            ShopDebugLogger.logLazy(function(): string
                return "NativePurchaseFinished: productId=" .. tostring(arg2) .. " wasPurchased=" .. tostring(bool10) .. " checkoutSessionId=" .. tostring(str1)
            end)
            pollBonusOwnershipAfterNativeRobuxPurchase(bool10, arg2, arg1)
        end

        local function onNativePurchaseFinishedWithLocalPlayer(arg1, bool10: boolean, str1: string?)
            ShopDebugLogger.logLazy(function(): string
                return "NativePurchaseFinishedWithLocalPlayer: productId=" .. tostring(arg1) .. " wasPurchased=" .. tostring(bool10) .. " checkoutSessionId=" .. tostring(str1)
            end)
            pollBonusOwnershipAfterNativeRobuxPurchase(bool10, arg1, nil)
        end

        local function connectIfAvailable(rbxScriptSignal, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 4 call sites recovered
            if typeof(rbxScriptSignal) == "RBXScriptSignal" or type(rbxScriptSignal) == "table" and rbxScriptSignal.Connect ~= nil then
                rbxScriptSignal:Connect(func1)
            end
        end

        local marketplaceService = MarketplaceService
        local engineFeature = game:GetEngineFeature("NativePurchaseWithLocalPlayer")
        ShopDebugLogger.logLazy(function(): string
            return "NativePurchaseFinished: connecting v2=" .. tostring(FFlagLuaAppEnableNativePurchaseFinishedV2Signals) .. " localPlayerFeature=" .. tostring(engineFeature)
        end)
        connectIfAvailable(marketplaceService.NativePurchaseFinished, onNativePurchaseFinished)
        if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then
            connectIfAvailable(marketplaceService.NativePurchaseFinishedV2, onNativePurchaseFinished)
        end
        if engineFeature then
            connectIfAvailable(marketplaceService.NativePurchaseFinishedWithLocalPlayer, onNativePurchaseFinishedWithLocalPlayer)

            if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then
                connectIfAvailable(marketplaceService.NativePurchaseFinishedWithLocalPlayerV2, onNativePurchaseFinishedWithLocalPlayer)
            end
        end
    end

    return {
        getCategories = getCategories,
        getSections = getSections,
        getLoading = getLoading,
        getError = getError,
        getOwnership = getOwnership,
        getTrialAvailabilities = getTrialAvailabilities,
        getTrialAvailabilityPhase = getTrialAvailabilityPhase,
        getTrialRedemptionInFlight = getTrialRedemptionInFlight,
        getTrialRedeemSuccessCount = getTrialRedeemSuccessCount,
        getTrialRedemptionError = getTrialRedemptionError,
        getTrialRedeemThumbnail = getTrialRedeemThumbnail,
        dismissTrialRedemptionError = function()
            var45(nil)
        end,
        getBonusPromotionEligibility = getBonusPromotionEligibility,
        getItemsPerRow = getItemsPerRow,
        getMetadata = getMetadata,
        getGlobalIconBackendEnabled = getGlobalIconBackendEnabled,
        getGlobalIconHasNewOffers = getGlobalIconHasNewOffers,
        getNotificationFreeTrialTopBarChip = getNotificationFreeTrialTopBarChip,
        getPurchasedOwnedGamePass = getPurchasedOwnedGamePass,
        getShouldOpenToRobuxTab = getShouldOpenToRobuxTab,
        getOpenedFromBuyRobux = getOpenedFromBuyRobux,
        getPurchasedRobuxAmount = getPurchasedRobuxAmount,
        dismissRobuxPurchaseSuccess = function()
            var26(nil)
        end,
        onShopOpened = onShopOpened,
        fetchAllShopData = fetchAllShopData2,
        prefetchWidgetsOnly = prefetchWidgetsOnly,
        refreshShopItemInfo = refreshShopItemInfo,
        refreshRobuxWidgetsAfterPurchase = refreshRobuxWidgetsAfterPurchase,
        fetchGamePassOwnership = fetchGamePassOwnership,
        currentlyOwnsGamePass = currentlyOwnsGamePass,
        redeemGamePassTrial = redeemGamePassTrial2,
        pollGamePassOwnership = pollGamePassOwnershipAfterPurchase,
        bonusGamePassIdForNativePurchase = bonusGamePassIdForNativePurchase,
        setItemsPerRow = function(num3: number)
            var24(num3)
        end,
        setShouldOpenToRobuxTab = setShouldOpenToRobuxTab,
        setOpenedFromBuyRobux = setOpenedFromBuyRobux
    }
end

return createInExperienceShopStore

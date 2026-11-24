-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local _Promise = require(InExperienceOffersParent.Promise)
local SharedFlags = require(InExperienceOffersParent.SharedFlags)
local Signals = require(InExperienceOffersParent.Signals)
local createSessionScopedSignal = require(InExperienceOffersParent.SignalsUtils).createSessionScopedSignal

local getAllUserOffers = require(InExperienceOffers.Api.getAllUserOffers)
local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)
local _Types = require(InExperienceOffers.Types)
local MockGetAllUserOffers = require(InExperienceOffers.Mocks.MockGetAllUserOffers)
local getSecondsUntilNextExpiration = require(InExperienceOffers.Utils.getSecondsUntilNextExpiration)
local getSecondsUntilAnyKeyEmpties = require(InExperienceOffers.Utils.getSecondsUntilAnyKeyEmpties)
local isNotificationEligible = require(InExperienceOffers.Utils.isNotificationEligible)
local FeatureKey = require(InExperienceOffers.Enums.FeatureKey)
local NotificationLocation = require(InExperienceOffers.Enums.NotificationLocation)
local FFlagHideOfferNotificationsWhenShopEmpty = SharedFlags.FFlagHideOfferNotificationsWhenShopEmpty
local FFlagOffersRespectExpiration = require(InExperienceOffers.Flags.FFlagOffersRespectExpiration)
local FFlagOffersMergeStoreResults = require(InExperienceOffers.Flags.FFlagOffersMergeStoreResults)
local FFlagUseMockUserOffers = require(InExperienceOffers.Flags.FFlagUseMockUserOffers)
local FIntOfferExpirationRefetchBufferSeconds = require(InExperienceOffers.Flags.FIntOfferExpirationRefetchBufferSeconds)
local FIntOfferExpirationRefetchJitterSeconds = require(InExperienceOffers.Flags.FIntOfferExpirationRefetchJitterSeconds)
local FIntOfferExpirationRefetchMaxCount = require(InExperienceOffers.Flags.FIntOfferExpirationRefetchMaxCount)
local FFlagOffersPerKeyExpiryRefetch = require(InExperienceOffers.Flags.FFlagOffersPerKeyExpiryRefetch)
local FFlagOffersShopScopedNotification = require(InExperienceOffers.Flags.FFlagOffersShopScopedNotification)

local function normalizePresentationData(presentationData)
    if presentationData == nil then
        return nil
    end
    local result = {}
    for _, value in presentationData do
        if value.banner ~= nil then
            result.banner = value.banner
        end
        if value.menuBadge ~= nil then
            result.menuBadge = value.menuBadge
        end
        if value.tooltip ~= nil then
            result.tooltip = value.tooltip
        end
    end
    return result
end

local function normalizeOffer(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        offerId = arg1.offerId,
        offerStatus = arg1.offerStatus,
        featureKeys = arg1.featureKeys,
        expirationTimeInUTC = arg1.expirationTimeInUTC,
        presentationData = normalizePresentationData(arg1.presentationData)
    }
end

local function bucketResponse(arg1)
    local result = ({})
    for _, offer in arg1.offers do
        local tbl1 = normalizeOffer(offer)

        for _, featureKey in tbl1.featureKeys do
            local tbl2 = result[featureKey]
            if tbl2 == nil then
                tbl2 = {}
                result[featureKey] = tbl2
            end
            table.insert(tbl2, tbl1)
        end
    end
    return result
end

local function mergeRequestedKeys(arg1, tbl1, tbl2)
    local var1 = arg1 == nil and {} or table.clone(arg1)
    for _, value in tbl2 do
        var1[value] = tbl1[value]
    end
    return var1
end

local function keysOf(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    for value in arg1 do
        table.insert(result, value)
    end
    return result
end

local function createOffersStore()
    local getOffers, var2 = createSessionScopedSignal(nil)

    local getOfferExposureSnapshot, var4 = createSessionScopedSignal(nil)

    local getHasInExperienceShopOpened, var6 = createSessionScopedSignal(false)

    local getIsInExperienceShopGlobalIconAvailable, setInExperienceShopGlobalIconAvailable = Signals.createSignal(false)

    local getIsShopAvailable, setIsShopAvailable = Signals.createSignal(true)

    local getShopHasItems, setShopHasItems = Signals.createSignal(true)

    local getOfferNotificationShown = Signals.createComputed(function(arg1)
        local var13 = getOffers(arg1)
        local var14 = getOfferExposureSnapshot(arg1)

        if var13 == nil or var14 == nil then
            return false
        end

        if not getIsShopAvailable(arg1) then
            return false
        end

        if FFlagHideOfferNotificationsWhenShopEmpty and not getShopHasItems(arg1) then
            return false
        end

        if not FFlagOffersShopScopedNotification then
            for _, value in var13 do
                for _, value2 in value do
                    if isNotificationEligible(value2, var14) then
                        return true
                    end
                end
            end
            return false
        end

        local var15 = var13[FeatureKey.RobloxShop]
        if var15 ~= nil then
            for _, value in var15 do
                if isNotificationEligible(value, var14) then
                    return true
                end
            end
        end
        return false
    end)

    local getOfferNotificationShownWithEnum = Signals.createComputed(function(arg1)
        if getHasInExperienceShopOpened(arg1) then
            return NotificationLocation.None
        end

        local var13 = getOffers(arg1)
        local var14 = getOfferExposureSnapshot(arg1)

        if var13 == nil or var14 == nil then
            return NotificationLocation.None
        end

        if FFlagHideOfferNotificationsWhenShopEmpty and not getShopHasItems(arg1) then
            return NotificationLocation.None
        end

        local var15 = getIsInExperienceShopGlobalIconAvailable(arg1)
        if not (var15 or getIsShopAvailable(arg1)) then
            return NotificationLocation.None
        end

        local var16 = if var15 then NotificationLocation.GlobalIcon else NotificationLocation.Hamburger

        if not FFlagOffersShopScopedNotification then
            for _, value in var13 do
                for _, value2 in value do
                    if isNotificationEligible(value2, var14) then
                        return var16
                    end
                end
            end
            return NotificationLocation.None
        end

        local var17 = var13[FeatureKey.RobloxShop]
        if var17 ~= nil then
            for _, value in var17 do
                if isNotificationEligible(value, var14) then
                    return var16
                end
            end
        end
        return NotificationLocation.None
    end)

    local function hydrateOfferExposureSnapshot(arg1)
        if getOfferExposureSnapshot(false) == nil then
            var4(arg1)
        end
    end

    local function markInExperienceShopOpened()
        var6(true)
    end

    local var13 = if FFlagUseMockUserOffers then MockGetAllUserOffers else getAllUserOffers
    local var14 = nil
    local var15 = nil

    local num1 = 0

    local num2 = 0

    local scheduleExpirationRefetch = nil

    local function cancelExpirationRefetch() -- Luacid: Inlined by compiler; 4 call sites recovered
        if var15 ~= nil then
            pcall(task.cancel, var15)
            var15 = nil
        end
    end

    local function commitOffers(arg1)
        local tbl1 = ({})
        for _, offer in arg1.offers do
            local tbl2 = normalizeOffer(offer)

            for _, featureKey in tbl2.featureKeys do
                local tbl3 = tbl1[featureKey]
                if tbl3 == nil then
                    tbl3 = {}
                    tbl1[featureKey] = tbl3
                end
                table.insert(tbl3, tbl2)
            end
        end
        var2(tbl1)

        if FFlagOffersRespectExpiration then
            scheduleExpirationRefetch(tbl1)
        end
    end

    local function commitMergedOffers(tbl1, arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
        local tbl2 = bucketResponse(arg1)
        local var16 = mergeRequestedKeys(getOffers(false), tbl2, tbl1)
        var2(var16)

        if FFlagOffersRespectExpiration then
            scheduleExpirationRefetch(var16)
        end
    end

    local function expireShopOffers()
        local var16 = getOffers(false)
        if var16 == nil or var16[FeatureKey.RobloxShop] == nil then
            return
        end
        local tbl1 = ({})
        for value, value2 in var16 do
            if value ~= FeatureKey.RobloxShop then
                tbl1[value] = value2
            end
        end
        var2(tbl1)
    end

    local function commitOffersIfCurrent(num3: number, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if num3 ~= num2 then
            return
        end
        commitOffers(arg1)
    end

    local function commitMergedOffersIfCurrent(num3: number, tbl1, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if num3 ~= num2 then
            return
        end

        commitMergedOffers(tbl1, arg1)
    end

    local function fetchOffers(tbl1)
        if not FFlagOffersRespectExpiration then
            var13(tbl1):andThen(function(arg1)
                if FFlagOffersMergeStoreResults then
                    commitMergedOffers(tbl1, arg1)

                    return
                end

                commitOffers(arg1)
            end):catch(function(arg1)
                OffersDebugLogger.log("fetchOffers failed: " .. tostring(arg1))
            end)
            return
        end

        var14 = tbl1
        cancelExpirationRefetch()
        num2 += 1
        local num3 = num2
        var13(tbl1):andThen(function(arg1)
            if FFlagOffersMergeStoreResults then
                commitMergedOffersIfCurrent(num3, tbl1, arg1)
                return
            end
            commitOffersIfCurrent(num3, arg1)
        end):catch(function(arg1)
            OffersDebugLogger.log("fetchOffers failed: " .. tostring(arg1))

            if num3 ~= num2 then
                return
            end

            local var16 = getOffers(false)
            if var16 ~= nil then
                scheduleExpirationRefetch(var16)
            end
        end)
    end

    local function armExpirationRefetch(tbl1, num3: number)
        if FIntOfferExpirationRefetchMaxCount <= num1 then
            return
        end

        local var16 = num3 + FIntOfferExpirationRefetchBufferSeconds
        if FIntOfferExpirationRefetchJitterSeconds > 0 then
            var16 += math.random() * FIntOfferExpirationRefetchJitterSeconds
        end
        var15 = task.delay(var16, function()
            var15 = nil
            num1 += 1
            local num4 = num2
            var13(tbl1):andThen(function(arg1)
                if FFlagOffersMergeStoreResults then
                    commitMergedOffersIfCurrent(num4, tbl1, arg1)
                    return
                end
                commitOffersIfCurrent(num4, arg1)
            end):catch(function(arg1)
                if num4 ~= num2 then
                    return
                end
                OffersDebugLogger.log("expiration refetch failed: " .. tostring(arg1))

                local var17 = getOffers(false)
                if var17 ~= nil then
                    scheduleExpirationRefetch(var17)
                end
            end)
        end)
    end

    local function scheduleExpirationRefetchPerKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        cancelExpirationRefetch()
        local secondsUntilAnyKeyEmpties = getSecondsUntilAnyKeyEmpties(arg1)
        if secondsUntilAnyKeyEmpties == nil then
            return
        end

        armExpirationRefetch(keysOf(arg1), secondsUntilAnyKeyEmpties)
    end

    scheduleExpirationRefetch = function(arg1)
        if FFlagOffersPerKeyExpiryRefetch then
            scheduleExpirationRefetchPerKey(arg1)
            return
        end

        cancelExpirationRefetch()
        local var16 = var14
        local secondsUntilNextExpiration = getSecondsUntilNextExpiration(arg1)
        if var16 == nil or secondsUntilNextExpiration == nil or FIntOfferExpirationRefetchMaxCount <= num1 then
            return
        end

        local var17 = secondsUntilNextExpiration + FIntOfferExpirationRefetchBufferSeconds
        if FIntOfferExpirationRefetchJitterSeconds > 0 then
            var17 += math.random() * FIntOfferExpirationRefetchJitterSeconds
        end
        var15 = task.delay(var17, function()
            var15 = nil
            num1 += 1
            local num3 = num2

            var13(var16):andThen(function(arg2)
                if FFlagOffersMergeStoreResults then
                    commitMergedOffersIfCurrent(num3, var16, arg2)
                    return
                end
                commitOffersIfCurrent(num3, arg2)
            end):catch(function(arg2)
                if num3 ~= num2 then
                    return
                end
                OffersDebugLogger.log("expiration refetch failed, expiring shop offers: " .. tostring(arg2))

                expireShopOffers()
            end)
        end)
    end

    return {
        getOffers = getOffers,
        getOfferNotificationShown = getOfferNotificationShown,
        getOfferNotificationShownWithEnum = getOfferNotificationShownWithEnum,
        getOfferExposureSnapshot = getOfferExposureSnapshot,
        getHasInExperienceShopOpened = getHasInExperienceShopOpened,
        getIsInExperienceShopGlobalIconAvailable = getIsInExperienceShopGlobalIconAvailable,
        getIsShopAvailable = getIsShopAvailable,
        getShopHasItems = getShopHasItems,
        fetchOffers = fetchOffers,
        hydrateOfferExposureSnapshot = hydrateOfferExposureSnapshot,
        markInExperienceShopOpened = markInExperienceShopOpened,
        setInExperienceShopGlobalIconAvailable = setInExperienceShopGlobalIconAvailable,
        setIsShopAvailable = setIsShopAvailable,
        setShopHasItems = setShopHasItems
    }
end

return createOffersStore

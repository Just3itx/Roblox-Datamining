-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)

local InExperienceOffers = require(CorePackages.Workspace.Packages.InExperienceOffers)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local LocalStore = require(Chrome.ChromeShared.Service.LocalStore)

local FFlagOfferNotifyOnGlobalIcon = SharedFlags.FFlagOfferNotifyOnGlobalIcon

local getOffersStore = InExperienceOffers.getOffersStore
local isNotificationEligible = InExperienceOffers.Utils.isNotificationEligible
local NotificationLocation = InExperienceOffers.NotificationLocation

local str1 = game:DefineFastString("InExperienceOfferExposureStorageKey", "InExperienceOfferExposure")

local num1 = game:DefineFastInt("InExperienceOfferExposureMaxStoredOffers", 50)

local tbl1 = {}

local function loadPersistedTally()
    local var1 = LocalStore.loadForLocalPlayer(str1)
    local result = ({})
    if type(var1) ~= "table" then
        return result
    end

    for value, value2 in var1 do
        if type(value) ~= "string"
            or type(value2) ~= "table"
            or type(value2.exposureCount) ~= "number"
            or type(value2.lastExposureUTCTime) ~= "string"
        then
            continue
        end
        local tbl2 = {
            exposureCount = value2.exposureCount,
            lastExposureUTCTime = value2.lastExposureUTCTime
        }
        result[value] = tbl2
    end

    return result
end

local function withOldestEvicted(tbl2)
    local tbl3 = {}
    for value in tbl2 do
        table.insert(tbl3, value)
    end
    if #tbl3 <= num1 then
        return tbl2
    end

    table.sort(tbl3, function(arg1, arg2): boolean
        return tbl2[arg1].lastExposureUTCTime > tbl2[arg2].lastExposureUTCTime
    end)

    local result = ({})
    for i = 1, num1 do
        local var1 = tbl3[i]
        result[var1] = tbl2[var1]
    end
    return result
end

local function tallyExposures(offers, offerExposureSnapshot)
    if offers == nil or offerExposureSnapshot == nil then
        return
    end

    local tbl2 = {}
    for _, offer in offers do
        for _, value in offer do
            if not tbl1[value.offerId] and isNotificationEligible(value, offerExposureSnapshot) then
                tbl1[value.offerId] = true
                table.insert(tbl2, value.offerId)
            end
        end
    end
    if #tbl2 == 0 then
        return
    end

    local tbl3 = loadPersistedTally()
    local lastExposureUtcTime = DateTime.now():ToIsoDate()
    for _, value in tbl2 do
        local var1 = tbl3[value]
        local tbl4 = {
            exposureCount = if var1 == nil then 1 else var1.exposureCount + 1,
            lastExposureUTCTime = lastExposureUtcTime
        }
        tbl3[value] = tbl4
    end

    local tbl4 = withOldestEvicted(tbl3)
    LocalStore.storeForLocalPlayer(str1, tbl4)
end

local function useInExperienceOfferExposure()
    React.useEffect(function()
        local offersStore = getOffersStore(false)

        offersStore.hydrateOfferExposureSnapshot((loadPersistedTally()))

        return Signals.createEffect(function(arg1)
            if FFlagOfferNotifyOnGlobalIcon then
                if offersStore.getOfferNotificationShownWithEnum(arg1) == NotificationLocation.None then
                    return
                end
            elseif not offersStore.getIsShopAvailable(arg1) then
                return
            end

            tallyExposures(offersStore.getOffers(arg1), offersStore.getOfferExposureSnapshot(arg1))
        end)
    end, {})
end

return useInExperienceOfferExposure

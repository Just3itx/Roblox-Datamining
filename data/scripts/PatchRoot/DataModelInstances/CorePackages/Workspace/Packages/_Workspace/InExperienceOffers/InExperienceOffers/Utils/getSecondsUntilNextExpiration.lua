-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)
local FeatureKey = require(InExperienceOffers.Enums.FeatureKey)
local OfferStatus = require(InExperienceOffers.Enums.OfferStatus)
local _Types = require(InExperienceOffers.Types)

local function getSecondsUntilNextExpiration(arg1)
    local unixTimestampMillis = DateTime.now().UnixTimestampMillis
    local var1 = nil

    local var2 = arg1[FeatureKey.RobloxShop]
    if var2 == nil then
        return nil
    end
    for _, value in var2 do
        if value.offerStatus ~= OfferStatus.Available then
            continue
        end

        local expirationTimeInUtc = value.expirationTimeInUTC
        local isoDate = if expirationTimeInUtc == nil then nil else DateTime.fromIsoDate(expirationTimeInUtc)

        OffersDebugLogger.logLazy(function()
            local format = string.format
            local str1 = "getSecondsUntilNextExpiration parse offerId=%s expirationTimeInUTC=%s parsedUnixMillis=%s"
            local str2 = tostring(value.offerId)
            local str3 = tostring(expirationTimeInUtc)
            local var3 = if isoDate == nil then "nil" else tostring(isoDate.UnixTimestampMillis)
            return format(str1, str2, str3, var3)
        end)

        if isoDate == nil then
            continue
        end

        local num1 = (isoDate.UnixTimestampMillis - unixTimestampMillis) / 1000
        if num1 > 0 and (var1 == nil or var1 < num1) then
            var1 = num1
        end
    end

    OffersDebugLogger.logLazy(function(): string
        return string.format("getSecondsUntilNextExpiration return %s", tostring(var1))
    end)
    return var1
end

return getSecondsUntilNextExpiration

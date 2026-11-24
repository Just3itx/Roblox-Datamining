-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)
local _Types = require(InExperienceOffers.Types)

local function isOfferExpired(arg1): boolean
    local expirationTimeInUtc = arg1.expirationTimeInUTC
    local isoDate = if expirationTimeInUtc == nil then nil else DateTime.fromIsoDate(expirationTimeInUtc)

    OffersDebugLogger.logLazy(function()
        local format = string.format
        local str1 = "isOfferExpired parse offerId=%s expirationTimeInUTC=%s parsedUnixMillis=%s"
        local str2 = tostring(arg1.offerId)
        local str3 = tostring(expirationTimeInUtc)
        local var1 = if isoDate == nil then "nil" else tostring(isoDate.UnixTimestampMillis)
        return format(str1, str2, str3, var1)
    end)

    if isoDate == nil then
        OffersDebugLogger.log("isOfferExpired return false (unparsed or missing expiry)")
        return false
    end

    local bool1 = isoDate.UnixTimestampMillis <= DateTime.now().UnixTimestampMillis
    OffersDebugLogger.logLazy(function(): string
        return string.format("isOfferExpired return %s", tostring(bool1))
    end)
    return bool1
end

return isOfferExpired

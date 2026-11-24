-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)
local OfferStatus = require(InExperienceOffers.Enums.OfferStatus)
local _Types = require(InExperienceOffers.Types)

local function secondsUntilExpiry(arg1, num1: number) -- Luacid: unused: defined but never referenced
    if arg1.offerStatus ~= OfferStatus.Available then
        return nil
    end
    local expirationTimeInUtc = arg1.expirationTimeInUTC
    local isoDate = if expirationTimeInUtc == nil then nil else DateTime.fromIsoDate(expirationTimeInUtc)

    if isoDate == nil then
        return nil
    end
    local num2 = (isoDate.UnixTimestampMillis - num1) / 1000
    return if num2 > 0 then num2 else nil
end

local function keyEmptiesInSeconds(tbl1, unixTimestampMillis: number)
    local var1 = nil
    for _, value in tbl1 do
        local var2

        if value.offerStatus == OfferStatus.Available then
            local expirationTimeInUtc = value.expirationTimeInUTC
            local isoDate = if expirationTimeInUtc == nil then nil else DateTime.fromIsoDate(expirationTimeInUtc)

            if isoDate == nil then
                var2 = nil
            else
                var2 = (isoDate.UnixTimestampMillis - unixTimestampMillis) / 1000
                if not (var2 > 0) then
                    var2 = nil
                end
            end
        else
            var2 = nil
        end

        if var2 ~= nil and (var1 == nil or var1 < var2) then
            var1 = var2
        end
    end

    return var1
end

local function getSecondsUntilAnyKeyEmpties(arg1)
    local unixTimestampMillis = DateTime.now().UnixTimestampMillis
    local var1 = nil
    for _, value in arg1 do
        local var2 = keyEmptiesInSeconds(value, unixTimestampMillis)
        if var2 ~= nil and (var1 == nil or var2 < var1) then
            var1 = var2
        end
    end

    OffersDebugLogger.logLazy(function(): string
        return string.format("getSecondsUntilAnyKeyEmpties return %s", tostring(var1))
    end)
    return var1
end

return getSecondsUntilAnyKeyEmpties

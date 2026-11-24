-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local _Types = require(InExperienceOffers.Types)

local FFlagOffersRespectExpiration = require(InExperienceOffers.Flags.FFlagOffersRespectExpiration)
local isOfferExpired = require(InExperienceOffers.Utils.isOfferExpired)

local num1 = game:DefineFastInt("InExperienceOffersNotificationMaxExposureCount", 3)

local num2 = game:DefineFastInt("InExperienceOffersNotificationCooldownSeconds", 86400)

local function isNotificationEligible(arg1, arg2): boolean
    if arg1.offerStatus ~= "AVAILABLE" then
        return false
    end

    if FFlagOffersRespectExpiration and isOfferExpired(arg1) then
        return false
    end

    local var1 = arg2[arg1.offerId]
    if var1 == nil then
        return true
    end
    if var1.exposureCount >= num1 then
        return false
    end

    local dateTime = DateTime.fromIsoDate(var1.lastExposureUTCTime)
    if dateTime == nil then
        return false
    end
    local num3 = DateTime.now().UnixTimestamp - dateTime.UnixTimestamp
    return num2 <= num3
end

return isNotificationEligible

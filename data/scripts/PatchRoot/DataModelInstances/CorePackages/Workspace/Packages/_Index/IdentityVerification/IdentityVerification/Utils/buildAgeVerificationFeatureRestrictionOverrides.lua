-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local IdentityVerificationParent = script:FindFirstAncestor("IdentityVerification").Parent

local Localization = require(IdentityVerificationParent.RobloxAppLocales).Localization
local _UniversalFeatureRestrictions = require(IdentityVerificationParent.UniversalFeatureRestrictions)

local function buildAgeVerificationFeatureRestrictionOverrides()
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return {
        titleOverride = localization:Format("Feature.UniversalFeatureRestrictions.AbuseVector.AgeVerification.DialogTitle.Suspended"),
        bodyOverride = localization:Format("Feature.UniversalFeatureRestrictions.AbuseVector.AgeVerification.DialogBody.Suspended")
    }
end

return buildAgeVerificationFeatureRestrictionOverrides

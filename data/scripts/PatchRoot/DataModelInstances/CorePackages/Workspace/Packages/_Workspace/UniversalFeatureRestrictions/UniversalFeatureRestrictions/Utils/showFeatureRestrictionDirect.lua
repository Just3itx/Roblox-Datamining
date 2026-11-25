-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")
local UniversalFeatureRestrictionsParent = UniversalFeatureRestrictions.Parent

local _AbuseVector = require(UniversalFeatureRestrictions.Common.AbuseVector)
local featureRestrictionDisplayDirectSignal = require(UniversalFeatureRestrictions.Signals.featureRestrictionDisplayDirectSignal)
local _Types = require(UniversalFeatureRestrictionsParent.ModerationCommon.Types)

local function showFeatureRestrictionDirect(abuseVector, moderationDetail, options)
    featureRestrictionDisplayDirectSignal:fire(
        { abuseVector = abuseVector, moderationDetail = moderationDetail, options = options }
    )
end

return showFeatureRestrictionDirect

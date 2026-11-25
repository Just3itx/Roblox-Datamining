-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")

local featureRestrictionDisplaySignal = require(UniversalFeatureRestrictions.Signals.featureRestrictionDisplaySignal)
local _AbuseVector = require(UniversalFeatureRestrictions.Common.AbuseVector)

local function showFeatureRestriction(abuseVector, options)
    featureRestrictionDisplaySignal:fire({ abuseVector = abuseVector, options = options })
end

return showFeatureRestriction

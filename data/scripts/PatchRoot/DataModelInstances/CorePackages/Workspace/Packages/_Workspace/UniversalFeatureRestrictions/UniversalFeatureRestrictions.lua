-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AbuseVector = require(script.Common.AbuseVector)
local featureRestrictionDisplaySignal = require(script.Signals.featureRestrictionDisplaySignal)
local featureRestrictionDisplayDirectSignal = require(script.Signals.featureRestrictionDisplayDirectSignal)
return {
    showFeatureRestriction = require(script.Utils.showFeatureRestriction),
    showFeatureRestrictionDirect = require(script.Utils.showFeatureRestrictionDirect),
    AbuseVector = AbuseVector,
    Signals = {
        featureRestrictionDisplaySignal = featureRestrictionDisplaySignal,
        featureRestrictionDisplayDirectSignal = featureRestrictionDisplayDirectSignal
    },
    ["jest.config"] = script["jest.config"]
}

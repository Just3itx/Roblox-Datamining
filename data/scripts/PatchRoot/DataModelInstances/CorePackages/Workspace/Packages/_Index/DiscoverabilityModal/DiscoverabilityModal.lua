-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    DiscoverabilityOverlay = require(script.Components.DiscoverabilityOverlay),
    DiscoverabilityWithAudit = require(script.Components.DiscoverabilityWithAudit),
    FetchUserSettingsMetadata = require(script.Networking.FetchUserSettingsMetadata),
    installReducer = require(script.installReducer),
    dependencies = require(script.dependencies),
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    Analytics = require(script.Analytics),
    Flags = require(script.Flags),
    ["jest.config"] = script["jest.config"]
}

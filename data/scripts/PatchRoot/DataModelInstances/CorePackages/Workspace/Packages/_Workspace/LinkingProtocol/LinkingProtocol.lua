-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _DeepLinkSource = require(script.Enums.DeepLinkSource)
local _SettingsRoute = require(script.Enums.SettingsRoute)
local _LinkingProtocolTypes = require(script.LinkingProtocolTypes)

return {
    LinkingProtocol = require(script.LinkingProtocol),
    AdConsentAttributionAdapter = require(script.AdConsentAttributionAdapter),
    readCachedAdConsentRegion = require(script.readCachedAdConsentRegion),
    getFFlagEnableAdConsentAttribution = require(script.Flags.getFFlagEnableAdConsentAttribution),
    Enums = require(script.Enums),
    ["jest.config"] = script["jest.config"]
}

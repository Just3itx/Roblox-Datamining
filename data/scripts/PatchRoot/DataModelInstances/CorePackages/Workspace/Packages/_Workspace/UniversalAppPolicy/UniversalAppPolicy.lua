-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local _PolicyTypes = require(script.PolicyTypes)
local CrossPlayCapabilities = require(script.Enum.CrossPlayCapabilities)

return {
    getAppFeaturePolicies = require(script.getAppFeaturePolicies),
    GetAppPolicyStore = require(script.GetAppPolicyStore),
    AppFeaturePolicies = require(script.AppFeaturePolicies),
    RoactAppPolicy = require(script.RoactAppPolicy),
    UniversalAppPolicy = require(script.UniversalAppPolicy),
    useAppPolicy = require(script.useAppPolicy),
    Enum = { CrossPlayCapabilities = CrossPlayCapabilities }
}

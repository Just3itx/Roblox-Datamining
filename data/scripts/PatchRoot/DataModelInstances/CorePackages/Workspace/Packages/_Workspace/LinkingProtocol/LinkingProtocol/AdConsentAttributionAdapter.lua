-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LinkingProtocol = script:FindFirstAncestor("LinkingProtocol")

local StartAttributionOrchestrator = require(script.Parent.StartAttributionOrchestrator)
local getFFlagEnableAdConsentAttribution = require(LinkingProtocol.Flags.getFFlagEnableAdConsentAttribution)

local module = {}

function module.toAdConsent(str1: string?): boolean?
    return str1 == "Enabled" or not (str1 == "Disabled") and nil
end

function module.resolveAndPublish(arg1, arg2, func1: (...any) -> (...any), str1: string?)
    if not getFFlagEnableAdConsentAttribution() then
        return
    end

    local var1 = module.toAdConsent(func1())
    StartAttributionOrchestrator.resolveAndPublish(arg1, arg2, var1, str1)
end

return module

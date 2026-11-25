-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local UserInputService = game:GetService("UserInputService")

local UpsellFlow = require(scriptParentParent.Enums.UpsellFlow)
local getUpsellFlow = require(scriptParentParent.NativeUpsell.getUpsellFlow)
local getAppFeaturePolicies = require(scriptParentParentParent.UniversalAppPolicy).getAppFeaturePolicies

return function(): boolean
    local platform = UserInputService:GetPlatform()
    local upsellFlow = getUpsellFlow(platform)
    return if getAppFeaturePolicies().getShouldUseDMCCALegalDisclosureInApp() then true else upsellFlow == UpsellFlow.Web
end

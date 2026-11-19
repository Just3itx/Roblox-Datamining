-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Chrome = script:FindFirstAncestor("Chrome")

local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local PolicyProvider = require(CorePackages.Packages.PolicyProvider)
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local registerPartyIntegration = require(script.Parent.registerPartyIntegration)

local Service = require(Chrome.Service)
local isConnectUnibarEnabled = require(Chrome.Integrations.Connect.isConnectUnibarEnabled)
local isConnectDropdownEnabled = require(Chrome.Integrations.Connect.isConnectDropdownEnabled)

local GetFFlagIsSquadEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIsSquadEnabled

local var1 = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")

local function canAccessParty() -- Luacid: Inlined by compiler; 3 call sites recovered
    return UniversalAppPolicy.getAppFeaturePolicies().getCanAccessParty()
end

local function shouldEnableIntegrationForParty() -- Luacid: Inlined by compiler; 2 call sites recovered
    return GetFFlagIsSquadEnabled() and canAccessParty() and isConnectDropdownEnabled()
end

local var2 = nil
local var3 = nil

local function updatePartyIntegration(arg1)
    var2 = var2
        or registerPartyIntegration(
            "party_entrypoint",
            if arg1 then Service.AvailabilitySignal.Pinned else Service.AvailabilitySignal.Unavailable
        )

    if not arg1 then
        var2.availability:unavailable()

        if var3 then
            var3()
            var3 = nil
        end

        return
    end

    if InExperienceAppChatModal.default.currentSquadId ~= "" then
        var2.availability:pinned()
    end

    if var3 then
        return
    end

    local connection = InExperienceAppChatModal.default.currentSquadIdSignal.Event:Connect(function(arg2)
        if arg2 == "" then
            var2.availability:unavailable()
            return
        end
        var2.availability:pinned()
    end)

    var3 = function()
        connection:Disconnect()
    end
end

local function handlePolicyUpdate() -- Luacid: Inlined by compiler; 1 call site recovered
    updatePartyIntegration((shouldEnableIntegrationForParty()))
end

if isConnectUnibarEnabled() then
    handlePolicyUpdate()
    var1.onPolicyChanged(handlePolicyUpdate)
end

return var2

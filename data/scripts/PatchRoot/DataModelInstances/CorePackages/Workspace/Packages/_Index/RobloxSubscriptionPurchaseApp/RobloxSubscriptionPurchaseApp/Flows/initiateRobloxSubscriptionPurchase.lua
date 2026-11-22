-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local initiateRobloxSubscriptionPurchaseInternal = require(RobloxSubscriptionPurchaseApp.Actions.initiateRobloxSubscriptionPurchaseInternal)
local RobloxSubscriptionOverlayController = require(RobloxSubscriptionPurchaseApp.Flows.RobloxSubscriptionOverlayController)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local SurfaceContext = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceContext)
local SurfaceName = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceName)
local _types = require(RobloxSubscriptionPurchaseApp.types)
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet

local FFlagEnablePlusReferralEntrypointTelemetry = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralEntrypointTelemetry

local function initiateRobloxSubscriptionPurchase(arg1, arg2, universeId: number?, surfaceName, context, arg3, arg4, num1: number?)
    local var1 = RobloxSubscriptionStore.get()
    if arg2 then
        if arg2.onFlowComplete then
            var1.setOnFlowComplete(arg2.onFlowComplete)
        end
        if arg2.onBackButtonActivated then
            var1.setOnBackButtonActivated(arg2.onBackButtonActivated)
        end
        if arg2.onCtaOverride then
            var1.setOnCtaOverride(arg2.onCtaOverride)
        end
    end
    if arg1 then
        var1.setPurchaseUIOptions(arg1)
    end
    if arg3 then
        var1.setPurchaseFlowOptions(arg3)
    end
    if FFlagEnablePlusReferralLandingSheet then
        var1.setReferrerId(num1)
    end

    local metadata = {}
    if universeId ~= nil then
        metadata.universeId = universeId
    end

    local clientSessionId = if arg4 then arg4.clientSessionId else nil
    local entrypoint = if FFlagEnablePlusReferralEntrypointTelemetry and arg4 then arg4.entrypoint else nil
    local tbl2 = {
        context = context or SurfaceContext.Unspecified,
        surfaceName = surfaceName or SurfaceName.Unspecified,
        metadata = metadata,
        clientSessionId = clientSessionId,
        entrypoint = entrypoint
    }
    var1.setEntryContext(tbl2)

    initiateRobloxSubscriptionPurchaseInternal(tbl2)

    return RobloxSubscriptionOverlayController.render()
end

return initiateRobloxSubscriptionPurchase

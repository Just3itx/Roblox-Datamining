-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local MappedSignal = ChromeUtils.MappedSignal
local initialAvailability = if isSpatial() then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable
local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return VRHub.SafetyBubble and VRHub.SafetyBubble.enabled
end)

if VRHub.SafetyBubble then
    VRHub.SafetyBubble.Toggled.Event:Connect(function()
        signal:fire()
    end)
end

return (Service:register({
    initialAvailability = initialAvailability,
    id = "vr_safety_bubble",
    label = "CoreScripts.VRFTUX.Heading.SafetyBubble.Title",
    isActivated = mappedSignal,
    activated = function()
        VRHub:ToggleSafetyBubble()
        RbxAnalyticsService:ReportCounter("VR-BottomBar-Safety")
    end,
    components = {
        Icon = function()
            return CommonIcon(
                "rbxasset://textures/ui/MenuBar/icon_safety_off.png",
                "rbxasset://textures/ui/MenuBar/icon_safety_on.png",
                mappedSignal
            )
        end
    }
}))

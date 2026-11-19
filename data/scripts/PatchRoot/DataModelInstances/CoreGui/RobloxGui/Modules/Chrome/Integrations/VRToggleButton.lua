-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")

local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local SettingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local MappedSignal = ChromeUtils.MappedSignal

local UIManager = require(CorePackages.Workspace.Packages.VrSpatialUi).UIManager
local initialAvailability = if isSpatial() then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable
local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return VRHub.ShowTopBar
end)

VRHub.ShowTopBarChanged.Event:Connect(function()
    signal:fire()
end)

return (Service:register({
    initialAvailability = initialAvailability,
    id = "vr_toggle_button",
    label = "Feature.Catalog.Label.Filter.Hide",
    isActivated = mappedSignal,
    activated = function()
        if VRHub.ShowTopBar then
            UIManager.getInstance():prepareGuiToggleAnimationState()
            VRHub:SetShowTopBar(false)
            if SettingsHub:GetVisibility() then
                SettingsHub:ToggleVisibility()
            end
        else
            VRHub:SetShowTopBar(true)
        end

        RbxAnalyticsService:ReportCounter("VR-BottomBar-ToggleGui")
    end,
    components = {
        Icon = function()
            return CommonIcon(
                "rbxasset://textures/ui/MenuBar/icon_maximize.png",
                "rbxasset://textures/ui/MenuBar/icon_minimize.png",
                mappedSignal
            )
        end
    }
}))

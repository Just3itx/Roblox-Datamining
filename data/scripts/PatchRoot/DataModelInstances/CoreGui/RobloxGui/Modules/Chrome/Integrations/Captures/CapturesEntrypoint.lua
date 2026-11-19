-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local StarterGui = game:GetService("StarterGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local CapturesApp = require(RobloxGui.Modules.Captures.CapturesApp)
local CapturesPolicy = require(CorePackages.Workspace.Packages.CapturesInExperience).CapturesPolicy
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local MappedSignal = ChromeUtils.MappedSignal
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local _Available = Service.AvailabilitySignal.Available
local initialAvailability = if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Captures) then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable

local mappedSignal = MappedSignal.new(CapturesApp.onIsActiveChanged, function()
    return CapturesApp.getIsActive()
end)

local var2 = Service:register({
    initialAvailability = initialAvailability,
    id = "camera_entrypoint",
    label = "Feature.SettingsHub.Label.Captures",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = function(_)
        CapturesApp.onToggleActivationFromChrome()
    end,
    isActivated = mappedSignal,
    components = {
        Icon = function(_)
            return CommonIcon("icons/controls/cameraOff", "icons/controls/cameraOn", mappedSignal)
        end
    }
})

ChromeUtils.setCoreGuiAvailability(var2, Enum.CoreGuiType.Captures)

if FFlagEnableConsoleExpControls then
    local var3 = CapturesPolicy.PolicyImplementation.read()

    if not (var3 and CapturesPolicy.Mapper(var3).eligibleForCapturesFeature()) then
        var2.availability:forceUnavailable()
    end
end

return var2

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")

if require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled then
    return true
end

if not require(RobloxGui.Modules.Flags.FFlagEnableSpatialRobloxGui) then
    return false
end

local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local FStringSpatialRobloxUIIXPLayerName = require(RobloxGui.Modules.Flags.FStringSpatialRobloxUIIXPLayerName)

local FStringSpatialRobloxUIIXPUITypeVariableName = require(RobloxGui.Modules.Flags.FStringSpatialRobloxUIIXPUITypeVariableName)

local FStringSpatialRobloxUIIXPSpatialUIVariantValue = require(RobloxGui.Modules.Flags.FStringSpatialRobloxUIIXPSpatialUIVariantValue)

return IXPServiceWrapper:GetLayerData(FStringSpatialRobloxUIIXPLayerName)[FStringSpatialRobloxUIIXPUITypeVariableName] == FStringSpatialRobloxUIIXPSpatialUIVariantValue

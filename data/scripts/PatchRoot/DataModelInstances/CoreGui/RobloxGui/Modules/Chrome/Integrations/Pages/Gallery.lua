-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)

local CapturesPolicy = require(CorePackages.Workspace.Packages.CapturesInExperience).CapturesPolicy
local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local FFlagFixSpatialUICaptures = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFixSpatialUICaptures

local bool1 = game:DefineFastFlag("UpdateGalleryIcon", false)

local InGameMenuIntegrationUtils = require(script.Parent.InGameMenuIntegrationUtils)

local var1 = CapturesPolicy.PolicyImplementation.read()

local var2 = (if var1 then CapturesPolicy.Mapper(var1).eligibleForCapturesFeature() else false)
    and not (isInExperienceUIVREnabled and FFlagFixSpatialUICaptures and isSpatial())

if not var2 then
    return nil
end

local isActivated = InGameMenuIntegrationUtils.createPageOpenSignal("CapturesPage")

local tbl1 = {
    initialAvailability = if var2 then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable,
    id = "gallery",
    label = "Feature.Captures.Title.Gallery",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = 0,
    isActivated = 0,
    components = 0
}

function tbl1.activated(_)
    InGameMenuIntegrationUtils.toggleIGMPage("CapturesPage", isActivated:get())
end
tbl1.isActivated = isActivated
tbl1.components = {
    Icon = function(_)
        if bool1 then
            return CommonIcon("Image", nil, isActivated)
        end
        return CommonIcon("icons/controls/cameraOff", "icons/controls/cameraOn", isActivated)
    end
}

return Service:register(tbl1)

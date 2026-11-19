-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
local IsVRAppBuild = require(CorePackages.Workspace.Packages.AppCommonLib).IsVRAppBuild
local PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)
local FTUXConstants = require(scriptParentParent.Resources.FTUXConstants)

function IsFTUXExperience(questVr)
    if questVr ~= PlatformEnum.QuestVR then
        return false
    end

    return IsVRAppBuild() and tostring(game.PlaceId) == FTUXConstants[PlatformEnum.QuestVR].ExperienceIds.PlaceId
end

return IsFTUXExperience

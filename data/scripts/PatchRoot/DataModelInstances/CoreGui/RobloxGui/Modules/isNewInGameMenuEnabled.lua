-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local CorePackages = game:GetService("CorePackages")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

game:DefineFastInt("NewInGameMenuPercentRollout3", 0)
game:DefineFastString("NewInGameMenuForcedUserIds", "")
game:DefineFastFlag("NewInGameMenuDisabledInVR", false)

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local _isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

return function()
    if VRService.VREnabled then
        return not isInExperienceUIVREnabled
    end

    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = Players.LocalPlayer
    end

    for value in game:GetFastString("NewInGameMenuForcedUserIds"):gmatch("%d+") do
        if tonumber(value) == localPlayer.UserId then
            return true
        end
    end

    return game:GetFastInt("NewInGameMenuPercentRollout3") > localPlayer.UserId % 100
end

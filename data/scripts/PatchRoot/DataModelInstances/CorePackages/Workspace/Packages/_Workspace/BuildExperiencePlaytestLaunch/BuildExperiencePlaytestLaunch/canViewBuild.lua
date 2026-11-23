-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent

local AppCommonLib = require(BuildExperiencePlaytestLaunchParent.AppCommonLib)
local SharedFlags = require(BuildExperiencePlaytestLaunchParent.SharedFlags)
local _UniversalAppPolicy = require(BuildExperiencePlaytestLaunchParent.UniversalAppPolicy)

local IsVRAppBuild = AppCommonLib.IsVRAppBuild
local isTenFootInterface = AppCommonLib.isTenFootInterface
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab
local FFlagEnableBuildTabOverride = SharedFlags.FFlagEnableBuildTabOverride

local function canViewBuild(arg1)
    return (FFlagEnableBuildTabOverride or FFlagAppNavMyStatsTab and arg1.getCanViewBuild())
        and not (IsVRAppBuild() or isTenFootInterface())
end

return canViewBuild

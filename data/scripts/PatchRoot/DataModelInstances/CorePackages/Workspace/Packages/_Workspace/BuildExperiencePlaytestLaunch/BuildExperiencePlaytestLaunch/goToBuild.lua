-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunch = script:FindFirstAncestor("BuildExperiencePlaytestLaunch")
local BuildExperiencePlaytestLaunchParent = BuildExperiencePlaytestLaunch.Parent

local AppPage = require(BuildExperiencePlaytestLaunchParent.RobloxAppEnums).AppPage
local Logger = require(BuildExperiencePlaytestLaunchParent.Loggers).Logger
local UniversalAppPolicy = require(BuildExperiencePlaytestLaunchParent.UniversalAppPolicy)
local canViewBuild = require(BuildExperiencePlaytestLaunch.canViewBuild)
local openDeepLink = require(BuildExperiencePlaytestLaunch.openDeepLink)

local function goToBuild(bool1: boolean, tbl1)
    if not canViewBuild(UniversalAppPolicy.getAppFeaturePolicies()) then
        Logger:warning("goToBuild: dropped a request because the user cannot view Build")
        return
    end

    if not bool1 then
        if tbl1 == nil then
            error("goToBuild needs a navigation object outside an experience")
        end
        tbl1.navigate(AppPage.Build)
    else
        openDeepLink("roblox://navigation/build", true)
    end
end

return goToBuild

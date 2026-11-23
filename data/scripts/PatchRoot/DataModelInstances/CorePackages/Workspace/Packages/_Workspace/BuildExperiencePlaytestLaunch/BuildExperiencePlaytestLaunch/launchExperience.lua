-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent
local SharedFlags = require(BuildExperiencePlaytestLaunchParent.SharedFlags)
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local FFlagConnectionRelaunchBuildPlaytest = SharedFlags.FFlagConnectionRelaunchBuildPlaytest
local FFlagDeferInExperienceRbxmDownload = SharedFlags.FFlagDeferInExperienceRbxmDownload
local FFlagEnableDeferredAssetManagerService = SharedFlags.FFlagEnableDeferredAssetManagerService
local FFlagLuaAppPrivatePlaytestEarlyTesting = SharedFlags.FFlagLuaAppPrivatePlaytestEarlyTesting
local FFlagLuaAppPrivatePlaytestWithoutBuildMode = SharedFlags.FFlagLuaAppPrivatePlaytestWithoutBuildMode

local CreatorAgentChat = require(BuildExperiencePlaytestLaunchParent.DataHydration.CreatorAgentChat)
local ExperienceService = require(BuildExperiencePlaytestLaunchParent.ExperienceService)
local ExperienceService2 = ExperienceService.ExperienceService
local GameParams = ExperienceService.GameParams

local BuildModeLaunch = require(script.Parent.BuildModeLaunch)

local debug2 = CreatorAgentChat.debug

local function launchExperience(num1: number, source: string, bool1: boolean?, tbl1, bool2: boolean?)
    local var1 = bool2 and FFlagLuaAppPrivatePlaytestEarlyTesting
    local var2 = if bool2 and not FFlagLuaAppPrivatePlaytestEarlyTesting then true else bool1
    if FFlagLuaAppPrivatePlaytestWithoutBuildMode then
        BuildModeLaunch:clear()
    end
    if not (bool2 and FFlagLuaAppPrivatePlaytestWithoutBuildMode) then
        BuildModeLaunch:set(
            if tbl1 == nil then nil else tbl1.sessionId,
            num1,
            if FFlagConnectionRelaunchBuildPlaytest then var2 else nil
        )
    end

    local gameParams = if var1 then GameParams.fromParams({ placeId = num1, isEarlyTesting = true }) else GameParams.fromPlaceId(num1, var2)

    if FFlagBuildExperienceLibrary then
        gameParams.isTeamCreateViewer = tbl1 ~= nil or nil
        if tbl1 == nil then
            require(BuildExperiencePlaytestLaunchParent.ProgressLoading).PregameOverride.setPregameOverride(nil)
        end

        if FFlagDeferInExperienceRbxmDownload and FFlagEnableDeferredAssetManagerService then
            local DeferredAssetManagerService = game:GetService("DeferredAssetManagerService")
            DeferredAssetManagerService.JoiningPlaceId = num1
            DeferredAssetManagerService.JoiningUniverseId = 0
        end
    end
    debug2.log("info", "LaunchExperience gameParams", { gameParams = gameParams, source = source })

    ExperienceService2:LaunchExperience(gameParams, source)
end

return launchExperience

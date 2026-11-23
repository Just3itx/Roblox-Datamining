-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent
local SharedFlags = require(BuildExperiencePlaytestLaunchParent.SharedFlags)
local teamCreateUtils = require(script.Parent.teamCreateUtils)

local CreatorAgentChat = require(BuildExperiencePlaytestLaunchParent.DataHydration.CreatorAgentChat)

local BuildModeLaunch = require(script.Parent.BuildModeLaunch)
local PlaytestRejoin = require(script.Parent.PlaytestRejoin)
local launchExperience = require(script.Parent.launchExperience)
local leaveExperience = require(script.Parent.leaveExperience)
local teleportToPlace = require(script.Parent.teleportToPlace)

local debug2 = CreatorAgentChat.debug
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local FFlagLuaAppPrivatePlaytestEarlyTesting = SharedFlags.FFlagLuaAppPrivatePlaytestEarlyTesting

local function isAlreadyInPlace(placeId: number, num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (num1 == 0) and num1 == placeId
end

local function listenForTeleportFailure(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer

    local connection = TeleportService.TeleportInitFailed:Connect(function(player: Instance)
        if player == localPlayer then
            callback()
        end
    end)

    return function()
        connection:Disconnect()
    end
end

local function playtestExperience(placeId: number, source: string, tbl1): string
    local currentPlaceId = if tbl1 and tbl1.currentPlaceId ~= nil then tbl1.currentPlaceId else game.PlaceId
    local isTeamTest = if tbl1 then tbl1.isTeamTest else nil
    local isEarlyTesting = if tbl1 then tbl1.isEarlyTesting else nil
    debug2.log("info", "playtestExperience", {
        isTeamTest = isTeamTest,
        isEarlyTesting = isEarlyTesting,
        placeId = placeId,
        currentPlaceId = currentPlaceId,
        source = source
    })

    local var2 = teamCreateUtils.isViewer()

    local var3 = isEarlyTesting and FFlagLuaAppPrivatePlaytestEarlyTesting

    if not isAlreadyInPlace(placeId, currentPlaceId) or var2 or var3 then
        if var2 and FFlagBuildExperienceLibrary then
            PlaytestRejoin.request(placeId, source, isTeamTest, isEarlyTesting)
            leaveExperience()
        elseif var2 then
            leaveExperience(function()
                launchExperience(placeId, source, isTeamTest, nil, isEarlyTesting)
            end)
        else
            launchExperience(placeId, source, isTeamTest, nil, isEarlyTesting)
        end
        return "experience_launch"
    end

    local var4 = nil
    if tbl1 and tbl1.onTeleportFailed then
        local onTeleportFailed = tbl1.onTeleportFailed
        local function func1()
            if var4 then
                var4()
                var4 = nil
            end
            onTeleportFailed()
        end

        var4 = listenForTeleportFailure(func1)
    end

    BuildModeLaunch:set()
    teleportToPlace(placeId)
    return "teleport_pending"
end

return playtestExperience

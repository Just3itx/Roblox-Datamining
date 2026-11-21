-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameLaunchParent = script:FindFirstAncestor("GameLaunch").Parent

local default = require(GameLaunchParent.LoggingProtocol).default
local Cryo = require(GameLaunchParent.Cryo)
local _ExperienceService = require(GameLaunchParent.ExperienceService)
local ExperienceService = require(GameLaunchParent.ExperienceService).ExperienceService

local GetFFlagMoveLuaExpLaunchBegin = require(GameLaunchParent.ExperienceService).Flags.GetFFlagMoveLuaExpLaunchBegin

local FFlagDeferInExperienceRbxmDownload = require(GameLaunchParent.SharedFlags).FFlagDeferInExperienceRbxmDownload
local FFlagEnableDeferredAssetManagerService = require(GameLaunchParent.SharedFlags).FFlagEnableDeferredAssetManagerService
local DeferredAssetManagerService = if FFlagDeferInExperienceRbxmDownload and FFlagEnableDeferredAssetManagerService then game:GetService("DeferredAssetManagerService") else nil

local function LaunchGame(str1: string?, referralPage: string?, tbl1, _, str2: string?, func1: ((...any) -> (...any))?)
    if not GetFFlagMoveLuaExpLaunchBegin() then
        default:logEvent("experience_launch_begin")
    end

    local tbl2 = {
        placeId = tonumber(str1),
        referralPage = referralPage
    }

    if tbl1 then
        tbl2 = Cryo.Dictionary.join(tbl2, tbl1)
    end

    if FFlagDeferInExperienceRbxmDownload and FFlagEnableDeferredAssetManagerService then
        local var1 = DeferredAssetManagerService
        var1.JoiningPlaceId = tbl2.placeId or 0
        var1.JoiningUniverseId = tonumber(tbl2.universeId) or 0
    end

    ExperienceService:LaunchExperience(tbl2, str2, func1)
end

return LaunchGame

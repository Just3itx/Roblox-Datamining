-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PioneerUtilsParent = script:FindFirstAncestor("PioneerUtils").Parent

local Logger = require(PioneerUtilsParent.Loggers).Logger
local ExperienceService = require(PioneerUtilsParent.ExperienceService).ExperienceService
local GameParams = require(PioneerUtilsParent.ExperienceService).GameParams
local PioneerInfo = require(script.Parent.PioneerInfo)

local function pendingJoinTargetsPlace(pioneerRootPlaceId: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return ExperienceService:GetPendingJoinAttempt()
    end)
    if not success or type(result) ~= "table" then
        return false
    end
    local var1 = tonumber(result.placeId)
    return not (var1 == nil) and var1 == pioneerRootPlaceId
end

local function launchPioneerExperience()
    local pioneerRootPlaceId = PioneerInfo.getPioneerRootPlaceId()
    if not pioneerRootPlaceId then
        Logger:warning("launchPioneerExperience: could not resolve a valid Pioneer root place id")
    elseif not pendingJoinTargetsPlace(pioneerRootPlaceId) then
        ExperienceService:LaunchExperience(GameParams.fromPlaceId(pioneerRootPlaceId), "PioneerLaunch")
    end
end
return launchPioneerExperience

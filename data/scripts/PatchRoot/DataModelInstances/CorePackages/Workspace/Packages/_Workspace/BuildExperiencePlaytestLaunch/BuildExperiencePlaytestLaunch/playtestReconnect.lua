-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildModeLaunch = require(script.Parent.BuildModeLaunch)
local PlaytestRejoin = require(script.Parent.PlaytestRejoin)
local leaveExperience = require(script.Parent.leaveExperience)
local teamCreateUtils = require(script.Parent.teamCreateUtils)

local function isTeamTest(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return arg1:GetService("RunService"):IsTeamTest()
    end)
    return success and result == true
end

return {
    getRelaunchPlaceId = function(arg1)
        local var1 = arg1 or game
        if not BuildModeLaunch:hasBuildMode() or teamCreateUtils.isViewer(var1) then
            return nil
        elseif var1.PlaceId ~= 0 and isTeamTest(var1) then
            return var1.PlaceId
        end

        return BuildModeLaunch:getTeamTestPlaceId()
    end,
    relaunch = function(num1: number)
        PlaytestRejoin.request(num1, "BuildPlaytestReconnect", true)
        leaveExperience()
    end
}

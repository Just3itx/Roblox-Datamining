-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunch = script:FindFirstAncestor("BuildExperiencePlaytestLaunch")

local GetPlaytestLoadingStore = require(BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)
local playtestExperience = require(script.Parent.playtestExperience)
local releaseAnyFocus = require(script.Parent.releaseAnyFocus)

local function launchPlaytestWithLoadingState(num1: number, str1: string, isTeamTest: boolean?, callback: ((...any) -> (...any))?, isEarlyTesting: boolean?): boolean
    local playtestLoadingStore = GetPlaytestLoadingStore()
    if playtestLoadingStore.getIsPlaytestLoadingForPlaceId(num1)() then
        return false
    end

    playtestLoadingStore.setPlaytestStatusForPlaceId(num1, "Loading")

    task.defer(function()
        local var1 = nil
        local str2 = "experience_launch"
        if not xpcall(function()
            releaseAnyFocus()
            str2 = playtestExperience(num1, str1, {
                isTeamTest = isTeamTest,
                isEarlyTesting = isEarlyTesting,
                onTeleportFailed = function()
                    playtestLoadingStore.setPlaytestStatusForPlaceId(num1, "Idle")
                    if callback ~= nil then
                        callback()
                    end
                end
            })
        end, function(arg1)
            var1 = debug.traceback(tostring(arg1), 2)
        end) then
            playtestLoadingStore.setPlaytestStatusForPlaceId(num1, "Idle")
            if callback ~= nil then
                callback()
            end
            error(var1 or "Failed to launch playtest", 0)
        end

        if str2 == "teleport_pending" then
            return
        end

        playtestLoadingStore.setPlaytestStatusForPlaceId(num1, "Completed")
    end)
    return true
end

return launchPlaytestWithLoadingState

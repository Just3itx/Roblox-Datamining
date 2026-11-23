-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent

local LoggingProtocol = require(AchievementsParent.LoggingProtocol)
local _Signal = require(AchievementsParent.Signal)

local AchievementRules = require(script.Parent.AchievementRules)
local AchievementConstants = require(script.Parent.AchievementConstants)

local AchievementTelemetry = require(script.Parent.AchievementTelemetry)

local module = {
    NAMES = AchievementConstants.ACHIEVEMENT_NAMES
}

function module:_init(achievementName, arg1, achievementService)
    self.achievementService = achievementService
    self.achievementName = achievementName
    self.achievementRule = AchievementRules[achievementName]
    self.achievementAwardedCallbacks = {}
    self.hasAchieved = nil
    assert(self.achievementRule, "Achievement rule not found for " .. tostring(achievementName))

    if not self.achievementService:IsAvailable() then
        return
    end

    pcall(function()
        self.hasAchieved = self.achievementService:HasAchieved(achievementName)
    end)

    if self.hasAchieved ~= false then
        return
    end

    self.achievementDataSubscription = arg1:subscribe(function(arg2)
        if self.achievementRule(arg2) then
            self:grantAchievement(self.achievementName)
        end
    end)
end

function module:grantAchievement(achievementName)
    if self.hasAchieved ~= false then
        return
    end

    local _success, result = pcall(function()
        return self.achievementService:GrantAchievement(achievementName)
    end)

    LoggingProtocol.default:logRobloxTelemetryEvent(
        AchievementTelemetry,
        nil,
        {
            achievementName = achievementName,
            grantedState = tostring(result)
        }
    )

    if result ~= true then
        return
    end

    self.hasAchieved = true
    self.achievementDataSubscription:unsubscribe()
    for _, achievementAwardedCallback in self.achievementAwardedCallbacks do
        achievementAwardedCallback(achievementName)
    end
end

function module.registerOnAchievementAwardedListener(tbl1, func1: (...any) -> (...any))
    tbl1.achievementAwardedCallbacks[func1] = func1
    return {
        unsubscribe = function()
            tbl1.achievementAwardedCallbacks[func1] = nil
        end
    }
end

function module.new(arg1, arg2, arg3)
    local result = {}
    setmetatable(result, { __index = module })
    result:_init(arg1, arg2, arg3)
    return result
end

function module.newWithRefresher(arg1, arg2, tbl1, arg3)
    local module2 = module.new(arg1, arg2, arg3)

    if module2.hasAchieved == false then
        tbl1:start()
        module2:registerOnAchievementAwardedListener(function()
            tbl1:stop()
        end)
    end

    return module2
end

return module

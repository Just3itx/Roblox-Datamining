-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Achievements = script:FindFirstAncestor("Achievements")
local AchievementsParent = Achievements.Parent
local Signal = require(AchievementsParent.Signal)
local Achievement = require(Achievements.Achievement.Achievement)
local Logger = require(Achievements.Logger)
local HttpRequest = require(AchievementsParent.HttpRequest)
local GetUserRecentExperiences = require(Achievements.Requests.GetUserRecentExperiences)
local Dash = require(AchievementsParent.Dash)

local TimeRefresher = require(Achievements.AchievementDataRefresher.TimeRefresher)
local FriendCountRefresher = require(Achievements.AchievementDataRefresher.FriendCountRefresher)
local FFlagLuaAppDefaultHttpRetry = require(AchievementsParent.SharedFlags).FFlagLuaAppDefaultHttpRetry

local FFlagInExpAchievementsIsolateStartUpErrors = require(Achievements.Flags.FFlagInExpAchievementsIsolateStartUpErrors)

local var1 = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("InExpAchievementManagerHttpRetryCount", 4) else nil
})

local PlatformFriendsService = nil
pcall(function()
    PlatformFriendsService = game:GetService("PlatformFriendsService")
end)

local PlatformCloudStorageService = nil
pcall(function()
    PlatformCloudStorageService = game:GetService("PlatformCloudStorageService")
end)

local AchievementService = nil
pcall(function()
    AchievementService = game:GetService("AchievementService")
end)

local Players = game:GetService("Players")

local PlatformService = nil

pcall(function()
    PlatformService = game:GetService("PlatformService")
end)

local module = ({})

function module:startUp()
    local var2, var3 = Signal.createReadableSignal(0)
    local var4, var5 = Signal.createReadableSignal(0)

    local var6, var7 = Signal.createReadableSignal(0)

    local var8, var9 = Signal.createReadableSignal(0)

    TimeRefresher:init(var3, 3600)
    FriendCountRefresher:init(var9, self.playersService)

    self.achievementMarathon = Achievement.newWithRefresher(Achievement.NAMES.ACHIEVEMENT_MARATHON, var2, TimeRefresher, self.achievementService)

    self.achievementFoursCompany = Achievement.newWithRefresher(
        Achievement.NAMES.ACHIEVEMENT_FOURS_COMPANY,
        var8,
        FriendCountRefresher,
        self.achievementService
    )
    self.achievementScout = Achievement.new(Achievement.NAMES.ACHIEVEMENT_SCOUT, var4, self.achievementService)
    self.achievementExplorer = Achievement.new(Achievement.NAMES.ACHIEVEMENT_EXPLORER, var4, self.achievementService)
    self.achievementTrailblazer = Achievement.new(Achievement.NAMES.ACHIEVEMENT_TRAILBLAZER, var4, self.achievementService)

    self.achievementStrengthInNumbers = Achievement.new(Achievement.NAMES.ACHIEVEMENT_STRENGTH_IN_NUMBERS, var6, self.achievementService)

    if not FFlagInExpAchievementsIsolateStartUpErrors then
        self:_checkStrengthInNumbers(var7)

        self:_checkJoinExperienceAchievements(var5)
        return
    end

    local success, result = pcall(self._checkStrengthInNumbers, self, var7)
    if not success then
        Logger:warning("Failed to check Strength In Numbers achievement: " .. tostring(result))
    end

    local success2, result2 = pcall(self._checkJoinExperienceAchievements, self, var5)
    if not success2 then
        Logger:warning("Failed to check join experience achievements: " .. tostring(result2))
    end
end

function module:_checkJoinExperienceAchievements(callback)
    if self.achievementScout.hasAchieved ~= false
        and self.achievementExplorer.hasAchieved ~= false
        and self.achievementTrailblazer.hasAchieved ~= false
    then
        return
    end
    if not self.platformCloudStorageService or not self.platformCloudStorageService:IsUserDataAvailable() then
        GetUserRecentExperiences(self.requestImpl):andThen(function(arg1)
            callback(arg1)
        end):catch(function(arg1)
            Logger:warning(arg1)
        end)

        return
    end

    local data = self.platformCloudStorageService:GetUserDataAsync("ExperiencesPlayed").data or {}

    if #data < 15 and not Dash.includes(data, game.GameId) then
        table.insert(data, game.GameId)
        self.platformCloudStorageService:SetUserDataAsync("ExperiencesPlayed", { data = data })
    end
    callback(#data)
end

function module:_checkStrengthInNumbers(callback)
    if self.achievementStrengthInNumbers.hasAchieved ~= false then
        return
    end

    local localPlayer = self.playersService.LocalPlayer

    if localPlayer
        and localPlayer.FollowUserId ~= 0
        and localPlayer:IsFriendsWithAsync(localPlayer.FollowUserId)
        and self.playersService:GetPlayerByUserId(localPlayer.FollowUserId)
    then
        callback(0)
    end
end

function module.new(requestImpl, platformFriendsService, platformCloudStorageService, achievementService, playersService, platformService)
    return (setmetatable({
        requestImpl = requestImpl or var1,
        platformFriendsService = platformFriendsService or PlatformFriendsService,
        platformCloudStorageService = platformCloudStorageService or PlatformCloudStorageService,
        achievementService = achievementService or AchievementService,
        playersService = playersService or Players,
        platformService = platformService or PlatformService
    }, { __index = module }))
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Achievements = script:FindFirstAncestor("Achievements")
local AvatarEditorService = game:GetService("AvatarEditorService")

local AchievementsParent = Achievements.Parent
local Signal = require(AchievementsParent.Signal)
local Signals = require(AchievementsParent.Signals)
local Achievement = require(Achievements.Achievement.Achievement)
local Logger = require(Achievements.Logger)
local LoginStatus = require(AchievementsParent.RobloxAppEnums).LoginStatus
local HttpRequest = require(AchievementsParent.HttpRequest)

local FFlagUseSignalsForAuthenticationStatus = require(AchievementsParent.SharedFlags).FFlagUseSignalsForAuthenticationStatus
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AchievementsParent.AuthenticationStatus).GetAuthenticationStatusStore else nil
local GetXboxLoginConsecutiveDays = require(Achievements.Requests.GetXboxLoginConsecutiveDays)

local VoteCountRefresher = require(Achievements.AchievementDataRefresher.VoteCountRefresher)

local FFlagLuaAppDefaultHttpRetry = require(AchievementsParent.SharedFlags).FFlagLuaAppDefaultHttpRetry

local FFlagGateLoginStreaksByAchievementAvailability = require(Achievements.Flags.FFlagGateLoginStreaksByAchievementAvailability)
local FFlagFixAvatarSaveAchievementListenerRace = require(Achievements.Flags.FFlagFixAvatarSaveAchievementListenerRace)

local engineFeature = game:GetEngineFeature("AchievementServiceIsAchievementAvailable")
local var1 = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("InAppAchievementManagerHttpRetryCount", 4) else nil
})

local PlatformCloudStorageService = nil
pcall(function()
    PlatformCloudStorageService = game:GetService("PlatformCloudStorageService")
end)

local AchievementService = nil

pcall(function()
    AchievementService = game:GetService("AchievementService")
end)

local module = ({})

function module:startUp()
    task.spawn(function()
        self:initAchievements()
    end)
end

function module:initAchievements()
    local var2, var3 = Signal.createReadableSignal(0)
    local var4, var5 = Signal.createReadableSignal(0)
    local var6, var7 = Signal.createReadableSignal(false)

    VoteCountRefresher:init(var3, self.store, self.requestImpl, self.platformCloudStorageService)

    self.achievementPollster = Achievement.newWithRefresher(Achievement.NAMES.ACHIEVEMENT_POLLSTER, var2, VoteCountRefresher, self.achievementService)

    self.achievement3DayRoll = Achievement.new(Achievement.NAMES.ACHIEVEMENT_3_DAY_ROLL, var4, self.achievementService)

    self.achievement10DayRoll = Achievement.new(Achievement.NAMES.ACHIEVEMENT_10_DAY_ROLL, var4, self.achievementService)

    self.achievement20DayRoll = Achievement.new(Achievement.NAMES.ACHIEVEMENT_20_DAY_ROLL, var4, self.achievementService)

    self.achievementOneNameManyFaces = Achievement.new(Achievement.NAMES.ACHIEVEMENT_ONE_NAME_MANY_FACES, var6, self.achievementService)

    self:setupAchievements(var5, var7)
end

function module:hasPendingLoginStreakAchievement()
    for _, value in { self.achievement3DayRoll, self.achievement10DayRoll, self.achievement20DayRoll } do
        if value.hasAchieved == false and self.achievementService:IsAchievementAvailable(value.achievementName) then
            return true
        end
    end
    return false
end

function module:setupAchievements(callback, callback2)
    if if FFlagGateLoginStreaksByAchievementAvailability and engineFeature then self:hasPendingLoginStreakAchievement() else self.achievement3DayRoll.hasAchieved == false
        or self.achievement10DayRoll.hasAchieved == false
        or self.achievement20DayRoll.hasAchieved == false then
        GetXboxLoginConsecutiveDays(self.requestImpl):andThen(function(arg1)
            if arg1.responseBody == nil then
                Logger:warning("Response body is empty.")
                return
            end

            local count = arg1.responseBody.count
            if count == nil then
                Logger:warning("Day count is missing.")
                return
            end

            callback(count)
        end):catch(function(arg1)
            Logger:warning(arg1)
        end)
    end

    if FFlagFixAvatarSaveAchievementListenerRace and self.saveAvatarCompletedConnection then
        self.saveAvatarCompletedConnection:Disconnect()
        self.saveAvatarCompletedConnection = nil
    end

    if self.achievementOneNameManyFaces.hasAchieved ~= false then
        return
    end

    if not FFlagFixAvatarSaveAchievementListenerRace then
        self.saveAvatarCompletedConnection = self.avatarEditorService.PromptSaveAvatarCompleted:Connect(function(result: Enum.AvatarPromptResult)
            if result == Enum.AvatarPromptResult.Success then
                callback2(true)
                self.saveAvatarCompletedConnection:Disconnect()
                self.saveAvatarCompletedConnection = nil
            end
        end)

        return
    end

    local connection = nil
    connection = self.avatarEditorService.PromptSaveAvatarCompleted:Connect(function(result: Enum.AvatarPromptResult)
        if result ~= Enum.AvatarPromptResult.Success or not connection.Connected then
            return
        end
        connection:Disconnect()
        if self.saveAvatarCompletedConnection == connection then
            self.saveAvatarCompletedConnection = nil
        end
        callback2(true)
    end)

    self.saveAvatarCompletedConnection = connection
end

function module:shutDown()
    self.achievementPollster = nil
    self.achievement3DayRoll = nil
    self.achievement10DayRoll = nil
    self.achievement20DayRoll = nil
    VoteCountRefresher:stop()

    if self.saveAvatarCompletedConnection and self.saveAvatarCompletedConnection.Connected then
        self.saveAvatarCompletedConnection:Disconnect()
        self.saveAvatarCompletedConnection = nil
    end
end

function module.new(store, requestImpl, avatarEditorService, platformCloudStorageService, achievementService)
    local self = setmetatable({
        store = store,
        requestImpl = requestImpl or var1,
        avatarEditorService = avatarEditorService or AvatarEditorService,
        platformCloudStorageService = platformCloudStorageService or PlatformCloudStorageService,
        achievementService = achievementService or AchievementService
    }, { __index = module })

    if not FFlagUseSignalsForAuthenticationStatus then
        store.changed:connect(function(arg1, arg2)
            local var2 = if arg1.AuthenticationStatus then arg1.AuthenticationStatus.status else LoginStatus.UNKNOWN
            local var3 = if arg2.AuthenticationStatus then arg2.AuthenticationStatus.status else LoginStatus.UNKNOWN

            if var2 == var3 then
                return
            end

            if var2 == LoginStatus.LOGGED_IN then
                self:startUp()
                return
            end

            if var2 == LoginStatus.LOGGED_OUT then
                self:shutDown()
            end
        end)

        return self
    end

    self._authStatusInitialized = false
    self._lastAuthStatus = nil
    self._disposeAuthStatus = Signals.createEffect(function(arg1)
        local _lastAuthStatus = GetAuthenticationStatusStore(false).getStatus(arg1)
        if not self._authStatusInitialized then
            self._authStatusInitialized = true
            self._lastAuthStatus = _lastAuthStatus
            return
        end
        if _lastAuthStatus == self._lastAuthStatus then
            return
        end

        self._lastAuthStatus = _lastAuthStatus
        if _lastAuthStatus == LoginStatus.LOGGED_IN then
            self:startUp()
        elseif _lastAuthStatus == LoginStatus.LOGGED_OUT then
            self:shutDown()
        end
    end)

    return self
end

return module

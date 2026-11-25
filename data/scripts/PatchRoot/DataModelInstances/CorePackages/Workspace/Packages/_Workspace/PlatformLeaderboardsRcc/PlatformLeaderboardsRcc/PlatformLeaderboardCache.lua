-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Signal = require(scriptParentParent.AppCommonLib).Signal

local _PlatformLeaderboardTypes = require(scriptParent.PlatformLeaderboardTypes)

local num1 = game:DefineFastInt("PlatformLeaderboardGlobalIntervalSeconds", 180)
local num2 = game:DefineFastInt("PlatformLeaderboardGlobalJitterSeconds", 30)

local num3 = game:DefineFastInt("PlatformLeaderboardFriendsIntervalSeconds", 180)
local num4 = game:DefineFastInt("PlatformLeaderboardFriendsJitterSeconds", 30)

local module = {}
module.__index = module

local task2 = task

function module.new(_fetcher, _config, _scheduler)
    return (setmetatable({
        _fetcher = _fetcher,
        _config = _config,
        _globalData = nil,
        _globalEntriesByUserId = {},
        _friendsData = {},
        _userScoreEntries = {},
        _globalTimer = nil,
        _currentlyActiveGlobalLeaderboardViewersByUserId = {},
        _friendsTimer = nil,
        _currentFriendsLeaderboardViewersById = {},
        _scheduler = _scheduler or task2,
        _globalUpdated = Signal.new(),
        _friendsUpdated = Signal.new(),
        _userScoreUpdated = Signal.new()
    }, module))
end

function module:onGlobalUpdated(func1: (...any) -> (...any))
    return self._globalUpdated:connect(func1)
end

function module:onFriendsUpdated(func1: (...any) -> (...any))
    return self._friendsUpdated:connect(func1)
end

function module:onUserScoreUpdated(func1: (...any) -> (...any))
    return self._userScoreUpdated:connect(func1)
end

function module:getGlobalData()
    return self._globalData
end

function module:getFriendsData(num5: number)
    return self._friendsData[num5]
end

function module:getUserScore(num5: number)
    return self._userScoreEntries[num5]
end

function module:_rebuildGlobalIndex()
    table.clear(self._globalEntriesByUserId)
    if not self._globalData then
        return
    end
    for _, value in self._globalData.entries do
        self._globalEntriesByUserId[value.userId] = value
    end
end

function module:resolveRankFromCache(num5: number)
    local var1 = self._globalEntriesByUserId[num5]
    return if var1 then var1.rank else nil
end

function module:_resolveEntryFromGlobalLeaderboard(num5: number)
    return self._globalEntriesByUserId[num5]
end

function module:_fetchUserScoreForUser(num5: number)
    if self._userScoreEntries[num5] then
        self._userScoreUpdated:fire(num5, self._userScoreEntries[num5])
        return
    end

    local var1 = self:_resolveEntryFromGlobalLeaderboard(num5)
    if var1 then
        self._userScoreEntries[num5] = var1
        self._userScoreUpdated:fire(num5, var1)
        return
    end

    local success, result, result2 = pcall(self._fetcher.fetchUserScore, self._config.leaderboardId, num5)
    if success and result then
        self._userScoreEntries[num5] = result2
        self._userScoreUpdated:fire(num5, result2)
    end
end

function module:_resolveUserScoresParallel()
    table.clear(self._userScoreEntries)
    for value in self._currentlyActiveGlobalLeaderboardViewersByUserId do
        self._scheduler.spawn(function()
            self:_fetchUserScoreForUser(value)
        end)
    end
end

function module:_fetchFriendsLeaderboardForUser(num5: number)
    local success, result, result2 = pcall(self._fetcher.fetchFriendsLeaderboard, self._config.leaderboardId, num5)

    if not success or not result or not result2 then
        return
    end

    local tbl1 = {
        entries = result2.entries,
        lastRefreshedAt = os.time()
    }
    self._friendsData[num5] = tbl1
    self._friendsUpdated:fire(num5, tbl1, result2.config)
end

function module:startGlobalRefresh(num5: number)
    local var1 = self._currentlyActiveGlobalLeaderboardViewersByUserId[num5]
    self._currentlyActiveGlobalLeaderboardViewersByUserId[num5] = true
    if self._globalTimer then
        if not var1 then
            self:_fetchUserScoreForUser(num5)
        end
        return
    end

    local var2 = nil
    local function loop()
        repeat
            local success, result, result2 = pcall(self._fetcher.fetchGlobalLeaderboard, self._config.leaderboardId)

            if success and result and result2 then
                local _globalData = {
                    entries = result2.entries,
                    lastRefreshedAt = os.time()
                }
                self._globalData = _globalData
                self:_rebuildGlobalIndex()
                self._globalUpdated:fire(_globalData, result2.config)
            end
            self:_resolveUserScoresParallel()

            local num6 = math.random(-num2, num2)
            self._scheduler.wait(math.max(1, num1 + num6))
        until self._globalTimer ~= var2
    end

    var2 = self._scheduler.defer(function()
        if not pcall(loop) and self._globalTimer == var2 then
            self._globalTimer = nil
        end
    end)
    self._globalTimer = var2
end

function module:stopGlobalRefresh(num5: number)
    self._currentlyActiveGlobalLeaderboardViewersByUserId[num5] = nil
    self._userScoreEntries[num5] = nil
    if next(self._currentlyActiveGlobalLeaderboardViewersByUserId) then
        return
    end

    if self._globalTimer then
        pcall(self._scheduler.cancel, self._globalTimer)
        self._globalTimer = nil
    end
    self._globalData = nil
    table.clear(self._globalEntriesByUserId)
end

function module:startFriendsRefresh(num5: number)
    self._currentFriendsLeaderboardViewersById[num5] = true
    if self._friendsTimer then
        if not self._friendsData[num5] then
            self:_fetchFriendsLeaderboardForUser(num5)
        end
        return
    end

    local var1 = nil

    local bool1 = true
    local function loop()
        repeat
            table.clear(self._friendsData)
            for value in self._currentFriendsLeaderboardViewersById do
                local num6 = if bool1 then 0 else math.random(0, num4)
                self._scheduler.spawn(function()
                    self._scheduler.wait(num6)
                    if self._currentFriendsLeaderboardViewersById[value] then
                        self:_fetchFriendsLeaderboardForUser(value)
                    end
                end)
            end
            bool1 = false

            self._scheduler.wait(math.max(1, num3))
        until self._friendsTimer ~= var1
    end

    var1 = self._scheduler.defer(function()
        if not pcall(loop) and self._friendsTimer == var1 then
            self._friendsTimer = nil
        end
    end)
    self._friendsTimer = var1
end

function module:stopFriendsRefresh(num5: number)
    self._currentFriendsLeaderboardViewersById[num5] = nil
    if next(self._currentFriendsLeaderboardViewersById) then
        return
    end

    if self._friendsTimer then
        pcall(self._scheduler.cancel, self._friendsTimer)
        self._friendsTimer = nil
    end
end

function module:forceRefresh(_config, bool1: boolean)
    self._config = _config

    if bool1 then
        self._globalData = nil
        table.clear(self._globalEntriesByUserId)
        table.clear(self._friendsData)
        table.clear(self._userScoreEntries)
    end

    local var1 = next(self._currentlyActiveGlobalLeaderboardViewersByUserId)
    if self._globalTimer and var1 then
        pcall(self._scheduler.cancel, self._globalTimer)
        self._globalTimer = nil
        self:startGlobalRefresh(var1)
    end

    if not self._friendsTimer then
        return
    end

    pcall(self._scheduler.cancel, self._friendsTimer)
    self._friendsTimer = nil

    local tbl1 = {}
    for value in self._currentFriendsLeaderboardViewersById do
        table.insert(tbl1, value)
    end
    table.clear(self._currentFriendsLeaderboardViewersById)

    for _, value in tbl1 do
        self:startFriendsRefresh(value)
    end
end

function module.cleanupForUserId(arg1, num5: number)
    arg1:stopGlobalRefresh(num5)
    arg1:stopFriendsRefresh(num5)
end

function module:teardown()
    if self._globalTimer then
        pcall(self._scheduler.cancel, self._globalTimer)
    end
    self._globalTimer = nil
    self._globalData = nil
    table.clear(self._globalEntriesByUserId)
    table.clear(self._currentlyActiveGlobalLeaderboardViewersByUserId)
    if self._friendsTimer then
        pcall(self._scheduler.cancel, self._friendsTimer)
    end
    self._friendsTimer = nil
    table.clear(self._currentFriendsLeaderboardViewersById)
    table.clear(self._friendsData)
    table.clear(self._userScoreEntries)
end

function module.destroy(arg1)
    arg1:teardown()
end

return module

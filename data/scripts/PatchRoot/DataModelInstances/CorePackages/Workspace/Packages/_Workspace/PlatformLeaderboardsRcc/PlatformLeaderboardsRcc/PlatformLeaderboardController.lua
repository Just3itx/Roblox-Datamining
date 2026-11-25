-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local PlatformLeaderboardTypes = require(scriptParent.PlatformLeaderboardTypes)
local PlatformLeaderboardCache = require(scriptParent.PlatformLeaderboardCache)
local _PlatformLeaderboardConfigService = require(scriptParent.PlatformLeaderboardConfigService)
local SharedFlags = require(scriptParentParent.SharedFlags)

local EventType = PlatformLeaderboardTypes.EventType
local LeaderboardType = PlatformLeaderboardTypes.LeaderboardType
local RemoteEventName = PlatformLeaderboardTypes.RemoteEventName

local num1 = game:DefineFastInt("PlatformLeaderboardTabEventRateLimit", 20)

local num2 = game:DefineFastInt("PlatformLeaderboardTabEventRateWindowSeconds", 10)
local FFlagPlatformLeaderboardDebugLogging = SharedFlags.FFlagPlatformLeaderboardDebugLogging

local module = {}
module.__index = module

function module.new(_configService, _fetcher)
    return (setmetatable({
        _configService = _configService,
        _fetcher = _fetcher,
        _cache = nil,
        _pushEvent = nil,
        _conns = {},
        _playerTabs = {},
        _rateLimits = {}
    }, module))
end

function module:_onConfigChanged(arg1, config)
    self:_pushToAll({ type = EventType.ConfigUpdate, config = config })

    if not config then
        if self._cache then
            self._cache:teardown()
            self._cache = nil
        end
        table.clear(self._playerTabs)
        return
    end

    if not self._cache then
        self:_initializeCache(config)
    elseif arg1 then
        local bool1 = arg1.leaderboardId == config.leaderboardId
        self._cache:forceRefresh(config, not bool1)
    end
end

function module:_initializeCache(arg1)
    self._cache = PlatformLeaderboardCache.new(self._fetcher, arg1)
    local _cache = self._cache

    table.insert(self._conns, _cache:onGlobalUpdated(function(arg2, arg3)
        self:_pushToGlobalViewers({ type = EventType.GlobalLeaderboardData, data = arg2 })
        if arg3 then
            self._configService:updateConfig(arg3)
        end
    end))

    table.insert(self._conns, _cache:onFriendsUpdated(function(userId: number, arg2, arg3)
        local player = Players:GetPlayerByUserId(userId)
        if player then
            self:_pushToPlayer(player, { type = EventType.FriendsLeaderboardData, userId = userId, data = arg2 })
        end

        if arg3 then
            self._configService:updateConfig(arg3)
        end
    end))

    table.insert(self._conns, _cache:onUserScoreUpdated(function(userId: number, entry)
        local player = Players:GetPlayerByUserId(userId)
        if not player then
            return
        end

        self:_pushToPlayer(player, { type = EventType.UserScore, userId = userId, entry = entry })
    end))
end

function module:initialize()
    self._pushEvent = Instance.new("RemoteEvent")
    self._pushEvent.Name = RemoteEventName.Push
    self._pushEvent.Parent = RobloxReplicatedStorage

    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = RemoteEventName.TabOpened
    remoteEvent.Parent = RobloxReplicatedStorage

    local remoteEvent2 = Instance.new("RemoteEvent")
    remoteEvent2.Name = RemoteEventName.TabClosed
    remoteEvent2.Parent = RobloxReplicatedStorage

    self._pushEvent.OnServerEvent:Connect(function() end)

    local config = self._configService:getConfig()
    if config then
        self:_initializeCache(config)
    end

    local _conns = self._conns
    local _configService = self._configService

    table.insert(_conns, _configService:onConfigChanged(function(arg1, arg2)
        self:_onConfigChanged(arg1, arg2)
    end))

    self:_pushToAll({ type = EventType.ConfigUpdate, config = self._configService:getConfig() })

    local _conns2 = self._conns
    local onServerEvent = remoteEvent.OnServerEvent

    table.insert(_conns2, onServerEvent:Connect(function(player: Player, arguments)
        if self:_isRateLimited(player.UserId) then
            return
        end
        local var1 = self:_validateTabPayload(player, arguments)
        if var1 then
            self:_onTabOpened(player, var1)
        end
    end))

    local _conns3 = self._conns
    local onServerEvent2 = remoteEvent2.OnServerEvent

    table.insert(_conns3, onServerEvent2:Connect(function(player: Player, arguments)
        if self:_isRateLimited(player.UserId) then
            return
        end
        local var1 = self:_validateTabPayload(player, arguments)
        if var1 then
            self:_onTabClosed(player, var1)
        end
    end))

    local _conns4 = self._conns
    local playerAdded = Players.PlayerAdded

    table.insert(_conns4, playerAdded:Connect(function(player: Player)
        task.defer(function()
            self:_pushToPlayer(player, { type = EventType.ConfigUpdate, config = self._configService:getConfig() })
        end)
    end))

    local _conns5 = self._conns
    local playerRemoving = Players.PlayerRemoving

    table.insert(_conns5, playerRemoving:Connect(function(player: Player)
        self:_removePlayerFromAllTabs(player.UserId)
    end))
end

function module:_isRateLimited(num3: number)
    local windowStart = os.clock()
    local _rateLimit = self._rateLimits[num3]
    if _rateLimit ~= nil and not (windowStart - _rateLimit.windowStart >= num2) then
        if _rateLimit.count >= num1 then
            return true
        end
        _rateLimit.count += 1
        return false
    end

    self._rateLimits[num3] = { windowStart = windowStart, count = 1 }
    return false
end

function module:_validateTabPayload(arg1, arg2)
    if typeof(arg2) ~= "table" then
        return nil
    end
    local tabType = arg2.tabType
    if typeof(tabType) ~= "string" then
        return nil
    end
    local userId = arg2.userId
    return if userId == nil or userId == arg1.UserId then { tabType = tabType } else nil
end

function module:_removePlayerFromAllTabs(num3: number)
    if self._cache then
        self._cache:cleanupForUserId(num3)
    end
    self._playerTabs[num3] = nil
    self._rateLimits[num3] = nil
end

function module:_onTabOpened(arg1, tbl1)
    local _cache = self._cache
    if not _cache then
        return
    end

    local _playerTab = self._playerTabs[arg1.UserId] or {}
    self._playerTabs[arg1.UserId] = _playerTab

    if tbl1.tabType == LeaderboardType.Global then
        if not _playerTab.global then
            _playerTab.global = true
            _cache:startGlobalRefresh(arg1.UserId)
            local globalData = _cache:getGlobalData()
            if globalData then
                self:_pushToPlayer(arg1, { type = EventType.GlobalLeaderboardData, data = globalData })
            end
            local entry = _cache:getUserScore(arg1.UserId)
            if entry then
                self:_pushToPlayer(arg1, { type = EventType.UserScore, userId = arg1.UserId, entry = entry })
            end
        end
    elseif tbl1.tabType == LeaderboardType.Friends then
        if not _playerTab.friends then
            _playerTab.friends = true
            _cache:startFriendsRefresh(arg1.UserId)
            local friendsData = _cache:getFriendsData(arg1.UserId)
            if friendsData then
                self:_pushToPlayer(arg1, { type = EventType.FriendsLeaderboardData, userId = arg1.UserId, data = friendsData })
            end
        end
    elseif FFlagPlatformLeaderboardDebugLogging then
        warn("[PlatformLeaderboard] Unknown tabType:", tbl1.tabType)
    end
end

function module:_onTabClosed(arg1, tbl1)
    if not self._cache then
        return
    end
    local _cache = self._cache
    local _playerTab = self._playerTabs[arg1.UserId]

    if tbl1.tabType == LeaderboardType.Global and _playerTab and _playerTab.global then
        _playerTab.global = nil
        _cache:stopGlobalRefresh(arg1.UserId)
    elseif tbl1.tabType == LeaderboardType.Friends and _playerTab and _playerTab.friends then
        _playerTab.friends = nil
        _cache:stopFriendsRefresh(arg1.UserId)
    end
end

function module:_pushToAll(arg1)
    if self._pushEvent then
        self._pushEvent:FireAllClients(arg1)
    end
end

function module:_pushToGlobalViewers(arg1)
    if not self._pushEvent then
        return
    end
    for _, player in Players:GetPlayers() do
        local _playerTab = self._playerTabs[player.UserId]
        if _playerTab and _playerTab.global then
            self._pushEvent:FireClient(player, arg1)
        end
    end
end

function module:_pushToPlayer(arg1, arg2)
    if self._pushEvent then
        self._pushEvent:FireClient(arg1, arg2)
    end
end

function module:destroy()
    for _, _conn in self._conns do
        if typeof(_conn) == "table" and _conn.disconnect then
            _conn:disconnect()
        elseif typeof(_conn) == "RBXScriptConnection" then
            _conn:Disconnect()
        end
    end
    table.clear(self._conns)
    self._configService:teardown()
    if self._cache then
        self._cache:destroy()
    end
    if self._pushEvent then
        self._pushEvent:Destroy()
    end
end

return module

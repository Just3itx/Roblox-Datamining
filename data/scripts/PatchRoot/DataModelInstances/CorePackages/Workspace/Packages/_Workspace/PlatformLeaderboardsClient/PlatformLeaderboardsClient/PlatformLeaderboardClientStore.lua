-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local IXPService = game:GetService("IXPService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local timeOut = game:DefineFastInt("PlatformLeaderboardPushWaitTimeoutSeconds", 30)
local bool1 = game:DefineFastFlag("PlatformLeaderboardsExposure2Enabled_V2", false)

local layerName = game:DefineFastString("PlatformLeaderboardsExposure2Layer", "Social.PlatformLeaderboardsExposure2")

local bool2 = game:DefineFastFlag("PlatformLeaderboardLocalizedUnitEnabled", false)

local bool3 = game:DefineFastFlag("PlatformLeaderboardBadgeMetadataEnabled", false)

local bool4 = game:DefineFastFlag("PlatformLeaderboardsIXPNoLeaderboardsShown_V3", false)

local scriptParentParent = script.Parent.Parent
local Signals = require(scriptParentParent.Signals)
local Url = require(scriptParentParent.CoreScriptsCommon).Url

local createSignalMap = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local function getPlayerPermissionsModule() -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function()
        local robloxGui = CoreGui:WaitForChild("RobloxGui")
        return require(robloxGui.Modules.PlayerPermissionsModule)
    end)
    return if success then result else nil
end

local function resolveIsLocalPlayerCreator(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return false
    end

    local playerPermissionsModule = getPlayerPermissionsModule()

    if not playerPermissionsModule then
        return false
    end
    local success, result = pcall(function()
        return playerPermissionsModule.CanPlayerManagePlaceAsync(localPlayer)
    end)
    return success and result == true
end

local module = {}
module.__index = module

function module.new()
    local getHasActiveLeaderboard, _setHasActiveLeaderboard = Signals.createSignal(false)
    local getGlobalLastRefreshedAt, _setGlobalLastRefreshedAt = Signals.createSignal(nil)
    local getFriendsLastRefreshedAt, _setFriendsLastRefreshedAt = Signals.createSignal(nil)
    local getUserScore, _setUserScore = Signals.createSignal(nil)
    local getUserRank, _setUserRank = Signals.createSignal(nil)
    local getUnit, _setUnit = Signals.createSignal(nil)
    local getUserFriendRank, _setUserFriendRank = Signals.createSignal(nil)
    local getUserFriendScore, _setUserFriendScore = Signals.createSignal(nil)
    local var17, var18, var19, var20

    if bool3 then
        var17, var18 = Signals.createSignal(nil)
        var19, var20 = Signals.createSignal(nil)
    else
        var17 = nil
        var19 = nil
        var18 = nil
        var20 = nil
    end

    local self = setmetatable({
        getHasActiveLeaderboard = getHasActiveLeaderboard,
        globalEntries = createSignalMap(),
        friendsEntries = createSignalMap(),
        getGlobalLastRefreshedAt = getGlobalLastRefreshedAt,
        getFriendsLastRefreshedAt = getFriendsLastRefreshedAt,
        getUserScore = getUserScore,
        getUserRank = getUserRank,
        getUnit = getUnit,
        getUserFriendRank = getUserFriendRank,
        getUserFriendScore = getUserFriendScore,
        getUserIsVerified = var17,
        getUserHasRobloxSubscription = var19,
        _setHasActiveLeaderboard = _setHasActiveLeaderboard,
        _setGlobalLastRefreshedAt = _setGlobalLastRefreshedAt,
        _setFriendsLastRefreshedAt = _setFriendsLastRefreshedAt,
        _setUserScore = _setUserScore,
        _setUserRank = _setUserRank,
        _setUnit = _setUnit,
        _setUserFriendRank = _setUserFriendRank,
        _setUserFriendScore = _setUserFriendScore,
        _setUserIsVerified = var18,
        _setUserHasRobloxSubscription = var20,
        _globalEntrySetters = {},
        _friendsEntrySetters = {},
        _conn = nil
    }, module)

    task.spawn(function()
        local platformLeaderboardPush = RobloxReplicatedStorage:WaitForChild("PlatformLeaderboardPush", timeOut)

        if not platformLeaderboardPush then
            return
        end
        self._conn = platformLeaderboardPush.OnClientEvent:Connect(function(tbl1)
            self:_handleEvent(tbl1)
        end)
    end)

    return self
end

function module:_updateEntries(arg1, tbl1, tbl2)
    local tbl3 = ({})

    for _, value in ipairs(tbl2) do
        local userId = value.userId
        tbl3[userId] = true

        local var1 = tbl1[userId]
        if var1 then
            var1.setScore(value.score)
            var1.setRank(value.rank)
            local data = arg1.getData(userId, false)
            if data
                and (data.displayName ~= value.displayName
                    or bool3 and (data.isVerified ~= value.isVerified or data.hasRobloxSubscription ~= value.hasRobloxSubscription))
            then
                arg1.setData(userId, {
                    getScore = data.getScore,
                    getRank = data.getRank,
                    displayName = value.displayName,
                    isVerified = if bool3 then value.isVerified else nil,
                    hasRobloxSubscription = if bool3 then value.hasRobloxSubscription else nil
                }, false)
            end
        else
            local getScore, setScore = Signals.createSignal(value.score)
            local getRank, setRank = Signals.createSignal(value.rank)

            tbl1[userId] = { setScore = setScore, setRank = setRank }

            arg1.setData(userId, {
                getScore = getScore,
                getRank = getRank,
                displayName = value.displayName,
                isVerified = if bool3 then value.isVerified else nil,
                hasRobloxSubscription = if bool3 then value.hasRobloxSubscription else nil
            }, false)
        end
    end

    local allData = arg1.getAllData(false)
    for k, _ in pairs(allData) do
        if not tbl3[k] then
            arg1.removeData(k, false)
            tbl1[k] = nil
        end
    end
end

function module:_handleEvent(tbl1)
    if bool1 and tbl1.config ~= nil then
        IXPService:LogFlagLinkedUserLayerExposure(layerName)
    end

    if bool4 and not resolveIsLocalPlayerCreator() then
        return
    end

    if tbl1.type == "CONFIG_UPDATE" then
        self._setHasActiveLeaderboard(tbl1.config ~= nil)
        self._setUnit(if tbl1.config then tbl1.config.unit else nil)
        if bool2 and tbl1.config then
            self:_fetchLocalizedUnit()
        end

        return
    elseif tbl1.type == "GLOBAL_LEADERBOARD_DATA" then
        if tbl1.data then
            self:_updateEntries(self.globalEntries, self._globalEntrySetters, tbl1.data.entries)
            self._setGlobalLastRefreshedAt(tbl1.data.lastRefreshedAt)
        end

        return
    elseif tbl1.type == "FRIENDS_LEADERBOARD_DATA" then
        if tbl1.data then
            self:_updateEntries(self.friendsEntries, self._friendsEntrySetters, tbl1.data.entries)
            self._setFriendsLastRefreshedAt(tbl1.data.lastRefreshedAt)
            if bool2 then
                self:_updateUserFriendRankAndScore(tbl1.data.entries)
            end
        end

        return
    end

    if tbl1.type ~= "USER_SCORE" then
        return
    end

    if tbl1.entry then
        self._setUserScore(tbl1.entry.score)
        self._setUserRank(tbl1.entry.rank)
        if bool3 then
            self._setUserIsVerified(tbl1.entry.isVerified)
            self._setUserHasRobloxSubscription(tbl1.entry.hasRobloxSubscription)
        end
    else
        self._setUserScore(nil)
        self._setUserRank(nil)
        if bool3 then
            self._setUserIsVerified(nil)
            self._setUserHasRobloxSubscription(nil)
        end
    end
end

function module:_updateUserFriendRankAndScore(tbl1)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    local userId = localPlayer.UserId
    for _, value in ipairs(tbl1) do
        if value.userId == userId then
            self._setUserFriendRank(value.rank)
            self._setUserFriendScore(value.score)
            return
        end
    end
    self._setUserFriendRank(nil)
    self._setUserFriendScore(nil)
end

function module:_fetchLocalizedUnit()
    task.spawn(function()
        local gameId = game.GameId
        local apiUrl = `{Url.APIS_URL}platform-leaderboards-api/v1/universes/{gameId}/leaderboard/localized`

        local success, result = pcall(function(): string
            return HttpRbxApiService:GetAsyncFullUrl(apiUrl)
        end)
        if not success then
            warn("[PlatformLeaderboard] Failed to fetch localized unit:", tostring(result))
            return
        end

        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if not success2 or typeof(result2) ~= "table" then
            warn("[PlatformLeaderboard] Failed to decode localized unit response")
            return
        end

        local localizedUnit = result2.localizedUnit
        if typeof(localizedUnit) == "string" then
            self._setUnit(localizedUnit)
        end
    end)
end

function module.fireTabOpened(_, tabType: string)
    local platformLeaderboardTabOpened = RobloxReplicatedStorage:FindFirstChild("PlatformLeaderboardTabOpened")
    if platformLeaderboardTabOpened then
        platformLeaderboardTabOpened:FireServer({ tabType = tabType })
    end
end

function module.fireTabClosed(_, tabType: string)
    local platformLeaderboardTabClosed = RobloxReplicatedStorage:FindFirstChild("PlatformLeaderboardTabClosed")
    if platformLeaderboardTabClosed then
        platformLeaderboardTabClosed:FireServer({ tabType = tabType })
    end
end

function module:destroy()
    if self._conn then
        self._conn:Disconnect()
        self._conn = nil
    end
end

return module

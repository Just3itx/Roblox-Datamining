-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local scriptParentParent = script.Parent.Parent

local SharedFlags = require(scriptParentParent.SharedFlags)
local Signals = require(scriptParentParent.Signals)

local CoreScriptsRoactCommon = require(scriptParentParent.CoreScriptsRoactCommon)
local createSignalMap = CoreScriptsRoactCommon.Utilities.createSignalMap
local sortTableByValue = CoreScriptsRoactCommon.Utilities.sortTableByValue

local createPlayerStore = require(script.Parent.createPlayerStore)
local createTeamStore = require(script.Parent.createTeamStore)
local _LeaderboardStoreTypes = require(script.Parent.LeaderboardStoreTypes)

local bool1 = game:DefineFastFlag("FilterNewPlayerListValueStat", false)
local bool2 = game:DefineFastFlag("PlayerListHideUnusedStats", false)
local FFlagPlayerListFixLeaderstatsStacking = SharedFlags.FFlagPlayerListFixLeaderstatsStacking
local bool3 = game:DefineFastFlag("PlayerListSortByLowercaseUsername", false)

local module = ({})
module.__index = module

function module.new(_teamsService, _playersService)
    local self = setmetatable({ _leaderboardConnections = {} }, module)

    self._teamStores = {}
    self._playerStores = {}

    self._teamsService = _teamsService
    self._playersService = _playersService

    local _getServerAddOrder, _setServerAddOrder = Signals.createSignal({})
    self._getServerAddOrder = _getServerAddOrder
    self._setServerAddOrder = _setServerAddOrder
    self._serverAddOrderConnection = {}
    self._serverInstanceAddedConnection = nil
    self._serverAddOrderEffectCleanup = nil
    self._gameStatMetadata = {}

    self._topGameStatsOrder = createSignalMap()
    self._topGameStatsOrderSetter = {}
    self._topGameStatSortOrder = {}

    self._gameStatsUsage = {}

    self._virtualTeamList = createSignalMap()

    self._teamStores.Neutral = createTeamStore("Neutral", _teamsService)

    local neutral = self._teamStores.Neutral
    self._virtualTeamList.setData("Neutral", {
        name = neutral.getName,
        color = neutral.getColor,
        order = neutral.getOrder,
        stats = neutral.getStats,
        players = neutral.getPlayers
    }, false)

    self:_connectPlayers()
    self:_connectTeams()
    self:_updateServerAddOrder()

    return self
end

function module:destroy()
    for _, value in pairs(self._serverAddOrderConnection) do
        if value.Disconnect then
            value:Disconnect()
        end
    end
    self._serverAddOrderConnection = {}
    if self._serverAddOrderEffectCleanup then
        self._serverAddOrderEffectCleanup()
    end
    if self._serverInstanceAddedConnection then
        self._serverInstanceAddedConnection:Disconnect()
    end
    self._serverInstanceAddedConnection = nil

    for _, _leaderboardConnection in pairs(self._leaderboardConnections) do
        if _leaderboardConnection.Disconnect then
            _leaderboardConnection:Disconnect()
        end
    end

    self._leaderboardConnections = {}

    for _, value in pairs(self._teamStores) do
        value.destroy()
    end
    self._teamStores = {}

    for _, value in pairs(self._playerStores) do
        value.destroy()
    end
    self._playerStores = {}
end

function module:getGameStatsList()
    return self._topGameStatsOrder
end

function module:getTeamList()
    return self._virtualTeamList
end

function module:getTeamPlayerList(arg1, _)
    local var1 = self._teamStores[arg1]
    if not var1 then
        return createSignalMap()
    end

    return var1.getPlayers
end

function module:getPlayerEntry(arg1, _)
    local var1 = self._playerStores[arg1]
    if not var1 then
        return nil
    end

    return var1.getPlayerEntry()
end

function module:_updateTeamStats(arg1, str1: string)
    local var1 = self._teamStores[arg1]
    if not var1 then
        return
    end

    var1.updateStat(str1, function(arg2, arg3, arg4)
        local var2 = self._playerStores[arg2]
        if var2 then
            return var2.getStatValue(arg3, arg4)
        end
        return nil
    end)
end

function module:_removeTeamStats(arg1, str1: string)
    local var1 = self._teamStores[arg1]
    if var1 then
        var1.removeStat(str1)
    end
end

function module:_updateAllTeamStats(str1: string)
    for k, _ in pairs(self._teamStores) do
        self:_updateTeamStats(k, str1)
    end
end

function module:_removeAllTeamStats(str1: string)
    for k, _ in pairs(self._teamStores) do
        self:_removeTeamStats(k, str1)
    end
end

function module:_shouldSortPlayers(_, str1: string?): boolean
    if not str1 then
        return true
    end

    if str1 == self._topGameStatSortOrder[1] and self._gameStatMetadata[str1] and self._gameStatMetadata[str1].isNumber then
        return true
    end

    if self._gameStatMetadata[str1] and self._gameStatMetadata[str1].priority == math.huge then
        return true
    end

    return not not (not self._topGameStatSortOrder[1] and self._gameStatMetadata[str1] and self._gameStatMetadata[str1].isNumber)
end

function module:_sortPlayers(arg1, str1: string?)
    if not self:_shouldSortPlayers(arg1, str1) then
        return
    end

    local var1 = self._teamStores[arg1]
    if not var1 then
        return
    end

    local allData = var1.getPlayers.getAllData(false)

    local var2 = sortTableByValue(allData, self:_compareStatsValue(self._topGameStatSortOrder))

    for i, value in ipairs(var2) do
        local key = value.key
        local var3 = self._playerStores[key]
        if var3 then
            var3.setOrder(i)
        end
    end
end

function module:_compareStatsValue(tbl1)
    return function(arg1, arg2)
        local var1 = tbl1[1]
        if var1 then
            local var2 = self._playerStores[arg1.key]
            local var3 = self._playerStores[arg2.key]

            if not var2 then
                return false
            end
            if not var3 then
                return true
            end

            local var4 = var2.getPlayerEntry().stats.getData(var1, false)
            if var4 == nil then
                return false
            end
            local var5 = var3.getPlayerEntry().stats.getData(var1, false)
            if var5 == nil then
                return true
            end
            local var6 = var4(false)
            local var7 = var5(false)
            if typeof(var6) == typeof(var7) and var6 ~= var7 then
                return self:_compareRawStatsValue(var6, var7)
            end
            if not bool3 then
                return arg1.key.Name < arg2.key.Name
            end
        end

        return arg1.key.DisplayName:lower() < arg2.key.DisplayName:lower()
    end
end

function module:_compareRawStatsValue(arg1, arg2): boolean
    return if arg1 == nil or arg2 == nil then arg2 ~= nil else arg2 < arg1
end

local function isGameStatValidNumber(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:IsA("NumberValue")
        or arg1:IsA("IntValue")
        or arg1:IsA("DoubleConstrainedValue")
        or arg1:IsA("IntConstrainedValue")
end

local function compareGameStats(arg1, arg2): boolean
    if arg1.value.priority == nil and arg2.value.priority == nil then
        return true
    end

    if arg1.value.priority == nil then
        return arg2.value.priority < 0
    end

    if arg2.value.priority == nil then
        return arg1.value.priority > 0
    end

    return arg1.value.priority > arg2.value.priority
end

function module:_updateGameStatsToShow()
    local tbl1 = ({})
    local var1 = sortTableByValue(self._gameStatMetadata, compareGameStats)

    self._topGameStatSortOrder = {}

    local num1 = 0
    for i, value in ipairs(var1) do
        if num1 >= 4 then
            break
        end

        if bool2 and not self._gameStatMetadata[value.key].isUsed then
            continue
        end

        local key = value.key
        tbl1[key] = i

        if self._topGameStatsOrder.getData(key, false) == nil then
            local order, var3 = Signals.createSignal(i)
            self._topGameStatsOrder.setData(key, { order = order }, false)
            self._topGameStatsOrderSetter[key] = var3
        else
            self._topGameStatsOrderSetter[key](i)
        end

        table.insert(self._topGameStatSortOrder, key)

        num1 += 1
    end

    for k, _ in pairs(self._topGameStatsOrder.getAllData(false)) do
        if not tbl1[k] then
            self._topGameStatsOrder.removeData(k, false)
            self._topGameStatsOrderSetter[k] = nil
        end
    end
end

function module:_updateGameStatOrder(arg1, num1: number?)
    local var1 = self._gameStatMetadata[arg1.Name]
    local priority = num1 or 0
    if var1 then
        if num1 == nil then
            self._gameStatMetadata[arg1.Name].hasPriority = false
        else
            self._gameStatMetadata[arg1.Name].hasPriority = true
        end
    end
    if var1.priority ~= priority then
        self._gameStatMetadata[arg1.Name].priority = priority
        self:_updateGameStatsToShow()
    end
end

function module:_updateServerAddOrder()
    local leaderstatsOrder = RobloxReplicatedStorage:GetAttribute("LeaderstatsOrder") or {}
    RobloxReplicatedStorage:GetAttributeChangedSignal("LeaderstatsOrder"):Connect(function()
        leaderstatsOrder = RobloxReplicatedStorage:GetAttribute("LeaderstatsOrder") or {}
        self._setServerAddOrder(leaderstatsOrder)
    end)

    local HttpService = game:GetService("HttpService")

    local function decodeJSON(input: string)
        return HttpService:JSONDecode(input)
    end

    local function decodeAddOrder(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local success, result = pcall(decodeJSON, str1)
        return success and result or {}
    end

    self._serverInstanceAddedConnection = nil

    local function childAdded(child: Instance)
        if child.Name ~= "LeaderstatsOrder" then
            return
        end
        if self._serverInstanceAddedConnection then
            self._serverInstanceAddedConnection:Disconnect()
        end
        leaderstatsOrder = decodeAddOrder(child.Value)
        self._serverAddOrderConnection[child] = child.Changed:Connect(function(arg1)
            leaderstatsOrder = decodeAddOrder(arg1)
            self._setServerAddOrder(leaderstatsOrder)
        end)
    end

    self._serverInstanceAddedConnection = RobloxReplicatedStorage.ChildAdded:Connect(childAdded)

    for _, child in ipairs(RobloxReplicatedStorage:GetChildren()) do
        childAdded(child)
    end

    self._serverAddOrderEffectCleanup = Signals.createEffect(function(arg1)
        local var1 = self._getServerAddOrder(arg1)
        local bool4 = false
        for k, value in pairs(var1) do
            if bool1 and value == 0 then
                continue
            end

            if self._gameStatMetadata[k] then
                if self._gameStatMetadata[k].hasPriority ~= true then
                    self._gameStatMetadata[k].priority = value * -1
                    bool4 = true
                end
            elseif not bool2 then
                local _gameStatMetadata = self._gameStatMetadata
                local tbl1 = {
                    priority = value * -1,
                    hasPriority = false
                }
                _gameStatMetadata[k] = tbl1
            end
        end

        if bool4 then
            self:_updateGameStatsToShow()
        end
    end)
end

function module:_updateGameStatPriority(arg1)
    local priority = arg1:FindFirstChild("Priority")
    local priorityValue = if priority and (priority:IsA("IntValue") or priority:IsA("NumberValue")) then priority.Value else nil
    local isPrimary = arg1:FindFirstChild("IsPrimary")
    if isPrimary then
        priorityValue = not isPrimary:IsA("BoolValue") and math.huge or isPrimary.Value and math.huge or priorityValue
    end

    self:_updateGameStatOrder(arg1, priorityValue)
end

function module:_addGameStat(arg1)
    if self._gameStatMetadata[arg1.Name] == nil then
        self._gameStatMetadata[arg1.Name] = {}
    end
    self._gameStatMetadata[arg1.Name].isNumber = isGameStatValidNumber(arg1)
    self:_updateGameStatPriority(arg1)
    if bool2 and not self._gameStatMetadata[arg1.Name].isUsed then
        self._gameStatMetadata[arg1.Name].isUsed = true
        self:_updateGameStatsToShow()
    end

    self._gameStatsUsage[arg1.Name] = if self._gameStatsUsage[arg1.Name] then self._gameStatsUsage[arg1.Name] + 1 else 1

    self:_updateAllTeamStats(arg1.Name)
end

function module:_removeGameStat(arg1)
    self._gameStatsUsage[arg1.Name] = if self._gameStatsUsage[arg1.Name] then self._gameStatsUsage[arg1.Name] - 1 else 0

    if not (self._gameStatsUsage[arg1.Name] <= 0) then
        self:_updateGameStatPriority(arg1)

        return
    end

    self._gameStatsUsage[arg1.Name] = nil
    self._topGameStatsOrder.removeData(arg1.Name, false)
    self._topGameStatsOrderSetter[arg1.Name] = nil
    self._gameStatMetadata[arg1.Name] = nil
    self:_updateGameStatsToShow()

    self:_updateAllTeamStats(arg1.Name)
end

if FFlagPlayerListFixLeaderstatsStacking then
    function module:_checkGameStatsExist()
        local tbl1 = ({})
        for value, _ in self._gameStatMetadata do
            tbl1[value] = false
        end

        for value, _ in self._playerStores do
            local leaderstats = value:FindFirstChild("leaderstats")
            if not leaderstats then
                continue
            end

            for value2, _ in tbl1 do
                if leaderstats:FindFirstChild(value2) then
                    tbl1[value2] = true
                end
            end
        end

        for value, value2 in tbl1 do
            if value2 then
                continue
            end

            self._gameStatsUsage[value] = nil
            self._topGameStatsOrder.removeData(value, false)
            self._topGameStatsOrderSetter[value] = nil
            self._gameStatMetadata[value] = nil
            self:_updateGameStatsToShow()
            self:_updateAllTeamStats(value)
        end
    end
end

function module:_createPlayerStore(arg1)
    return createPlayerStore(arg1, function(arg2)
        self:_addGameStat(arg2)
    end, function(arg2)
        self:_removeGameStat(arg2)
    end, function(arg2, arg3)
        self:_updateTeamStats(arg2, arg3)
    end, function(arg2, arg3)
        self:_sortPlayers(arg2, arg3)
    end, FFlagPlayerListFixLeaderstatsStacking and function()
        self:_checkGameStatsExist()
    end or nil)
end

function module:_createTeamStore(arg1)
    return createTeamStore(arg1, self._teamsService)
end

function module:_getOrCreateTeamStore(arg1)
    local var1 = self._teamStores[arg1]
    if not var1 then
        var1 = self:_createTeamStore(arg1)
        self._teamStores[arg1] = var1

        if arg1 ~= "Neutral" then
            self._virtualTeamList.setData(
                arg1,
                {
                    name = var1.getName,
                    color = var1.getColor,
                    order = var1.getOrder,
                    stats = var1.getStats,
                    players = var1.getPlayers
                },
                false
            )
        end
    end

    return var1
end

function module:_addPlayerStore(arg1)
    if self._playerStores[arg1] then
        return
    end

    local var1 = if arg1.Team then arg1.Team else "Neutral"
    self:_getOrCreateTeamStore(var1).addPlayer(arg1)

    local var2 = self:_createPlayerStore(arg1)
    self._playerStores[arg1] = var2

    self:_connectPlayerTeamChange(arg1)

    self:_sortPlayers(var1)
end

function module:_removePlayerStore(arg1)
    local var1 = self._playerStores[arg1]
    if not var1 then
        return
    end

    local team = var1.getTeam()
    local var2 = self._teamStores[team]
    if var2 then
        var2.removePlayer(arg1)
    end

    local var3 = "PlayerTeamChanged_" .. arg1.Name
    local _leaderboardConnection = self._leaderboardConnections[var3]
    if _leaderboardConnection and _leaderboardConnection.Disconnect then
        _leaderboardConnection:Disconnect()
        self._leaderboardConnections[var3] = nil
    end

    var1.destroy()
    self._playerStores[arg1] = nil

    self:_sortPlayers(team)
end

function module:_connectPlayerTeamChange(arg1)
    local connection = arg1.Changed:Connect(function(str1: string)
        if str1 ~= "Team" then
            return
        end

        local var1 = self._playerStores[arg1]
        if not var1 then
            return
        end

        local team = var1.getTeam()
        local var2 = if arg1.Team then arg1.Team else "Neutral"

        local var3 = self._teamStores[team]
        if var3 then
            var3.removePlayer(arg1)
        end

        self:_getOrCreateTeamStore(var2).addPlayer(arg1)

        var1.setTeam(var2)

        self:_sortPlayers(team)
        self:_sortPlayers(var2)
    end)

    self._leaderboardConnections["PlayerTeamChanged_" .. arg1.Name] = connection
end

function module:_addTeamStore(arg1)
    if self._teamStores[arg1] then
        return
    end

    local var1 = self:_createTeamStore(arg1)
    self._teamStores[arg1] = var1

    self._virtualTeamList.setData(
        arg1,
        {
            name = var1.getName,
            color = var1.getColor,
            order = var1.getOrder,
            stats = var1.getStats,
            players = var1.getPlayers
        },
        false
    )
end

function module:_removeTeamStore(arg1)
    local var1 = self._teamStores[arg1]
    if not var1 then
        return
    end

    local var2 = self:_getOrCreateTeamStore("Neutral")
    local allData = var1.getPlayers.getAllData(false)

    for k, _ in pairs(allData) do
        var1.removePlayer(k)
        var2.addPlayer(k)

        local var3 = self._playerStores[k]
        if var3 then
            var3.setTeam("Neutral")
        end
    end

    var1.destroy()
    self._teamStores[arg1] = nil

    self._virtualTeamList.removeData(arg1, false)
end

function module:_connectTeams()
    local teamAdded = self._teamsService.ChildAdded:Connect(function(child: Instance)
        if child:IsA("Team") then
            self:_addTeamStore(child)
        end
    end)
    self._leaderboardConnections.TeamAdded = teamAdded

    local teamRemoved = self._teamsService.ChildRemoved:Connect(function(child: Instance)
        if child:IsA("Team") then
            self:_removeTeamStore(child)
        end
    end)
    self._leaderboardConnections.TeamRemoved = teamRemoved

    for _, team in pairs(self._teamsService:GetTeams()) do
        self:_addTeamStore(team)
    end
end

function module:_connectPlayers()
    local playerAdded = self._playersService.PlayerAdded:Connect(function(player: Player)
        self:_addPlayerStore(player)
    end)
    self._leaderboardConnections.PlayerAdded = playerAdded

    local playerRemoving = self._playersService.PlayerRemoving:Connect(function(player: Player)
        self:_removePlayerStore(player)
    end)
    self._leaderboardConnections.PlayerRemoving = playerRemoving

    for _, player in pairs(self._playersService:GetPlayers()) do
        self:_addPlayerStore(player)
    end
end

return module

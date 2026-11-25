-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")

local SwitchServer = script:FindFirstAncestor("SwitchServer")

local FFlagUseMultipleServerIdsForSwitchServer = require(SwitchServer.Flags.FFlagUseMultipleServerIdsForSwitchServer)
local FIntSwitchServerMaxRecentServers = require(SwitchServer.Flags.FIntSwitchServerMaxRecentServers)
local FIntSwitchServerRecentServerWindowSeconds = require(SwitchServer.Flags.FIntSwitchServerRecentServerWindowSeconds)

local module = ({})
module.__index = module

local function isFresh(tbl1, num1: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 - tbl1.joinedAt <= FIntSwitchServerRecentServerWindowSeconds
end

function module.new(_historyKey: string?)
    local tbl1 = {
        _connections = {},
        _historyKey = "",
        _history = {}
    }
    if _historyKey == nil or _historyKey == "" then
        return (setmetatable(tbl1, module))
    end

    tbl1._historyKey = _historyKey
    local self = setmetatable(tbl1, module)

    local function initHistory()
        local item = MemStorageService:GetItem(tbl1._historyKey)
        if item and item ~= "" then
            local _history = HttpService:JSONDecode(item)
            if typeof(_history) == "table" then
                tbl1._history = _history
            end
        end

        local var1 = self
        local str1 = tostring(game.PlaceId)
        local jobId = game.JobId
        var1:recordServer(str1, tostring(jobId))
        self:writeHistory()
    end

    if game:IsLoaded() then
        initHistory()
        return self
    end

    local _connections = tbl1._connections
    local loaded = game.Loaded

    table.insert(_connections, loaded:Connect(function()
        initHistory()
    end))

    return self
end

function module:recordServer(placeId: string, serverId: string)
    local joinedAt = os.time()
    local serverEntries = {}
    local tbl2 = { serverId = serverId, joinedAt = joinedAt }

    if self._history.placeId ~= placeId then
        self._history = {
            placeId = placeId,
            serverEntries = { tbl2 }
        }
        return
    end

    table.insert(serverEntries, tbl2)
    for _, value in self._history.serverEntries do
        if #serverEntries >= FIntSwitchServerMaxRecentServers then
            break
        end

        if isFresh(value, joinedAt) then
            table.insert(serverEntries, value)
        end
    end
    self._history.serverEntries = serverEntries
end

function module:getRecentServerIds()
    local now = os.time()
    local recentServerIds = {}

    if self._history.serverEntries then
        for _, value in self._history.serverEntries do
            if isFresh(value, now) then
                table.insert(recentServerIds, value.serverId)
            end
        end
    end

    local str1 = tostring(game.JobId)
    if str1 ~= "" and table.find(recentServerIds, str1) == nil then
        table.insert(recentServerIds, 1, str1)
    end

    return recentServerIds
end

function module:writeHistory()
    if self._historyKey == "" then
        return
    end
    MemStorageService:SetItem(self._historyKey, HttpService:JSONEncode(self._history))
end

function module:disconnect()
    for _, _connection in self._connections do
        _connection:Disconnect()
    end
    self._connections = {}
end

if FFlagUseMultipleServerIdsForSwitchServer then
    module.default = module.new("RecentServerHistory")
else
    module.default = module.new("")
end

return module

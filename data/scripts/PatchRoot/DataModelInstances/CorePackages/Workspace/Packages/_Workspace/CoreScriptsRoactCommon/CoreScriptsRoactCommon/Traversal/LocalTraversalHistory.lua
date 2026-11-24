-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local engineFeature = game:GetEngineFeature("UseTeleportedPlacesBackHistory2")

local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Cryo = require(CoreScriptsRoactCommonParent.Cryo)
local Signals = require(CoreScriptsRoactCommonParent.Signals)

local Flags = require(script.Parent.Flags)
local FFlagUseLocalTraversalHistory = Flags.FFlagUseLocalTraversalHistory
local FFlagUseTeleportTraversalHistory = Flags.FFlagUseTeleportTraversalHistory

local module = ({})
module.__index = module

function module.new(str1: string?)
    local tbl1 = {
        _connections = {},
        _historyKey = "",
        _history = {}
    }
    local _historySignal, _setHistorySignal = Signals.createSignal({})
    tbl1._historySignal = _historySignal
    tbl1._setHistorySignal = _setHistorySignal

    if str1 == nil or str1 == "" then
        return (setmetatable(tbl1, module))
    end

    local function initLocalHistory()
        tbl1._historyKey = "TraversalHistory" .. str1
        local item = MemStorageService:GetItem(tbl1._historyKey)
        if item and item ~= "" then
            local _history = HttpService:JSONDecode(item)
            if typeof(_history) == "table" then
                tbl1._history = _history
            end
        end

        table.insert(tbl1._history, 1, { universeId = tostring(game.GameId), placeId = tostring(game.PlaceId) })

        MemStorageService:SetItem(tbl1._historyKey, HttpService:JSONEncode(tbl1._history))
        tbl1._setHistorySignal(tbl1._history)
    end

    local _connections = tbl1._connections
    local loaded = game.Loaded

    table.insert(_connections, loaded:Connect(function()
        initLocalHistory()
    end))

    return (setmetatable(tbl1, module))
end

function module:addHistoryEntry(tbl1)
    table.insert(self._history, 1, tbl1)
    self._setHistorySignal(self._history)
end

function module:addHistoryEntries(tbl1)
    self._history = Cryo.List.join(tbl1, self._history)
    self._setHistorySignal(self._history)
end

local function getNMostRecent(tbl1, num1: number?) -- Luacid: Inlined by compiler; 4 call sites recovered
    if num1 == nil then
        return tbl1
    end
    local nMostRecent = {}
    for i = 1, num1 do
        table.insert(nMostRecent, tbl1[i])
    end
    return nMostRecent
end

function module:getHistory(num1: number?)
    return getNMostRecent(self._history, num1)
end

function module.getUniverseHistorySignal(tbl1, num1: number?)
    return Signals.createComputed(function(arg1)
        local result = {}

        for _, value in (getNMostRecent(tbl1._historySignal(arg1), num1)) do
            table.insert(result, value.universeId)
        end
        return result
    end)
end

function module:getUniverseHistory(num1: number?)
    local universeHistory = {}
    if FFlagUseTeleportTraversalHistory and engineFeature then
        local var1 = TeleportService:TeleportedUniversesBackHistory()
        return getNMostRecent(Cryo.List.map(var1, tostring), num1)
    end

    for _, value in (getNMostRecent(self._history, num1)) do
        table.insert(universeHistory, value.universeId)
    end

    return universeHistory
end

function module:writeHistory()
    MemStorageService:SetItem(self._historyKey, HttpService:JSONEncode(self._history))
end

function module:disconnect()
    for _, _connection in self._connections do
        _connection:Disconnect()
    end
    self._connections = {}
end

local function getDefaultId(): string -- Luacid: Inlined by compiler; 1 call site recovered
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or nil

    if userId == nil or userId <= 0 then
        return "Local"
    end
    return tostring(userId)
end

if FFlagUseLocalTraversalHistory or FFlagUseTeleportTraversalHistory then
    module.default = module.new((getDefaultId()))
else
    module.default = module.new("")
end

return module

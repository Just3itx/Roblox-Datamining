-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local _RunService = game:GetService("RunService")

local t = require(CorePackages.Packages.t)

local var1 = t.strictInterface({
    eraseTimeout = t.number,
    testHarness = t.optional(
        t.strictInterface({
            players = t.union(
                t.instanceOf("Players"),
                t.interface({
                    GetPlayers = t.callback,
                    GetPlayerByUserId = t.callback,
                    PlayerAdded = t.RBXScriptSignal,
                    PlayerRemoving = t.RBXScriptSignal
                })
            ),
            wait = t.callback
        })
    )
})

local module = ({})
module.__index = module

function module.new(tbl1)
    assert(var1(tbl1))
    local _players = if tbl1.testHarness == nil then Players else tbl1.testHarness.players
    local wait = if tbl1.testHarness == nil then wait else tbl1.testHarness.wait
    return (setmetatable({
        _eraseTimeout = tbl1.eraseTimeout,
        _trackedPii = {},
        _playerCounter = 1,
        _disambiguationIdentifiers = {},
        _waitFn = wait,
        _players = _players
    }, module))
end

function module:_addPlayerToEraseMap(arg1)
    local _disambiguationIdentifier = self._disambiguationIdentifiers[arg1.UserId]
    if _disambiguationIdentifier == nil then
        _disambiguationIdentifier = self._playerCounter
        self._disambiguationIdentifiers[arg1.UserId] = self._playerCounter
        self._playerCounter += 1
    end

    local _trackedPii = self._trackedPii
    local userId = arg1.UserId
    _trackedPii[tostring(userId)] = string.format("UserId(%d)", _disambiguationIdentifier)
    local _trackedPii2 = self._trackedPii
    local name = arg1.Name
    _trackedPii2[tostring(name)] = string.format("UserName(%d)", _disambiguationIdentifier)
    local _trackedPii3 = self._trackedPii
    local displayName = arg1.DisplayName
    _trackedPii3[tostring(displayName)] = string.format("DisplayName(%d)", _disambiguationIdentifier)
end

function module:_removePlayerFromEraseMap(arg1)
    local _trackedPii = self._trackedPii
    local userId = arg1.UserId
    _trackedPii[tostring(userId)] = nil
    local _trackedPii2 = self._trackedPii
    local name = arg1.Name
    _trackedPii2[tostring(name)] = nil
    local _trackedPii3 = self._trackedPii
    local displayName = arg1.DisplayName
    _trackedPii3[tostring(displayName)] = nil
end

function module:startTracking()
    for _, player in ipairs(self._players:GetPlayers()) do
        self:_addPlayerToEraseMap(player)
    end

    self._playerAddedConnection = self._players.PlayerAdded:Connect(function(player: Player)
        self:_addPlayerToEraseMap(player)
    end)

    self._playerRemovingConnection = self._players.PlayerRemoving:Connect(function(player: Player)
        self._waitFn(self._eraseTimeout)

        if self._players:GetPlayerByUserId(player.UserId) == nil then
            self:_removePlayerFromEraseMap(player)
        end
    end)
end

function module.stopTracking(arg1)
    arg1._playerAddedConnection:Disconnect()
    arg1._playerRemovingConnection:Disconnect()
end

function module:cleanPii(str1: string)
    for k, value in pairs(self._trackedPii) do
        str1 = string.gsub(str1, k, value)
    end

    return str1
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ScriptContext = game:GetService("ScriptContext")
local HttpService = game:GetService("HttpService")

local Signal = require(script.Parent.Parent.Parent.Signal)

local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._serverStatsUpdated = Signal.new()
    result._serverStatsData = {}
    result._isRunning = false
    return result
end

function module:Signal()
    return self._serverStatsUpdated
end

function module:getCurrentData()
    return self._serverStatsData
end

function module:isRunning()
    return self._isRunning
end

function module:start()
    local clientReplicator = getClientReplicator()
    if not clientReplicator or self._statsListenerConnection then
        return
    end

    self._statsListenerConnection = clientReplicator.StatsReceived:connect(function(arg1)
        if arg1 and arg1.ServerLuauHeapData and #arg1.ServerLuauHeapData > 0 then
            self._serverStatsData = HttpService:JSONDecode(arg1.ServerLuauHeapData)
            self._serverStatsUpdated:Fire(self._serverStatsData)
        end
    end)
    clientReplicator:RequestServerStats(true)
    self._isRunning = true
end

function module:stop()
    if self._statsListenerConnection then
        self._statsListenerConnection:Disconnect()
        self._statsListenerConnection = nil
    end
    self._isRunning = false
end

return module

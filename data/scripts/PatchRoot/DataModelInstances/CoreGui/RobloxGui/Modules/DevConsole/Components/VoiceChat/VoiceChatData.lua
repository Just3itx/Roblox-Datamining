-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Signal = require(script.Parent.Parent.Parent.Signal)
local VoiceChatService = game:GetService("VoiceChatService")

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._statsUpdated = Signal.new()
    result._statsData = {}
    result._isRunning = false
    return result
end

function module:Signal()
    return self._statsUpdated
end

function module:getCurrentData()
    return self._statsData
end

function module:isRunning()
    return self._isRunning
end

function module:start()
    if not VoiceChatService or self._statsListenerConnection then
        return
    end

    self._statsListenerConnection = VoiceChatService.VoiceChatStatsCollected:Connect(function()
        self._statsData = VoiceChatService:lastVoiceChatStats()
        self._statsUpdated:Fire(self._statsData)
    end)
    self._isRunning = true
end

function module:stop()
    self._isRunning = false
    if self._statsListenerConnection then
        self._statsListenerConnection:Disconnect()
    end
end

return module

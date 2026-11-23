-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    self.lastInputTimeSec = -1
    self.subscriptions = {}
    self.lastProgress = -1

    return self
end

function module:getCurrentProgress()
    local var1 = os.clock() - self.lastInputTimeSec

    if var1 < self.dwellTimeSec then
        return 1
    end

    if var1 < self.dwellTimeSec + self.fadeDurationSec then
        return 1 - (var1 - self.dwellTimeSec) / self.fadeDurationSec
    end

    return 0
end

function module.inProgress(arg1): boolean
    return arg1:getCurrentProgress() > 0
end

function module:isFading(): boolean
    local var1 = os.clock() - self.lastInputTimeSec
    return self.dwellTimeSec <= var1 and var1 < self.dwellTimeSec + self.fadeDurationSec
end

function module:updateLastInputTime()
    self.lastInputTimeSec = os.clock()
end

function module:skipToFade()
    if not self:isFading() then
        self.lastInputTimeSec = os.clock() - self.dwellTimeSec
    end
end

function module:zeroOut()
    self.lastInputTimeSec = -1
end

function module:subscribe(arg1)
    table.insert(self.subscriptions, arg1)

    if self.heartbeatConnection then
        return
    end

    self.heartbeatConnection = RunService.RenderStepped:Connect(function()
        local lastProgress = self:getCurrentProgress()
        if lastProgress == self.lastProgress then
            return
        end

        self.lastProgress = lastProgress
        for _, subscription in ipairs(self.subscriptions) do
            subscription(lastProgress)
        end
    end)
end

function module:unsubscribe(arg1)
    for i, subscription in ipairs(self.subscriptions) do
        if subscription == arg1 then
            table.remove(self.subscriptions, i)
            break
        end
    end

    if #self.subscriptions == 0 and self.heartbeatConnection then
        self.heartbeatConnection:Disconnect()
        self.heartbeatConnection = nil
    end
end

module.fadeDurationSec = 1
module.dwellTimeSec = 1

return module

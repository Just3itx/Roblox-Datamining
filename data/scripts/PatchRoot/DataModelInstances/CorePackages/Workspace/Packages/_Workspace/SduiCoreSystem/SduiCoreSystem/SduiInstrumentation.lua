-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local DiscoveryAppLaunchTracker = require(SduiCoreSystemParent.AppLaunchTracker).DiscoveryAppLaunchTracker

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)

local bool1 = game:DefineFastInt("DiscoverySduiInstrumentationHundredthsPercent", 0) >= math.random(10000)

local module = {}
module.__index = module

function module.new(flushDelay: number?, enabled: boolean?)
    local tbl1 = {
        startTime = 0,
        openTimerCount = 0,
        openTimers = {},
        closedTimers = {},
        isFlushScheduled = false,
        flushDelay = flushDelay or 0.1,
        enabled = enabled or bool1
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:startTimerFlow(str1: string)
    if not self.enabled then
        return
    end

    local startTime = 1000 * os.clock()

    if self.openTimerCount == 0 then
        self.startTime = startTime
    end
    self.openTimerCount += 1

    local openTimer = self.openTimers[str1]
    if openTimer then
        if openTimer.openCount == 0 then
            openTimer.startTime = startTime
        end
        openTimer.count += 1
        openTimer.openCount += 1
        return
    end
    self.openTimers[str1] = { startTime = startTime, failed = 0, count = 1, openCount = 1 }
end

function module:stopTimerFlow(name: string, arg1, bool2: boolean?)
    if not self.enabled then
        return
    end
    self.openTimerCount -= 1

    local openTimer = self.openTimers[name]
    if not openTimer then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.NilInstrumentationTimer,
            { name = name, message = "Failed to find timer when calling stopTimer" },
            arg1.appPage
        )
        return
    end
    if bool2 then
        openTimer.failed += 1
    end
    openTimer.openCount -= 1

    if openTimer.openCount ~= 0 then
        return
    end

    local num1 = 1000 * os.clock()
    local var1 = num1 - openTimer.startTime
    self:aggregateClosedTimer(name, openTimer.count, openTimer.failed, var1)
    self.openTimers[name] = nil

    if self.openTimerCount == 0 then
        self:scheduleFlush(arg1)
        local var2 = num1 - self.startTime
        if DiscoveryAppLaunchTracker.isEnabled() and DiscoveryAppLaunchTracker.default then
            DiscoveryAppLaunchTracker.default:trackSduiDuration(var2)
        end
    elseif self.openTimerCount < 1 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.ImbalancedStartStopTimer,
            {
                name = name,
                message = `Negative timer count when stopping timer {self.openTimerCount}`
            },
            arg1.appPage
        )
    end
end

function module:aggregateClosedTimer(str1: string, count: number, failed: number, durationMs: number)
    local closedTimer = self.closedTimers[str1]
    if closedTimer then
        closedTimer.failed += failed
        closedTimer.count += count
        closedTimer.durationMs += durationMs
        return
    end
    self.closedTimers[str1] = { failed = failed, count = count, durationMs = durationMs }
end

function module:scheduleFlush(arg1)
    if not self.enabled or self.isFlushScheduled then
        return
    end

    task.delay(self.flushDelay, function()
        self.isFlushScheduled = false
        self:reportTimers(arg1)
    end)
    self.isFlushScheduled = true
end

function module:reportTimers(arg1)
    if self.enabled then
        arg1.dependencies.logger.reportTimers(self.closedTimers, arg1.appPage)
        self.closedTimers = {}
    end
end

return module

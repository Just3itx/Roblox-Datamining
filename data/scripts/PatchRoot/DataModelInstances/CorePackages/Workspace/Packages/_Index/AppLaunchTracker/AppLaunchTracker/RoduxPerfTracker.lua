-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _AppLaunchTrackerTypes = require(script.Parent.AppLaunchTrackerTypes)

local module = { __className = "Devtools" }
module.__index = module

local function createTable() -- Luacid: Inlined by compiler; 8 call sites recovered
    return table.create(100)
end

function module.new(reportTopAction: boolean, reportTopThunk: boolean, startImmediately: boolean?)
    return (setmetatable({
        reportTopAction = reportTopAction,
        reportTopThunk = reportTopThunk,
        startImmediately = startImmediately,
        shouldTrack = false,
        flushCount = 0,
        totalFlushTimeMs = 0,
        reduceCount = 0,
        totalReduceTimeMs = 0,
        maxListenerCount = 0,
        totalThunkTimeMs = 0,
        thunkCount = 0,
        actionCounts = if reportTopAction then createTable() else nil,
        actionTotalTimes = if reportTopAction then createTable() else nil,
        thunkCounts = if reportTopThunk then createTable() else nil,
        thunkTotalTimes = if reportTopThunk then createTable() else nil
    }, module))
end

function module:_hookIntoStore(store)
    self.store = store
    self.originalReducer = store._reducer
    self.originalFlushHandler = store._flushHandler

    if self.startImmediately then
        self:startTracking()
    end
end

function module:trackingReducer(arg1, arg2)
    assert(self.originalReducer, "self.originalReducer must exist")
    local startTime = os.clock()
    local var1 = self.originalReducer(arg1, arg2)
    local num1 = (os.clock() - startTime) * 1000
    self.totalReduceTimeMs += num1
    self.reduceCount += 1

    if self.reportTopAction and self.actionCounts and self.actionTotalTimes then
        local var2 = arg2.type or tostring(arg2)
        if var2 then
            local var3 = (self.actionCounts[var2] or 0) + 1
            self.actionCounts[var2] = var3

            local var4 = (self.actionTotalTimes[var2] or 0) + num1
            self.actionTotalTimes[var2] = var4
        end
    end
    return var1
end

function module:trackingFlush(...)
    local startTime = os.clock()
    self.originalFlushHandler(...)
    local num1 = (os.clock() - startTime) * 1000
    self.totalFlushTimeMs += num1
    self.flushCount += 1

    local _listenersLen = #self.store.changed._listeners
    if self.maxListenerCount < _listenersLen then
        self.maxListenerCount = _listenersLen
    end
end

function module:startTracking()
    function self.store._flushHandler(...)
        return self:trackingFlush(...)
    end
    function self.store._reducer(...)
        return self:trackingReducer(...)
    end
    self.shouldTrack = true
end

function module:stopTracking()
    if self.shouldTrack then
        self.shouldTrack = false
        self.store._flushHandler = self.originalFlushHandler
        self.store._reducer = self.originalReducer
    end
end

function module:clear()
    self.flushCount = 0
    self.totalFlushTimeMs = 0
    self.reduceCount = 0
    self.totalReduceTimeMs = 0
    self.maxListenerCount = 0
    self.totalThunkTimeMs = 0
    self.thunkCount = 0

    if self.reportTopAction then
        self.actionCounts = createTable()
        self.actionTotalTimes = createTable()
    end
    if self.reportTopThunk then
        self.thunkCounts = createTable()
        self.thunkTotalTimes = createTable()
    end
end

local function getRelevantLineFromTrace(str1: string)
    local tbl1 = string.split(str1, "\n")
    for i = 3, #tbl1 do
        local str2 = tbl1[i]

        if not (string.find(str2, "AppLaunchTracker")
            or string.find(str2, "_Index.Rodux")
            or string.find(str2, "_Index.RoactRodux")
            or string.find(str2, "_Index.Promise")
            or string.find(str2, ".RoactRodux")) then
            return str2
        end
    end
    return nil
end

local function getThunkName(arg1) -- Luacid: unused: defined but never referenced
    local relevantLineFromTrace = getRelevantLineFromTrace(debug.traceback())
    if relevantLineFromTrace then
        return relevantLineFromTrace
    end
    return debug.info(arg1, "slf")
end

function module.makeThunkMiddleware(arg1, arg2)
    local function tracebackReporter(arg3)
        return debug.traceback(arg3)
    end
    local function thunkMiddleware(arg3, arg4)
        return function(arg5)
            if typeof(arg5) ~= "function" then
                return arg3(arg5)
            end

            local success, result = xpcall(function()
                if not arg1.shouldTrack then
                    return arg5(arg4, arg2)
                end

                local startTime = os.clock()
                local var1 = arg5(arg4, arg2)
                local num1 = (os.clock() - startTime) * 1000
                local var2 = arg1
                var2.totalThunkTimeMs += num1
                local var3 = arg1
                var3.thunkCount += 1

                if arg1.reportTopThunk and arg1.thunkCounts and arg1.thunkTotalTimes then
                    local func1 = arg5
                    local var4 = getRelevantLineFromTrace(debug.traceback()) or debug.info(func1, "slf")

                    local var5 = (arg1.thunkCounts[var4] or 0) + 1
                    arg1.thunkCounts[var4] = var5

                    local var6 = (arg1.thunkTotalTimes[var4] or 0) + num1
                    arg1.thunkTotalTimes[var4] = var6
                end
                return var1
            end, tracebackReporter)

            if success then
                return result
            end

            arg4._errorReporter.reportReducerError(
                arg4:getState(),
                arg5,
                { message = "Caught error in thunk", thrownValue = result }
            )
            return nil
        end
    end

    return thunkMiddleware
end

local function getTopValue(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = nil
    local var2 = nil
    for value, value2 in tbl1 do
        if (var1 or -1) < value2 then
            var2 = value
            var1 = value2
        end
    end

    return var2, var1
end

local function fixThunkName(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return str1:gsub("CoreGui.RobloxGui.Modules.", ""):gsub("CorePackages.Workspace.Packages._Workspace.", "")
end

function module:getStats()
    local actionCount = nil
    local var1 = nil
    local var2 = nil
    local thunkCount = nil
    local var3, var4

    if self.reportTopAction and self.actionCounts and self.actionTotalTimes then
        var3, var4 = getTopValue(self.actionTotalTimes)
        if var3 then
            actionCount = self.actionCounts[var3]
        end
    else
        var3 = nil
        var4 = nil
    end

    if self.reportTopThunk and self.thunkCounts and self.thunkTotalTimes then
        var1, var2 = getTopValue(self.thunkTotalTimes)
        if var1 then
            thunkCount = self.thunkCounts[var1]
            var1 = fixThunkName(var1)
        end
    end

    return {
        flushCount = self.flushCount,
        totalFlushTimeMs = self.totalFlushTimeMs,
        reduceCount = self.reduceCount,
        totalReduceTimeMs = self.totalReduceTimeMs,
        maxListenerCount = self.maxListenerCount,
        totalThunkTimeMs = self.totalThunkTimeMs,
        thunkCount = self.thunkCount,
        topActionName = var3,
        topActionDurationMs = var4,
        topActionCount = actionCount,
        topThunkName = var1,
        topThunkDurationMs = var2,
        topThunkCount = thunkCount
    }
end

return module

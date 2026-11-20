-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local ReactGlobals = require(scriptParentParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local Object = LuauPolyfill.Object
local Shared = require(scriptParentParentParent.Shared)
local console = Shared.console
local errorToString = Shared.errorToString
local describeError = Shared.describeError
local SafeFlags = require(scriptParentParentParent.SafeFlags)

local function getCurrentTime(): number -- Luacid: Inlined by compiler; 7 call sites recovered
    return os.clock() * 1000
end

local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local bool1 = false
local var1 = nil
local None = Object.None

local getFInt = SafeFlags.createGetFInt("ReactSchedulerYieldInterval2", 15)

local var2 = SafeFlags.createGetFInt("ReactSchedulerDesiredFrameRate", 60)()

local var3 = SafeFlags.createGetFInt("ReactSchedulerMinFrameRate", 30)()

local var4 = SafeFlags.createGetFFlag("ReactSchedulerEnableDeferredWork")()

local var5 = SafeFlags.createGetFFlag("ReactSchedulerSetFrameMarkerOnHeartbeatEnd")()

local var6 = SafeFlags.createGetFFlag("ReactSchedulerSetTargetMsByHeartbeatDelta")()

local var7 = SafeFlags.createGetFInt("ReactSchedulerNumberOfLookbackFrames", 1)()

local var8 = SafeFlags.createGetFFlag("ReactSchedulerLookbackUseRingBuffer")()

local bool2 = false
local num1 = 0
local var9 = 1000 / var2
local var10 = 1000 / var3
local var11 = var9
local var12 = var11

local connection = nil
local var13 = if var8 then table.create(var7) else nil
local num2 = 1

local function resetFrameBudgets() -- Luacid: Inlined by compiler; 2 call sites recovered
    var9 = 1000 / var2
    var10 = 1000 / var3
    var11 = var9
    var12 = var11
end

local function createHeartbeatConnection() -- Luacid: Inlined by compiler; 2 call sites recovered
    if connection then
        connection:Disconnect()
    end
    connection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime: number)
        if not (var7 > 1) then
            var11 = math.clamp(deltaTime * 1000, var9, var10)

            return
        end

        if var8 then
            var13[num2] = deltaTime * 1000
            num2 = num2 % var7 + 1

            local num3 = 0
            local var14 = var7
            for i = 1, var14 do
                if var13[i] == nil then
                    var14 = i - 1
                    break
                end

                num3 += var13[i]
            end
            var12 = num3 / var14
        else
            local var14 = var7
            var12 = (var12 * (var14 - 1) + deltaTime * 1000) / var14
        end

        var11 = math.clamp(var12, var9, var10)
    end)
end
if var6 then
    createHeartbeatConnection()
end

local function setFrameMarker()
    num1 = getCurrentTime()
end

local fInt = getFInt()
local num3 = 0

local function setSchedulerFlags(tbl1)
    if tbl1.yieldInterval ~= nil then
        fInt = tbl1.yieldInterval
    end
    if tbl1.desiredFrameRate ~= nil then
        var2 = tbl1.desiredFrameRate
        resetFrameBudgets()
    end

    if tbl1.minimumFrameRate ~= nil then
        var3 = tbl1.minimumFrameRate
        resetFrameBudgets()
    end

    if tbl1.deferredWork ~= nil then
        var4 = tbl1.deferredWork
    end
    if tbl1.heartbeatFrameMarker ~= nil then
        var5 = tbl1.heartbeatFrameMarker
    end
    if tbl1.targetMsByHeartbeatDelta ~= nil then
        var6 = tbl1.targetMsByHeartbeatDelta
        if tbl1.targetMsByHeartbeatDelta then
            createHeartbeatConnection()
        elseif connection then
            connection:Disconnect()
            connection = nil
            var11 = var9
        end
    end

    if tbl1.numberOfLookbackFrames ~= nil then
        var7 = tbl1.numberOfLookbackFrames
    end
    if tbl1.lookbackUseRingBuffer ~= nil then
        var8 = tbl1.lookbackUseRingBuffer
    end
end

local function getSchedulerFlags()
    return {
        yieldInterval = fInt,
        desiredFrameRate = var2,
        minimumFrameRate = var3,
        deferredWork = var4,
        heartbeatFrameMarker = var5,
        targetMsByHeartbeatDelta = var6,
        numberOfLookbackFrames = var7,
        lookbackUseRingBuffer = var8
    }
end

local function doesBudgetRemain(): boolean -- Luacid: unused: defined but never referenced
    local num4 = getCurrentTime() - num1
    local var14 = var11 - num4
    return fInt < var14
end

local function shouldYieldToHost(): boolean
    local num4 = getCurrentTime()
    return num3 <= num4
end

local function forceFrameRate(arg1)
    if arg1 < 0 or arg1 > 125 then
        console.warn(
            "forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported"
        )
        return
    end

    if arg1 > 0 then
        fInt = math.floor(1000 / arg1)
    else
        fInt = 5
    end
end

local function func2()
    if var1 == nil then
        bool1 = false

        return
    end

    local num4 = getCurrentTime()
    num3 = num4 + fInt
    local bool3 = true

    if var4 and not (var5 or bool2) then
        num1 = num4
    end

    if var5 and bool2 then
        local num5 = getCurrentTime() - num1
        if not (var11 - num5 > fInt) then
            bool3 = false
        end
    end

    local function doWork()
        if not var1(bool3, num4) then
            bool1 = false
            var1 = nil
        elseif var4 then
            local num5 = getCurrentTime() - num1
            if var11 - num5 > fInt then
                bool2 = true
                task.defer(func2)
            else
                bool2 = false
                task.delay(0, func2)
                if var5 then
                    task.defer(setFrameMarker)
                end
            end
        else
            task.delay(0, func2)
        end

        return nil
    end

    local success, result

    if not ReactGlobals.__YOLO__ then
        success, result = xpcall(doWork, describeError)
    else
        result = doWork()
        success = true
    end

    if success then
        return
    end

    task.delay(0, func2)
    if var5 then
        task.defer(setFrameMarker)
    end

    error(errorToString(result))
end

local function wrapPerformWorkWithCoroutine(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local thread = coroutine.create(function()
        while true do
            local success, result = pcall((coroutine.wrap(arg1)))
            coroutine.yield(success, result)
        end
    end)

    return function()
        local _, var14, var15 = coroutine.resume(thread)

        if not var14 then
            error(var15)
        end
    end
end

func2 = wrapPerformWorkWithCoroutine(func2)

return {
    requestHostCallback = function(arg1)
        var1 = arg1
        if bool1 then
            return
        end

        bool1 = true

        task.delay(0, func2)
        if var5 then
            task.defer(setFrameMarker)
        end
    end,
    cancelHostCallback = function()
        var1 = nil
    end,
    requestHostTimeout = function(callback, arg1)
        None = setTimeout(function()
            callback((getCurrentTime()))
        end, arg1)
    end,
    cancelHostTimeout = function()
        clearTimeout(None)
        None = Object.None
    end,
    shouldYieldToHost = shouldYieldToHost,
    requestPaint = function() end,
    getCurrentTime = getCurrentTime,
    forceFrameRate = forceFrameRate,
    setSchedulerFlags = setSchedulerFlags,
    getSchedulerFlags = getSchedulerFlags
}

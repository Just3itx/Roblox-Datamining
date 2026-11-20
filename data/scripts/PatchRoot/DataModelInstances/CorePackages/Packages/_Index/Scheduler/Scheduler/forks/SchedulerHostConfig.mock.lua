-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local getCurrentTime = 0
local var1 = nil
local var2 = nil
local num2 = -1
local var3 = nil
local num3 = -1
local bool1 = false
local bool2 = false
local bool3 = false
local bool4 = false
local scriptParentParentParent = script.Parent.Parent.Parent
local console = require(scriptParentParentParent.Shared).console
local disabledLog = require(scriptParentParentParent.Shared).ConsolePatchingDev.disabledLog

function module.requestHostCallback(func1: (...any) -> (...any))
    var1 = func1
end

function module.cancelHostCallback()
    var1 = nil
end

function module.requestHostTimeout(func1: (...any) -> (...any), num4: number)
    var2 = func1
    num2 = getCurrentTime + num4
end

function module.cancelHostTimeout()
    var2 = nil
    num2 = -1
end

function module.shouldYieldToHost()
    local var4 = var3

    if num3 ~= -1 and var4 ~= nil and #var4 >= num3 then
        bool1 = true
        return true
    end

    if not (bool4 and bool3) then
        return false
    end

    bool1 = true
    return true
end

function module.getCurrentTime()
    return getCurrentTime
end

function module.forceFrameRate() end

function module.reset()
    if bool2 then
        error("Cannot reset while already flushing work.")
    end

    getCurrentTime = 0
    var1 = nil
    var2 = nil
    num2 = -1
    var3 = nil
    num3 = -1
    bool1 = false
    bool2 = false
    bool3 = false
end

function module.unstable_flushNumberOfYields(num4: number)
    if bool2 then
        error("Already flushing work.")
    end

    if var1 == nil then
        return
    end

    local var4 = var1
    num3 = num4
    bool2 = true

    local success, result = pcall(function()
        local var5

        repeat
            var5 = var4(true, getCurrentTime)
        until not var5 or bool1

        if not var5 then
            var1 = nil
        end
    end)

    num3 = -1
    bool1 = false
    bool2 = false

    if not success then
        error(result)
    end
end

function module.unstable_flushUntilNextPaint()
    if bool2 then
        error("Already flushing work.")
    end

    if var1 == nil then
        return
    end

    local var4 = var1
    bool4 = true
    bool3 = false
    bool2 = true

    local success, result = pcall(function()
        local var5

        repeat
            var5 = var4(true, getCurrentTime)
        until not var5 or bool1

        if not var5 then
            var1 = nil
        end
    end)

    bool4 = false
    bool1 = false
    bool2 = false

    if not success then
        error(result)
    end
end

function module.unstable_flushExpired()
    if bool2 then
        error("Already flushing work.")
    end
    if var1 == nil then
        return
    end

    bool2 = true
    local success, result = pcall(function()
        if not var1(false, getCurrentTime) then
            var1 = nil
        end
    end)

    bool2 = false

    if not success then
        error(result)
    end
end

function module.unstable_flushAllWithoutAsserting(): boolean
    if bool2 then
        error("Already flushing work.")
    end
    if var1 == nil then
        return false
    end

    local var4 = var1
    bool2 = true
    local success, result = pcall(function()
        local var5

        repeat
            var5 = var4(true, getCurrentTime)
        until not var5

        if not var5 then
            var1 = nil
        end
    end)

    bool2 = false

    if not success then
        error(result)
    end

    return true
end

function module.unstable_clearYields()
    if var3 == nil then
        return {}
    end
    local var4 = var3
    var3 = nil
    return var4
end

function module.unstable_flushAll()
    if var3 ~= nil then
        error("Log is not empty. Assert on the log of yielded values before flushing additional work.")
    end

    module.unstable_flushAllWithoutAsserting()
    if var3 ~= nil then
        error(
            "While flushing work, something yielded a value. Use an assertion helper to assert on the log of yielded values, e.g. expect(Scheduler).toFlushAndYield([...])"
        )
    end
end

function module.unstable_yieldValue(arg1)
    if console.log == disabledLog then
        return
    end

    if var3 == nil then
        var3 = { arg1 }
    else
        table.insert(var3, arg1)
    end
end

function module.unstable_advanceTime(num4: number)
    if console.log == disabledLog then
        return
    end
    getCurrentTime += num4

    if var2 ~= nil and num2 <= getCurrentTime then
        var2(getCurrentTime)
        num2 = -1
        var2 = nil
    end
end

function module.requestPaint()
    bool3 = true
end

return module

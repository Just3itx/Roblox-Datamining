-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Logger = require(script.Parent.Parent.Logger)

local function func1(dateTime, dateTime2: DateTime) -- Luacid: Inlined by compiler; 1 call site recovered
    return (dateTime.UnixTimestampMillis - dateTime2.UnixTimestampMillis) / 1000
end

local function SimpleTimer(tbl1)
    local var1 = nil
    local var2 = nil
    local var3 = nil

    local var4 = nil
    local timeoutThreshold = if tbl1 then tbl1.timeoutThreshold or nil else nil
    local onReachingThreshold = if tbl1 then tbl1.onReachingThreshold or nil else nil

    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        return if var1 and var2 then var2 - var1 else -1
    end

    local function func3() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var4 then
            task.cancel(var4)
        end
    end

    local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
        if not (timeoutThreshold and onReachingThreshold) then
            return
        end

        local var5 = onReachingThreshold

        var4 = task.delay(timeoutThreshold, function()
            var4 = nil
            var5()
        end)
    end

    return {
        start = function(arg1)
            if var1 then
                Logger:warning("Timer has been already started")

                return
            end

            var1 = os.clock()
            var3 = arg1 or DateTime.now()
            if arg1 then
                var1 = func1(var3, DateTime.now())
            end

            func4()
        end,
        getStartTimestamp = function()
            if var3 then
                return var3
            end

            Logger:warning("Timer has not been started yet")
            return nil
        end,
        stop = function()
            func3()

            if var1 and not var2 then
                var2 = os.clock()
            elseif not var1 then
                Logger:warning("Timer has not been started yet")
            else
                Logger:warning("Timer has been already stopped")
            end

            return func2()
        end,
        clear = function()
            var1 = nil
            var2 = nil
            func3()
        end,
        getTime = function()
            local var5 = nil

            if var1 and not var2 then
                var5 = os.clock()
            elseif not var1 then
                Logger:warning("Timer has not been started yet")
            else
                Logger:warning("Timer has been already stopped")
            end

            return if var1 and var5 then var5 - var1 else -1
        end
    }
end
return SimpleTimer

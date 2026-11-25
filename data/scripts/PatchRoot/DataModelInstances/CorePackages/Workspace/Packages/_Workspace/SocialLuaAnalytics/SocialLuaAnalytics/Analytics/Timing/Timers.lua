-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SimpleTimer = require(script.Parent.SimpleTimer)
local Logger = require(script.Parent.Parent.Logger)

local function Timers(arg1)
    local tbl1 = ({})

    local function func1(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if not tbl1[str1] then
            Logger:warning("(Clear) Timer with this key doesn't exist: " .. tostring(str1))
            return
        end

        tbl1[str1].clear()
        tbl1[str1] = nil
    end

    local function func2(str1: string, callback: ((...any) -> (...any))?): (() -> ())? -- Luacid: Inlined by compiler; 1 call site recovered
        return if callback then function()
            func1(str1)
            callback()
        end else nil
    end

    local function func3(str1: string?)
        local str2 = str1 or HttpService:GenerateGUID(false)
        if tbl1[str2] then
            Logger:warning("(Start) Timer with this key already exists: " .. tostring(str2))

            return str2
        end

        local tbl2 = tbl1
        tbl2[str2] = SimpleTimer({
            timeoutThreshold = if arg1 then arg1.timeoutThreshold or nil else nil,
            onReachingThreshold = if arg1 then func2(str2, arg1.onReachingThreshold) or nil else nil
        })
        return str2
    end

    return {
        start = function(str1: string?, arg2)
            local str2 = func3(str1)
            tbl1[str2].start(arg2)

            return str2
        end,
        stop = function(str1: string): number
            if not tbl1[str1] then
                Logger:warning("(Stop) Timer with this key doesn't exist: " .. tostring(str1))
                return -1
            end

            local var1 = tbl1[str1].stop()
            func1(str1)
            return var1
        end,
        getTime = function(str1: string)
            if tbl1[str1] then
                return tbl1[str1].getTime()
            end

            Logger:warning("(getTime) Timer with this key doesn't exist: " .. tostring(str1))
            return -1
        end,
        getStartTimestamp = function(str1: string)
            if tbl1[str1] then
                return tbl1[str1].getStartTimestamp()
            end

            Logger:warning("(startTimeStamp) Timer with this key doesn't exist: " .. tostring(str1))
            return nil
        end
    }
end
return Timers

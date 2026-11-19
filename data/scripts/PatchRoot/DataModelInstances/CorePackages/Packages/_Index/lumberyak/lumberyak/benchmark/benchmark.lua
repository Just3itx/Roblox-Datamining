-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Logger = require(game.LoadedCode.Packages.Lumberyak.Logger)

local function timeit(arg1, callback)
    local var1 = arg1()

    local startTime = tick()
    for _ = 1, 2000000 do
        callback(var1)
    end
    return (tick() - startTime) / 2000000
end

local function callSimple(arg1)
    arg1:info("foo")
end

local function callInterp(arg1)
    arg1:info("foo {}", 2)
end

local function empty()
    return {
        info = function() end
    }
end

local var1 = timeit(empty, callSimple)
local var2 = timeit(empty, callInterp)

local function fmt(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    print(string.format("%-40s %0.3e [%0.4fx]", arg1 .. " - " .. arg2, arg3, arg3 / var1))
end

print(string.format("%-40s %0.3e [%0.4fx]", "Empty function - Simple", var1, var1 / var1))
print(string.format("%-40s %0.3e [%0.4fx]", "Empty function - Interpolation", var2, var2 / var1))

for k, value in pairs({
    ["Log level off"] = function() -- name: off
        local num1 = 0
        local tbl1 = {
            maxLevel = Logger.Levels.Error,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }

        local logger = Logger.new()
        logger:setContext({ number = 1 })
        logger:addSink(tbl1)
        return logger
    end,
    ["Simple logger"] = function() -- name: simple
        local num1 = 0
        local tbl1 = {
            maxLevel = Logger.Levels.Info,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }

        local logger = Logger.new()
        logger:setContext({ number = 1 })
        logger:addSink(tbl1)
        return logger
    end,
    ["Short chain"] = function() -- name: short
        local num1 = 0
        local tbl1 = {
            maxLevel = Logger.Levels.Info,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }

        local logger = Logger.new()
        local var3 = logger:new()
        logger:setContext({ number = 1 })
        logger:addSink(tbl1)
        return var3
    end,
    ["Long chain"] = function() -- name: long
        local num1 = 0
        local tbl1 = {
            maxLevel = Logger.Levels.Info,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }

        local logger = Logger.new()
        logger:setContext({ number = 1 })
        logger:addSink(tbl1)
        return (logger:new():new():new():new())
    end,
    ["Many sinks"] = function() -- name: many
        local num1 = 0
        local tbl1 = {
            maxLevel = Logger.Levels.Error,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }
        local tbl2 = {
            maxLevel = Logger.Levels.Warning,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }
        local tbl3 = {
            maxLevel = Logger.Levels.Info,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }
        local tbl4 = {
            maxLevel = Logger.Levels.Debug,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }
        local tbl5 = {
            maxLevel = Logger.Levels.Trace,
            log = function(_, _, arg1)
                num1 += arg1.number
            end
        }

        local logger = Logger.new()
        logger:setContext({ number = 1 })
        logger:addSink(tbl1)
        logger:addSink(tbl2)
        logger:addSink(tbl3)
        logger:addSink(tbl4)
        logger:addSink(tbl5)
        return logger
    end
}) do
    local var3 = timeit(value, callSimple)
    print(string.format("%-40s %0.3e [%0.4fx]", k .. " - Simple", var3, var3 / var1))

    local var4 = timeit(value, callInterp)
    print(string.format("%-40s %0.3e [%0.4fx]", k .. " - Interpolation", var4, var4 / var1))
end

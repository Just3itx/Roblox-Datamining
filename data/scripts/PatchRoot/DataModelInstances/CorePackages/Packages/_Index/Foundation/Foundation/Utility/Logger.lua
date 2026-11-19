-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local Lumberyak = require(FoundationParent.Lumberyak)

local Logger = Lumberyak.Logger
local foundationSink = {
    maxLevel = Logger.Levels.Info,
    log = function(_, arg1, arg2)
        if arg2.level == Logger.Levels.Error or arg2.level == Logger.Levels.Warning then
            warn(arg1)
            return
        end
        print(arg1)
    end
}

local var1 = (function(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local logger = Lumberyak.Logger.new(nil, str1)
    logger:setContext({ prefix = "[{loggerName} - {level}] - " })
    logger:addSink(foundationSink)
    return logger
end)("Foundation")

local tbl2 = {
    foundationSink = foundationSink,
    setLogLevel = function(arg1, maxLevel: string)
        arg1.foundationSink.maxLevel = maxLevel
        arg1:addSink(arg1.foundationSink)
    end,
    enableTraceLog = function(arg1)
        arg1:setLogLevel(Logger.Levels.Trace)
    end
}

setmetatable(tbl2, { __index = var1 })

return tbl2

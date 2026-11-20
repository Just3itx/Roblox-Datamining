-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppDebug = script:FindFirstAncestor("AppDebug")
local AppDebugParent = AppDebug.Parent
local Dash = require(AppDebugParent.Dash)
local Lumberyak = require(AppDebugParent.Lumberyak)
local Levels = Lumberyak.Logger.Levels
local SharedSink = require(AppDebug.SharedSink)

local logger = Lumberyak.Logger.new(nil, "root")

local startTime = tick()

local tbl1 = { ["*"] = logger }

logger:setContext({
    tostring = function(arg1) -- name: argToString
        if typeof(arg1) == "string" then
            return arg1
        end

        local var1 = getmetatable(arg1)
        if var1 and var1.__tostring then
            return tostring(arg1)
        end
        return Dash.pretty(arg1)
    end
})

local function newLogger(arg1, arg2) -- Luacid: unused: defined but never referenced
    local logger2 = Lumberyak.Logger.new(arg1, arg2)
    tbl1[arg2] = logger2
    return logger2
end

local function createLoggerTree(str1: string)
    local tbl2 = str1:split(".")
    local str2 = ""
    local var1 = logger
    for value, value2 in tbl2 do
        if value2 == "" then
            error("Invalid log tag: " .. str1)
        end
        if value == 1 then
            str2 = value2
        else
            str2 ..= "." .. value2
        end
        local var2 = tbl1[str2]

        if var2 then
            var1 = var2
        else
            var1 = Lumberyak.Logger.new(var1, str2)
            tbl1[str2] = var1
        end
    end
    return var1
end

local function logger2(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1] or createLoggerTree(str1)
end

local function parseTag(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl2 = str1:split(":")
    if #tbl2 ~= 2 then
        warn("Invalid LogTree value: " .. str1)
        return nil, nil
    end

    local str2, str3 = table.unpack(tbl2)
    return Dash.trim(str2), Levels.fromString(str3)
end

local function formatLog(arg1, arg2, arg3): string -- Luacid: Inlined by compiler; 1 call site recovered
    local level = arg2.level
    local str1 = string.format("%s [%s] %s", level:sub(1, 1), arg2.loggerName, arg1)
    if arg3 then
        local var1 = tick() - startTime
        str1 = string.format("[%0.3f] %s", var1, str1)
    end
    return str1
end

local function splitNonEmpty(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Dash.splitOn(str1, "%s+")
    return Dash.filter(var1, function(arg1): boolean
        return #arg1 > 0
    end)
end

return {
    logger = logger2,
    formatLog = formatLog,
    logToConsole = function(_, arg1, arg2)
        local level = arg2.level
        local str1 = formatLog(arg1, arg2, false)

        if level == Levels.Error or level == Levels.Warning then
            warn(str1)
            return
        end
        print(str1)
    end,
    setLogTags = function(str1: string, arg1)
        local sharedSink = SharedSink.new(arg1)

        for _, value in (splitNonEmpty(str1)) do
            local var1, var2 = parseTag(value)

            if var1 ~= nil then
                logger2(tostring(var1)):addSink((sharedSink:newSink(var2)))
            end
        end
    end
}

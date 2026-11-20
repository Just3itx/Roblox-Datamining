-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppDebug = script:FindFirstAncestor("AppDebug")
local AppDebugParent = AppDebug.Parent
local LogTree = require(AppDebug.LogTree)
local Levels = require(AppDebugParent.Lumberyak).Logger.Levels

local tbl1 = {
    [Levels.Error] = "pink",
    [Levels.Warning] = "orange",
    [Levels.Info] = "yellow",
    [Levels.Debug] = "cyan",
    [Levels.Trace] = "green"
}

local tbl2 = {
    [Levels.Error] = 1,
    [Levels.Warning] = 2,
    [Levels.Info] = 3,
    [Levels.Debug] = 4,
    [Levels.Trace] = 5
}

local function maxLevelToGraphvizAttr(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[arg1]
    return var1 and string.format(" fillcolor=%s style=filled", var1) or ""
end

local function getLevelRank(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl2[arg1] or 0
end

local function maxLogLevel(arg1, arg2) -- Luacid: unused: defined but never referenced
    if getLevelRank(arg1) > getLevelRank(arg2) then
        arg2 = arg1 or arg2
    end

    return arg2
end

local function dfsGraphviz(arg1, arg2)
    local str1 = ""
    local str2 = tostring(arg1.name)
    for _, sink in arg1.sinks do
        str2 ..= "\\n(sink: " .. tostring(sink.maxLevel) .. ")"
        local maxLevel = sink.maxLevel

        if not (getLevelRank(arg2) > getLevelRank(maxLevel) and arg2) then
            arg2 = maxLevel
        end
    end

    local str3 = str1 .. string.format("\"%s\" [label=\"%s\"%s];\n", arg1.name, str2, (maxLevelToGraphvizAttr(arg2)))
    for k, _ in arg1.children do
        str3 = (str3 .. string.format("\"%s\" -> \"%s\"\n", tostring(k.name), arg1.name)) .. dfsGraphviz(k, arg2)
    end
    return str3
end

return function()
    local var1 = LogTree.logger("*")
    return "digraph {\n" .. dfsGraphviz(var1) .. "}\n"
end

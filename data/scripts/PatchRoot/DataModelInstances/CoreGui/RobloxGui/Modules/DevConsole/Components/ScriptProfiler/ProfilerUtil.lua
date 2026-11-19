-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ProfilerDataFormatV2 = require(script.Parent.ProfilerDataFormatV2)

local module = {}

function module.getDurations(arg1, arg2)
    if arg2 > 0 then
        local var1 = arg1.Nodes[arg2]
        assert(var1 ~= nil)

        return var1.TotalDuration, var1.Duration
    end

    local num1 = 0

    for _, value in arg1.Categories do
        num1 += arg1.Nodes[value.NodeId].TotalDuration
    end

    return num1, 0
end

function module.getName(_, arg1)
    return arg1 and arg1.Name
end

function module.getSourceName(_, arg1)
    return arg1 and arg1.Source
end

function module.getLine(_, arg1)
    return arg1 and arg1.Line
end

function module.getNativeFlag(_, arg1)
    return arg1 and arg1.IsNative or false
end

function module.getPluginFlag(_, arg1)
    return arg1 and arg1.IsPlugin or false
end

function module.standardizeChildren(_, arg1)
    return arg1 and arg1.Children
end

function module.formatSessionLength(num1: number?)
    if not num1 then
        return nil
    end

    local num2 = num1 / 3600000
    local num3 = num1 / 60000 % 60
    local num4 = num1 / 1000 % 60
    local num5 = num1 % 1000

    return string.format("%02i:%02i:%02i.%04i", num2, num3, num4, num5)
end

function module.formatTimer(num1: number?): string
    if num1 == nil then
        return ""
    end

    if num1 == 0 then
        return ""
    elseif num1 >= 60 then
        return string.format("%dm", num1 / 60)
    end
    return string.format("%ds", num1)
end

function module.formatFrequency(arg1): string
    if arg1 < 1000 then
        return tostring(arg1) .. " Hz"
    end
    return tostring(arg1 / 1000) .. " KHz"
end

function module.getSourceLocationString(arg1, arg2, str1: string)
    local sourceName = module.getSourceName(arg1, arg2)
    if sourceName and #sourceName ~= 0 then
        str1 = sourceName
    end

    local line = module.getLine(arg1, arg2)
    if line and line >= 1 then
        str1 = string.format("%s:%s", str1, tostring(line))
    end
    return str1
end

return module

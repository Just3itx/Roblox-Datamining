-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")

local DiagEventTypes = require(SocialLuaAnalytics.Analytics.Enums).DiagEventTypes

local _Types = require(script.Parent.Parent.Types)

local function formatValue(arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    if type(arg1) == "function" then
        return (arg1(arg2))
    end

    return arg1
end

local function getFormattedDiagEventInfo()
    return function(arg1, arg2)
        local name = formatValue(arg1.name, arg2)
        local type = arg1.type or DiagEventTypes.Counter
        local var3

        if type == DiagEventTypes.Stats then
            local stats = arg1.stats
            stats = formatValue(stats, arg2)
            var3 = stats or 0
        else
            local count = arg1.count
            count = formatValue(count, arg2)
            var3 = count or 1
        end

        return {
            type = type,
            name = name,
            value = var3,
            platformSpecificity = arg1.platformSpecificity
        }
    end
end

return getFormattedDiagEventInfo

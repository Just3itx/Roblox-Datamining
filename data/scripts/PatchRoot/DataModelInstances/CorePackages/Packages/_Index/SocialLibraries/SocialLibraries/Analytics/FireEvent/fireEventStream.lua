-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local llama = require(scriptParentParentParent.dependencies).llama
local _Types = require(script.Parent.Types)
local toStringAdditionalArgs = require(script.Parent.toStringAdditionalArgs)
local getEventInfo = require(script.Parent.getEventInfo)
local optionallyLog = require(script.Parent.optionallyLog)
local compose = require(script.Parent.Parent.Parent.RoduxTools.compose)
local isEnum = require(script.Parent.Parent.Parent.Utils.isEnum)

local function func1(additionalInfo) -- Luacid: Inlined by compiler; 1 call site recovered
    return llama.Dictionary.map(additionalInfo or {}, function(arg1)
        if isEnum(arg1) then
            return arg1.rawValue()
        end

        return arg1
    end)
end

local function func2(arg1, formatRulesForAdditionalInfo)
    if not (arg1 and formatRulesForAdditionalInfo) then
        return {}
    end

    return llama.Dictionary.map(arg1, function(arg2, arg3)
        local var1 = formatRulesForAdditionalInfo[arg3]
        if var1 then
            if type(var1) == "function" then
                return (var1(arg2))
            end

            return arg2
        end
        return llama.None
    end)
end

local function func3(tbl1): string
    return string.format(
        "context: (%s), eventName: (%s), additionalInfo: (%s)",
        tbl1.context,
        tbl1.eventType,
        toStringAdditionalArgs(tbl1.additionalInfo)
    )
end

local function func4(eventStreamImpl) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl1)
        eventStreamImpl:setRBXEventStream(tbl1.context, tbl1.eventType, tbl1.additionalInfo)

        return tbl1
    end
end

return function(tbl1): (T, U) -> (T, U)
    local eventInfo = getEventInfo(tbl1.eventList)

    return function<T, U>(arg1: T, arg2: U): (T, U)
        local var1 = eventInfo(arg1)

        compose(optionallyLog(tbl1.loggerImpl, func3), (func4(tbl1.eventStreamImpl)))({
            context = var1.context.rawValue(),
            eventType = var1.eventType.rawValue(),
            additionalInfo = llama.Dictionary.join(
                tbl1.infoForAllEvents or {},
                func1(var1.additionalInfo),
                func2(arg2, var1.formatRulesForAdditionalInfo)
            )
        })

        return arg1, arg2
    end
end

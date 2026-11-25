-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local scriptParentParentParentParent = scriptParentParentParent.Parent
local llama = require(scriptParentParentParent.dependencies).llama
local _Types = require(script.Parent.Parent.Types)
local toStringAdditionalArgs = require(script.Parent.toStringAdditionalArgs)
local getEventInfo = require(script.Parent.getEventInfo)
local optionallyLog = require(script.Parent.optionallyLog)
local isEnum = require(script.Parent.Parent.Parent.Utils.isEnum)

local Dash = require(scriptParentParentParentParent.Dash)
local FFlagPymkCarouselExtendProps = require(scriptParentParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps

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

local function func4(eventStreamImpl, shouldUseSendEventDeferred: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl1)
        if shouldUseSendEventDeferred then
            eventStreamImpl:sendEventDeferred(tbl1.context, tbl1.eventType, tbl1.additionalInfo)
        else
            eventStreamImpl:setRBXEventStream(tbl1.context, tbl1.eventType, tbl1.additionalInfo)
        end

        return tbl1
    end
end

return function(tbl1): (T, U) -> (T, U)
    local eventInfo = getEventInfo(tbl1.eventList)

    return function<T, U>(arg1: T, arg2: U): (T, U)
        local var1 = eventInfo(arg1)
        local infoForAllEvents = if tbl1.getInfoForAllEvents then tbl1.getInfoForAllEvents() else tbl1.infoForAllEvents
        Dash.pipe(func4(tbl1.eventStreamImpl, tbl1.shouldUseSendEventDeferred), optionallyLog(tbl1.loggerImpl, func3))({
            context = if FFlagPymkCarouselExtendProps and tbl1.context then tbl1.context else var1.context,
            eventType = var1.eventType,
            additionalInfo = llama.Dictionary.join(
                infoForAllEvents or {},
                func1(var1.additionalInfo),
                func2(arg2, var1.formatRulesForAdditionalInfo)
            )
        })

        return arg1, arg2
    end
end

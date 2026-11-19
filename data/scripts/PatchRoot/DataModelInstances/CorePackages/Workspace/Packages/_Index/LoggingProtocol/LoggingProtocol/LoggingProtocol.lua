-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)
local ArgCheck = require(scriptParentParent.ArgCheck)

local _LoggingProtocolTypes = require(scriptParent.LoggingProtocolTypes)
local AppCommonLib = require(scriptParentParent.AppCommonLib)
local callOnce = AppCommonLib.callOnce
local callOncePerDM = require(scriptParent.callOncePerDM)
local Signal = AppCommonLib.Signal

game:DefineFastFlag("EnableTelemetryProtocol", false)

function getDomainName(): string
    return if game:GetFastFlag("EnableTelemetryProtocol") then "Telemetry" else "Logging"
end

local TelemetryBackends = {
    UNSPECIFIED = "UNSPECIFIED",
    EventIngest = "EventIngest",
    Points = "Points",
    EphemeralCounter = "EphemeralCounter",
    EphemeralStat = "EphemeralStat",
    Counter = "RobloxTelemetryCounter",
    Stats = "RobloxTelemetryStat"
}

local validateParams = t.strictInterface({ eventName = t.string, timestamp = t.optional(t.number), metadata = t.optional(t.keys(t.string)) })
local module = {
    TelemetryBackends = TelemetryBackends,
    StandardizedFields = {
        addPlaceId = "addPlaceId",
        addUniverseId = "addUniverseId",
        addPlaceInstanceId = "addPlaceInstanceId",
        addSessionId = "addSessionId",
        addOsInfo = "addOSInfo"
    },
    LOG_EVENT_WITH_TIMESTAMP_DESCRIPTOR = {
        fid = MessageBus.getMessageId(getDomainName(), "logEventWithTimestamp"),
        validateParams = validateParams
    },
    GET_TIMESTAMP_DESCRIPTOR = {
        fid = MessageBus.getMessageId(getDomainName(), "getTimestamp"),
        validateParams = t.table
    },
    LOG_EVENT_FROM_LUA_DESCRIPTOR = {
        fid = MessageBus.getMessageId(getDomainName(), "logEventFromLua"),
        validateParams = t.interface({
            eventType = t.string,
            config = t.optional(
                t.strictInterface({
                    eventName = t.string,
                    backends = t.array(t.valueOf(TelemetryBackends)),
                    throttlingPercentage = t.optional(t.number),
                    lastUpdated = t.optional(t.array(t.integer)),
                    description = t.optional(t.string),
                    links = t.optional(t.string)
                })
            ),
            data = t.optional(t.table)
        })
    }
}
module.__index = module

function module.new(messageBus)
    local tbl2 = {
        messageBus = messageBus or MessageBus,
        durationLoggerSignal = Signal.new()
    }
    setmetatable(tbl2, module)
    return tbl2
end

function module:setDurationLoggerListener(func1: (...any) -> (...any))
    return self.durationLoggerSignal:connect(func1)
end

function module:logEventWithTimestamp(eventName: string, timestamp: number, metadata)
    ArgCheck.isType(eventName, "string", "eventName")
    ArgCheck.isType(timestamp, "number", "timestamp")
    self.messageBus.call(
        self.LOG_EVENT_WITH_TIMESTAMP_DESCRIPTOR,
        { eventName = eventName, timestamp = timestamp, metadata = metadata }
    )
    self.durationLoggerSignal:fire(eventName)
end

function module.logEvent(tbl2, str1: string, arg1)
    ArgCheck.isType(str1, "string", "eventName")
    tbl2:logEventWithTimestamp(str1, 0, arg1)
end

function module.logEventOnce(tbl2, str1: string, arg1)
    ArgCheck.isType(str1, "string", "eventName")
    if game:DefineFastFlag("LuaAppSendTTIEventsPerDM", false) then
        callOncePerDM(string.format("logging_protocol_key-%s", str1), function()
            tbl2:logEvent(str1, arg1)
        end)

        return
    end

    callOnce(string.format("logging_protocol_key-%s", str1), function()
        tbl2:logEvent(str1, arg1)
    end)
end

function module:getTimestamp()
    return self.messageBus.call(self.GET_TIMESTAMP_DESCRIPTOR, {})
end

function module:logRobloxTelemetryCounter(config, incrementValue: number?, customFields)
    self.messageBus.call(self.LOG_EVENT_FROM_LUA_DESCRIPTOR, {
        eventType = "RobloxTelemetryCounter",
        config = config,
        data = incrementValue and { incrementValue = incrementValue, customFields = customFields }
            or customFields and { customFields = customFields }
            or nil
    })
end

function module:logRobloxTelemetryStat(config, statValue: number, customFields)
    self.messageBus.call(
        self.LOG_EVENT_FROM_LUA_DESCRIPTOR,
        {
            eventType = "RobloxTelemetryStat",
            config = config,
            data = { statValue = statValue, customFields = customFields }
        }
    )
end

function module:logRobloxTelemetryEvent(config, standardizedFields, customFields, eventContext: string?)
    self.messageBus.call(self.LOG_EVENT_FROM_LUA_DESCRIPTOR, {
        eventType = "RobloxTelemetry",
        config = config,
        data = {
            standardizedFields = standardizedFields,
            customFields = customFields,
            eventContext = eventContext
        }
    })
end

function module:logEphemeralCounterEvent(config, incrementValue: number?)
    self.messageBus.call(self.LOG_EVENT_FROM_LUA_DESCRIPTOR, {
        eventType = "EphemeralCounter",
        config = config,
        data = incrementValue and { incrementValue = incrementValue } or nil
    })
end

function module:logEphemeralStatEvent(config, statValue: number)
    self.messageBus.call(
        self.LOG_EVENT_FROM_LUA_DESCRIPTOR,
        {
            eventType = "EphemeralStat",
            config = config,
            data = { statValue = statValue }
        }
    )
end

module.default = module.new()

return module

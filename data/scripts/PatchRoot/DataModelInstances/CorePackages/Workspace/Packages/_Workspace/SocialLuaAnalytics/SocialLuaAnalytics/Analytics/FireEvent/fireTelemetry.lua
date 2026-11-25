-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")
local SocialLuaAnalyticsParent = SocialLuaAnalytics.Parent
local Cryo = require(SocialLuaAnalyticsParent.Cryo)
local Dash = require(SocialLuaAnalyticsParent.Dash)
local SupportedTelemetryBackends = require(SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends)

local _Contexts = require(SocialLuaAnalytics.Analytics.Enums.Contexts)
local _Types = require(script.Parent.Parent.Types)

local TelemetryService = nil
local function getDefaultTelemetryService() -- Luacid: Inlined by compiler; 1 call site recovered
    if TelemetryService == nil then
        TelemetryService = game:GetService("TelemetryService")
    end
    return TelemetryService
end

local function func1(loggerImpl, telemetryPipeline: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1, value, arg3, ctx)
        if not loggerImpl then
            return
        end
        local var1 = (type(value) == "string" or type(value) == "number") and { value = value } or value

        local var2 = Cryo.Dictionary.join(arg1, var1 or {}, arg3 or {})

        if ctx then
            var2.ctx = ctx
        end

        var2.telemetryPipeline = telemetryPipeline

        loggerImpl:info(Dash.pretty(var2))
    end
end

return function(tbl1)
    return function(eventName, arg1, tbl2, eventContext)
        local defaults = tbl1.eventList.defaults
        local var1 = tbl1.eventList[eventName]
        local bool1 = tbl1.shouldUseTelemetryService == true
        local func2 = func1(tbl1.loggerImpl, if bool1 then "TelemetryService" else "LoggingProtocol")
        local var2 = if bool1 then tbl1.telemetryServiceImpl or getDefaultTelemetryService() else nil

        for _, backend in var1.backendsList do
            local incrementValue = backend.incrementValue or 1
            local var3 = if backend.overrideName then backend.overrideName(arg1) else eventName
            local throttlingThousandths = backend.throttlingThousandths or var1.throttlingThousandths or defaults.throttlingThousandths

            local tbl3 = {
                eventName = var3,
                backends = { backend.type },
                throttlingPercentage = math.clamp(throttlingThousandths, 0, 10000),
                lastUpdated = var1.lastUpdated,
                description = var1.description,
                links = var1.links or defaults.links
            }

            local tbl4 = ({})
            if tbl1.getInfoForAllEvents then
                local infoForAllEvents = tbl1.getInfoForAllEvents()
                tbl4 = Cryo.Dictionary.join(tbl4, infoForAllEvents)
            end
            if backend.format then
                assert(backend.dynamicCustomFields == nil, "Cannot use dynamicCustomFields with format")
                assert(backend.staticCustomFields == nil, "Cannot use staticCustomFields with format")
                tbl4 = backend.format(arg1, tbl2 or {})
            else
                if backend.dynamicCustomFields and arg1 then
                    for k, dynamicCustomField in backend.dynamicCustomFields do
                        if arg1[k] then
                            tbl4[k] = dynamicCustomField(arg1[k])
                        end
                    end
                end

                if backend.staticCustomFields then
                    tbl4 = Cryo.Dictionary.join(tbl4, backend.staticCustomFields)
                end
            end

            if backend.type == SupportedTelemetryBackends.Points then
                tbl1.telemetryImpl:logRobloxTelemetryEvent(tbl3, backend.standardizedFields, tbl4)
                func2(tbl3, backend.standardizedFields, tbl4)
            elseif backend.type == SupportedTelemetryBackends.RobloxTelemetryStat then
                if not (arg1 and arg1.statValue) then
                    tbl3.backends = { SupportedTelemetryBackends.RobloxTelemetryCounter }
                    tbl3.eventName = eventName .. "MissingStatValue"

                    if bool1 then
                        var2:LogCounter(tbl3, { standardizedFields = backend.standardizedFields, customFields = tbl4 }, incrementValue)
                    else
                        tbl1.telemetryImpl:logRobloxTelemetryCounter(tbl3, incrementValue, tbl4)
                    end
                    func2(tbl3, incrementValue, tbl4)

                    return
                end

                if bool1 then
                    local tbl5 = {
                        standardizedFields = backend.standardizedFields,
                        customFields = tbl4
                    }
                    var2:LogStat(tbl3, tbl5, arg1.statValue)
                else
                    tbl1.telemetryImpl:logRobloxTelemetryStat(tbl3, arg1.statValue, tbl4)
                end

                func2(tbl3, arg1.statValue, tbl4)
            elseif backend.type == SupportedTelemetryBackends.RobloxTelemetryCounter then
                if bool1 then
                    local tbl5 = {
                        standardizedFields = backend.standardizedFields,
                        customFields = tbl4
                    }
                    var2:LogCounter(tbl3, tbl5, incrementValue)
                else
                    tbl1.telemetryImpl:logRobloxTelemetryCounter(tbl3, incrementValue, tbl4)
                end
                func2(tbl3, incrementValue, tbl4)
            elseif backend.type == SupportedTelemetryBackends.EventIngest then
                if bool1 then
                    local tbl5 = {
                        eventContext = eventContext or tbl4.eventContext,
                        standardizedFields = backend.standardizedFields,
                        customFields = tbl4
                    }
                    var2:LogEvent(tbl3, tbl5)
                else
                    tbl1.telemetryImpl:logRobloxTelemetryEvent(tbl3, backend.standardizedFields, tbl4, eventContext or tbl4.eventContext)
                end

                func2(tbl3, arg1, tbl4, eventContext or tbl4.eventContext)
            end
        end
    end
end

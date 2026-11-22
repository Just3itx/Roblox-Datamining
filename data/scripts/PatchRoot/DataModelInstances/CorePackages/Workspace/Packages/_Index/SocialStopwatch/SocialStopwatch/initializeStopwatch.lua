-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialStopwatch = script:FindFirstAncestor("SocialStopwatch")
local SocialStopwatchParent = SocialStopwatch.Parent
local HttpService = game:GetService("HttpService")

local Timers = require(SocialStopwatchParent.SocialLuaAnalytics).Analytics.Timing.Timers
local _Events = require(SocialStopwatch.Events)
local EventModes = require(SocialStopwatch.EventModes)
local EventRegister = require(SocialStopwatch.EventRegister)
local LoggingProtocol = require(SocialStopwatchParent.LoggingProtocol)
local StopwatchTelemetryConfig = require(SocialStopwatch.StopwatchTelemetryConfig)
local _Types = require(script.Parent.Types)

return function()
    local tbl1 = ({})
    local var1 = Timers()
    local default = LoggingProtocol.default

    local function func1(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var2 = EventRegister[arg1]
        if not var2 then
            error("Event not registered: " .. arg1)
        end
        return var2
    end

    local function func2(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        return function(arg1)
            local var2 = func1(arg1)
            local id = tbl1[arg1]
            if not id then
                default:logRobloxTelemetryEvent(
                    StopwatchTelemetryConfig,
                    { default.StandardizedFields.addOsInfo },
                    {
                        eventName = `FailedOn{str1}{arg1}`,
                        count = 1
                    }
                )

                if var2.mode == EventModes.Strict then
                    error(`Cannot {str1} an event that has not been started: {arg1}`)
                end
            end

            if not (id and var1.getStartTimestamp(id)) then
                return nil
            end

            return {
                startTime = var1.getStartTimestamp(id),
                id = id,
                timeElapsed = var1.getTime(id)
            }
        end
    end

    local get = func2("Get")
    local func4 = func2("Stop")

    return {
        start = function(arg1, arg2)
            local var2 = func1(arg1)
            local id = var1.start(HttpService:GenerateGUID(false), arg2)

            if tbl1[arg1] then
                default:logRobloxTelemetryEvent(
                    StopwatchTelemetryConfig,
                    { default.StandardizedFields.addOsInfo },
                    {
                        eventName = `FailedOnStart{arg1}`,
                        count = 1
                    }
                )
                if var2.mode == EventModes.Strict then
                    error("Cannot start event twice: " .. arg1)
                end
            end

            tbl1[arg1] = id

            return {
                startTime = var1.getStartTimestamp(id),
                id = id
            }
        end,
        get = get,
        stop = function(arg1)
            local var2 = func4(arg1)
            tbl1[arg1] = nil
            return var2
        end,
        _unsafeClearEventLog = function()
            tbl1 = {}
        end
    }
end

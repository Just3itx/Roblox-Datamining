-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local LoggingProtocol = require(SduiCoreSystemParent.LoggingProtocol)
local tutils = require(SduiCoreSystemParent.tutils)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiErrors = require(SduiCoreSystem.SduiErrors)
local FFlagLuaAppAddHasOneByTwoField = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppAddHasOneByTwoField
local FFlagLuaAppAddHasOneByTwoFieldSdui = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppAddHasOneByTwoFieldSdui
local FFlagLuaAppSduiHomeFeedStats = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppSduiHomeFeedStats

local throttlingPercentage = game:DefineFastInt("DiscoverySduiErrorHundredthsPercent", 0)
local num1 = game:DefineFastInt("DiscoverySduiTimerEventsHundredthsPercent", 0)
local num2 = game:DefineFastInt("DiscoveryFeedStatsHundredthsPercent", 0)

local tbl1 = {
    eventName = "DiscoverySdui_ErrorDetails",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 24, 11, 4 },
    description = "Error details related to discovery server-driven ui",
    links = ""
}

local tbl2 = {
    eventName = "DiscoverySdui_ErrorCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = 0,
    lastUpdated = { 24, 12, 14 },
    description = "Error related to discovery server-driven ui"
}

local tbl3 = {
    eventName = "DiscoverySdui_Timers",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = num1,
    lastUpdated = { 25, 3, 14 },
    description = "Timers related to discovery server-driven ui",
    links = ""
}

local tbl4 = {
    eventName = "DiscoverySdui_FeedStats",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = num2,
    lastUpdated = { 25, 5, 27 },
    description = "Stats for feed response. Number of items per collection",
    links = ""
}

local function makeErrorKey(errorType, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{errorType}_{arg1.name}_{arg1.componentType}_{arg1.parserName}_{arg1.propName}`
end

local tbl5 = ({})
return {
    clearSeenErrors = function()
        tbl5 = {}
    end,
    reportError = function(errorType, arg1, page: string, arg2)
        arg2 = arg2 or LoggingProtocol.default
        assert(arg2, "loggingProtocol must exist")
        local errorKey = makeErrorKey(errorType, arg1)

        if tbl5[errorKey] then
            return
        end
        tbl5[errorKey] = true

        local tbl6 = tbl2
        local num4 = 1
        local tbl7 = {
            errorType = errorType,
            name = if arg1 then arg1.name else nil,
            componentType = if arg1 then arg1.componentType else nil,
            propName = if arg1 then arg1.propName else nil,
            parserName = if arg1 then arg1.parserName else nil,
            page = page
        }
        arg2:logRobloxTelemetryCounter(tbl6, num4, tbl7)

        arg2:logRobloxTelemetryEvent(
            tbl1,
            { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo },
            Cryo.Dictionary.union({ errorType = errorType, page = page }, arg1 or {}),
            page
        )

        if not _G.__TESTEZ_RUNNING_TEST__ then
            warn(`Discovery server-driven ui error \n{errorType} \n{tutils.toString(arg1)}`)
        end
    end,
    reportCounter = function(str1: string, arg1, bool1: boolean?, arg2)
        arg2 = arg2 or LoggingProtocol.default
        assert(arg2, "loggingProtocol must exist")

        local tbl6 = {
            eventName = `DiscoverySdui_Counter_{str1}`,
            backends = { LoggingProtocol.TelemetryBackends.Counter },
            throttlingPercentage = 0,
            lastUpdated = { 25, 2, 5 },
            description = "Counters related to discovery server-driven ui"
        }

        local num4 = 1
        local tbl7 = if arg1 then {
            name = if arg1 then arg1.name else nil,
            componentType = if arg1 then arg1.componentType else nil,
            propName = if arg1 then arg1.propName else nil,
            parserName = if arg1 then arg1.parserName else nil
        } else nil
        arg2:logRobloxTelemetryCounter(tbl6, num4, tbl7)

        if not (bool1 or _G.__TESTEZ_RUNNING_TEST__ or _G.__TEST_SUITE_PACKAGE__) then
            warn(`Discovery server-driven ui counter \n{str1} \n{tutils.toString(arg1)}`)
        end
    end,
    reportTimers = function(tbl6, str1: string, arg1)
        arg1 = arg1 or LoggingProtocol.default
        assert(arg1, "loggingProtocol must exist")
        for flow, value2 in tbl6 do
            local tbl7 = tbl3
            local tbl8 = { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo }

            local tbl9 = {
                flow = flow,
                durationMs = value2.durationMs,
                count = value2.count,
                failed = value2.failed
            }
            arg1:logRobloxTelemetryEvent(tbl7, tbl8, tbl9, str1)
        end
    end,
    reportOmniFeedStats = function(arg1, arg2, appPage, sduiResponseRequestId, arg3, hasOneByTwo: boolean?)
        arg3 = arg3 or LoggingProtocol.default
        assert(arg3, "loggingProtocol must exist")
        if not arg1 then
            return
        end
        arg2 = arg2 or {}
        local tbl6 = {}
        local tbl7 = {}
        for _, value in arg1 do
            if not value.topicId then
                continue
            end

            local bool1 = value.treatmentType == "sdui"
            tbl7[value.topicId] = bool1

            if bool1 then
                local num4 = 0
                local feedItems = arg2.feed and arg2.feed.props and arg2.feed.props.feedItems
                if feedItems then
                    for _, feedItem in feedItems do
                        if feedItem.feedItemKey ~= value.feedItemKey then
                            continue
                        end

                        local items = feedItem.props and feedItem.props.items
                        if items then
                            num4 = #items
                        elseif feedItem.props and feedItem.props.item then
                            num4 = 1
                        end

                        break
                    end
                end

                tbl6[value.topicId] = (tbl6[value.topicId] or 0) + num4
            else
                tbl6[value.topicId] = (tbl6[value.topicId] or 0) + (value.recommendationList and #value.recommendationList or 0)
            end
        end

        local tbl8 = ({})
        for value, value2 in tbl6 do
            tbl8[`{value}_item_count`] = value2
            tbl8[`{value}_is_sdui`] = if tbl7[value] then 1 else 0
        end
        tbl8.appPage = appPage
        tbl8.sduiResponseRequestId = sduiResponseRequestId
        if FFlagLuaAppAddHasOneByTwoField then
            tbl8.hasOneByTwo = hasOneByTwo
        end

        arg3:logRobloxTelemetryEvent(tbl4, { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo }, tbl8, appPage)
    end,
    reportSduiV2FeedStats = FFlagLuaAppSduiHomeFeedStats and function(tbl6, appPage: string, sduiResponseRequestId: string?, arg1, hasOneByTwo: boolean?)
        arg1 = arg1 or LoggingProtocol.default
        assert(arg1, "loggingProtocol must exist")
        if next(tbl6) == nil then
            return
        end

        local tbl7 = ({})
        for value, value2 in tbl6 do
            if value2.itemCount ~= nil then
                tbl7[`{value}_item_count`] = value2.itemCount
            end
            tbl7[`{value}_is_sdui`] = 1
            tbl7[`{value}_position`] = value2.position
        end
        tbl7.appPage = appPage
        tbl7.sduiResponseRequestId = sduiResponseRequestId
        tbl7.feedSource = "SduiV2FullPage"
        if FFlagLuaAppAddHasOneByTwoFieldSdui then
            tbl7.hasOneByTwo = hasOneByTwo
        end

        arg1:logRobloxTelemetryEvent(tbl4, { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo }, tbl7, appPage)
    end or nil
}

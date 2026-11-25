-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")
local SocialLuaAnalyticsParent = SocialLuaAnalytics.Parent

local Cryo = require(SocialLuaAnalyticsParent.Cryo)

local createFireEvent = require(SocialLuaAnalytics.Analytics.FireEvent.createFireEvent)

local _Types = require(script.Parent.Parent.Types)

local function AnalyticsFactory(tbl1)
    local var1 = tbl1.infoForAllEvents or {}

    local function updateInfoForAllEvents(arg1)
        var1 = Cryo.Dictionary.join(var1, arg1)
        return var1
    end

    local function getInfoForAllEvents()
        return var1
    end

    return {
        fireAnalyticsEvent = createFireEvent(
            {
                EventStream = tbl1.eventLists.EventStream,
                Diag = tbl1.eventLists.Diag,
                Telemetry = tbl1.eventLists.Telemetry
            }
        )(
            {
                analytics = {
                    EventStream = tbl1.analyticsImpl.EventStream,
                    Diag = tbl1.analyticsImpl.Diag,
                    Telemetry = tbl1.analyticsImpl.Telemetry
                },
                getInfoForAllEvents = getInfoForAllEvents,
                loggerImpl = tbl1.loggerImpl
            }
        ),
        updateInfoForAllEvents = updateInfoForAllEvents,
        getInfoForAllEvents = getInfoForAllEvents
    }
end

return AnalyticsFactory

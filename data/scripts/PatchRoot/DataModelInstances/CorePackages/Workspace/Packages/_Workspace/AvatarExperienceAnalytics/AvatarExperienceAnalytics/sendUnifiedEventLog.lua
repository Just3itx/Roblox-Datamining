-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local isRunningInStudio = require(AvatarExperienceAnalyticsParent.AppCommonLib).isRunningInStudio
local DebugPanel = require(AvatarExperienceAnalyticsParent.DebugPanel)
local DeviceTier = require(AvatarExperienceAnalyticsParent.Devices).DeviceTier

local AnalyticsService = require(script.Parent.AnalyticsService)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventPageStore = require(script.Parent.Store.UnifiedEventPageStore)
local UnifiedEventCounterAggregator = require(script.Parent.Lib.UnifiedEventCounterAggregator)
local AXUnifiedEventFilter = require(script.Parent.AXUnifiedEventFilter)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXSendUnifiedEventLogWithInstance = AvatarExperienceFlags.FFlagAXSendUnifiedEventLogWithInstance
local FFlagAXDebugPanelImpressed = AvatarExperienceFlags.FFlagAXDebugPanelImpressed
local FFlagAXUnifiedEventPageContext = AvatarExperienceFlags.FFlagAXUnifiedEventPageContext
local FFlagAXUnifiedEventCounters = AvatarExperienceFlags.FFlagAXUnifiedEventCounters
local FFlagAXUnifiedEventDeviceTier = AvatarExperienceFlags.FFlagAXUnifiedEventDeviceTier
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local bool1 = game:DefineFastFlag("AXSendUnifiedEventsInStudio", false)
local deviceTier = if FFlagAXUnifiedEventDeviceTier then DeviceTier.GetDeviceMemoryTier() else nil

return function(arg1, instance, tbl1)
    if FFlagAXUnifiedEventPageContext then
        local sessionTag = SessionService:GetSessionTag("level2a")
        local pageFields = UnifiedEventPageStore.getPageFields()
        local join = Cryo.Dictionary.join
        local tbl2 = {
            navigationPage = pageFields.navigationPage,
            navigationOpaquePage = pageFields.navigationOpaquePage,
            sessionTag = 0
        }

        if sessionTag == nil or sessionTag == "" then
            sessionTag = UnifiedEventPageStore.UNKNOWN
        end

        tbl2.sessionTag = sessionTag
        arg1 = join(tbl2, arg1)
    end

    if FFlagAXUnifiedEventDeviceTier then
        arg1 = Cryo.Dictionary.join({ deviceTier = deviceTier or "Unknown" }, arg1)
    end

    if FFlagAXUnifiedEventStrictPayloads and arg1.surface == nil then
        arg1 = Cryo.Dictionary.join(arg1, { surface = UnifiedLoggingSurface.UNDEFINED_SURFACE })
    end

    if FFlagAXDebugPanelImpressed then
        local notify = DebugPanel.AnalyticsFeed.notify
        local tbl2 = {
            feedId = "ax.marketplaceLogging",
            fields = arg1,
            instance = 0,
            eventName = 0,
            ctx = 0
        }

        if not FFlagAXSendUnifiedEventLogWithInstance then
            instance = nil
        end

        tbl2.instance = instance
        tbl2.eventName = UnifiedEventLogConstants.EVENT_NAME
        tbl2.ctx = UnifiedEventLogConstants.EVENT_NAME
        notify(tbl2)
    end

    if isRunningInStudio() and not bool1 then
        return
    end

    if FFlagAXUnifiedEventCounters then
        local var1 = if tbl1 ~= nil and tbl1.filterPassed ~= nil then tbl1.filterPassed else AXUnifiedEventFilter.filter(arg1, { skipReporting = true })
        UnifiedEventCounterAggregator.record(arg1, var1)
    end

    AnalyticsService.EventStream:sendTelemetryEvent(
        UnifiedEventLogConstants.EVENT_NAME,
        UnifiedEventLogConstants.EVENT_NAME,
        arg1
    )
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)
local sendUnifiedEventLog = require(script.Parent.sendUnifiedEventLog)
local UnifiedEventPageStore = require(script.Parent.Store.UnifiedEventPageStore)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)

local isRunningInStudio = require(AvatarExperienceAnalyticsParent.AppCommonLib).isRunningInStudio

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXSendUnifiedEventLogWithInstance = AvatarExperienceFlags.FFlagAXSendUnifiedEventLogWithInstance
local FFlagAXUnifiedEventPageContext = AvatarExperienceFlags.FFlagAXUnifiedEventPageContext
local FFlagAXUnifiedEventCounters = AvatarExperienceFlags.FFlagAXUnifiedEventCounters

local FFlagAllowCustomUnifiedEventFilter = require(script.Parent.FFlagAllowCustomUnifiedEventFilter)

local AXUnifiedEventFilter = require(script.Parent.AXUnifiedEventFilter)

return function(arg1, arg2, tbl1)
    local sessionTag = SessionService:GetSessionTag("level2a")
    local var1 = arg1:GetAttribute(UnifiedEventLogConstants.SESSION_TAG_NAME)
    if not FFlagAXUnifiedEventPageContext and sessionTag ~= var1 and not isRunningInStudio() then
        return
    end

    local tbl2 = tbl1 or {}
    local tbl3 = {}
    local attributes = arg1:GetAttributes()

    if FFlagAXMISEnableMultiShoppingUnifiedEvents then
        tbl3 = UnifiedEventLoggingUtils.getFieldsToSendFromInstanceAttributes(attributes)
    else
        for value, value2 in attributes do
            if UnifiedEventLoggingUtils.isUnifiedLoggingAttribute(value) then
                tbl3[UnifiedEventLoggingUtils.getUnifiedLoggingFieldName(value)] = value2
            end
        end
    end

    if tbl2.includeScreenSize then
        tbl3 = Cryo.Dictionary.join(tbl3, UnifiedEventLoggingUtils.getScreenSize(arg1))
    end

    if tbl2.includeElementSizeAndPosition then
        tbl3 = Cryo.Dictionary.join(tbl3, UnifiedEventLoggingUtils.getElementSizeAndPosition(arg1))
    end

    local var2 = Cryo.Dictionary.join(tbl3, arg2)

    if FFlagAXUnifiedEventPageContext then
        local join = Cryo.Dictionary.join
        local tbl4 = { elementSessionTag = 0 }
        if var1 == nil or var1 == "" then
            var1 = UnifiedEventPageStore.UNKNOWN
        end

        tbl4.elementSessionTag = var1
        var2 = join(var2, tbl4)
    end

    local filterPassed = (if FFlagAllowCustomUnifiedEventFilter and tbl2.filter then tbl2.filter else AXUnifiedEventFilter.filter)(var2)

    local var4 = sendUnifiedEventLog

    if not FFlagAXSendUnifiedEventLogWithInstance then
        arg1 = nil
    end

    var4(var2, arg1, FFlagAXUnifiedEventCounters and { filterPassed = filterPassed } or nil)
end

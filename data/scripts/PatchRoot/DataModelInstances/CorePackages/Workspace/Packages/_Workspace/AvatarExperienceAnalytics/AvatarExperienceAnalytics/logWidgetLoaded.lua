-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local _AvatarExperienceModel = require(AvatarExperienceAnalyticsParent.AvatarExperienceModel)
local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)

local FFlagAXDeferWidgetLoadedUntilMarketplaceEntered = AvatarExperienceFlags.FFlagAXDeferWidgetLoadedUntilMarketplaceEntered
local FFlagAXLimitWidgetLoadedItemCount = AvatarExperienceFlags.FFlagAXLimitWidgetLoadedItemCount
local FIntAXWidgetLoadedItemCountLimit = AvatarExperienceFlags.FIntAXWidgetLoadedItemCountLimit
local FFlagAXUnifiedEventCounters = AvatarExperienceFlags.FFlagAXUnifiedEventCounters

local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local sendUnifiedEventLog = require(script.Parent.sendUnifiedEventLog)
local getUnifiedDeferredEventStore = require(script.Parent.Store.getUnifiedDeferredEventStore)

local WIDGET_LOADED = UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_LOADED

local function logWidgetLoaded(tbl1, requestId: string, func1: ((...any) -> (...any))?)
    if FFlagAXDeferWidgetLoadedUntilMarketplaceEntered then
        local unifiedDeferredEventStore = getUnifiedDeferredEventStore(false)
        if not unifiedDeferredEventStore.isEntered(false) then
            unifiedDeferredEventStore.enqueue(WIDGET_LOADED, function()
                logWidgetLoaded(tbl1, requestId, if FFlagAXUnifiedEventCounters then func1 else nil)
            end)
            return
        end
    end

    local var1 = if FFlagAXUnifiedEventCounters and func1 ~= nil then func1() else nil

    for gridPositionRow, value2 in tbl1 do
        local tbl2 = {}
        local tbl3 = {}
        local tbl4 = {}
        if value2.content then
            for _, value3 in value2.content do
                if FFlagAXLimitWidgetLoadedItemCount and #tbl4 >= FIntAXWidgetLoadedItemCountLimit then
                    break
                end

                if value3.type == "Asset" then
                    table.insert(tbl2, value3.id)
                elseif value3.type == "Bundle" then
                    table.insert(tbl3, value3.id)
                end
                table.insert(tbl4, value3.id)
            end
        end

        sendUnifiedEventLog({
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_LOADED,
            surface = if FFlagAXUnifiedEventCounters then var1 else nil,
            requestId = requestId,
            widgetId = value2.id,
            widgetType = value2.type,
            themeId = value2.tagId,
            gridPositionRow = gridPositionRow,
            gridPositionColumn = 1,
            assetIds = table.concat(tbl2, ","),
            bundleIds = table.concat(tbl3, ","),
            widgetItemIds = table.concat(tbl4, ",")
        })
    end
end

return logWidgetLoaded

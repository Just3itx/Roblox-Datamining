-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local useRoactService = require(GameCollectionsParent.RobloxAppHooks).useRoactService
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local AppEventIngestService = require(GameCollectionsParent.RoactServiceTags).AppEventIngestService
local RoactAnalytics = require(GameCollectionsParent.RoactServiceTags).RoactAnalytics
local Signal = require(GameCollectionsParent.AppCommonLib).Signal
local DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)
local GameSortLoadSource = require(GameCollectionsParent.DiscoveryAvailability).GameSortLoadSource
local reportWarning = require(GameCollectionsParent.DiscoveryAnalytics).Points.reportWarning
local LoggingProtocol = require(GameCollectionsParent.LoggingProtocol)
local DiscoveryEventErrorLogger = require(GameCollectionsParent.DiscoveryUtils).DiscoveryEventErrorLogger
local ApportioningDiagnosticTelemetry = require(GameCollectionsParent.DiscoveryUtils).ApportioningDiagnosticTelemetry
local GameCollectionItemTypes = DiscoveryTypes.GameCollectionItemTypes

local SendGameImpressions = require(script.Parent.SendGameImpressions)
local FFlagLuaAppEnableNxMRoduxApportioning = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local FFlagLuaAppEnableNxMApportioningExtraLogging = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEnableNxMApportioningExtraLogging

local function getGameSetTypeId(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil then nil elseif bool1 then arg1.topicId else arg1.gameSetTypeId
end

local function getGameSetTargetId(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 or arg1 == nil then nil else arg1.gameSetTargetId
end

local function getAppliedFilters(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 or not arg1 then nil else arg1.appliedFilters
end

local function useGameSortImpressionsParams<T>(arg1, bool1: boolean, num1: number, pageContext: string, bool2: boolean?, str2: string?, str3: string?, gameSortId: string, arg2: T, num2: number?, num3: number?, tbl1, arg3)
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useRoactService(RoactAnalytics)
    local sortLoadSource = if pageContext == AppPage.Home and arg1 and arg1.topicId then GameSortLoadSource.getSortLoadSource(arg1.topicId) else nil
    local sortSubId = if arg1 then arg1.sortSubId else nil
    local analyticsData = if arg1 then arg1.analyticsData else nil

    local var3 = React.useCallback(function(arg4)
        if tbl1 == nil or #tbl1 == 0 then
            DiscoveryEventErrorLogger.reportError(
                "useGameSortImpressionsParams_MissingEntries",
                "useGameSortImpressionsParams: entries is nil or empty for game sort impressions",
                { pageContext = pageContext, gameSortId = gameSortId }
            )

            return
        end

        if FFlagLuaAppEnableNxMApportioningExtraLogging then
            local num4 = 0
            local num5 = 0
            local num6 = 0
            local var3 = nil
            local var4 = nil
            for _, value in ipairs(arg4) do
                if var3 == nil or value < var3 then
                    var3 = value
                end

                if var4 == nil or var4 < value then
                    var4 = value
                end

                local var5 = tbl1 and tbl1[value]
                if var5 == nil then
                    num6 += 1
                elseif var5.gameCollectionItemTypeOverride == GameCollectionItemTypes.GameCollectionItemType.Blank then
                    num4 += 1
                else
                    num5 += 1
                end
            end
            ApportioningDiagnosticTelemetry.log("ImpressionsBatchSent", {
                batchSize = #arg4,
                realTileCount = num5,
                blankCount = num4,
                missingCount = num6,
                firstIndex = var3,
                lastIndex = var4,
                entriesCount = #tbl1,
                pageContext = pageContext,
                gameSortId = gameSortId,
                sortIndexOnPage = num1,
                topicId = arg1 and arg1.topicId,
                nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
            })
        end

        if pageContext ~= AppPage.SearchPage then
            local gameSetTypeId = getGameSetTypeId(arg1, bool1)
            local gameSetTargetId = getGameSetTargetId(arg1, bool1)
            local appliedFilters = getAppliedFilters(arg1, bool1)

            SendGameImpressions.sendFromTopicContents(
                var1,
                var2,
                arg4,
                tbl1,
                pageContext,
                gameSetTypeId,
                num1,
                num3,
                gameSetTargetId,
                str3,
                num2,
                bool2,
                str2,
                appliedFilters,
                sortLoadSource,
                nil,
                sortSubId,
                analyticsData
            )

            return
        end

        if not arg3 then
            reportWarning(
                LoggingProtocol.default,
                "useGameSortImpressionsParams_MissingSearchParams",
                "useGameSortImpressionsParams: searchParams is nil for search page game sort impressions"
            )
        end

        local tbl2 = {
            searchUuid = arg3 and arg3.searchUuid,
            emphasisFlag = arg3 and arg3.hasEmphasizedTile and 1 or 0,
            seeAllFlag = 1,
            sortPos = num1,
            gameSetTypeId = arg1 and arg1.topicId
        }

        SendGameImpressions.sendFromSearch(var1, var2, arg4, tbl1, pageContext, tbl2, num2, num3, bool2, str2)
    end, {
        var1,
        var2,
        num1,
        bool2,
        str2,
        bool1,
        arg1,
        pageContext,
        num2,
        num3,
        str3,
        tbl1,
        sortLoadSource,
        sortSubId,
        analyticsData,
        arg3,
        gameSortId
    })

    local var4 = React.useRef(nil)
    if var4.current == nil then
        var4.current = Signal.new()
    end
    local current = var4.current

    React.useEffect(function()
        current:fire()

        local connection = if arg2 then arg2:connect(function()
            current:fire()
        end) else nil

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end, { arg2, current })

    return var3, current, (React.useCallback(function()
        current:fire()
    end, { current }))
end

return useGameSortImpressionsParams

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local Cryo = require(ServerDrivenUiParent.Cryo)
local SendGameImpressions = require(ServerDrivenUiParent.GameCollections).SendGameImpressions
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local SduiParsers = SduiCoreSystem.SduiParsers
local FFlagSduiSearchResultsPageEnabled = require(ServerDrivenUiParent.SharedFlags).FFlagSduiSearchResultsPageEnabled
local FFlagSduiFixSearchTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiFixSearchTelemetry
local FFlagLuaAppSponsoredGamePreviewVideo = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSponsoredGamePreviewVideo
local FFlagLuaAppSduiPassSortSubId = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiPassSortSubId

local tbl1 = {}

local var1 = not require(ServerDrivenUiParent.SharedFlags).FFlagSduiForwardAnalyticsDataToGameClick and function(arg1)
    if not arg1 or type(arg1) ~= "table" then
        return nil
    end

    local tbl2 = ({})

    for value, value2 in arg1 do
        if type(value) == "string" and (type(value2) == "string" or type(value2) == "number" or type(value2) == "boolean") then
            tbl2[value] = tostring(value2)
        end
    end

    return if next(tbl2) then tbl2 else nil
end or require(ServerDrivenUi.Analytics.filterAndStringifyAnalyticsData)

local function SduiGameImpressionsHandler(arg1, tbl2, tbl3, arg2, num1: number?)
    if not arg2 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogGameImpressions,
            { name = "SduiGameImpressionsHandler", message = "Missing collectionAnalyticsData" },
            arg1.appPage
        )
        return
    end

    local tbl4 = ({})
    local var2 = if FFlagSduiFixSearchTelemetry then 0 else nil
    for value, value2 in tbl3 or tbl1 do
        local join = Cryo.Dictionary.join
        local tbl5 = {
            analyticsData = var1(value2) or Cryo.None,
            isSponsored = SduiParsers.safeParseBoolean(value2.adFlag or false, arg1, tbl1),
            gameCollectionItemTypeOverride = if FFlagSduiFixSearchTelemetry then value2.tileType else nil,
            sponsoredGamePreviewVideoEligible = if FFlagLuaAppSponsoredGamePreviewVideo then SduiParsers.safeParseBoolean(value2.sponsoredGamePreviewVideoEligible or false, arg1, tbl1) else nil
        }
        local var3 = join(value2, tbl5)

        if FFlagSduiFixSearchTelemetry then
            tbl4[value] = var3
            var2 += 1
        else
            table.insert(tbl4, var3)
        end
    end

    if #tbl2 ~= 0 and not (if FFlagSduiFixSearchTelemetry then var2 == 0 else #tbl4 == 0) then
        local var3 = tbl4[tbl2[1]]
        local componentType = if var3 then var3.itemComponentType else "unknown"

        if arg1.appPage == AppPage.SearchPage then
            local tbl5 = {
                searchUuid = arg2.searchUuid,
                emphasisFlag = FFlagSduiSearchResultsPageEnabled and arg2.hasEmphasizedTile and 1 or 0,
                seeAllFlag = if FFlagSduiSearchResultsPageEnabled then tonumber(arg2.seeAllFlag) or 0 else 0,
                sortPos = arg2.collectionPosition,
                gameSetTypeId = tostring(arg2.collectionId)
            }
            SendGameImpressions.sendFromSearch(
                arg1.dependencies.eventIngest,
                arg1.dependencies.appAnalytics,
                tbl2,
                tbl4,
                arg1.appPage,
                tbl5,
                arg2.itemsPerRow,
                num1,
                arg2.isWideTiles or false,
                componentType
            )
            return
        elseif arg1.appPage == AppPage.ExperienceDetail or arg1.appPage == AppPage.GameDetail then
            local refId = arg2.refId
            SendGameImpressions.sendFromGameDetails(
                arg1.dependencies.eventIngest,
                arg1.dependencies.appAnalytics,
                tbl2,
                tbl4,
                tostring(refId)
            )
            return
        elseif arg2.seeAllFlag then
            SendGameImpressions.sendFromSeeAll(
                arg1.dependencies.eventIngest,
                arg1.dependencies.appAnalytics,
                tbl2,
                tbl4,
                arg1.appPage,
                tostring(arg2.collectionId),
                arg2.gameSetTargetId,
                nil,
                arg2.appliedFilters,
                arg2.isWideTiles or false
            )
            return
        else
            local sendFromTopicContents = SendGameImpressions.sendFromTopicContents
            local eventIngest = arg1.dependencies.eventIngest
            local appAnalytics = arg1.dependencies.appAnalytics

            local appPage = arg1.appPage
            local str1 = tostring(arg2.collectionId)
            local collectionPosition = arg2.collectionPosition

            local gameSetTargetId = arg2.gameSetTargetId
            local var5 = nil
            local itemsPerRow = arg2.itemsPerRow
            local isWideTiles = arg2.isWideTiles or false

            local appliedFilters = arg2.appliedFilters
            local var6 = nil
            local function func1(str2: string)
                local var7 = SduiParseHelpers.stringifyValue(arg2)

                arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogGameImpressions, {
                    componentType = componentType,
                    name = "SduiGameImpressionsHandler",
                    message = `Failed to log game impressions. reason: {str2}. analyticsContext: {var7}`
                }, arg1.appPage)
            end

            local var7 = if FFlagLuaAppSduiPassSortSubId and arg2.sortSubId then tostring(arg2.sortSubId) else nil
            sendFromTopicContents(
                eventIngest,
                appAnalytics,
                tbl2,
                tbl4,
                appPage,
                str1,
                collectionPosition,
                num1,
                gameSetTargetId,
                var5,
                itemsPerRow,
                isWideTiles,
                componentType,
                appliedFilters,
                var6,
                func1,
                var7,
                var1(arg2)
            )

            return
        end
    end

    arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogGameImpressions, {
        name = "SduiGameImpressionsHandler",
        message = `No entries to log: impressionIndexes={#tbl2}, gameImpressionEntries={not FFlagSduiFixSearchTelemetry and #tbl4 or var2}`
    }, arg1.appPage)
end
return SduiGameImpressionsHandler

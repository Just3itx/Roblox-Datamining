-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Cryo = require(ServerDrivenUiParent.Cryo)
local SendGameImpressions = require(ServerDrivenUiParent.GameCollections).SendGameImpressions
local _UnifiedLogging = require(ServerDrivenUiParent.UnifiedLogging)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParsers = SduiCoreSystem.SduiParsers
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local _DiscoveryTypes = require(ServerDrivenUiParent.DiscoveryTypes)
local FFlagSduiFixSearchTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiFixSearchTelemetry
local FFlagLuaAppSponsoredGamePreviewVideo = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSponsoredGamePreviewVideo
local FFlagLuaAppSduiPassSortSubId = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiPassSortSubId

local tbl1 = {}

local function sendLegacyGameImpressionsForSdui(tbl2, tbl3, tbl4, arg1, arg2, num1: number?, arg3, callback: ((...any) -> (...any))?, num2: number?, name: string?)
    local tbl5 = ({})
    local var1 = if FFlagSduiFixSearchTelemetry then 0 else nil
    for value, value2 in tbl3 or tbl1 do
        local join = Cryo.Dictionary.join
        local tbl6 = {
            isSponsored = SduiParsers.safeParseBoolean(value2.adFlag or false, arg3, arg1),
            gameCollectionItemTypeOverride = if FFlagSduiFixSearchTelemetry then value2.tileType else nil,
            sponsoredGamePreviewVideoEligible = if FFlagLuaAppSponsoredGamePreviewVideo then SduiParsers.safeParseBoolean(value2.sponsoredGamePreviewVideoEligible or false, arg3, arg1) else nil
        }
        local var2 = join(value2, tbl6)

        if FFlagSduiFixSearchTelemetry then
            tbl5[value] = var2
            var1 += 1
        else
            table.insert(tbl5, var2)
        end
    end

    if not ((not FFlagSduiFixSearchTelemetry and #tbl5 or var1) > 0) or not (#tbl2 > 0) then
        return
    end
    local itemComponentType = tbl5[tbl2[1]] and tbl5[tbl2[1]].itemComponentType or "unknown"

    local var2 = tbl4[tbl2[1]]
    local var3

    if var2 then
        local componentType = SduiBuilder.getComponentType(var2, arg3)

        local var4 = var2.props and (var2.props.imageAspectRatio or 0) > 1
        var3 = (componentType == "Tile" or componentType == "GameTile") and var4
    else
        var3 = nil
    end

    local analyticsFieldInAncestors = if FFlagLuaAppSduiPassSortSubId then findAnalyticsFieldInAncestors("sortSubId", arg1) else nil

    if callback then
        callback(tbl2, tbl5, arg2.itemsPerRow, num1, var3)
        return
    end

    if arg3.appPage == AppPage.SearchPage then
        local tbl6 = {
            searchUuid = findAnalyticsFieldInAncestors("searchUuid", arg1),
            emphasisFlag = 0,
            seeAllFlag = 0,
            sortPos = arg2.collectionPosition,
            gameSetTypeId = tostring(arg2.collectionId)
        }

        SendGameImpressions.sendFromSearch(
            arg3.dependencies.eventIngest,
            arg3.dependencies.appAnalytics,
            tbl2,
            tbl5,
            arg3.appPage,
            tbl6,
            num2,
            num1,
            var3 or false,
            itemComponentType
        )
        return
    end

    if arg3.appPage == AppPage.ExperienceDetail or arg3.appPage == AppPage.GameDetail then
        local refId = arg2.refId
        SendGameImpressions.sendFromGameDetails(
            arg3.dependencies.eventIngest,
            arg3.dependencies.appAnalytics,
            tbl2,
            tbl5,
            tostring(refId)
        )
        return
    end

    local sendFromTopicContents = SendGameImpressions.sendFromTopicContents
    local eventIngest = arg3.dependencies.eventIngest
    local appAnalytics = arg3.dependencies.appAnalytics

    local appPage = arg3.appPage
    local str2 = tostring(arg2.collectionId)
    local collectionPosition = arg2.collectionPosition

    local var4 = nil
    local var5 = nil

    local var6 = var3 or false

    local var7 = nil
    local var8 = nil
    local function func1(str3: string)
        local var9 = if arg1 then SduiParseHelpers.stringifyValue(arg1.analyticsData) else nil
        arg3.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogGameImpressions, {
            componentType = itemComponentType,
            name = name,
            message = `Failed to log game impressions. reason: {str3}. analyticsContext: {var9}`
        }, arg3.appPage)
    end

    local var9 = if FFlagLuaAppSduiPassSortSubId and analyticsFieldInAncestors then tostring(analyticsFieldInAncestors) else nil
    sendFromTopicContents(
        eventIngest,
        appAnalytics,
        tbl2,
        tbl5,
        appPage,
        str2,
        collectionPosition,
        num1,
        var4,
        var5,
        num2,
        var6,
        itemComponentType,
        var7,
        var8,
        func1,
        var9
    )
end

return sendLegacyGameImpressionsForSdui

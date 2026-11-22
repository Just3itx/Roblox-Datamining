-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")
local LocalizationService = game:GetService("LocalizationService")

local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local getActionTelemetryFieldValue = require(SocialServerDrivenUiParent.SduiCoreSystem).getActionTelemetryFieldValue
local calculateRowPositionFields = require(SocialServerDrivenUiParent.UnifiedLogging).calculateRowPositionFields

local throttlingPercentage = game:DefineFastInt("SduiPlayerTileClickThrottlingHundredthsPercent", 10000)

local function SduiPlayerTileClickTelemetryHandler(arg1, arg2, arg3)
    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "profileType")
    if actionTelemetryFieldValue ~= nil and actionTelemetryFieldValue ~= "User" then
        return
    end

    local playerId = getActionTelemetryFieldValue(arg1, arg2, "playerId")
    if playerId == nil then
        return
    end

    local tilePos = getActionTelemetryFieldValue(arg1, arg2, "tilePos") or getActionTelemetryFieldValue(arg1, arg2, "itemPosition")
    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "userSearchSessionId")
    local userSearchSessionId = if actionTelemetryFieldValue4 == nil then nil else tostring(actionTelemetryFieldValue4)
    local actionTelemetryFieldValue5 = getActionTelemetryFieldValue(arg1, arg2, "collectionId")
    local sortPosition = getActionTelemetryFieldValue(arg1, arg2, "collectionPosition")
    local collectionData = if arg2 and arg2.getCollectionData then arg2.getCollectionData() else nil
    local itemsPerRow = if collectionData then collectionData.itemsPerRow else nil
    local startRowNumber = if collectionData then collectionData.startRowNumber else nil
    local rowPositionFields = calculateRowPositionFields(tilePos, itemsPerRow, startRowNumber)

    local actionTelemetryFieldValue7 = getActionTelemetryFieldValue(arg1, arg2, "feedRowNumber")

    if not actionTelemetryFieldValue7 then
        if rowPositionFields.rowOnPage == -1 then
            actionTelemetryFieldValue7 = nil
        else
            actionTelemetryFieldValue7 = rowPositionFields.rowOnPage
        end
    end

    local actionTelemetryFieldValue8 = getActionTelemetryFieldValue(arg1, arg2, "positionInRow")

    if not actionTelemetryFieldValue8 then
        if rowPositionFields.positionInRow == -1 then
            actionTelemetryFieldValue8 = nil
        else
            actionTelemetryFieldValue8 = rowPositionFields.positionInRow
        end
    end

    local actionTelemetryFieldValue9 = getActionTelemetryFieldValue(arg1, arg2, "rowInSort")

    if not actionTelemetryFieldValue9 then
        if rowPositionFields.rowInSort == -1 then
            actionTelemetryFieldValue9 = nil
        else
            actionTelemetryFieldValue9 = rowPositionFields.rowInSort
        end
    end

    TelemetryService:LogEvent({
        eventName = "playerTileClick",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 7, 17 },
        description = "Fired when a player tile is clicked in an SDUI collection"
    }, {
        eventContext = getActionTelemetryFieldValue(arg1, arg2, "eventContext") or "playerSearch",
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            playerId = playerId,
            tilePos = tilePos,
            contentType = getActionTelemetryFieldValue(arg1, arg2, "contentType") or "User",
            actionType = "OpenProfile",
            pageContext = getActionTelemetryFieldValue(arg1, arg2, "pageContext") or arg3.appPage,
            interactionUuid = HttpService:GenerateGUID(false),
            locale = LocalizationService.RobloxLocaleId,
            userSearchSessionId = userSearchSessionId,
            feedRowNumber = actionTelemetryFieldValue7,
            positionInRow = actionTelemetryFieldValue8,
            rowInSort = actionTelemetryFieldValue9,
            sortId = if actionTelemetryFieldValue5 == nil then nil else tostring(actionTelemetryFieldValue5),
            sortPosition = sortPosition
        }
    })
end

return SduiPlayerTileClickTelemetryHandler

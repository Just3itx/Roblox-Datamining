-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")
local LocalizationService = game:GetService("LocalizationService")

local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local getActionTelemetryFieldValue = require(SocialServerDrivenUiParent.SduiCoreSystem).getActionTelemetryFieldValue

local throttlingPercentage = game:DefineFastInt("SduiPlayerFriendAddThrottlingHundredthsPercent", 10000)

local function firePlayerFriendAddTelemetry(playerId: string, arg1, arg2)
    local tilePos = getActionTelemetryFieldValue(nil, arg1, "tilePos") or getActionTelemetryFieldValue(nil, arg1, "itemPosition")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(nil, arg1, "pageContext")

    if not actionTelemetryFieldValue2 then
        if arg2 then
            actionTelemetryFieldValue2 = arg2.appPage
        else
            actionTelemetryFieldValue2 = nil
        end
    end

    local eventContext = getActionTelemetryFieldValue(nil, arg1, "eventContext") or "playerSearch"
    local contentType = getActionTelemetryFieldValue(nil, arg1, "contentType") or "User"
    local actionTelemetryFieldValue5 = getActionTelemetryFieldValue(nil, arg1, "userSearchSessionId")
    local userSearchSessionId = if actionTelemetryFieldValue5 == nil then nil else tostring(actionTelemetryFieldValue5)
    local actionTelemetryFieldValue6 = getActionTelemetryFieldValue(nil, arg1, "collectionId")
    local sortPosition = getActionTelemetryFieldValue(nil, arg1, "collectionPosition")
    local collectionData = if arg1 and arg1.getCollectionData then arg1.getCollectionData() else nil
    local itemsPerRow = if collectionData then collectionData.itemsPerRow else nil
    local startRowNumber = if collectionData then collectionData.startRowNumber else nil
    local var2 = nil
    local var3, var4

    if typeof(tilePos) == "number" and tilePos > 0 and typeof(itemsPerRow) == "number" and itemsPerRow > 0 then
        var3 = math.ceil(tilePos / itemsPerRow)
        var4 = (tilePos - 1) % itemsPerRow + 1
        if typeof(startRowNumber) == "number" then
            var2 = startRowNumber + var3 - 1
        end
    else
        var4 = nil
        var3 = nil
    end

    local feedRowNumber = getActionTelemetryFieldValue(nil, arg1, "feedRowNumber") or var2

    local positionInRow = getActionTelemetryFieldValue(nil, arg1, "positionInRow") or var4

    local rowInSort = getActionTelemetryFieldValue(nil, arg1, "rowInSort") or var3

    TelemetryService:LogEvent({
        eventName = "playerFriendAdd",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 7, 17 },
        description = "Fired when a player tile friend request is sent in an SDUI collection"
    }, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            playerId = playerId,
            contentType = contentType,
            actionType = "RequestFriendship",
            interactionUuid = HttpService:GenerateGUID(false),
            tilePos = tilePos,
            pageContext = actionTelemetryFieldValue2,
            userSearchSessionId = userSearchSessionId,
            feedRowNumber = feedRowNumber,
            positionInRow = positionInRow,
            rowInSort = rowInSort,
            sortId = if actionTelemetryFieldValue6 == nil then nil else tostring(actionTelemetryFieldValue6),
            sortPosition = sortPosition,
            locale = LocalizationService.RobloxLocaleId
        }
    })
end

return firePlayerFriendAddTelemetry

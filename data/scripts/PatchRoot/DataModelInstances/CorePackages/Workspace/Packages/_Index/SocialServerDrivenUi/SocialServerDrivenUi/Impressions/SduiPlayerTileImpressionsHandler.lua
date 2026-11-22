-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local LocalizationService = game:GetService("LocalizationService")

local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local SduiErrors = require(SocialServerDrivenUiParent.SduiCoreSystem).SduiErrors

local throttlingPercentage = game:DefineFastInt("SduiPlayerTileImpressionsThrottlingHundredthsPercent", 10000)

local function SduiPlayerTileImpressionsHandler(arg1, tbl1, tbl2, arg2, num2: number?)
    if not arg2 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogPlayerTileImpressions,
            {
                name = "SduiPlayerTileImpressionsHandler",
                message = "Missing collectionAnalyticsData"
            },
            arg1.appPage
        )
        return
    end

    if #tbl1 == 0 or #tbl2 == 0 then
        return
    end

    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}
    local itemsPerRow = arg2.itemsPerRow

    for _, value in tbl1 do
        local var1 = tbl2[value]
        local playerId = if var1 then var1.playerId else nil

        if playerId == nil then
            continue
        end

        table.insert(tbl3, value)
        table.insert(tbl4, playerId)
        table.insert(tbl5, var1.playerName or var1.name or var1.username or "")
        if typeof(num2) == "number" and typeof(itemsPerRow) == "number" and itemsPerRow > 0 then
            table.insert(tbl6, num2 + math.ceil(value / itemsPerRow) - 1)
        end
    end

    if #tbl4 == 0 then
        return
    end

    local userSearchSessionId = arg2.userSearchSessionId

    local telemetryService = TelemetryService
    local config = {
        eventName = "playerTileImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 7, 17 },
        description = "Fired when player tiles are visible in an SDUI collection"
    }
    local tbl7 = {
        eventContext = arg2.eventContext or "playerSearch",
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = 0
    }

    local customFields = {
        tilePos = table.concat(tbl3, ","),
        playerId = table.concat(tbl4, ","),
        playerName = table.concat(tbl5, ","),
        userSearchSessionId = if userSearchSessionId == nil then nil else tostring(userSearchSessionId),
        sortId = if arg2.collectionId == nil then nil else tostring(arg2.collectionId),
        sortPosition = arg2.collectionPosition,
        pageContext = arg2.pageContext or arg1.appPage,
        rowInSort = if #tbl6 > 0 then table.concat(tbl6, ",") else nil,
        locale = LocalizationService.RobloxLocaleId
    }
    tbl7.customFields = customFields
    telemetryService:LogEvent(config, tbl7)
end

return SduiPlayerTileImpressionsHandler

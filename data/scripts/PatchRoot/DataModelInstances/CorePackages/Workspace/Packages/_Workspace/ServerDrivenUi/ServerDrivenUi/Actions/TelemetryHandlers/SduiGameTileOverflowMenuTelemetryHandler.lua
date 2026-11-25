-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local FFlagSduiGameTileDirectAction = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileDirectAction

local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local gameTileOverflowMenuAction = DiscoveryAnalytics.Events.gameTileOverflowMenuAction
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local function SduiGameTileOverflowMenuTelemetryHandler(arg1, arg2, arg3)
    local menuItem = getActionTelemetryFieldValue(arg1, arg2, "menuItemId")
    if typeof(menuItem) ~= "string" or menuItem == "" then
        return
    end

    local universeId = getActionTelemetryFieldValue(arg1, arg2, "universeId")
    local sortId = getActionTelemetryFieldValue(arg1, arg2, "collectionId")

    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "availableMenuItemIds", menuItem)
    local analyticsFieldInAncestors = if FFlagSduiGameTileDirectAction then findAnalyticsFieldInAncestors("isDirectAction", arg2) else nil
    local appPage = arg3.appPage or "Unknown"

    local var1 = gameTileOverflowMenuAction
    local tbl1 = {
        universeId = universeId,
        sortId = sortId,
        actionType = "GameTileOverflowMenuItemActivated",
        menuItem = menuItem,
        availableMenuItems = 0,
        isDirectAction = 0
    }

    if typeof(actionTelemetryFieldValue4) ~= "string" then
        actionTelemetryFieldValue4 = nil
    end

    tbl1.availableMenuItems = actionTelemetryFieldValue4
    if typeof(analyticsFieldInAncestors) ~= "boolean" then
        analyticsFieldInAncestors = nil
    end

    tbl1.isDirectAction = analyticsFieldInAncestors
    var1(tbl1, appPage)
end

return SduiGameTileOverflowMenuTelemetryHandler

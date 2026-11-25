-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local navigateToEventDetails = require(ServerDrivenUiParent.VirtualEvents).navigateToEventDetails
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local FFlagLuaAppSduiEventDetailsEnabled = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiEventDetailsEnabled

return function(arg1, arg2, arg3, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "OpenEventDetails", message = "Missing actionParams" },
            arg3.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")

    local eventId = actionParams.eventId
    if eventId == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "OpenEventDetails", message = "Missing eventId", propName = "eventId" },
            arg3.appPage
        )
        return
    end

    local universeId = actionParams.universeId or arg2 and arg2.analyticsData and arg2.analyticsData.universeId

    local navigation = arg3.dependencies.getNavigation()
    if FFlagLuaAppSduiEventDetailsEnabled then
        navigateToEventDetails(navigation, tostring(eventId), if universeId then tostring(universeId) else nil)
        return
    end
    navigation.navigate(
        AppPage.EventDetails,
        {
            extraProps = {
                currentTime = DateTime.now(),
                virtualEventId = tostring(eventId)
            }
        }
    )
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSeeAll,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local str1 = tostring(actionParams.collectionId)
    if str1 == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSeeAll,
                message = `Missing collectionId: {str1}`,
                propName = "collectionId"
            },
            arg2.appPage
        )
        return
    end
    local collectionPosition = actionParams.collectionPosition
    local isOmni = arg2.appPage == "Home"

    arg2.dependencies.gameAnalytics.reportSeeAllWithId(str1, actionParams.gameSetTargetId, collectionPosition)

    local tbl1 = {
        name = AppPage.GamesList,
        detail = str1,
        extraProps = {
            sortPageId = tostring(str1),
            sortName = str1,
            pageContext = arg2.appPage,
            isOmni = isOmni,
            sortIndex = if isOmni then tonumber(collectionPosition) else nil
        }
    }
    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end

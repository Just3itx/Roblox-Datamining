-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenProfile,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local profileId = actionParams.profileId
    if profileId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenProfile,
                message = "Missing actionParam: profileId",
                propName = "profileId"
            },
            arg2.appPage
        )
        return
    end

    local profileType = actionParams.profileType
    if profileType == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenProfile,
                message = "Missing actionParam: profileType",
                propName = "profileType"
            },
            arg2.appPage
        )
        return
    end

    local tbl1 = {
        name = AppPage.ProfilePlatform,
        detail = profileId,
        extraProps = {
            profileType = if profileType == "Group" then "Community" else profileType,
            source = actionParams.source
        }
    }
    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end

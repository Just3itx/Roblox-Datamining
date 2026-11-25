-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local IXPService = game:GetService("IXPService")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder).UrlBuilder
local FFlagLuaAppBadgeDetailsEnabled = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppBadgeDetailsEnabled
local fetchBadgeDetailsPage = require(ServerDrivenUiParent.Badges).fetchBadgeDetailsPage
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiLoadTimer = require(ServerDrivenUiParent.SduiSharedUtilities).SduiLoadTimer

local FFlagLuaAppBadgeDetailsLogExposure = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppBadgeDetailsLogExposure
local FStringLuaAppBadgeDetailsIxpLayer = require(ServerDrivenUiParent.SharedFlags).FStringLuaAppBadgeDetailsIxpLayer

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local var1 = UrlBuilder.fromString("www:badges")()

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenBadgeDetails,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    if actionParams.badgeId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenBadgeDetails,
                message = "Missing actionParam: badgeId"
            },
            arg2.appPage
        )
        return
    end

    if FFlagLuaAppBadgeDetailsLogExposure then
        IXPService:LogFlagLinkedUserLayerExposure(FStringLuaAppBadgeDetailsIxpLayer)
    end

    if FFlagLuaAppBadgeDetailsEnabled then
        local pageTimer = SduiLoadTimer.createLoadTimer("BadgeDetails")
        pageTimer.start("navigate")

        fetchBadgeDetailsPage(actionParams.badgeId, pageTimer)

        local tbl1 = {
            name = AppPage.BadgeDetails,
            extraProps = {
                badgeId = actionParams.badgeId,
                pageTimer = pageTimer
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg2.dependencies.dispatch(NavigateDown(tbl1))
        return
    end

    local detail = `{var1}/{actionParams.badgeId}`
    local tbl1 = {
        name = AppPage.GenericWebPage,
        detail = detail,
        extraProps = {
            title = actionParams.titleText,
            transitionAnimation = "SlideInFromRight"
        }
    }

    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end

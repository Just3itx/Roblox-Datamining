-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage
local Sources = require(SocialServerDrivenUiParent.SocialLuaAnalytics).Analytics.Enums.Sources
local NavigateDown = require(SocialServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

local function SduiOpenTrustedFriendsUpsellModalAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenTrustedFriendsUpsellModal,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local targetUserId = actionParams.targetUserId
    if targetUserId == nil or targetUserId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenTrustedFriendsUpsellModal,
            message = "Missing actionParam: targetUserId",
            propName = "targetUserId"
        }, arg2.appPage)
        return
    end

    local source = actionParams.source
    if typeof(source) ~= "string" or source == "" then
        source = Sources.PartyChatConversationUpsell
    end
    local tbl1 = {
        name = AppPage.TrustedContactsModal,
        props = { userId = targetUserId, source = source }
    }

    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end

return SduiOpenTrustedFriendsUpsellModalAction

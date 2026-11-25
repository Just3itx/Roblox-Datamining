-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local OpenDynamicAbuseReport = require(ServerDrivenUiParent.GenericAbuseReporting.OpenDynamicAbuseReport)
local AbuseVector = require(ServerDrivenUiParent.GenericAbuseReporting.AbuseVector)
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigationRodux = require(ServerDrivenUiParent.NavigationRodux)
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local NavigateBack = NavigationRodux.Thunks.NavigateBack
local SduiLoadTimer = require(ServerDrivenUiParent.SduiSharedUtilities).SduiLoadTimer
local fetchBadgeDetailsPage = require(ServerDrivenUiParent.Badges).fetchBadgeDetailsPage
local getIsBadgeDetailsSheetOpen = require(ServerDrivenUiParent.Badges).BadgeDetailsSheetState.getIsBadgeDetailsSheetOpen
local FFlagEnableGroupAnnouncementReporting = require(ServerDrivenUiParent.SharedFlags).FFlagEnableGroupAnnouncementReporting
local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAbuseReport,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    if actionParams.targetId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAbuseReport,
                message = "Missing actionParam: targetId"
            },
            arg2.appPage
        )
        return
    end

    if actionParams.abuseVector == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAbuseReport,
                message = "Missing actionParam: abuseVector"
            },
            arg2.appPage
        )
        return
    end

    local targetId = actionParams.targetId
    local abuseVector = actionParams.abuseVector

    local assetTypeName = actionParams.assetTypeName
    local universeId = actionParams.universeId
    local groupId

    if FFlagEnableGroupAnnouncementReporting and abuseVector == AbuseVector.GroupAnnouncement then
        if type(targetId) ~= "string" or targetId == "" then
            arg2.dependencies.logger.reportError(
                SduiErrorType.InvalidActionParams,
                {
                    name = SduiActionType.OpenAbuseReport,
                    message = "Group announcement reports require a nonempty targetId"
                },
                arg2.appPage
            )
            return
        end

        groupId = actionParams.groupId
        if type(groupId) ~= "string" or groupId == "" then
            arg2.dependencies.logger.reportError(
                SduiErrorType.InvalidActionParams,
                {
                    name = SduiActionType.OpenAbuseReport,
                    message = "Group announcement reports require a nonempty groupId"
                },
                arg2.appPage
            )
            return
        end
    else
        groupId = nil
    end

    local dispatch = arg2.dependencies.dispatch
    local isBadgeDetailsSheetOpen = arg2.appPage == "BadgeDetails" and getIsBadgeDetailsSheetOpen()

    if isBadgeDetailsSheetOpen then
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back()
        else
            dispatch(NavigateBack())
        end
    end

    local badgeId = if isBadgeDetailsSheetOpen then targetId else nil

    local tbl1 = {
        abuseVector = abuseVector,
        targetId = targetId,
        custom = { assetTypeName = assetTypeName, universeId = universeId },
        onClose = function()
            dispatch(CloseCentralOverlay())

            if not badgeId then
                return
            end

            local pageTimer = SduiLoadTimer.createLoadTimer("BadgeDetails")
            pageTimer.start("navigate")
            fetchBadgeDetailsPage(badgeId, pageTimer)

            local tbl1 = {
                name = AppPage.BadgeDetails,
                extraProps = { badgeId = badgeId, pageTimer = pageTimer }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                return
            end
            dispatch(NavigateDown(tbl1))
        end
    }

    if groupId then
        tbl1.attributes = { targetId = targetId, groupId = groupId }
        tbl1.analyticsTargetId = targetId
        tbl1.targetId = nil
    end
    dispatch(OpenDynamicAbuseReport(tbl1))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local gameConnectionsPlayedChipClicked = require(SduiSharedContentParent.DiscoveryAnalytics).Events.gameConnectionsPlayedChipClicked

local AppPage = require(SduiSharedContentParent.RobloxAppEnums).AppPage

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local function SduiOpenSocialProofUserListSheetAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSocialProofUserListSheet,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    local userIds = actionParams.userIds
    if userIds == nil or typeof(userIds) ~= "table" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSocialProofUserListSheet,
                message = "Missing or invalid userIds"
            },
            arg2.appPage
        )
        return
    end

    local sheetTitle = actionParams.sheetTitle

    local universeId = actionParams.universeId
    local placeId = actionParams.placeId
    local totalConnections = actionParams.totalConnections
    local analyticsSource = actionParams.analyticsSource

    if universeId and placeId and totalConnections and analyticsSource then
        local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
        gameConnectionsPlayedChipClicked({
            uid = if userId then tostring(userId) else "",
            universeId = universeId,
            placeId = placeId,
            totalConnections = totalConnections
        }, analyticsSource)
    end

    local tbl1 = {}
    for _, userId in userIds do
        if typeof(userId) == "table" then
            userId = userId.userId
        end

        local var1 = tonumber(userId)
        if var1 then
            table.insert(tbl1, var1)
        end
    end

    arg2.dependencies.getNavigation().navigate(
        AppPage.SocialProofVerticalUserListSheet,
        {
            extraProps = { userIds = tbl1, title = sheetTitle }
        }
    )
end

return SduiOpenSocialProofUserListSheetAction

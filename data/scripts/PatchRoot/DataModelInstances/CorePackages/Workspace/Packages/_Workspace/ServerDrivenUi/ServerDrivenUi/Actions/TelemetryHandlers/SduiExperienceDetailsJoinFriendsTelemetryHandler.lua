-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local gameJoinFriendsInGame = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameJoinFriendsInGame

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local function SduiExperienceDetailsJoinFriendsTelemetryHandler(arg1, arg2, arg3)
    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "placeId")
    if actionTelemetryFieldValue == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { message = "ExperienceDetailsJoinFriends telemetry missing placeId" },
            arg3.appPage
        )
        return
    end
    local ctx = getActionTelemetryFieldValue(arg1, arg2, "ctx") or "ExperienceDetailsOverflow"
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        return
    end
    gameJoinFriendsInGame(
        {
            ctx = ctx,
            uid = tostring(localPlayer.UserId),
            placeId = tostring(actionTelemetryFieldValue)
        },
        ctx
    )
end

return SduiExperienceDetailsJoinFriendsTelemetryHandler

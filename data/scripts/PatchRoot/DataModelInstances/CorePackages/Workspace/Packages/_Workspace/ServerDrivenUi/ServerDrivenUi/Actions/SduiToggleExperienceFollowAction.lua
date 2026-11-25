-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DataHydration = require(ServerDrivenUiParent.DataHydration)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Game = DataHydration.Game
local Signals = require(ServerDrivenUiParent.Signals)

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents
local localizeStrings = require(ServerDrivenUiParent.Localization).localizeStrings

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local gameFollow = DiscoveryAnalytics.Events.gameFollow
local getSduiPageEntrySnackbarStore = require(ServerDrivenUiParent.SduiSharedUtilities).getSduiPageEntrySnackbarStore

local function SduiToggleExperienceFollowAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceFollow,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    local gameName = actionParams.gameName or ""
    if universeId == nil or typeof(universeId) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceFollow,
                message = "Missing universeId"
            },
            arg2.appPage
        )
        return
    end

    local placeId = actionParams.placeId
    local ctx = actionParams.ctx or ""

    local followingsStore = Game.getFollowingsStore(false)
    local var1 = followingsStore.getAndFetchFollowing(universeId).data(false)
    local bool1 = not (var1 and var1.isFollowing) or false

    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
    gameFollow({
        uid = tostring(userId),
        placeId = tostring(placeId),
        state = if bool1 then "on" else "off",
        ctx = ctx,
        universeId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
    }, ctx)

    local var2 = followingsStore.updateFollowing(universeId, bool1)
    local localization = arg2.dependencies.localization

    local tbl1 = {}
    tbl1.dispose = Signals.createEffect(function(arg3)
        local var3 = var2(arg3)
        if var3 == nil then
            return
        end

        local configKey = arg2.configKey

        if var3.type == "error" then
            if configKey then
                local str1 = if var3.errorType == "LimitReached" then "Feature.GameFollows.TooltipNotificationsLimitReached" else "Feature.Toast.NetworkingError.SomethingIsWrong"

                local title = localization:Format(str1)
                getSduiPageEntrySnackbarStore().show(configKey, { title = title, icon = Foundation.Enums.IconName.TriangleExclamation })
            end
        elseif var3.type == "success" and configKey then
            local var4 = localizeStrings(localization, {
                notificationsTurnedOn = {
                    "Feature.GameFollows.TooltipTurnedOnNotifications",
                    experienceName = gameName
                },
                notificationsTurnedOff = {
                    "Feature.GameFollows.TooltipTurnedOffNotifications",
                    experienceName = gameName
                }
            })
            local title = if var3.isFollowing then var4.notificationsTurnedOn else var4.notificationsTurnedOff
            getSduiPageEntrySnackbarStore().show(configKey, {
                title = title,
                icon = if var3.isFollowing then Foundation.Enums.IconName.Bell else Foundation.Enums.IconName.BellSlash
            })
        end

        local dispose = tbl1.dispose
        if dispose then
            dispose()
            tbl1.dispose = nil
        end
    end)
end

return SduiToggleExperienceFollowAction

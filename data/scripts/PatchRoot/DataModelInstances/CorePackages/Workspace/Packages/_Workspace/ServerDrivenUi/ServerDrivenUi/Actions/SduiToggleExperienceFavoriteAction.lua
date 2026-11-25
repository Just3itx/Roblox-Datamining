-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:58Z
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

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local gameFavorite = DiscoveryAnalytics.Events.gameFavorite
local getSduiPageEntrySnackbarStore = require(ServerDrivenUiParent.SduiSharedUtilities).getSduiPageEntrySnackbarStore

local function SduiToggleExperienceFavoriteAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceFavorite,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if universeId == nil or typeof(universeId) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceFavorite,
                message = "Missing universeId"
            },
            arg2.appPage
        )
        return
    end

    local placeId = actionParams.placeId
    local ctx = actionParams.ctx or ""

    local favoritesStore = Game.getFavoritesStore(false)
    local var1 = favoritesStore.getAndFetchFavorite(universeId).data(false)

    local bool1 = not (not (var1 == nil) and var1.isFavorited)

    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
    gameFavorite({
        uid = tostring(userId),
        ctx = ctx,
        placeId = tostring(placeId),
        state = if bool1 then "on" else "off",
        targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
    }, ctx)

    local var2 = favoritesStore.updateFavorite(universeId, bool1)

    local tbl1 = {}
    tbl1.dispose = Signals.createEffect(function(arg3)
        local var3 = var2(arg3)
        if var3 == nil then
            return
        end

        if var3.type == "error" then
            local configKey = arg2.configKey
            if configKey then
                local title = arg2.dependencies.localization:Format("Feature.Toast.NetworkingError.SomethingIsWrong")
                getSduiPageEntrySnackbarStore().show(configKey, { title = title, icon = Foundation.Enums.IconName.TriangleExclamation })
            end
        end

        local dispose = tbl1.dispose
        if dispose then
            dispose()
            tbl1.dispose = nil
        end
    end)
end

return SduiToggleExperienceFavoriteAction

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local Players = game:GetService("Players")

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local Game = require(ServerDrivenUiParent.DataHydration).Game
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local Localization = require(ServerDrivenUiParent.Localization)

local SduiChip = require(ServerDrivenUiParent.SduiSharedContent).SduiChip

local ToastRodux = require(ServerDrivenUiParent.ToastRodux)
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local gameFavorite = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameFavorite

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization

local useOptimisticUpdateStatus = require(ServerDrivenUi.Content.ExperienceDetails.Hooks.useOptimisticUpdateStatus)

return React.memo(function(tbl1) -- name: ExperienceDetailsFavoriteChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId
    local var1 = useDispatch()

    local var2 = Game.getFavoritesStore(false).getAndFetchFavorite(universeId)
    local var3 = SignalsReact.useSignalState(function(arg1)
        local var3 = var2.data(arg1)
        return not (var3 == nil) and var3.isFavorited
    end)

    local var4 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)
    local rootPlaceId = if var4 then var4.rootPlaceId or nil else nil
    local var5 = useLocalization({ favorite = "Feature.Favorites.Label.Favorite" })

    local var6 = React.useCallback(function()
        local bool1 = not var3

        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameFavorite({
                uid = tostring(userId),
                ctx = "ExperienceDetailsFavoriteChip",
                placeId = rootPlaceId,
                state = if bool1 then "on" else "off",
                targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
            }, "ExperienceDetailsFavoriteChip")
        end

        return Game.getFavoritesStore(false).updateFavorite(universeId, bool1)
    end, { universeId, rootPlaceId, var3 })

    local var7 = React.useCallback(function(arg1)
        if arg1 and arg1.type == "error" then
            var1(
                SetCurrentToastMessage(
                    {
                        toastType = ToastType.NetworkingError,
                        toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong"
                    }
                )
            )
        end
    end, { var1 })

    local onActivated = useOptimisticUpdateStatus(var6, var7)

    return React.createElement(SduiChip, {
        text = var5.favorite,
        leadingIconName = Foundation.Enums.IconName.Star,
        leadingIconVariant = if var3 then Foundation.Enums.IconVariant.Filled else nil,
        onActivated = onActivated,
        layoutOrder = layoutOrder
    })
end)

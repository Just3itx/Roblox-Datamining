-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:59Z
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

local UniversalAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy)
local gameFollow = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameFollow

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useAppPolicy = UniversalAppPolicy.useAppPolicy

local useOptimisticUpdateStatus = require(ServerDrivenUi.Content.ExperienceDetails.Hooks.useOptimisticUpdateStatus)

return React.memo(function(tbl1) -- name: ExperienceDetailsNotifyChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId

    local var1 = useDispatch()

    local var2 = SignalsReact.useSignalState(Game.getFollowingsStore(false).getAndFetchFollowing(universeId).data)
    local isFollowing = if var2 then var2.isFollowing or false else false
    local var3 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)
    local name = var3 and var3.name or ""

    local var4 = useLocalization({
        notifications = "Feature.GameFollows.LabelNotifications",
        notificationsTurnedOn = {
            "Feature.GameFollows.TooltipTurnedOnNotifications",
            experienceName = name
        },
        notificationsTurnedOff = {
            "Feature.GameFollows.TooltipTurnedOffNotifications",
            experienceName = name
        }
    })
    local rootPlaceId = if var3 then var3.rootPlaceId or nil else nil

    local var5 = React.useCallback(function()
        local bool1 = not isFollowing

        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameFollow({
                uid = tostring(userId),
                placeId = rootPlaceId,
                state = if bool1 then "on" else "off",
                ctx = "ExperienceDetailsNotifyChip",
                universeId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
            }, "ExperienceDetailsNotifyChip")
        end

        return Game.getFollowingsStore(false).updateFollowing(universeId, bool1)
    end, { universeId, rootPlaceId, isFollowing })

    local var6 = React.useCallback(function(arg1)
        if not arg1 then
            return
        end

        if arg1.type == "error" then
            local str1 = "Feature.GameFollows.TooltipFollowLimitReached"
            if arg1.errorType == "LimitReached" then
                str1 = "Feature.GameFollows.TooltipNotificationsLimitReached"
            elseif arg1.errorType == "NetworkError" then
                str1 = "Feature.Toast.NetworkingError.SomethingIsWrong"
            end

            var1(
                SetCurrentToastMessage({
                    toastType = if arg1.errorType == "LimitReached" then ToastType.GameFollowError else ToastType.NetworkingError,
                    toastMessage = str1
                })
            )
            return
        end
        if arg1.type ~= "success" then
            return
        end

        if arg1.isFollowing then
            var1(
                SetCurrentToastMessage(
                    {
                        toastType = ToastType.NotificationsTurnedOn,
                        toastMessage = var4.notificationsTurnedOn,
                        isLocalized = true
                    }
                )
            )
            return
        end

        var1(
            SetCurrentToastMessage(
                {
                    toastType = ToastType.NotificationsTurnedOff,
                    toastMessage = var4.notificationsTurnedOff,
                    isLocalized = true
                }
            )
        )
    end, { var1, name, var4 })

    local onActivated = useOptimisticUpdateStatus(var5, var6)

    if not useAppPolicy(function(arg1)
        return arg1.getNotificationsCanReceiveExperience()
    end) then
        return nil
    end

    return React.createElement(SduiChip, {
        text = var4.notifications,
        leadingIconName = Foundation.Enums.IconName.Bell,
        leadingIconVariant = if isFollowing then Foundation.Enums.IconVariant.Filled else nil,
        onActivated = onActivated,
        layoutOrder = layoutOrder
    })
end)

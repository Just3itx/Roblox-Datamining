-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local UserRelationshipModals = script:FindFirstAncestor("UserRelationshipModals")
local UserRelationshipModalsParent = UserRelationshipModals.Parent

local React = require(UserRelationshipModalsParent.React)
local useEffect = React.useEffect
local Signals = require(UserRelationshipModalsParent.Signals)
local SignalsReact = require(UserRelationshipModalsParent.SignalsReact)
local useDispatch = require(UserRelationshipModalsParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useLocalUserId = require(UserRelationshipModalsParent.RobloxAppHooks).useLocalUserId

local UserProfiles = require(UserRelationshipModalsParent.UserProfiles)

local FriendsNetworking = require(UserRelationshipModalsParent.FriendsNetworking)
local myFriendsNetworking = require(UserRelationshipModals.Networking.myFriendsNetworking)
local FriendshipOriginSourceType = FriendsNetworking.Enums.FriendshipOriginSourceType

local FFlagMigrateFriendshipStatusesRemainingActions = require(UserRelationshipModalsParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local var1 = require(UserRelationshipModalsParent.DataHydration).Friends.FriendsStore.get()
local Enums = require(UserRelationshipModalsParent.DataHydration).Friends.Enums

local Analytics = require(UserRelationshipModals.Analytics)
local useLocalization = require(UserRelationshipModalsParent.Localization).Hooks.useLocalization

local NotificationModalsManager = require(UserRelationshipModalsParent.NotificationModalsManager)

local PromptFriendRequestModal = require(script.Parent.PromptFriendRequestModal)

function triggerToast(toastTitle: string)
    NotificationModalsManager.SetUIBloxToast({ toastTitle = toastTitle, sequenceNumber = DateTime.now().UnixTimestamp })
end

local var2 = UserProfiles.Stores.UserProfileStore.get()

local function PromptFriendRequestModalContainer(tbl1)
    local var3 = useDispatch()
    local currentUserId = useLocalUserId()

    local fireAnalyticsEvent = Analytics.useUserRelationshipModalAnalytics(
        Analytics.RelationshipTypes.Friends,
        tonumber(currentUserId) or 0,
        tbl1.userId
    ).fireAnalyticsEvent

    useEffect(function()
        fireAnalyticsEvent(Analytics.EventNames.ModalSeen)
    end, { fireAnalyticsEvent })

    local var5 = useLocalization({
        friendRequestSent = "Feature.Friends.Action.FriendRequestSent",
        somethingWentWrong = "CommonUI.Messages.Response.SomethingWentWrong"
    })

    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var6 = var2.fetchNamesByUserIds({ tostring(tbl1.userId) })(arg1)
            local var7 = var6 and var6.data and var6.data[1]
            local names = var7 and var7.names
            return {
                combinedName = if names then names.getCombinedName(arg1) else "",
                username = if names then names.getUsername() else ""
            }
        end)
    end, { tbl1.userId })

    local var7 = SignalsReact.useSignalState(var6)

    local onSendClicked = React.useCallback(function()
        fireAnalyticsEvent(Analytics.EventNames.CreateActionPressed)

        local player = Players:GetPlayerByUserId(tbl1.userId)
        if Players.LocalPlayer ~= nil and player ~= nil then
            local success, _result = pcall(function()
                Players.LocalPlayer:RequestFriendship(player)
            end)
            triggerToast(if success then var5.friendRequestSent else var5.somethingWentWrong)
        else
            local var8 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.RequestFriendship(tostring(tbl1.userId), Enums.FriendshipOriginSourceType.InGame) else var3(
                myFriendsNetworking.RequestFriendshipFromUserId.API({
                    currentUserId = currentUserId,
                    targetUserId = tostring(tbl1.userId),
                    friendshipOriginSourceType = FriendshipOriginSourceType.InGame.rawValue()
                })
            )

            var8:andThen(function()
                triggerToast(var5.friendRequestSent)
            end):catch(function(_)
                triggerToast(var5.somethingWentWrong)
            end)
        end
        tbl1.onClose()
    end, {
        currentUserId,
        tbl1.userId,
        var3,
        tbl1.onClose,
        var5.friendRequestSent,
        var5.somethingWentWrong,
        fireAnalyticsEvent
    })

    return React.createElement(PromptFriendRequestModal, {
        userId = tbl1.userId,
        displayName = var7.combinedName,
        username = var7.username,
        onClose = function()
            fireAnalyticsEvent(Analytics.EventNames.ModalClosed)
            tbl1.onClose()
        end,
        onSendClicked = onSendClicked,
        inputDelay = tbl1.inputDelay
    })
end

return PromptFriendRequestModalContainer

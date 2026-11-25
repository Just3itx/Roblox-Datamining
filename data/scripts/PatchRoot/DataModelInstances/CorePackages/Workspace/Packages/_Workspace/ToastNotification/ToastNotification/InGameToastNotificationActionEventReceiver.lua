-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MessageBusService = game:GetService("MessageBusService")

local React = require(scriptParentParent.React)
local LifecycleEvents = require(script.Parent.utils.LifecycleEvents)
local NotificationTypeEnum = require(scriptParent.type).NotificationTypeEnum
local GuiObjectUtils = require(scriptParentParent.GuiObjectUtils)
local Logger = require(scriptParent.Logger)

local FFlagEnablePresenceOnlineInviteReceiver = require(scriptParent.Flags.FFlagEnablePresenceOnlineInviteReceiver)

local useProperty = GuiObjectUtils.useProperty

local messageId = MessageBusService:GetMessageId("ToastNotifications", "PresenceOnlineToast")

local function InGameToastNotificationActionEventReceiver()
    local var1 = useProperty(Players, "LocalPlayer")
    local var2 = if FFlagEnablePresenceOnlineInviteReceiver then useProperty(game, "PlaceId") else nil

    React.useEffect(function()
        local var3 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.FriendRequestReceived,
            function(arg1)
                if not arg1 or arg1.userActionType ~= "click" or not arg1.notificationData or not arg1.visualItem then
                    return
                end
                local senderUserId = HttpService:JSONDecode(arg1.visualItem.actionEventParams).senderUserId
                if not senderUserId or not var1 then
                    return
                end

                local playerByUserId = Players:GetPlayerByUserId(tonumber(senderUserId))
                if arg1.visualItem.eventName == "AcceptFriend" then
                    var1:RequestFriendship(playerByUserId)
                elseif arg1.visualItem.eventName == "IgnoreFriend" then
                    var1:RevokeFriendship(playerByUserId)
                end
            end
        )

        return function()
            var3()
        end
    end, { var1 })

    if not FFlagEnablePresenceOnlineInviteReceiver then
        return
    end

    local var3 = require(scriptParentParent.NotificationsCommon).LocalizationHelper.getLocalizedStrings({
        inviteSuccess = "Feature.SocialContextToast.Message.InvitationConfirmation",
        inviteFailure = "Feature.SocialContextToast.Message.InvitationFailure"
    })

    local inviteSuccess = var3.inviteSuccess
    local inviteFailure = var3.inviteFailure

    React.useEffect(function()
        local bool1 = true
        local var4 = MessageBusService:Subscribe(messageId, function(arg1)
            if type(arg1) ~= "table" then
                return
            end

            local senderUserId = arg1.senderUserId
            if not senderUserId or not var1 or not var2 or var2 <= 0 then
                return
            end

            local postSendExperienceInvite = require(scriptParentParent.GameInvite).PostSendExperienceInvite
            local GuiService = require(scriptParentParent.MockableProxyServices).GuiService
            local httpRequest = require(scriptParentParent.HttpRequest)
            postSendExperienceInvite(
                httpRequest.config({ requestFunction = httpRequest.requestFunctions.HttpRbxApi, maxRetryCount = 0 }),
                tostring(senderUserId),
                tostring(var2),
                "OnlineFriendPresence"
            ):andThen(
                function()
                    Logger:info("PresenceOnlineToast experience invite sent")
                    if bool1 then
                        GuiService:SendNotification({ Title = inviteSuccess })
                    end
                end,
                function()
                    Logger:warning("PresenceOnlineToast experience invite failed")
                    if bool1 then
                        GuiService:SendNotification({ Title = inviteFailure })
                    end
                end
            )
        end, false, false)

        return function()
            bool1 = false
            var4:Disconnect()
        end
    end, {
        var1,
        var2,
        inviteSuccess,
        inviteFailure
    })
end

return InGameToastNotificationActionEventReceiver

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local HttpService = game:GetService("HttpService")

local React = require(FriendsCallingParent.React)
local ReactUtils = require(FriendsCallingParent.ReactUtils)
local var1 = require(FriendsCallingParent.Loggers).Logger:new(script.Name)
local ToastNotification = require(FriendsCallingParent.ToastNotification)
local ToastNotificationsProtocol = require(FriendsCallingParent.ToastNotificationsProtocol)

local CallingStatus = require(FriendsCalling.Enums.CallingStatus)
local FFlagFriendsCallingServiceLuaMigration = require(FriendsCallingParent.SharedFlags.FFlagFriendsCallingServiceLuaMigration)

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum
local useEventConnection = ReactUtils.useEventConnection
local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

local function VoiceCallReceivedEventReceiver(tbl1)
    local var2 = tbl1.callingService or game:GetService("CallingService")
    local var3 = if FFlagFriendsCallingServiceLuaMigration then tbl1.friendsCallingService or game:GetService("FriendsCallingService") else nil

    local var4 = React.useRef({})

    local function forgetToast(notificationId: string) -- Luacid: Inlined by compiler; 1 call site recovered
        for value, value2 in var4.current do
            if value2 == notificationId then
                var4.current[value] = nil
                return
            end
        end
    end

    React.useEffect(function()
        local var5 = default:listenToDisplayNotification(function(arg1)
            if arg1 == nil or arg1.notificationType ~= NotificationTypeEnum.VoiceCallReceived then
                return
            end

            local callData = HttpService:JSONDecode(arg1.lifecycleData).callData
            local callId = HttpService:JSONDecode(callData).callId
            local status = var2:GetCallingState(callId).status
            local bool1 = not (arg1.content == nil) and arg1.content.currentState == "missed"

            if status == nil then
                var4.current[callId] = arg1.notificationId
                if FFlagFriendsCallingServiceLuaMigration then
                    var3:ReceiveCall(callData)
                    return
                end
                var2:ReceiveIncomingCall(callData)
                return
            end
            if status == CallingStatus.Ringing then
                var4.current[callId] = arg1.notificationId
            elseif status == CallingStatus.Missed then
                if not bool1 then
                    default:updateNotification(arg1.notificationId, "missed")
                end
            else
                default:dismissNotification(arg1.notificationId)
            end
        end)

        local var6 = default:listenToDismissNotification(function(arg1)
            if arg1 ~= nil then
                forgetToast(arg1.notificationId)
            end
        end)

        return function()
            var5:Disconnect()
            var6:Disconnect()
        end
    end, { var2, var3 })

    local var5 = React.useCallback(function(arg1)
        local var5 = var4.current[arg1.callId]
        if var5 == nil then
            return
        end

        if arg1.status == CallingStatus.Ringing then
            return
        end
        if arg1.status == CallingStatus.Missed then
            var4.current[arg1.callId] = nil
            default:updateNotification(var5, "missed")
        else
            var4.current[arg1.callId] = nil
            default:dismissNotification(var5)
        end
    end, {})

    useEventConnection(var2.OnCallingStateChange, var5)

    React.useEffect(function()
        return LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.VoiceCallReceived,
            function(arg1)
                local visualItem = arg1 and arg1.visualItem
                if arg1 == nil or arg1.userActionType ~= "click" or visualItem == nil then
                    return
                end

                local callData = HttpService:JSONDecode(visualItem.actionEventParams).callData
                local callId = HttpService:JSONDecode(callData).callId
                if visualItem.visualItemName ~= "AnswerCall" then
                    if visualItem.visualItemName == "DeclineCall" then
                        if FFlagFriendsCallingServiceLuaMigration then
                            var3:EndCall(callId, "ToastEndAction")
                            return
                        end
                        var2:EndCall(callId, "ToastEndAction")
                    end

                    return
                end

                if not FFlagFriendsCallingServiceLuaMigration then
                    local callingState = var2:GetCallingState()
                    if callingState.callId ~= nil and callingState.callId ~= callId then
                        var1:warning("Answering {} while {} is still up", callId, callingState.callId)
                    end
                    var2:AnswerIncomingCall(callId)
                    return
                end

                for _, child in var3:GetChildren() do
                    if child.ClassName == "FriendsCallingInstance" and child.CallId ~= "" and child.CallId ~= callId then
                        var1:warning("Answering {} while {} is still up", callId, child.CallId)
                        break
                    end
                end

                var3:AnswerCall(callId)
            end
        )
    end, { var2, var3 })

    return nil
end

return VoiceCallReceivedEventReceiver

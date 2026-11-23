-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local LoginStatus = require(AppChatParent.RobloxAppEnums).LoginStatus

local FFlagUseSignalsForAuthenticationStatus = require(AppChatParent.SharedFlags).FFlagUseSignalsForAuthenticationStatus
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AppChatParent.AuthenticationStatus).GetAuthenticationStatusStore else nil
local fetchChatMetadata = require(AppChat.Conversations.Thunks.fetchChatMetadata)
local useIsAppLoaded = require(AppChat.Hooks.useIsAppLoaded)
local useKeybind = require(AppChat.App.Hooks.useKeybind)
local usePrevious = require(AppChatParent.RoactUtils).Hooks.usePrevious
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local reloadAllMessages = require(AppChat.Conversations.Thunks.reloadAllMessages)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local GetFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)
local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local DismissedAllConversationModalsForSequence = require(AppChat.Conversations.Actions.DismissedAllConversationModalsForSequence)
local useIsAppChatVisible = require(AppChat.App.Hooks.useIsAppChatVisible)

local getFFlagDebugAppChat = require(AppChat.Flags.getFFlagDebugAppChat)

local FFlagEnableAEGIS2AppChatConversationBanner = require(AppChatParent.SharedFlags).FFlagEnableAEGIS2AppChatConversationBanner

local FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace = require(AppChatParent.SharedFlags).FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace

local var1 = require(AppChat.Logger):new(script.Name)

local function AppChatAccountSettingsEventReceiver(tbl1)
    local var2 = useDispatch()
    local var3 = useIsAppLoaded()

    local bool1 = if FFlagUseSignalsForAuthenticationStatus then useSignalState(GetAuthenticationStatusStore(false).getStatus) == LoginStatus.LOGGED_IN else useSelector(function(arg1)
        return arg1.AuthenticationStatus and arg1.AuthenticationStatus.status == LoginStatus.LOGGED_IN
    end)

    if getFFlagDebugAppChat() then
        useKeybind({
            keyCode = Enum.KeyCode.G,
            modifierKey = Enum.ModifierKey.Ctrl
        }, function()
            var1:debug("Ctrl + G pressed, toggling group chat enabled")
            var2({ type = "Debug_GroupChatEnabledToggled" })
        end, { var2 })
    end

    local var4 = React.useCallback(function()
        var2(fetchChatMetadata()):andThen(function(arg1)
            var1:info("Finished fetching chat metadata. Determined isChatEnabled as {}", arg1)
        end)
    end, { var2 })

    local var5 = useIsAppChatVisible()

    React.useEffect(function()
        if (tbl1.isInExperience or bool1) and not var3 then
            var1:info("App is not loaded, fetching chat metadata")
            var4()
        end
    end, {
        var4,
        var3,
        tbl1.isInExperience,
        bool1
    })

    local var6 = useIsChatEnabled()

    local var7 = if FFlagAppChatUseSignalsForChatSettings then useSignalState(GetFriendsChatSettingsStore(false).getChatUserMessagesEnabled) else useSelector(function(arg1)
        return getDeepValue2(arg1, "ChatAppReducer.ChatSettings.chatUserMessagesEnabled")
    end)
    local var8 = usePrevious(var7)

    React.useEffect(function()
        if var6 and var8 ~= nil and var8 ~= var7 then
            var1:info("Chat messages eligibility changed, reloading all messages")
            var2(reloadAllMessages()):catch(function(arg1)
                var1:warn("Failed to reload all messages after chat user messages eligibility change", arg1)
            end)
        end
    end, {
        var2,
        var6,
        var8,
        var7
    })
    RealtimeDelivery.useRealtimeNamespace("UserSettingsChanged", function(arg1)
        if not arg1.SettingsChanged then
            return
        end

        local bool2 = false
        local var9 = table.find(arg1.SettingsChanged, "WhoCanUsePartyChatWithMe")
        if var9 then
            var1:info("Received privacy setting notification, reloading all messages")
            var2(reloadAllMessages()):catch(function(arg2)
                var1:warn("Failed to reload all messages after party setting change", arg2)
            end)
        end

        if bool2
            or table.find(arg1.SettingsChanged, "WhoCanPartyWithMe")
            or table.find(arg1.SettingsChanged, "WhoCanUsePartyVoiceWithMe")
            or var9
        then
            var1:info("Received privacy setting notification, fetching chat metadata")
            var4()
        end
    end, { var4, var2 })

    RealtimeDelivery.useRealtimeConnectionStateChanged("UserSettingsChanged", function(connectionState, arg1)
        if connectionState == Enum.ConnectionState.Connected and arg1 then
            var1:info("Reconnected to UserSettingsChanged, fetching chat metadata")
            var4()
        end
    end, { var4 })

    local function func1(isInExperience: boolean)
        var2(AppChatNetworking.rodux.GetChatLandingModal.API(isInExperience)):catch(function(arg1)
            var1:warning("Error in GetChatLandingModal request. Error: {}", tostring(arg1))
        end)

        if FFlagEnableAEGIS2AppChatConversationBanner then
            var2(DismissedAllConversationModalsForSequence(AppChatNetworking.Constants.ModalSequence.ConversationBottomModal))
        end
    end

    RealtimeDelivery.useRealtimeNamespace(FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace, function(_)
        var1:info("Received Realtime: {}", FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace)
        if not var3 then
            return
        end

        func1(tbl1.isInExperience)
        var4()
    end, {
        var4,
        var3,
        tbl1.isInExperience,
        var5
    })
    RealtimeDelivery.useRealtimeConnectionStateChanged(FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace, function(connectionState, arg1)
        var1:info(
            "Reconnected to Realtime: {}, hasMissedEvents: {}",
            FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace,
            tostring(arg1)
        )
        if connectionState ~= Enum.ConnectionState.Connected or not (arg1 and var3) then
            return
        end

        func1(tbl1.isInExperience)
        var4()
    end, {
        var4,
        var3,
        tbl1.isInExperience,
        var5
    })

    return nil
end

return AppChatAccountSettingsEventReceiver

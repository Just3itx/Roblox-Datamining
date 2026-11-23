-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useNavigationFocus = require(AppChatParent.Navigation).useNavigationFocus
local RoactNavigation = require(AppChatParent.RoactNavigation)

local useUserExperiment = require(AppChatParent.RoactAppExperiment).useUserExperiment
local AppUserLayers = require(AppChatParent.ExperimentLayers).AppUserLayers
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local default = require(AppChatParent.LoggingProtocol).default

local NotificationsUpsell = require(AppChatParent.NotificationsUpsell)
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local PushUpsellEventConfig = NotificationsUpsell.PushUpsellEventConfig
local ModalEventConstants = NotificationsUpsell.ModalEventConstants
local setupPushNotificationsUpsell = NotificationsUpsell.setupPushNotificationsUpsell
local NotificationsUpsellConstants = NotificationsUpsell.NotificationsUpsellConstants

local GetFStringPushUpsellChatVariantName = require(AppChatParent.SharedFlags).GetFStringPushUpsellChatVariantName

local function CheckAndOpenChatPushUpsell()
    local var1 = useNavigationFocus()
    local var2 = useNavigation()
    local var3 = useChatIsVisible()
    local var4 = useIsInExperience()
    local var5, var6 = React.useState(false)

    local var7 = useUserExperiment({ AppUserLayers.SocialAppChat }, function(arg1)
        return {
            pushUpsellChatVariant = (arg1[AppUserLayers.SocialAppChat] or {})[GetFStringPushUpsellChatVariantName()] or -1
        }
    end)

    React.useEffect(function()
        local var8 = var2.addListener(RoactNavigation.Events.WillBlur, function(arg1)
            if arg1.action.routeName == "ChatConversation" then
                var6(true)
            end
        end)

        return function()
            var8.remove()
        end
    end, {})

    local function showUpsellOnChatLanding() -- Luacid: Inlined by compiler; 1 call site recovered
        setupPushNotificationsUpsell.ShouldShowUpsell(NotificationsUpsellConstants.ModalKey.PushUpsellChat):andThen(function(arg1)
            if not arg1 then
                return
            end
            IXPService:LogUserLayerExposure(AppUserLayers.SocialAppChat)
            default:logRobloxTelemetryEvent(PushUpsellEventConfig, {}, {
                [ModalEventConstants.ActionType] = ModalEventConstants.ShouldRequest,
                [ModalEventConstants.EntryPoint] = AppPage.Chat
            }, ModalEventConstants.ModalContextPushEduUpsell)

            setupPushNotificationsUpsell.OpenModal(NotificationsUpsellConstants.ModalKey.PushUpsellChat, true, AppPage.Chat)
        end)
    end

    local function showUpsellWhenReturnFromConversation() -- Luacid: Inlined by compiler; 1 call site recovered
        if not var5 then
            return
        end

        var6(false)
        setupPushNotificationsUpsell.ShouldShowUpsell(NotificationsUpsellConstants.ModalKey.PushUpsellChat):andThen(function(arg1)
            if not arg1 then
                return
            end
            IXPService:LogUserLayerExposure(AppUserLayers.SocialAppChat)
            default:logRobloxTelemetryEvent(PushUpsellEventConfig, {}, {
                [ModalEventConstants.ActionType] = ModalEventConstants.ShouldRequest,
                [ModalEventConstants.EntryPoint] = "ChatConversation"
            }, ModalEventConstants.ModalContextPushEduUpsell)

            setupPushNotificationsUpsell.OpenModal(NotificationsUpsellConstants.ModalKey.PushUpsellChat, true, "ChatConversation")
        end)
    end

    React.useEffect(function()
        if not var3 or not var1 or var4 or var7.pushUpsellChatVariant == nil or var7.pushUpsellChatVariant < 0 then
            return
        end

        if var7.pushUpsellChatVariant == 1 then
            showUpsellOnChatLanding()
        elseif var7.pushUpsellChatVariant == 2 then
            showUpsellWhenReturnFromConversation()
        end
    end, { var3, var1 })
end

return CheckAndOpenChatPushUpsell

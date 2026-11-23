-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local LuaAppNavigationContext = require(AppChat.LuaAppNavigationContext)
local React = require(AppChatParent.React)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local memo = React.memo
local useCallback = React.useCallback
local useContext = React.useContext
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useAnalytics = require(AppChat.Analytics.useAnalytics)

local AccessResponseEnum = require(AppChatParent.AmpUpsell).AmpEnums.AccessResponseEnum
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local NavigateBack = require(AppChatParent.NavigationRodux).Thunks.NavigateBack
local NavigateDown = require(AppChatParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AppChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppChatParent.RobloxAppNavigation).NavigationCommands else nil
local refreshAllUnfilteredThreadsDetails = require(AppChat.Conversations.Thunks.refreshAllUnfilteredThreadsDetails)
local UnfilteredThreadsAMPFeatureName = require(AppChat.Components.UnfilteredThreadsAMPFeatureName)

local ConversationModal = require(script.Parent.Parent.ConversationModal.ConversationModal)

local tbl1 = {
    showNetworkErrorToast = function() end,
    onHeightChanged = function() end
}

local tbl2 = { pending_state_phone_verify = true, pending_state_ineligible = true }

local tbl3 = {
    pending_state_phone_verify = "ConversationPvUpsell",
    pending_state_ineligible = "ConversationIneligibleModal"
}

function PendingStateModalContainer(tbl4)
    local var1 = Cryo.Dictionary.union(tbl1, tbl4)
    local var2 = useLocalUserId()
    local var3 = useAnalytics()
    local var4 = useContext(LuaAppNavigationContext)
    local var5 = useNavigation()
    local var6 = useDispatch()

    local var7 = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.Modals.pendingStateModals.{var1.conversationId}`)
    end) or {}

    local modalVariant = var7.modal_variant
    local deepValue2 = getDeepValue2(var7, "modal_layout.id")
    local deepValue2_2 = getDeepValue2(var7, "modal_layout.seen_record_action")
    local var8 = tbl3[modalVariant]
    local var9 = tbl2[modalVariant]
    local deepValue2_3 = getDeepValue2(var7, "modal_layout.buttons")
    local var10 = deepValue2_3 and deepValue2_3[1]
    local var11 = deepValue2_3 and deepValue2_3[2]

    useEffectOnMount(function()
        if var3 and var9 and var8 then
            var3.fireAnalyticsEvent(`{var8}Rendered`, { conversationId = var1.conversationId })
        end
    end)

    useEffect(function()
        if var9 then
            var6(AppChatNetworking.rodux.RecordModalSequenceResponse.API(deepValue2_2, "pending_state_modal", deepValue2)):catch(
                function(arg1)
                    warn("Error in PendingStateModalContainer -> RecordModalSequenceResponse seen: " .. tostring(arg1))
                end
            )
        end
    end, {
        var6,
        var9,
        deepValue2_2,
        deepValue2,
        var1.conversationId
    })

    local var12 = useCallback(function(arg1, arg2)
        return var6(AppChatNetworking.rodux.RemoveUserFromConversation.API(arg2, arg1))
    end, { var6 })

    local pendingStateIneligible = useCallback(function()
        if var3 and var8 then
            var3.fireAnalyticsEvent(`{var8}LearnMoreClicked`, { conversationId = var1.conversationId })
        end

        if var5 then
            var4.navigateToUnfilteredThreadsLearnMore(var5.navigate)
            return
        end
        var4.navigateToUnfilteredThreadsLearnMore()
    end, {
        var4,
        var3,
        var8,
        var1.conversationId,
        var5
    })

    local pendingStatePhoneVerify = useCallback(function()
        if var3 and var8 then
            var3.fireAnalyticsEvent(`{var8}ContinueClicked`, { conversationId = var1.conversationId })
        end

        local tbl5 = {
            name = AppPage.AmpWizardContainer,
            extraProps = {
                featureName = UnfilteredThreadsAMPFeatureName,
                completionCallback = function(granted, _)
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.back(true)
                    else
                        var6(NavigateBack(true))
                    end
                    if granted == AccessResponseEnum.Granted then
                        if var3 and var8 then
                            var3.fireAnalyticsEvent(`{var8}Succeeded`, { conversationId = var1.conversationId })
                        end

                        var6(refreshAllUnfilteredThreadsDetails(var1.conversationId))
                        return
                    end
                    if var3 and var8 then
                        var3.fireAnalyticsEvent(`{var8}Failed`, { conversationId = var1.conversationId })
                    end
                end
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl5))
            return
        end
        var6(NavigateDown(tbl5))
    end, {
        var6,
        var8,
        var3,
        var1.conversationId
    })

    local onDenied = useCallback(function()
        if var3 and var8 then
            var3.fireAnalyticsEvent(`{var8}LeftGroup`, { conversationId = var1.conversationId })
        end

        if var1.conversationId then
            var12(var2, var1.conversationId):catch(function()
                var1.showNetworkErrorToast()
            end)
        end
    end, {
        var2,
        var1.conversationId,
        var8,
        var3,
        var12,
        var1.showNetworkErrorToast
    })

    local onAccepted = ({
        pending_state_phone_verify = pendingStatePhoneVerify,
        pending_state_ineligible = pendingStateIneligible
    })[modalVariant]

    if not var9 then
        if modalVariant ~= "none" and modalVariant ~= nil and not tbl2[modalVariant] then
            warn("Unsupported PendingStateModal variant: " .. modalVariant)
        end
        return nil
    end

    return React.createElement(ConversationModal, {
        bodyText = getDeepValue2(var7, "modal_layout.body.text"),
        acceptText = if var11 and onAccepted then var11.text else nil,
        denyText = if var10 then var10.text else nil,
        layoutOrder = var1.layoutOrder,
        onAccepted = onAccepted,
        onDenied = onDenied,
        onHeightChanged = var1.onHeightChanged
    })
end

return memo(PendingStateModalContainer)

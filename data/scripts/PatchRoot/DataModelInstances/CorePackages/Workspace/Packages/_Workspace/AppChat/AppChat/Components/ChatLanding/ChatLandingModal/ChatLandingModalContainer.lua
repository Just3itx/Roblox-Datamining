-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local _types = require(AppChat.types)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local LuaAppNavigationContext = require(AppChat.LuaAppNavigationContext)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local memo = React.memo
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local useCallback = React.useCallback
local useContext = React.useContext
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useState = React.useState
local useRef = React.useRef
local useIsGuiInChatVisible = require(AppChat.Hooks.useIsGuiInChatVisible)
local useRecordModalSeenWithDelay = require(AppChat.Hooks.useRecordModalSeenWithDelay)

local ChatLandingModalTelemetry = require(script.Parent.ChatLandingModalTelemetry)
local ChatLandingTelemetryEvents = require(AppChat.Components.ChatLanding.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local enum = require(AppChatParent.UIBlox).App.Button.Enum

local SocialUpsell = require(AppChatParent.SocialUpsell)
local AccessResponseEnum = require(AppChatParent.AmpUpsell).AmpEnums.AccessResponseEnum
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ChatLandingModalVariant = AppChatNetworking.Constants.ChatLandingModalVariant
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local NavigateBack = require(AppChatParent.NavigationRodux).Thunks.NavigateBack
local NavigateDown = require(AppChatParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AppChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppChatParent.RobloxAppNavigation).NavigationCommands else nil
local refreshAllUnfilteredThreadsDetails = require(AppChat.Conversations.Thunks.refreshAllUnfilteredThreadsDetails)
local UnfilteredThreadsAMPFeatureName = require(AppChat.Components.UnfilteredThreadsAMPFeatureName)
local OpenTcLearnMoreLink = require(AppChat.Conversations.Thunks.OpenTcLearnMoreLink)
local ModalConfiguration = require(AppChat.Models.ModalConfiguration)
local AppChatFAEBanner = require(AppChat.Components.FaeBanner.AppChatFAEBanner)

local FIntAppChatModalSeenImpressionDelayMs = require(AppChat.Flags.FIntAppChatModalSeenImpressionDelayMs)
local FFlagAppChatLandingModalTelemetry = require(AppChat.Flags.FFlagAppChatLandingModalTelemetry)
local FFlagDebugAppChatFae = require(AppChat.Flags.FFlagDebugAppChatFae)

local FStringCanAccessTrustedContactsAmpFeature = require(AppChatParent.SharedFlags).FStringCanAccessTrustedContactsAmpFeature

local FStringCanAccessTrustedContactsAmpNameSpace = require(AppChatParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
local FFlagDebugAEGIS1AppChatBanner = require(AppChat.Flags.FFlagDebugAEGIS1AppChatBanner)
local SocialExperiments = require(AppChatParent.SocialExperiments)
local FFlagTestDeviceForFAEUpsell = require(AppChatParent.SocialExperiments).FFlagTestDeviceForFAEUpsell
local deviceMeetsRequirementsForFAE = SocialExperiments.deviceMeetsRequirementsForFAE
local GetAgeVerifiedChangedSignal = SocialUpsell.Signals.GetAgeVerifiedChangedSignal

local ChatLandingModal = require(script.Parent.ChatLandingModal)

local tbl1 = {
    fully_eligible_ftux = true,
    party_only_ftux = true,
    phone_verify = true,
    [ChatLandingModalVariant.AgeAssuranceUpsell] = true
}

local tbl2 = {
    fully_eligible_ftux = "ChatLandingUnfilteredThreadsFtux",
    phone_verify = "ChatLandingPvUpsell"
}

return memo(function(_) -- name: ChatLandingModalContainer
    local var1 = useDispatch()
    local var2 = useAnalytics()
    local var3 = useContext(LuaAppNavigationContext)
    local var4 = useNavigation()
    local var5, var6 = useState({})
    local var7 = useIsInExperience()

    local modalConfiguration = useSelector(function(arg1)
        local default = ModalConfiguration.default
        return getDeepValue2(arg1, "ChatAppReducer.Modals.chatLandingModal") or default
    end)

    local modalVariant = modalConfiguration.modal_variant
    local modalId = getDeepValue2(modalConfiguration, "modal_layout.id")
    local actionToRecord = getDeepValue2(modalConfiguration, "modal_layout.seen_record_action")
    local deepValue2_3 = getDeepValue2(modalConfiguration, "modal_layout.dismissed_record_action")
    local deepValue2_4 = getDeepValue2(modalConfiguration, "modal_layout.buttons")
    local var9 = deepValue2_4 and deepValue2_4[1]
    local var10 = tbl2[modalVariant]
    local bool1 = if tbl1[modalVariant] or modalVariant == ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal then not var5[modalVariant] else false
    local var11 = useTelemetry(ChatLandingTelemetryLayer.Context)
    useEffectOnMount(function()
        if var2 and var10 and bool1 then
            var2.fireAnalyticsEvent(`{var10}Rendered`)
        end
        if FFlagAppChatLandingModalTelemetry and var10 and bool1 then
            var11.emit(ChatLandingTelemetryEvents[`{var10}Rendered`], {})
        end
    end)
    useEffect(function()
        if bool1 and modalVariant == ChatLandingModalVariant.AgeAssuranceUpsell then
            var11.emit(ChatLandingModalTelemetry.Events.FaeModalShown, {})
        end
        if bool1 then
            var11.emit(ChatLandingModalTelemetry.Events.ModalRendered, { modalVariant = modalVariant })
        end
    end, { modalVariant, bool1 })

    local var12 = useCallback
    local function func1()
        if var2 and var10 then
            var2.fireAnalyticsEvent(`{var10}ContinueClicked`)
        end
        if FFlagAppChatLandingModalTelemetry and var10 then
            var11.emit(ChatLandingTelemetryEvents[`{var10}ContinueClicked`], {})
        end
        local tbl3 = {
            name = AppPage.AmpWizardContainer,
            extraProps = {
                featureName = UnfilteredThreadsAMPFeatureName,
                completionCallback = function(granted, _)
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.back(true)
                    else
                        var1(NavigateBack(true))
                    end

                    if granted == AccessResponseEnum.Granted then
                        if var2 and var10 then
                            var2.fireAnalyticsEvent(`{var10}Succeeded`)
                        end
                        if FFlagAppChatLandingModalTelemetry and var10 then
                            var11.emit(ChatLandingTelemetryEvents[`{var10}Succeeded`], {})
                        end
                        var1(refreshAllUnfilteredThreadsDetails(nil, var7))
                        return
                    end
                    if var2 and var10 then
                        var2.fireAnalyticsEvent(`{var10}Failed`)
                    end
                    if FFlagAppChatLandingModalTelemetry and var10 then
                        var11.emit(ChatLandingTelemetryEvents[`{var10}Failed`], {})
                    end
                end
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end

    local var13 = if FFlagAppChatLandingModalTelemetry then var11 else false
    local phoneVerify = var12(func1, { var1, var7, var2, var10, var13 })

    local var15 = useCallback(function()
        local str1 = HttpService:GenerateGUID(false)
        var11.emit(
            ChatLandingModalTelemetry.Events.TelemetryFaeButtonClick,
            {
                state = str1,
                btn = ChatLandingModalTelemetry.Constants.ConfirmFaeBtn
            }
        )

        local tbl3 = {
            name = AppPage.AmpWizardContainer,
            extraProps = {
                featureName = FStringCanAccessTrustedContactsAmpFeature,
                entryPointEventCtx = ChatLandingModalTelemetry.Constants.EventStreamCtx,
                metadata = { sessionId = str1 },
                nameSpace = FStringCanAccessTrustedContactsAmpNameSpace,
                completionCallback = function(granted, _)
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.back(true)
                    else
                        var1(NavigateBack(true))
                    end

                    if granted == AccessResponseEnum.Granted then
                        var11.emit(ChatLandingModalTelemetry.Events.ModalActionResult, {
                            modalVariant = modalVariant,
                            action = ModalTelemetry.Enums.ModalActions.PrimaryCta,
                            actionResult = ModalTelemetry.Enums.ModalActionResults.Success
                        })
                        var1(refreshAllUnfilteredThreadsDetails(nil, var7))
                    else
                        var11.emit(ChatLandingModalTelemetry.Events.ModalActionResult, {
                            modalVariant = modalVariant,
                            action = ModalTelemetry.Enums.ModalActions.PrimaryCta,
                            actionResult = ModalTelemetry.Enums.ModalActionResults.Failure
                        })
                    end
                    if FFlagDebugAppChatFae or FFlagDebugAEGIS1AppChatBanner then
                        var1({ type = "DEBUG_DismissChatLandingModal" })
                    end
                end
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end, {
        var1,
        var7,
        var11,
        modalVariant
    })

    local var16 = useCallback
    local function func2()
        if var2 and var10 then
            var2.fireAnalyticsEvent(`{var10}LearnMoreClicked`)
        end
        if FFlagAppChatLandingModalTelemetry and var10 then
            var11.emit(ChatLandingTelemetryEvents[`{var10}LearnMoreClicked`], {})
        end

        local navigate = if var4 then var4.navigate else nil
        var3.navigateToUnfilteredThreadsLearnMore(navigate)
    end

    local var17 = if FFlagAppChatLandingModalTelemetry then var11 else false
    local fullyEligibleFtux = var16(func2, { var3, var2, var4, var10, var17 })

    local var19 = useCallback(function()
        var1(OpenTcLearnMoreLink())
    end, { var1 })
    local var20 = useCallback(function()
        if var2 and var10 then
            var2.fireAnalyticsEvent(`{var10}Dismissed`)
        end
        if FFlagAppChatLandingModalTelemetry and var10 then
            var11.emit(ChatLandingTelemetryEvents[`{var10}Dismissed`], {})
        end
        if modalVariant == ChatLandingModalVariant.AgeAssuranceUpsell then
            var11.emit(
                ChatLandingModalTelemetry.Events.TelemetryFaeButtonClick,
                {
                    state = HttpService:GenerateGUID(false),
                    btn = ChatLandingModalTelemetry.Constants.CancelFaeBtn
                }
            )
        end

        var11.emit(
            ChatLandingModalTelemetry.Events.ModalAction,
            {
                modalVariant = modalVariant,
                action = ModalTelemetry.Enums.ModalActions.Dismiss
            }
        )

        var1(AppChatNetworking.rodux.RecordModalSequenceResponse.API(deepValue2_3, "chat_landing_modal", modalId)):catch(
            function(arg1)
                warn("Error in ChatLandingModalContainer -> RecordModalSequenceResponse dismissed: " .. tostring(arg1), arg1)
            end
        )

        if FFlagDebugAppChatFae and modalVariant == ChatLandingModalVariant.AgeAssuranceUpsell
            or FFlagDebugAEGIS1AppChatBanner and modalVariant == ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal
        then
            var1({ type = "DEBUG_DismissChatLandingModal" })
            return
        end

        var6(Cryo.Dictionary.join(var5, { [modalVariant] = true }))
    end, {
        var5,
        var6,
        var1,
        var2,
        var10,
        deepValue2_3,
        modalVariant,
        modalId,
        var11
    })

    local var21 = ({
        [ChatLandingModalVariant.AgeAssuranceUpsell] = var19
    })[modalVariant]
    local onActivated = useCallback(function(...)
        var11.emit(
            ChatLandingModalTelemetry.Events.ModalAction,
            {
                modalVariant = modalVariant,
                action = ModalTelemetry.Enums.ModalActions.InlineCta
            }
        )
        var21(...)
    end, { var21, var11, modalVariant })

    local var23 = not (modalConfiguration and modalConfiguration.modal_layout and modalConfiguration.modal_layout.body) and {}
        or modalConfiguration.modal_layout.body.additional_content
        or {}

    local additionalContent = React.useMemo(function()
        return Cryo.List.map(var23, function(arg1)
            local tbl3 = {
                type = arg1.type,
                text = arg1.text
            }
            if arg1.type == AppChatNetworking.Constants.ModalContentType.Link then
                tbl3.onActivated = onActivated
            end
            return tbl3
        end)
    end, { var23, var21, onActivated })
    local var25 = ({
        phone_verify = phoneVerify,
        fully_eligible_ftux = fullyEligibleFtux,
        [ChatLandingModalVariant.AgeAssuranceUpsell] = var15
    })[modalVariant]
    local var8 = useCallback(function(...)
        var11.emit(
            ChatLandingModalTelemetry.Events.ModalAction,
            {
                modalVariant = modalVariant,
                action = ModalTelemetry.Enums.ModalActions.PrimaryCta
            }
        )
        var25(...)
    end, { var25, var11, modalVariant })

    local ref = useRef(nil)
    local var28 = useIsGuiInChatVisible(ref, { ref.current, bool1 })
    useRecordModalSeenWithDelay({
        modalSequence = "chat_landing_modal",
        modalId = modalId,
        actionToRecord = actionToRecord,
        delayMs = FIntAppChatModalSeenImpressionDelayMs,
        canRecordAction = var28 and bool1
    })

    local var29 = if FFlagDebugAppChatFae then React.useCallback(function()
        var1({ type = "DEBUG_ShowAppChatFaeUpsell" })
    end, { var1 }) else function() end

    local var30 = if FFlagDebugAEGIS1AppChatBanner then React.useCallback(function()
        var1({ type = "DEBUG_ShowChatLandingAgeVerifiedTimedModal" })
    end, { var1 }) else nil

    if FFlagTestDeviceForFAEUpsell and not deviceMeetsRequirementsForFAE() then
        return nil
    end

    if bool1 then
        if modalVariant == ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal then
            return React.createElement(AppChatFAEBanner, { modalConfiguration = modalConfiguration, onDismiss = var20 })
        end

        return React.createElement(ChatLandingModal, {
            titleLabelText = getDeepValue2(modalConfiguration, "modal_layout.label.text"),
            titleText = getDeepValue2(modalConfiguration, "modal_layout.header.text"),
            bodyText = getDeepValue2(modalConfiguration, "modal_layout.body.text"),
            additionalContent = additionalContent,
            actionText = var9 and var9.text,
            buttonType = if modalVariant == "fully_eligible_ftux" then enum.ButtonType.Secondary else enum.ButtonType.PrimarySystem,
            onActivated = var8,
            onDismissed = var20,
            hideActionButton = not (var9 and var25),
            ref = ref
        })
    end
    if modalVariant ~= "none" and modalVariant ~= nil and not tbl1[modalVariant] then
        warn("Unsupported ChatLandingModal variant: " .. modalVariant)
    end
    if not FFlagDebugAEGIS1AppChatBanner then
        if not FFlagDebugAppChatFae then
            return nil
        end

        return React.createElement(
            "TextButton",
            {
                Text = "DEBUG Show FAE Upsell",
                Size = UDim2.new(0, 200, 0, 50),
                [React.Event.Activated] = var29
            }
        )
    end

    local createElement = React.createElement
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 200)
    }
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.Name,
            Padding = UDim.new(0, 10)
        }),
        Btn1 = React.createElement("TextButton", {
            Text = "DEBUG Show Chat Landing Age Verfication Timed Modal",
            Size = UDim2.new(0, 200, 0, 50),
            [React.Event.Activated] = var30
        }),
        Btn2 = 0
    }
    local createElement2 = React.createElement
    local tbl5 = {
        Text = "DEBUG Fire Age Verified event",
        Size = UDim2.new(0, 200, 0, 50)
    }

    tbl5[React.Event.Activated] = function()
        GetAgeVerifiedChangedSignal():fire()
    end

    tbl4.Btn2 = createElement2("TextButton", tbl5)
    return createElement("Frame", tbl3, tbl4)
end)

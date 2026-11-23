-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local Players = game:GetService("Players")

local AppLinking = require(AmpUpsellParent.RoactServiceTags).AppLinking
local React = require(AmpUpsellParent.React)
local Promise = require(AmpUpsellParent.Promise)

local IDVApiProvider = require(AmpUpsellParent.IdentityVerification).IDVApiProvider
local usePollIDVStatus = require(AmpUpsellParent.IdentityVerification).usePollIDVStatus

local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local useNavigation = require(AmpUpsellParent.Navigation).useNavigation
local useDispatch = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useAppPolicy = require(AmpUpsellParent.UniversalAppPolicy).useAppPolicy
local NavigateDown = require(AmpUpsellParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(AmpUpsellParent.RobloxAppEnums).AppPage
local UrlUtils = require(AmpUpsell.Common.UrlUtils)

local FFlagSignalsNavP3Dispatch = require(AmpUpsellParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AmpUpsellParent.RobloxAppNavigation).NavigationCommands else nil
local FacialAgeEstimationServiceWrapper = require(script.Parent.FacialAgeEstimationServiceWrapper)
local FAEDirectLinkUpsell = require(script.Parent.FAEDirectLinkUpsell)
local FAEWithQRCodeUpsell = require(script.Parent.FAEWithQRCodeUpsell)
local FAEFailedModal = require(script.Parent.FAEFailedModal)
local FAELoadingModal = require(script.Parent.FAELoadingModal)

local AuthAnalytics = require(AmpUpsellParent.AuthAnalytics)
local authMsgShown = AuthAnalytics.Events.authMsgShown
local authModalShown = AuthAnalytics.Events.authModalShown
local authFormInteraction = AuthAnalytics.Events.authFormInteraction

local useRoactService = require(AmpUpsellParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(AmpUpsellParent.RoactServiceTags).RoactNetworking

local GetFFlagEnableRoactNetworkingForChallengeInteception = require(AmpUpsell.Flags.GetFFlagEnableRoactNetworkingForChallengeInteception)
local GetFFlagShowFAELoadingModal = require(AmpUpsell.Flags.GetFFlagShowFAELoadingModal)
local bool1 = game:DefineFastFlag("EnableFAECancellationAnalytics", false)
local bool2 = game:DefineFastFlag("EnableValidateFAEVerificationLink", false)
local GetFFlagMoveAmpUpsellOffNavigateDown = require(AmpUpsellParent.SharedFlags).GetFFlagMoveAmpUpsellOffNavigateDown
local GetFFlagEnableWebAmpWizardForFAEHandoff = require(AmpUpsell.Flags.GetFFlagEnableWebAmpWizardForFAEHandoff)
local GetFFlagEnableFAEQRCodeHandoff = require(AmpUpsell.Flags.GetFFlagEnableFAEQRCodeHandoff)
local logEventOnceIfEnabled = require(AmpUpsell.Common.LoggingUtils).logEventOnceIfEnabled

local delay = game:DefineFastInt("FAEWithCallbackPollDelay", 2)
local retries = game:DefineFastInt("FAEWithCallbackPollMaxRetries", 5)

local num1 = game:DefineFastInt("FAEBackgroundOnlyPollDelay", 15)
local num2 = game:DefineFastInt("FAEBackgroundOnlyPollMaxRetries", 40)

local num3 = game:DefineFastInt("FAEWithWebViewCallbackPollDelay", 2)
local num4 = game:DefineFastInt("FAEWithWebViewCallbackPollMaxRetries", 15)

local function FAEUpsellContainer()
    local var1 = useNavigation()
    local var2 = useDispatch()
    local var3 = useRoactService(RoactNetworking)

    local var4 = useAppPolicy(function(arg1)
        return arg1.getHasWebViewSupportForFAE()
    end)

    local param = var1.getParam("extraProps")
    local entryPointEventCtx = param.entryPointEventCtx
    local metadata = param.metadata
    local skipFacialAgeEstimationWebLinkModal = param.skipFacialAgeEstimationWebLinkModal

    local var5 = useRoactService(AppLinking)

    local onSuccess = param.onSuccess
    local onCancel = param.onCancel
    local onFailure = param.onFailure
    local onRetry = param.onRetry

    local fFlagEnableFaeqrCodeHandoff = var4 and GetFFlagEnableFAEQRCodeHandoff()

    local var6, var7 = React.useState(false)
    local webLink, var9 = React.useState(nil)
    local appsFlyerLink, var11 = React.useState(nil)
    local var12, var13 = React.useState(false)
    local var14, var15 = React.useState(false)

    local sessionId = metadata and metadata.sessionId or ""
    local var8, var17 = React.useState(sessionId)

    local var18 = React.useCallback(function(arg1)
        authModalShown(entryPointEventCtx, arg1, "faeFailed")
        var7(true)
    end, { entryPointEventCtx })

    local var19 = React.useCallback(function(arg1)
        authFormInteraction(entryPointEventCtx, arg1, "faeCancelled")
        onCancel()
    end, { onCancel, entryPointEventCtx })

    local var20 = React.useCallback(function(arg1)
        authMsgShown(entryPointEventCtx, arg1, "faeSuccess")
        onSuccess()
    end, { onSuccess, entryPointEventCtx })

    local var21 = React.useCallback(function(detail, callback)
        if GetFFlagMoveAmpUpsellOffNavigateDown() then
            var1.push(AppPage.GenericWebPage, {
                detail = detail,
                extraProps = {
                    title = "",
                    onClose = function()
                        callback()
                    end
                }
            })

            return
        end

        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                title = "",
                onClose = function()
                    callback()
                end
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var2(NavigateDown(tbl1))
    end, { if GetFFlagMoveAmpUpsellOffNavigateDown() then var1 or var2 else var2 })

    local var22 = React.useMemo(function()
        if FacialAgeEstimationServiceWrapper.isAvailable() then
            return { delay = delay, retries = retries }
        end

        if fFlagEnableFaeqrCodeHandoff then
            return { delay = num1, retries = num2 }
        end

        if var4 and not GetFFlagEnableWebAmpWizardForFAEHandoff() then
            return { delay = num3, retries = num4 }
        end

        return { delay = num1, retries = num2 }
    end, { var4, fFlagEnableFaeqrCodeHandoff })

    local var23, var24 = usePollIDVStatus({ delay = var22.delay, retries = var22.retries })

    local var25 = React.useCallback(function(arg1, arg2)
        local sessionIdentifier = arg1.sessionIdentifier
        local verificationLink = arg1.verificationLink
        local sessionToken = arg1.sessionToken

        if FacialAgeEstimationServiceWrapper.isAvailable() then
            authModalShown(entryPointEventCtx, arg2, "nativeFae")
            var13(true)
            return FacialAgeEstimationServiceWrapper.startFlow(sessionIdentifier, sessionToken)
        elseif fFlagEnableFaeqrCodeHandoff then
            var13(false)
            authModalShown(entryPointEventCtx, arg2, "faeQRCodeHandoff")
            local str1 = tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
            local var25 = "roblox%3A%2F%2Fnavigation%2Famp_wizard%3Ffeature_name=TriggerFacialAgeEstimationRecourse%26namespace=account_identity%252FAgeCheck%26entry_point=" .. entryPointEventCtx .. "%26user_id=" .. str1
            var11(
                "https://ro.blox.com/Ebh5" .. "?pid=QR_code&c=fae_onelink" .. "&is_retargeting=false" .. "&af_dp=" .. var25 .. "&deep_link_value=" .. var25
            )
            return Promise.resolve(sessionIdentifier)
        else
            if GetFFlagEnableWebAmpWizardForFAEHandoff() then
                authModalShown(entryPointEventCtx, arg2, "webHandoffFAE")
                var13(false)

                var9(UrlUtils.buildAmpWizardUrl("TriggerAgeVerifyRecourse", "social%2FUpsells", entryPointEventCtx, "my%2Faccount"))

                return Promise.resolve(sessionIdentifier)
            end

            if bool2 and (not verificationLink or verificationLink == "") then
                return Promise.reject("Invalid verification link")
            end

            authModalShown(entryPointEventCtx, arg2, "noNativeFae")
            var13(false)

            if var4 then
                return Promise.new(function(callback)
                    var21(verificationLink, function()
                        callback(sessionIdentifier)
                    end)
                end)
            end

            if skipFacialAgeEstimationWebLinkModal then
                var5:openURL(verificationLink)
            else
                var9(verificationLink)
            end
            return Promise.resolve(sessionIdentifier)
        end
    end, {
        entryPointEventCtx,
        var4,
        var21,
        var13,
        skipFacialAgeEstimationWebLinkModal,
        var5,
        fFlagEnableFaeqrCodeHandoff
    })

    React.useEffect(function()
        local var26 = sessionId
        if not GetFFlagEnableRoactNetworkingForChallengeInteception() then
            IDVApiProvider.startVerification({ ageEstimation = true }):andThen(function(arg1)
                var26 = `{var26}_{arg1.sessionIdentifier}`
                var17(var26)
                return arg1
            end):andThen(function(arg1)
                return var25(arg1, var26)
            end):andThen(function(arg1)
                var15(true)
                return var23(arg1)
            end):andThen(function()
                return var20(var26)
            end):catch(function(arg1)
                if bool1 and arg1 and arg1.resultType == Enum.FacialAgeEstimationResultType.Cancel then
                    var19(var26)
                    return
                end
                var18(var26)
            end)

            return function()
                var24()
            end
        end

        logEventOnceIfEnabled("start_verification_init")
        IDVApiProvider.startVerificationWithWrappedNetworking(var3, { ageEstimation = true }):andThen(function(arg1)
            var26 = `{var26}_{arg1.sessionIdentifier}`
            var17(var26)
            logEventOnceIfEnabled("start_verification_end")
            return arg1
        end):andThen(function(arg1)
            logEventOnceIfEnabled("persona_flow_init")
            return var25(arg1, var26)
        end):andThen(
            function(arg1)
                logEventOnceIfEnabled("persona_flow_end")
                var15(true)
                logEventOnceIfEnabled("status_polling_init")
                return var23(arg1)
            end
        ):andThen(
            function()
                logEventOnceIfEnabled("status_polling_end")
                return var20(var26)
            end
        ):catch(
            function(arg1)
                logEventOnceIfEnabled("status_polling_end")

                if bool1 and arg1 and arg1.resultType == Enum.FacialAgeEstimationResultType.Cancel then
                    var19(var26)
                    return
                end
                var18(var26)
            end
        )

        return function()
            var24()
        end
    end, {})

    if var6 then
        return React.createElement(
            FAEFailedModal,
            {
                sessionId = var8,
                entryPointEventCtx = entryPointEventCtx,
                onClose = onFailure,
                onRetry = onRetry
            }
        )
    elseif appsFlyerLink then
        return React.createElement(
            FAEWithQRCodeUpsell,
            {
                appsFlyerLink = appsFlyerLink,
                sessionId = var8,
                entryPointEventCtx = entryPointEventCtx,
                onCancel = onCancel
            }
        )
    elseif webLink then
        return React.createElement(
            FAEDirectLinkUpsell,
            {
                sessionId = var8,
                entryPointEventCtx = entryPointEventCtx,
                webLink = webLink,
                onCancel = onCancel
            }
        )
    elseif GetFFlagShowFAELoadingModal() and var14 and not var12 then
        return React.createElement(FAELoadingModal, { sessionId = var8, entryPointEventCtx = entryPointEventCtx, onCancel = onCancel })
    end

    return React.createElement(
        Loading,
        {
            size = IconSize.Medium,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
end
return FAEUpsellContainer

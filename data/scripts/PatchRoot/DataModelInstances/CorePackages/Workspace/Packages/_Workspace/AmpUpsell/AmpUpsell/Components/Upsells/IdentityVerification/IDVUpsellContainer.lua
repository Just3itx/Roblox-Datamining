-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local Promise = require(AmpUpsellParent.Promise)
local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local AppScreens = require(AmpUpsell.Common.AppScreens)
local IDVWithQRCodeUpsell = require(script.Parent.IDVWithQRCodeUpsell)
local IDVApiProvider = require(AmpUpsellParent.IdentityVerification).IDVApiProvider
local GetFStringBiometricPrivacyPolicyLink = require(AmpUpsell.Flags.GetFStringBiometricPrivacyPolicyLink)
local GetFIntIDVPollDelay = require(AmpUpsellParent.IdentityVerification).GetFIntIDVPollDelay
local GetFIntIDVMaxRetries = require(AmpUpsellParent.IdentityVerification).GetFIntIDVMaxRetries
local useNavigation = require(AmpUpsellParent.Navigation).useNavigation
local Enums = require(AmpUpsell.Common.Enums)
local IDVStep = Enums.IDVStep
local IDVSessionStatusEnum = require(AmpUpsellParent.IdentityVerification).Enums.IDVSessionStatusEnum
local ActionStatusEnum = Enums.ActionStatusEnum
local IDVErrorScreen = require(script.Parent.IDVErrorScreen)
local LocalizationStrings = require(AmpUpsell.Common.LocalizationStrings)
local idvErrorScreenStrings = LocalizationStrings.idvErrorScreenStrings
local idvWithQRCodeUpsellStrings = LocalizationStrings.idvWithQRCodeUpsellStrings
local IDVDirectLinkUpsell = require(script.Parent.IDVDirectLinkUpsell)
local RobloxAppHooks = require(AmpUpsellParent.RobloxAppHooks)
local useDeviceType = RobloxAppHooks.useDeviceType
local useRoactService = RobloxAppHooks.useRoactService
local AppLinking = require(AmpUpsellParent.RoactServiceTags).AppLinking
local DeviceType = require(AmpUpsellParent.RobloxAppEnums).DeviceType
local GetFFlagEnableDirectLinkForTablets = require(AmpUpsell.Flags.GetFFlagEnableDirectLinkForTablets)

local RoactNetworking = require(AmpUpsellParent.RoactServiceTags).RoactNetworking

local GetFFlagEnableRoactNetworkingForChallengeInteception = require(AmpUpsell.Flags.GetFFlagEnableRoactNetworkingForChallengeInteception)

local GetFFlagEnableNativePersonaInquiryForAmpIDVUpsell = require(AmpUpsell.Flags.GetFFlagEnableNativePersonaInquiryForAmpIDVUpsell)
local GetFFlagEnableAmpIDVUpsellAnalytics = require(AmpUpsell.Flags.GetFFlagEnableAmpIDVUpsellAnalytics)

local FacialAgeEstimationServiceWrapper = require(script.Parent.Parent.FacialAgeEstimation.FacialAgeEstimationServiceWrapper)

local AuthAnalytics = require(AmpUpsellParent.AuthAnalytics)
local authMsgShown = AuthAnalytics.Events.authMsgShown
local authModalShown = AuthAnalytics.Events.authModalShown
local authFormInteraction = AuthAnalytics.Events.authFormInteraction

local fIntIDVPollDelay = GetFIntIDVPollDelay()
local fIntIDVMaxRetries = GetFIntIDVMaxRetries()

local function isFailure(sessionStatus): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return sessionStatus == IDVSessionStatusEnum.Failure
        or sessionStatus == IDVSessionStatusEnum.RequiresManualReview
        or sessionStatus == IDVSessionStatusEnum.RequiresRetry
        or sessionStatus == IDVSessionStatusEnum.Expired
end

local function getErrorDescription(sessionStatus, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if sessionStatus == IDVSessionStatusEnum.Failure or sessionStatus == IDVSessionStatusEnum.RequiresManualReview then
        return arg1.declined
    end

    if sessionStatus == IDVSessionStatusEnum.RequiresRetry then
        return arg1.retry
    end

    if sessionStatus == IDVSessionStatusEnum.Expired then
        return arg1.timeout
    end

    return arg1.retry
end

local function IDVUpsellContainer(tbl1)
    local featureName = tbl1.featureName
    local onSuccess = tbl1.onSuccess
    local onFailure = tbl1.onFailure
    local onCancelled = tbl1.onCancelled
    local var1 = if tbl1.idvApiProvider then tbl1.idvApiProvider else IDVApiProvider
    local var2 = tbl1.deviceType or useDeviceType()
    local var3 = useNavigation()
    local var4 = useLocalization(idvErrorScreenStrings)
    local var5 = useLocalization(idvWithQRCodeUpsellStrings)

    local entryPointEventCtx = tbl1.entryPointEventCtx or ""
    local sessionId = tbl1.metadata and tbl1.metadata.sessionId or ""

    local var6, var7 = React.useState(nil)
    local var8 = React.useRef(true)
    local var9, var10 = React.useState(ActionStatusEnum.Unknown)
    local var11, var12 = React.useState(false)
    local errorDescription, var14 = React.useState(var4.retry)
    local latestStepCompleted, var16 = React.useState(0)
    local var17 = GetFFlagEnableNativePersonaInquiryForAmpIDVUpsell() and FacialAgeEstimationServiceWrapper.isAvailable()
    local bool1 = if GetFFlagEnableDirectLinkForTablets() and var2 == DeviceType.Tablet then true else var2 == DeviceType.Phone
    local var18 = useRoactService(AppLinking)
    local var19 = useRoactService(RoactNetworking)
    local var20 = tbl1.schedulePoll or function(callback: (...any) -> (...any), num1: number)
        spawn(function()
            wait(num1)
            callback()
        end)
    end

    local openIdvLink = tbl1.openIdvLink or function(arg1)
        var18:openURL(arg1)
    end

    local function openPrivacyPolicyLink()
        var3.navigate(AppScreens.GenericWebPage, {
            detail = GetFStringBiometricPrivacyPolicyLink(),
            extraProps = {
                title = var5.privacyPageHeader,
                transitionAnimation = "SlideInFromBottom"
            }
        })
    end

    local function updateChecklist(sessionStatus)
        if sessionStatus == IDVSessionStatusEnum.Stored then
            var16(IDVStep.UpdatedRobloxProfile)
        elseif sessionStatus == IDVSessionStatusEnum.Success then
            var16(IDVStep.Verified)
        elseif sessionStatus == IDVSessionStatusEnum.Submitted then
            var16(IDVStep.GotResults)
        elseif sessionStatus == IDVSessionStatusEnum.Started then
            var16(IDVStep.ConnectedMobile)
        end
    end

    local function reportErrorShown(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if GetFFlagEnableAmpIDVUpsellAnalytics() then
            authModalShown(entryPointEventCtx, str1, "idvFailed")
        end
    end

    local function pollIDVStatus(str1: string, num1: number, str2: string)
        if num1 == 0 then
            var12(true)
            var14(var4.timeout)
            reportErrorShown(str2)
            return
        end

        var1.getVerifiedStatus(str1):andThen(function(arg1)
            local isVerified = arg1.isVerified
            local sessionStatus = arg1.sessionStatus
            updateChecklist(sessionStatus)
            if isVerified and sessionStatus == IDVSessionStatusEnum.Stored then
                if GetFFlagEnableAmpIDVUpsellAnalytics() then
                    authMsgShown(entryPointEventCtx, str2, "idvSuccess")
                end
                var10(ActionStatusEnum.Success)
                return
            end

            if isFailure(sessionStatus) then
                var12(true)
                var10(ActionStatusEnum.Failure)
                var14((getErrorDescription(sessionStatus, var4)))
                reportErrorShown(str2)
            else
                var20(function()
                    if var8.current then
                        pollIDVStatus(str1, num1 - 1, str2)
                    end
                end, fIntIDVPollDelay)
            end
        end):catch(function(_)
            var12(true)
            var14(var4.retry)
            reportErrorShown(str2)
        end)
    end

    React.useEffect(function()
        var8.current = true
        local var22 = GetFFlagEnableNativePersonaInquiryForAmpIDVUpsell() and FacialAgeEstimationServiceWrapper.isAvailable()
        local fFlagEnableAmpIdvUpsellAnalytics = GetFFlagEnableAmpIDVUpsellAnalytics()
        local var23 = sessionId

        local function afterStartVerification(arg1)
            local sessionIdentifier = arg1.sessionIdentifier
            if fFlagEnableAmpIdvUpsellAnalytics then
                var23 = `{sessionId}_{sessionIdentifier}`
            end

            if var22 then
                if fFlagEnableAmpIdvUpsellAnalytics then
                    authModalShown(entryPointEventCtx, var23, "nativeIDV")
                end
                return FacialAgeEstimationServiceWrapper.startFlow(sessionIdentifier, arg1.sessionToken):andThen(function()
                    pollIDVStatus(sessionIdentifier, fIntIDVMaxRetries, var23)
                end)
            end
            if fFlagEnableAmpIdvUpsellAnalytics then
                authModalShown(entryPointEventCtx, var23, if bool1 then "idvDirectLink" else "idvQRCode")
            end
            pollIDVStatus(sessionIdentifier, fIntIDVMaxRetries, var23)
            var7(arg1.verificationLink)
            return Promise.resolve()
        end

        local var24 = if GetFFlagEnableRoactNetworkingForChallengeInteception() then var1.startVerificationWithWrappedNetworking(var19) else var1.startVerification()

        var24:andThen(afterStartVerification):catch(function(arg1)
            if var22 and arg1 and arg1.resultType == Enum.FacialAgeEstimationResultType.Cancel then
                if fFlagEnableAmpIdvUpsellAnalytics then
                    authFormInteraction(entryPointEventCtx, var23, "idvCancelled")
                end
                var10(ActionStatusEnum.Cancelled)
                return
            end
            var12(true)
            var14(var4.retry)
            if fFlagEnableAmpIdvUpsellAnalytics then
                authModalShown(entryPointEventCtx, var23, "idvFailed")
            end
        end)

        return function()
            var8.current = false
        end
    end, {})

    React.useEffect(function()
        if var9 == ActionStatusEnum.Success then
            onSuccess()
        elseif var9 == ActionStatusEnum.Cancelled then
            onCancelled()
        end
    end, { var9 })

    if var11 then
        return React.createElement(IDVErrorScreen, {
            errorTitle = var4.title,
            errorDescription = errorDescription,
            buttonText = var4.close,
            onClose = function()
                onFailure()
            end
        })
    elseif var17 and var9 == ActionStatusEnum.Cancelled then
        return nil
    elseif var17 and not var11 and (var9 == ActionStatusEnum.Unknown or var9 == ActionStatusEnum.Success) then
        return React.createElement(
            Loading,
            {
                size = IconSize.Large,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }
        )
    elseif bool1 then
        return React.createElement(IDVDirectLinkUpsell, {
            featureName = featureName,
            idvLink = var6,
            openIdvLink = openIdvLink,
            onClose = function()
                if GetFFlagEnableAmpIDVUpsellAnalytics() then
                    authFormInteraction(entryPointEventCtx, sessionId, "idvCancelled")
                end
                var10(ActionStatusEnum.Cancelled)
            end,
            openPrivacyPolicyLink = openPrivacyPolicyLink,
            latestStepCompleted = latestStepCompleted
        })
    end
    return React.createElement(IDVWithQRCodeUpsell, {
        qrCodeLink = var6,
        featureName = featureName,
        openPrivacyPolicyLink = openPrivacyPolicyLink,
        latestStepCompleted = latestStepCompleted,
        onClose = function()
            if GetFFlagEnableAmpIDVUpsellAnalytics() then
                authFormInteraction(entryPointEventCtx, sessionId, "idvCancelled")
            end
            var10(ActionStatusEnum.Cancelled)
        end
    })
end

return IDVUpsellContainer

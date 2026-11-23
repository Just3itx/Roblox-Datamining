-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local VPCApiProvider = require(AmpUpsell.Common.VPCApiProvider)
local AmpApiProvider = require(AmpUpsell.Common.AmpApiProvider)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local vpcConfirmationScreenStrings = require(AmpUpsell.Common.LocalizationStrings).vpcConfirmationScreenStrings
local vpcUpsellGatherEmailStrings = require(AmpUpsell.Common.LocalizationStrings).vpcUpsellGatherEmailStrings
local VPCErrorScreen = require(script.Parent.VPCErrorScreen)
local VPCConfirmationScreen = require(script.Parent.VPCConfirmationScreen)
local VPCNewParentUpsell = require(script.Parent.VPCNewParentUpsell)
local isStringEmail = require(AmpUpsellParent.AuthCommon).Utils.isStringEmail
local AppScreens = require(AmpUpsell.Common.AppScreens)
local GetFStringPrivacyPolicyLink = require(AmpUpsell.Flags.GetFStringPrivacyPolicyLink)
local useNavigation = require(AmpUpsellParent.Navigation).useNavigation
local Enums = require(AmpUpsell.Common.Enums)
local ActionTypeEnum = Enums.ActionTypeEnum
local VPCStepEnum = Enums.VPCStepEnum
local VPCRetryBehaviorEnum = Enums.VPCRetryBehaviorEnum

local getRetryBehaviorFromErrorCodeAndRetryNum = require(AmpUpsell.Common.VPCErrorUtils).getRetryBehaviorFromErrorCodeAndRetryNum
local AccessResponseEnum = Enums.AccessResponseEnum
local AuthAnalytics = require(AmpUpsellParent.AuthAnalytics)
local authMsgShown = AuthAnalytics.Events.authMsgShown
local authButtonClick = AuthAnalytics.Events.authButtonClick
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local vpcEventConstants = require(AmpUpsell.Common.EventConstants).vpcEventConstants
local useAppPolicy = require(AmpUpsellParent.UniversalAppPolicy).useAppPolicy
local useRoactService = require(AmpUpsellParent.RobloxAppHooks).useRoactService
local ArgCheck = require(AmpUpsellParent.ArgCheck)
local AppLinking = require(AmpUpsellParent.RoactServiceTags).AppLinking

local GetFFlagEnableExternalBrowserForVPCPrivacyPolicy = require(AmpUpsell.Flags.GetFFlagEnableExternalBrowserForVPCPrivacyPolicy)
local RoactNetworking = require(AmpUpsellParent.RoactServiceTags).RoactNetworking
local FFlagLuaAppOdpRequestSentToast = require(AmpUpsellParent.SharedFlags).FFlagLuaAppOdpRequestSentToast

local FFlagLuaAppAmpWizardSendAnalyticsSessionId = require(AmpUpsellParent.SharedFlags).FFlagLuaAppAmpWizardSendAnalyticsSessionId

local function VPCUpsellContainer(tbl1)
    local onCancel = tbl1.onCancel
    local onSuccess = tbl1.onSuccess
    local var1 = if tbl1.vpcApiProvider then tbl1.vpcApiProvider else VPCApiProvider
    local var2 = if tbl1.ampApiProvider then tbl1.ampApiProvider else AmpApiProvider
    local recourseAction = tbl1.recourseAction
    local recourseData = tbl1.recourseData
    local var3 = if tbl1.entryPointEventCtx then tbl1.entryPointEventCtx else ""
    local parentConsentTypes = tbl1.parentConsentTypes
    local disablePortal = if tbl1.disablePortal then tbl1.disablePortal else false
    local isInExperienceEntry = if tbl1.isInExperienceEntry then tbl1.isInExperienceEntry else false
    local onRequestSent = tbl1.onRequestSent
    local analyticsSessionId = tbl1.analyticsSessionId
    local vpcEntryAnalytics = tbl1.vpcEntryAnalytics

    local var4 = useRoactService(RoactNetworking)

    local bool1 = false
    local var5 = nil
    if GetFFlagEnableExternalBrowserForVPCPrivacyPolicy() then
        bool1 = useAppPolicy(function(arg1)
            return arg1.shouldUseExternalBrowserForDisclaimerLinks()
        end)
        var5 = useRoactService(AppLinking)
    end

    local current, var7 = React.useState(
        if recourseAction == ActionTypeEnum.ParentLink then VPCStepEnum.NewParentLoading else VPCStepEnum.AlreadyLinkedSendRequest
    )

    local errorCode, var9 = React.useState("Unknown")
    local parentEmails, var11 = React.useState({})
    local isChildSubjectToParentalControls, var13 = React.useState(true)

    local var14 = useLocalization(vpcUpsellGatherEmailStrings)
    local canSendRequest, var16 = React.useState(false)
    local textInput, var18 = React.useState("")
    local errorText, var20 = React.useState("")
    local var21 = useNavigation()

    local function openExternalBrowser(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        ArgCheck.isNotNil(arg1, "linking")
        ArgCheck.isType(arg2, "string", "url")

        arg1:openURL(arg2)
    end

    local function openPrivacyPolicyLink()
        if GetFFlagEnableExternalBrowserForVPCPrivacyPolicy() and bool1 then
            openExternalBrowser(var5, (GetFStringPrivacyPolicyLink()))
            return
        end
        var21.navigate(AppScreens.GenericWebPage, {
            detail = GetFStringPrivacyPolicyLink(),
            extraProps = {
                title = var14.privacyLinkText,
                transitionAnimation = "SlideInFromBottom"
            }
        })
    end

    local function handleEmailInput(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        var18(str1)
        if isStringEmail(str1) then
            var16(true)
            var20("")
            return
        end
        var16(false)
        if str1 == "" then
            var20("")
            return
        end
        var20(var14.errorText)
    end

    local retryNum, var23 = React.useState(0)
    local onRetryAmp = tbl1.onRetryAmp
    local function onRetryVPC()
        var23(retryNum + 1)
        var11({})
        var9("Unknown")
        handleEmailInput("")
        var7(
            if recourseAction == ActionTypeEnum.ParentLink then VPCStepEnum.NewParentCollectEmail else VPCStepEnum.AlreadyLinkedSendRequest
        )
    end

    local function finishSuccessfulRequest(arg1)
        var7(VPCStepEnum.RequestSent)
        if FFlagLuaAppOdpRequestSentToast and onRequestSent then
            pcall(onRequestSent, if arg1 then arg1.sessionId else nil)
        end
    end

    local function getLinkedParentEmailsAndSendRequestToAllParents()
        var1.getLinkedParentEmails(var4):andThen(function(arg1)
            var11(arg1.parentEmails)
        end):catch(function(_) end)

        var1.sendRequestToAllParents(var4, parentConsentTypes, recourseData, analyticsSessionId):andThen(
            finishSuccessfulRequest
        ):catch(
            function(arg1)
                var9(arg1.code)
                var7(VPCStepEnum.Error)
            end
        )
    end
    local function sendRequestToNewParent(arg1)
        var1.sendRequestToNewParent(var4, arg1, parentConsentTypes, recourseData, analyticsSessionId):andThen(
            finishSuccessfulRequest
        ):catch(
            function(arg2)
                var9(arg2.code)
                var7(VPCStepEnum.Error)
            end
        )
    end
    local function getIsChildSubjectToParentalControls()
        local featureAccess = var2.getFeatureAccess({ "IsChildSubjectToParentalControls" })

        local bool2 = not (featureAccess.featureAccessList and featureAccess.featureAccessList[1])
            or featureAccess.featureAccessList[1].access ~= AccessResponseEnum.Denied

        var13(bool2)
        var7(VPCStepEnum.NewParentCollectEmail)
    end

    React.useEffect(function()
        if recourseAction == ActionTypeEnum.ParentConsent then
            getLinkedParentEmailsAndSendRequestToAllParents()
        elseif recourseAction == ActionTypeEnum.ParentLink then
            getIsChildSubjectToParentalControls()
        end
    end, { retryNum })

    local var24 = if FFlagLuaAppAmpWizardSendAnalyticsSessionId then React.useRef(nil) else nil
    local var25 = if FFlagLuaAppAmpWizardSendAnalyticsSessionId then React.useRef(false) else nil

    if FFlagLuaAppAmpWizardSendAnalyticsSessionId then
        React.useEffect(function()
            if vpcEntryAnalytics == nil or var24 == nil or var24.current == current then
                return
            end
            var24.current = current
            if current == VPCStepEnum.NewParentCollectEmail then
                if var25 then
                    var25.current = false
                end
                vpcEntryAnalytics.remoteEmailShown()
                return
            end

            if current == VPCStepEnum.RequestSent then
                vpcEntryAnalytics.remoteRequestSent()
                return
            end

            if current ~= VPCStepEnum.Error then
                return
            end

            if getRetryBehaviorFromErrorCodeAndRetryNum(errorCode, retryNum) == VPCRetryBehaviorEnum.Success then
                vpcEntryAnalytics.remoteRequestSent()
                return
            end
            vpcEntryAnalytics.remoteRequestError(errorCode)
        end, {
            current,
            errorCode,
            retryNum,
            vpcEntryAnalytics
        })
    end
    if current == VPCStepEnum.RequestSent then
        authMsgShown(var3, "", vpcEventConstants.confirmationPageLoadField, "")
        return React.createElement(VPCConfirmationScreen, {
            messageStrings = vpcConfirmationScreenStrings,
            parentEmails = parentEmails,
            onAck = function()
                authButtonClick(var3, vpcEventConstants.confirmationPageButton)
                if vpcEntryAnalytics then
                    vpcEntryAnalytics.remoteRequestOk()
                end
                onSuccess()
            end,
            onClose = vpcEntryAnalytics and function()
                vpcEntryAnalytics.remoteRequestClose()
                authButtonClick(var3, vpcEventConstants.confirmationPageButton)
                onSuccess()
            end or nil,
            disablePortal = disablePortal,
            isInExperienceEntry = isInExperienceEntry
        })
    end

    if current == VPCStepEnum.NewParentCollectEmail then
        authMsgShown(var3, "", vpcEventConstants.collectEmailPageLoadField, "")
        return React.createElement(VPCNewParentUpsell, {
            onCancel = function()
                if vpcEntryAnalytics then
                    vpcEntryAnalytics.remoteRequestClose()
                end
                onCancel()
            end,
            onCollectEmailAndSendRequest = function(arg1)
                authButtonClick(var3, vpcEventConstants.collectEmailPageSubmitButton)
                if vpcEntryAnalytics then
                    vpcEntryAnalytics.remoteEmailSubmit()
                end
                var11({ arg1 })
                var7(VPCStepEnum.NewParentSendRequest)
                sendRequestToNewParent(arg1)
            end,
            onTextChange = function(arg1)
                authFormInteraction(var3, vpcEventConstants.collectEmailPageInteractFormField)
                if vpcEntryAnalytics and var25 and not var25.current and arg1 ~= "" then
                    var25.current = true
                    vpcEntryAnalytics.remoteEmailEntered()
                end
                handleEmailInput(arg1)
            end,
            canSendRequest = canSendRequest,
            textInput = textInput,
            openPrivacyPolicyLink = openPrivacyPolicyLink,
            errorText = errorText,
            messageStrings = vpcUpsellGatherEmailStrings,
            isChildSubjectToParentalControls = isChildSubjectToParentalControls,
            disablePortal = disablePortal,
            isInExperienceEntry = isInExperienceEntry
        })
    end

    if current == VPCStepEnum.AlreadyLinkedSendRequest then
        return nil
    end

    if current == VPCStepEnum.NewParentSendRequest then
        return nil
    end

    if current == VPCStepEnum.NewParentLoading then
        return nil
    end
    authMsgShown(var3, "", vpcEventConstants.errorPageLoadField, errorCode)
    return React.createElement(VPCErrorScreen, {
        errorCode = errorCode,
        onRetryAmp = function()
            authButtonClick(var3, vpcEventConstants.errorPageRetryButton)
            if vpcEntryAnalytics then
                vpcEntryAnalytics.remoteRequestRetry()
            end
            onRetryAmp()
        end,
        onRetryVPC = function()
            authButtonClick(var3, vpcEventConstants.errorPageRetryButton)
            if vpcEntryAnalytics then
                vpcEntryAnalytics.remoteRequestRetry()
            end
            onRetryVPC()
        end,
        onCancel = function()
            authButtonClick(var3, vpcEventConstants.errorPageCancelButton)
            if vpcEntryAnalytics then
                vpcEntryAnalytics.remoteRequestCancel()
            end
            onCancel()
        end,
        onClose = vpcEntryAnalytics and function()
            vpcEntryAnalytics.remoteRequestClose()
            authButtonClick(var3, vpcEventConstants.errorPageCancelButton)
            onCancel()
        end or nil,
        onSuccess = function()
            authButtonClick(var3, vpcEventConstants.confirmationPageButton)
            if vpcEntryAnalytics then
                vpcEntryAnalytics.remoteRequestOk()
            end
            onSuccess()
        end,
        retryNum = retryNum,
        disablePortal = disablePortal,
        isInExperienceEntry = isInExperienceEntry
    })
end

return VPCUpsellContainer

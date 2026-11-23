-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local useNavigation = require(AmpUpsellParent.Navigation).useNavigation
local Enums = require(AmpUpsell.Common.Enums)
local ActionTypeEnum = Enums.ActionTypeEnum
local ActionStatusEnum = Enums.ActionStatusEnum
local AccessResponseEnum = Enums.AccessResponseEnum
local UserSettingsSettingNameEnum = Enums.UserSettingsSettingNameEnum
local _Types = require(AmpUpsell.Common.Types)
local accountSettingsUpsellStringsFn = require(AmpUpsell.Common.LocalizationStrings).accountSettingsUpsellStringsFn
local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local Cryo = require(AmpUpsellParent.Cryo)
local AnalyticsService = require(AmpUpsell.Analytics.AnalyticsService)
local sendModalActionEvent = require(AmpUpsell.Analytics.sendModalActionEvent)
local AmpApiProvider = require(AmpUpsell.Common.AmpApiProvider)
local AppScreens = require(AmpUpsell.Common.AppScreens)
local ErrorScreen = require(AmpUpsell.Components.ErrorScreen)
local useCompletionCallbackWithReturnPage = require(AmpUpsell.Common.useCompletionCallbackWithReturnPage)
local useApolloClient = require(AmpUpsellParent.ApolloClient).useApolloClient
local SharedFlags = require(AmpUpsellParent.SharedFlags)
local FFlagAmpWizardEntryPointEventCtxFallback = SharedFlags.FFlagAmpWizardEntryPointEventCtxFallback
local FFlagEnableAmpWizardDeepLink = SharedFlags.FFlagEnableAmpWizardDeepLink
local GetFFlagEnableAmpUpsellGql = require(AmpUpsell.Flags.GetFFlagEnableAmpUpsellGql)
local GetFFlagEnableAmpEmailUpsellSupport = require(AmpUpsell.Flags.GetFFlagEnableAmpEmailUpsellSupport)
local GetFFlagEnableAmpIDVUpsellSupport = require(AmpUpsell.Flags.GetFFlagEnableAmpIDVUpsellSupport)
local GetFFlagEnableAmpIDVUpsellPopOnCompletion = require(AmpUpsell.Flags.GetFFlagEnableAmpIDVUpsellPopOnCompletion)
local GetFFlagEnableAmpSubscriptionUpsell = require(AmpUpsell.Flags.GetFFlagEnableAmpSubscriptionUpsell)
local GetFFlagEnableAmpVPCPrologue = require(AmpUpsell.Flags.GetFFlagEnableAmpVPCPrologue)
local GetFFlagEnableAmpWizardInlineVPCForFAE = require(AmpUpsell.Flags.GetFFlagEnableAmpWizardInlineVPCForFAE)
local GetFFlagEnableAmpWizardVPCNavigationFix = require(AmpUpsell.Flags.GetFFlagEnableAmpWizardVPCNavigationFix)
local FFlagAmpWizardRetryKeepsNameSpace = require(AmpUpsell.Flags.FFlagAmpWizardRetryKeepsNameSpace)
local VPCPrologue = require(AmpUpsell.Components.Prologues.VPCPrologue)
local logEventOnceIfEnabled = require(AmpUpsell.Common.LoggingUtils).logEventOnceIfEnabled
local VPCApiProvider = require(AmpUpsell.Common.VPCApiProvider)
local useRoactService = require(AmpUpsellParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(AmpUpsellParent.RoactServiceTags).RoactNetworking
local VPCRequestTypeEnum = Enums.VPCRequestTypeEnum

local function VPCPrologueController(tbl1)
    local options = tbl1.options

    local onConfirm = React.useCallback(function()
        local actionProps = tbl1.request.actionProps
        tbl1.onDone()
        if options and options.onConfirm then
            options.onConfirm()
        end
        if tbl1.request.openUpsellFn then
            tbl1.request.openUpsellFn(actionProps)
        end
    end, { tbl1.request, tbl1.onDone, options })

    local onCancel = React.useCallback(function()
        tbl1.onDone()
        if options and options.onCancel then
            options.onCancel()
        end
        tbl1.handleCompletion(
            AccessResponseEnum.Denied,
            Cryo.Dictionary.join(tbl1.actionsTaken, { [tbl1.request.action] = ActionStatusEnum.Cancelled })
        )
    end, {
        tbl1.handleCompletion,
        tbl1.actionsTaken,
        tbl1.onDone,
        tbl1.request,
        options
    })
    return React.createElement(VPCPrologue, {
        recourseData = tbl1.recourseData,
        onConfirm = onConfirm,
        onCancel = onCancel,
        config = if options then options.config else nil
    })
end

local function getSuccessfulActions(tbl1)
    local successfulActions = {}
    for k, value in pairs(tbl1) do
        if value == ActionStatusEnum.Success then
            table.insert(successfulActions, k)
        end
    end
    return successfulActions
end

local function shouldUseVpcV2(vpcV2Launcher: ((...any) -> (...any))?, vpcExcludedRequestTypes, arg1): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    local action = arg1.action
    if vpcV2Launcher == nil or action ~= ActionTypeEnum.ParentConsent and action ~= ActionTypeEnum.ParentLink then
        return false
    end

    local parentConsentTypes = arg1.parentConsentTypes
    local var1 = if parentConsentTypes then parentConsentTypes[1] else nil
    return var1 == nil or vpcExcludedRequestTypes == nil or table.find(vpcExcludedRequestTypes, var1) == nil
end

local function WizardContainer(tbl1)
    local var1 = useNavigation()
    local featureName = tbl1.featureName
    local nameSpace = tbl1.nameSpace
    local recourseData = tbl1.recourseData
    local extraParameters = tbl1.extraParameters
    local entryPointEventCtx = if FFlagAmpWizardEntryPointEventCtxFallback and (tbl1.entryPointEventCtx == nil or tbl1.entryPointEventCtx == "") then "defaultLuaContext" else tbl1.entryPointEventCtx
    local openUpsells = tbl1.openUpsells
    local vpcV2Launcher = tbl1.vpcV2Launcher
    local vpcExcludedRequestTypes = tbl1.vpcExcludedRequestTypes
    local completionCallback = tbl1.completionCallback
    local metadata = tbl1.metadata
    local var3 = if tbl1.ampApiProvider then tbl1.ampApiProvider else AmpApiProvider
    local var4 = if tbl1.analyticsService then tbl1.analyticsService else AnalyticsService.EventStream
    local var5 = if tbl1.openAccountSettingsUpsell then tbl1.openAccountSettingsUpsell else var1.push
    local isInExperienceEntry = if tbl1.isInExperienceEntry then tbl1.isInExperienceEntry else false
    local var6 = useRoactService(RoactNetworking)
    local actionsTaken, var8 = React.useState({})
    local var9, var10 = React.useState(false)

    local request, var12 = React.useState(nil)
    local var13, var14 = React.useState(nil)
    local var15 = useApolloClient()

    local var16 = useCompletionCallbackWithReturnPage(var1, completionCallback, metadata)

    if FFlagEnableAmpWizardDeepLink then
        completionCallback = var16
    end

    local var17 = React.useCallback(function(arg1)
        if not shouldUseVpcV2(vpcV2Launcher, vpcExcludedRequestTypes, arg1) then
            var1.pop()
        end
    end, { var1.pop, vpcV2Launcher, vpcExcludedRequestTypes })

    local var18 = React.useCallback(function(_, arg1)
        local action = arg1.action
        if action == ActionTypeEnum.Phone then
            return {
                eventContext = "AmpUpsell",
                origin = AppScreens.AmpWizardContainer,
                onSuccess = function()
                    var8(Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Phone] = ActionStatusEnum.Success }))
                end,
                onFailure = function()
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Phone] = ActionStatusEnum.Failure })
                    )
                end,
                onCancelled = function()
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Phone] = ActionStatusEnum.Cancelled })
                    )
                end
            }
        end

        if GetFFlagEnableAmpEmailUpsellSupport() and action == ActionTypeEnum.AddedEmail then
            return {
                eventContext = "AmpUpsell",
                closeOnEmailUpdate = true,
                addEmailOver13TextKey = "Feature.VerificationUpsell.Description.IDVerificationAddEmailText",
                addEmailUnder13TextKey = "Feature.VerificationUpsell.Description.IDVerificationAddEmailText",
                addEmailTitleKey = "Feature.VerificationUpsell.Heading.AddEmail",
                successCallback = function(_)
                    var8(Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Email] = ActionStatusEnum.Success }))
                end,
                failureCallback = function()
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Phone] = ActionStatusEnum.Failure })
                    )
                end,
                closeCentralOverlay = function() end
            }
        end

        if GetFFlagEnableAmpIDVUpsellSupport() and action == ActionTypeEnum.GovernmentId then
            return {
                featureName = featureName,
                entryPointEventCtx = entryPointEventCtx,
                metadata = metadata,
                onSuccess = function()
                    if GetFFlagEnableAmpIDVUpsellPopOnCompletion() then
                        var1.pop()
                    end
                    var8(Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.GovernmentId] = ActionStatusEnum.Success }))
                end,
                onFailure = function()
                    if GetFFlagEnableAmpIDVUpsellPopOnCompletion() then
                        var1.pop()
                    end
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.GovernmentId] = ActionStatusEnum.Failure })
                    )
                end,
                onCancelled = function()
                    if GetFFlagEnableAmpIDVUpsellPopOnCompletion() then
                        var1.pop()
                    end
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.GovernmentId] = ActionStatusEnum.Cancelled })
                    )
                end
            }
        end
        if action == ActionTypeEnum.ParentConsent or action == ActionTypeEnum.ParentLink then
            return {
                recourseAction = arg1.action,
                parentConsentTypes = arg1.parentConsentTypes,
                recourseData = recourseData,
                entryPointEventCtx = entryPointEventCtx,
                isInExperienceEntry = isInExperienceEntry,
                onCancel = function()
                    if GetFFlagEnableAmpWizardVPCNavigationFix() then
                        var17(arg1)
                    end
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [action] = ActionStatusEnum.Cancelled })
                    )
                end,
                onSuccess = function()
                    if GetFFlagEnableAmpWizardVPCNavigationFix() then
                        var17(arg1)
                    end
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [action] = ActionStatusEnum.Success })
                    )
                end,
                onRetryAmp = function()
                    var17(arg1)
                    var8(Cryo.Dictionary.join(actionsTaken, { [action] = ActionStatusEnum.RetryRequested }))
                end
            }
        end
        if action ~= ActionTypeEnum.AgeEstimation then
            if not GetFFlagEnableAmpSubscriptionUpsell() or action ~= ActionTypeEnum.Subscription then
                return {}
            end

            local var18 = recourseData
            return {
                purchaseUIOptions = var18 and var18.purchaseUIOptions,
                surfaceName = var18 and var18.surfaceName,
                surfaceContext = var18 and var18.surfaceContext,
                analyticsContext = var18 and var18.analyticsContext,
                onSuccess = function()
                    var1.pop()
                    completionCallback(
                        AccessResponseEnum.Granted,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Subscription] = ActionStatusEnum.Success })
                    )
                end,
                onFailure = function()
                    var1.pop()
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Subscription] = ActionStatusEnum.Failure })
                    )
                end,
                onCancel = function()
                    var1.pop()
                    completionCallback(
                        AccessResponseEnum.Denied,
                        Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.Subscription] = ActionStatusEnum.Cancelled })
                    )
                end
            }
        end

        return {
            featureName = featureName,
            entryPointEventCtx = entryPointEventCtx,
            metadata = metadata,
            skipFacialAgeEstimationWebLinkModal = tbl1.skipFacialAgeEstimationWebLinkModal,
            onSuccess = function()
                logEventOnceIfEnabled("complete_flow_with_success")
                var1.pop()
                completionCallback(
                    AccessResponseEnum.Granted,
                    Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.AgeEstimation] = ActionStatusEnum.Success })
                )
            end,
            onFailure = function()
                logEventOnceIfEnabled("complete_flow_with_error")
                var1.pop()
                completionCallback(
                    AccessResponseEnum.Denied,
                    Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.AgeEstimation] = ActionStatusEnum.Failure })
                )
            end,
            onCancel = function()
                logEventOnceIfEnabled("complete_flow_with_cancel")
                var1.pop()
                completionCallback(
                    AccessResponseEnum.Denied,
                    Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.AgeEstimation] = ActionStatusEnum.Cancelled })
                )
            end,
            onRetry = function()
                var1.pop()
                var8(Cryo.Dictionary.join(actionsTaken, { [ActionTypeEnum.AgeEstimation] = ActionStatusEnum.RetryRequested }))
            end
        }
    end, { actionsTaken, completionCallback, var17 })

    local var19 = React.useCallback(function(arg1)
        if shouldUseVpcV2(vpcV2Launcher, vpcExcludedRequestTypes, arg1) then
            return vpcV2Launcher
        end

        local action = arg1.action

        if action == ActionTypeEnum.UserSettings then
            local userSettings = arg1.userSettings
            if userSettings and userSettings.settingName == UserSettingsSettingNameEnum.AllowFacialAgeEstimation then
                return nil
            end
        end

        return openUpsells[action]
    end, { openUpsells, vpcV2Launcher, vpcExcludedRequestTypes })

    local var20 = React.useCallback(function(_, tbl2)
        if tbl2 == nil or #tbl2 == 0 then
            var10(true)
            return
        end
        local var20 = tbl2[1]
        local action = var20.action

        local openUpsellFn = var19(var20)
        if openUpsellFn ~= nil then
            local actionProps = var18(action, var20)
            local bool1 = action == ActionTypeEnum.ParentConsent or action == ActionTypeEnum.ParentLink

            if tbl1.usePrologue
                and bool1
                and GetFFlagEnableAmpVPCPrologue()
                and not shouldUseVpcV2(vpcV2Launcher, vpcExcludedRequestTypes, var20)
            then
                var12({ action = action, actionProps = actionProps, openUpsellFn = openUpsellFn })
                return
            end
            openUpsellFn(actionProps)

            return
        end

        if GetFFlagEnableAmpWizardInlineVPCForFAE() and action == ActionTypeEnum.UserSettings then
            local userSettings = var20.userSettings
            if userSettings and userSettings.settingName == UserSettingsSettingNameEnum.AllowFacialAgeEstimation then
                var14(var20)
                return
            end
        end

        if action == ActionTypeEnum.Subscription then
            completionCallback(AccessResponseEnum.Denied, actionsTaken)
            return
        end

        local localizationStrings = accountSettingsUpsellStringsFn(var20)
        if not localizationStrings then
            completionCallback(AccessResponseEnum.Error, actionsTaken)
            return
        end

        var5({
            featureName = featureName,
            localizationStrings = localizationStrings,
            onCloseModal = function()
                var1.pop()
                completionCallback(
                    AccessResponseEnum.Denied,
                    Cryo.Dictionary.join(actionsTaken, { [action] = ActionStatusEnum.Cancelled })
                )
            end
        })
    end, {
        actionsTaken,
        completionCallback,
        featureName,
        var18,
        var1.pop,
        var5,
        var19,
        tbl1.usePrologue,
        vpcV2Launcher,
        vpcExcludedRequestTypes,
        var14
    })

    local var21 = React.useCallback(function(arg1, arg2)
        var10(false)
        logEventOnceIfEnabled("amp_feature_access_init")
        local var21 = if GetFFlagEnableAmpUpsellGql() then var3.upsellFeatureAccessGql(var15, arg1, getSuccessfulActions(actionsTaken), arg2, extraParameters) else var3.upsellFeatureAccess(arg1, getSuccessfulActions(actionsTaken), arg2, extraParameters)

        if var21.access == AccessResponseEnum.Error then
            var10(true)
        elseif var21.access == AccessResponseEnum.Actionable then
            logEventOnceIfEnabled("amp_feature_access_actionable")
            var20(var21.recourse, var21.recourses)
        elseif var21.access == AccessResponseEnum.Granted then
            logEventOnceIfEnabled("amp_feature_access_granted")
            completionCallback(AccessResponseEnum.Granted, actionsTaken)
        elseif var21.access == AccessResponseEnum.Denied then
            logEventOnceIfEnabled("amp_feature_access_denied")
            completionCallback(AccessResponseEnum.Denied, actionsTaken)
        else
            completionCallback(AccessResponseEnum.Pending, actionsTaken)
        end
    end, { var3, extraParameters, completionCallback })

    React.useEffect(function()
        sendModalActionEvent(var4, AppScreens.AmpWizardContainer, featureName, "Shown")
    end, { var4 })

    React.useEffect(function()
        var21(featureName, nameSpace)
    end, {
        actionsTaken,
        featureName,
        var21,
        nameSpace
    })

    React.useEffect(function()
        if not GetFFlagEnableAmpWizardInlineVPCForFAE() or var13 == nil then
            return
        end

        local function faeRecourse(action) -- Luacid: Inlined by compiler; 2 call sites recovered
            return {
                action = action,
                parentConsentTypes = { VPCRequestTypeEnum.UpdateUserSetting }
            }
        end

        local function buildFAEProps(tbl2: {action: any, parentConsentTypes: {any}})
            local var22 = var18(tbl2.action, tbl2)

            local var2 = Cryo.Dictionary.join(recourseData or {}, { allowFacialAgeEstimation = "Enabled" })
            return Cryo.Dictionary.join(var22, { recourseData = var2 })
        end

        VPCApiProvider.getLinkedParentEmails(var6):andThen(function(arg1)
            local action = if (arg1.parentEmails and #arg1.parentEmails or 0) > 0 then ActionTypeEnum.ParentConsent else ActionTypeEnum.ParentLink
            local tbl2 = faeRecourse(action)
            local actionProps = buildFAEProps(tbl2)
            local openUpsellFn = var19(tbl2)
            if openUpsellFn == nil then
                var10(true)
                var14(nil)
                return
            end

            if GetFFlagEnableAmpVPCPrologue() and not shouldUseVpcV2(vpcV2Launcher, vpcExcludedRequestTypes, tbl2) then
                var12({ action = action, actionProps = actionProps, openUpsellFn = openUpsellFn })
            else
                openUpsellFn(actionProps)
            end
            var14(nil)
        end):catch(function(_)
            local tbl2 = faeRecourse(ActionTypeEnum.ParentLink)
            local actionProps = buildFAEProps(tbl2)
            local openUpsellFn = var19(tbl2)
            if openUpsellFn == nil then
                var10(true)
            elseif GetFFlagEnableAmpVPCPrologue() and not shouldUseVpcV2(vpcV2Launcher, vpcExcludedRequestTypes, tbl2) then
                var12({ action = ActionTypeEnum.ParentLink, actionProps = actionProps, openUpsellFn = openUpsellFn })
            else
                openUpsellFn(actionProps)
            end
            var14(nil)
        end)
    end, {
        var13,
        var6,
        var18,
        openUpsells,
        recourseData,
        var19,
        vpcV2Launcher,
        vpcExcludedRequestTypes
    })

    if GetFFlagEnableAmpVPCPrologue() and request then
        return React.createElement(VPCPrologueController, {
            request = request,
            recourseData = recourseData,
            handleCompletion = completionCallback,
            actionsTaken = actionsTaken,
            options = tbl1.prologueOptions,
            onDone = function()
                var12(nil)
            end
        })
    elseif var9 then
        return React.createElement(ErrorScreen, {
            featureName = featureName,
            onRetry = function()
                var10(false)
                if FFlagAmpWizardRetryKeepsNameSpace then
                    var21(featureName, nameSpace)
                    return
                end
                var21(featureName)
            end,
            onCancel = function()
                completionCallback(AccessResponseEnum.Denied, actionsTaken)
            end
        })
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
return WizardContainer

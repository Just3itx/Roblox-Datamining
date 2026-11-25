-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)
local RoactNetworking = require(OnPlatformSurveysParent.RoactServiceTags).RoactNetworking
local useLocalization = require(OnPlatformSurveysParent.Localization).Hooks.useLocalization
local useRoactService = require(OnPlatformSurveysParent.RobloxAppHooks).useRoactService

local FFlagInlineSurveyEnhancements = require(OnPlatformSurveysParent.SharedFlags).FFlagInlineSurveyEnhancements

local Button = Foundation.Button
local FillBehavior = Foundation.Enums.FillBehavior
local useTokens = Foundation.Hooks.useTokens

local makeDevSurveyRequestImpl = require(OnPlatformSurveys.Dev.makeDevSurveyRequestImpl)
local InlineEventType = require(OnPlatformSurveys.Enums.InlineEventType)
local _InlineSurveyPreset = require(OnPlatformSurveys.Enums.InlineSurveyPreset)
local InviteBanner = require(OnPlatformSurveys.Components.InviteBanner)
local InlineSurveyLocalizationKeys = require(OnPlatformSurveys.Constants.InlineSurveyLocalizationKeys)
local Phase = require(OnPlatformSurveys.Enums.Phase)
local InlineSurveyPresets = require(OnPlatformSurveys.Constants.InlineSurveyPresets)
local surveyPhaseSlots = require(OnPlatformSurveys.Components.surveyPhaseSlots)
local Surface = require(OnPlatformSurveys.Enums.Surface)
local SurfaceWrapper = require(OnPlatformSurveys.Components.SurfaceWrapper)
local SurveyCard = require(OnPlatformSurveys.Components.SurveyCard)
local SurveyModal = require(OnPlatformSurveys.Components.SurveyModal)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)
local useInlineSurveyFlow = require(OnPlatformSurveys.Hooks.useInlineSurveyFlow)

local function noop() end

return React.memo(function(tbl1) -- name: InlineSurvey
    local var1 = useRoactService(RoactNetworking)
    local bool1 = tbl1.eventType == InlineEventType.DevDoNotPushToProd
    local networkImpl = React.useMemo(function()
        if bool1 then
            return (makeDevSurveyRequestImpl.makeRequestImpl())
        end

        return var1
    end, { bool1, var1 })

    local var3 = useTokens()
    local var4 = useLocalization({
        surveyTitle = InlineSurveyLocalizationKeys.surveyTitle,
        completedTitle = InlineSurveyLocalizationKeys.completedTitle,
        inviteBody = InlineSurveyLocalizationKeys.inviteBody,
        inviteAccept = InlineSurveyLocalizationKeys.inviteAccept,
        next = InlineSurveyLocalizationKeys.next,
        send = InlineSurveyLocalizationKeys.send,
        done = InlineSurveyLocalizationKeys.done,
        errorText = InlineSurveyLocalizationKeys.errorText,
        retry = InlineSurveyLocalizationKeys.retry
    })
    local presentationConfig = if FFlagInlineSurveyEnhancements then InlineSurveyPresets.getPresentationConfig(tbl1.preset) else nil
    local var5 = useInlineSurveyFlow({
        networkImpl = networkImpl,
        eventType = tbl1.eventType,
        hasInvite = not (presentationConfig == nil) and presentationConfig.hasInvite,
        onClose = tbl1.onClose,
        onComplete = tbl1.onComplete,
        onEligible = tbl1.onEligible
    })

    local phase = var5.state.phase

    local var6 = React.useRef(false)

    local dismiss = var5.dismiss
    local errorType = var5.state.errorType
    React.useEffect(function()
        if phase == Phase.Error and errorType == "fetch" then
            dismiss()
        end
    end, { phase, errorType, dismiss })

    if phase == Phase.Closed then
        if var6.current then
            if FFlagInlineSurveyEnhancements then
                return React.createElement(SurfaceWrapper, { surface = Surface.Modal, isOpen = false, onClose = noop, children = nil })
            end

            return React.createElement(SurveyModal, { isOpen = false, onClose = noop, children = nil })
        end

        return nil
    end

    if phase == Phase.Loading or phase == Phase.Error and var5.state.errorType == "fetch" then
        return nil
    end

    local slots = surveyPhaseSlots.getSlots(var5.state, var4, var3, {
        onAnswerChanged = var5.setAnswer,
        onSubmit = var5.submit,
        onRetry = var5.retry,
        onDismiss = var5.dismiss,
        onAccept = var5.acceptInvite
    })
    local element

    if slots.primaryAction then
        element = React.createElement(Button, {
            text = slots.primaryAction.text,
            variant = slots.primaryAction.variant,
            fillBehavior = FillBehavior.Fill,
            isLoading = slots.primaryAction.isLoading,
            isDisabled = slots.primaryAction.isDisabled,
            onActivated = slots.primaryAction.onActivated
        })
            or nil
    else
        element = nil
    end

    if not (FFlagInlineSurveyEnhancements and presentationConfig) then
        var6.current = true
        return React.createElement(
            SurveyModal,
            {
                isOpen = true,
                onClose = var5.dismiss,
                title = slots.headerTitle,
                footer = element,
                children = slots.body
            }
        )
    end

    local bool2 = phase == Phase.Invite
    local var7 = if presentationConfig.hasInvite and bool2 then presentationConfig.inviteSurface or presentationConfig.surveySurface else presentationConfig.surveySurface
    local onClose = if bool2 then var5.declineInvite else var5.dismiss

    if var7 == Surface.InContent and bool2 then
        return React.createElement(SurfaceWrapper, {
            surface = Surface.InContent,
            onClose = onClose,
            children = React.createElement(InviteBanner, { onAccept = var5.acceptInvite })
        })
    end

    if var7 ~= Surface.Modal then
        return React.createElement(SurfaceWrapper, {
            surface = Surface.InContent,
            onClose = onClose,
            children = React.createElement(SurveyCard, { slots = slots, onDismiss = var5.dismiss })
        })
    end

    var6.current = true
    return React.createElement(SurfaceWrapper, {
        surface = Surface.Modal,
        isOpen = true,
        onClose = onClose,
        title = slots.headerTitle,
        footer = element,
        children = slots.body
    })
end)

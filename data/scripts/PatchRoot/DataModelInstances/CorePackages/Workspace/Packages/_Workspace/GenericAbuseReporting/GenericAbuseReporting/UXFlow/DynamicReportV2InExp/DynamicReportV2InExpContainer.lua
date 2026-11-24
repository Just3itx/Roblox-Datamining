-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local GuiService = game:GetService("GuiService")

local React = require(GenericAbuseReportingParent.React)

local _RobloxAppEnums = require(GenericAbuseReportingParent.RobloxAppEnums)
local useDeviceOrientation = require(GenericAbuseReportingParent.RobloxAppHooks).useDeviceOrientation

local InlineEventType = require(GenericAbuseReportingParent.OnPlatformSurveys.InlineEventType)
local InlineSurvey = require(GenericAbuseReportingParent.OnPlatformSurveys.InlineSurvey)
local InlineSurveyPreset = require(GenericAbuseReportingParent.OnPlatformSurveys.InlineSurveyPreset)

local AbuseReportErrorBoundary = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportErrorBoundary)
local getIsInExpSceneSelectionAvailable = require(GenericAbuseReporting.BeduiV2.Components.Nodes.getIsInExpSceneSelectionAvailable)
local getUsers = require(GenericAbuseReporting.BeduiV2.Loaders.getUsers)
local _LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)
local recentlyLeftSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.recentlyLeftSignals)
local sendBoundaryErrorTelemetry = require(GenericAbuseReporting.BeduiV2.Analytics.sendBoundaryErrorTelemetry)
local useInExpCustomSubmit = require(GenericAbuseReporting.BeduiV2.Hooks.useInExpCustomSubmit)
local useInExpCustomSubmit2 = useInExpCustomSubmit.useInExpCustomSubmit
local useInExpClientActionHandlers = useInExpCustomSubmit.useInExpClientActionHandlers

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _fetchConfigWithAttributes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.fetchConfigWithAttributes)
local DynamicReportV2InExpError = require(script.Parent.DynamicReportV2InExpError)
local DynamicReportV2InExpLoading = require(script.Parent.DynamicReportV2InExpLoading)
local AbuseReportContentInExp = require(script.Parent.AbuseReportContentInExp)
local useDynamicInExpConfig = require(script.Parent.useDynamicInExpConfig).useDynamicInExpConfig
local useInExpConfigLoadingSkeleton = require(script.Parent.useInExpConfigLoadingSkeleton).useInExpConfigLoadingSkeleton
local _useAbuseSheetFlow = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.useAbuseSheetFlow)
local useIsVoiceChatReportable = require(script.Parent.useIsVoiceChatReportable).useIsVoiceChatReportable
local _appendReportAnythingTags = require(GenericAbuseReporting.BeduiV2.Utils.appendReportAnythingTags)

local FFlagAbuseReportInExpShowConfigLoadingSkeleton = require(GenericAbuseReporting.Flags.FFlagAbuseReportInExpShowConfigLoadingSkeleton)
local FFlagInlineSurveyOnInExpReport = require(GenericAbuseReporting.Flags.FFlagInlineSurveyOnInExpReport)
local FFlagAbuseReportInExpPlayerListV3 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportInExpPlayerListV3
local FFlagAbuseReportSubmissionTargetV4 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportSubmissionTargetV4
local FFlagAbuseReportVoiceMute = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportVoiceMute

return React.memo(function(tbl1) -- name: DynamicReportV2InExpContainer
    local preselectedPlayer = tbl1.preselectedPlayer

    local var1 = React.useMemo(function(): string
        return tostring(game.GameId)
    end, {})

    local isVoiceChatReportable = useIsVoiceChatReportable(tbl1.voiceChatServiceManager)

    local isSceneSelectionAvailable = React.useMemo(function()
        return tbl1.isReportTabVisible and getIsInExpSceneSelectionAvailable()
    end, { tbl1.isReportTabVisible })

    local var4 = React.useMemo(function()
        local tbl2 = {
            experienceTargetId = var1,
            isVoiceChatReportable = isVoiceChatReportable,
            isSceneSelectionAvailable = isSceneSelectionAvailable
        }
        if preselectedPlayer then
            tbl2.preselectedAbuserId = tostring(preselectedPlayer.UserId)
            tbl2.preselectedAbuserDisplayName = preselectedPlayer.DisplayName
            tbl2.preselectedAbuserUsername = preselectedPlayer.Name
        end
        return tbl2
    end, {
        var1,
        preselectedPlayer,
        isVoiceChatReportable,
        isSceneSelectionAvailable
    })
    local var5 = useDynamicInExpConfig(tbl1.isReportTabVisible, var4)
    local config = var5.config
    local hasError = var5.hasError
    local setHasError = var5.setHasError
    local abuseVector = var5.abuseVector

    local pendingInlineAlert, setInlineAlert = React.useState(nil)

    local var8 = useDeviceOrientation()
    local bool1 = GuiService.ViewportDisplaySize == Enum.DisplaySize.Small
    local shouldUseOverlaidControls = var8 == "Landscape" or not bool1
    local isReportTabVisible = tbl1.isReportTabVisible

    if isReportTabVisible then
        if config == nil then
            isReportTabVisible = not hasError
        else
            isReportTabVisible = false
        end
    end

    local var9 = if FFlagAbuseReportInExpShowConfigLoadingSkeleton then useInExpConfigLoadingSkeleton(tbl1.isReportTabVisible, isReportTabVisible) else false

    local loaders = React.useMemo(function()
        local tbl2 = {
            users = { type = "listItem", fetch = getUsers }
        }

        if tbl1.inExpChatMessagesLoader then
            tbl2.inExpChatMessages = tbl1.inExpChatMessagesLoader
        end
        if tbl1.inExpVoiceUsersLoader then
            tbl2.voiceUsers = tbl1.inExpVoiceUsersLoader
        end
        return tbl2
    end, { tbl1.inExpChatMessagesLoader, tbl1.inExpVoiceUsersLoader })

    local menuOpenTimeRef = React.useRef(DateTime.now().UnixTimestampMillis)
    React.useEffect(function()
        if tbl1.isReportTabVisible then
            menuOpenTimeRef.current = DateTime.now().UnixTimestampMillis
        end
    end, { tbl1.isReportTabVisible })

    if FFlagAbuseReportInExpPlayerListV3 then
        React.useEffect(function()
            recentlyLeftSignals.init()
        end, {})
    end

    React.useEffect(function()
        if not tbl1.isReportTabVisible then
            setInlineAlert(nil)
        end
    end, { tbl1.isReportTabVisible, setInlineAlert })

    local tbl2 = {
        voiceChatServiceManager = tbl1.voiceChatServiceManager,
        inExpChatMessagesLoader = tbl1.inExpChatMessagesLoader,
        menuOpenTimeRef = menuOpenTimeRef,
        reportAnythingSnapshotRef = tbl1.reportAnythingSnapshotRef
    }
    local var12 = nil
    local var13 = nil
    if FFlagAbuseReportSubmissionTargetV4 then
        var13 = useInExpClientActionHandlers(tbl2)
    else
        var12 = useInExpCustomSubmit2(tbl2)
    end

    local var14 = nil
    local var15 = nil
    local onReportFinish, var16

    if FFlagInlineSurveyOnInExpReport then
        local var17
        var14, var17 = React.useState(false)
        var15 = var17

        local onReportFinish2 = tbl1.onReportFinish
        onReportFinish = React.useCallback(function(tbl3)
            if tbl3.didSubmit and var15 then
                var15(true)
            end
            if onReportFinish2 then
                onReportFinish2(tbl3)
            end
        end, { onReportFinish2, var15 })

        var16 = React.useCallback(function()
            if var15 then
                var15(false)
            end
        end, { var15 })
    else
        var16 = nil
        onReportFinish = nil
    end

    local onResolveError = React.useCallback(function()
        setHasError(true)
    end, { setHasError })

    local onError = React.useCallback(function(arg1)
        warn("AbuseReportErrorBoundary (in-exp) caught:", arg1)
        sendBoundaryErrorTelemetry(arg1, { abuse_vector = abuseVector, target_id = var1 })

        setHasError(true)
    end, { abuseVector, var1, setHasError })

    local inlineAlertController = React.useMemo(function()
        return { pendingInlineAlert = pendingInlineAlert, setInlineAlert = setInlineAlert }
    end, { pendingInlineAlert, setInlineAlert })

    if var9 then
        return React.createElement(DynamicReportV2InExpLoading, { shouldUseOverlaidControls = shouldUseOverlaidControls })
    elseif tbl1.isReportTabVisible and hasError then
        return React.createElement(DynamicReportV2InExpError, nil)
    else
        local survey = if FFlagInlineSurveyOnInExpReport and var14 then React.createElement(InlineSurvey, {
            eventType = InlineEventType.InExperienceReportButtonClicked,
            preset = InlineSurveyPreset.ModalInviteToModalSurvey,
            onClose = var16
        }) else nil
        local var20

        if tbl1.isReportTabVisible and config and not hasError then
            local createElement = React.createElement
            local var21 = AbuseReportErrorBoundary
            local tbl3 = { onError = onError }
            local tbl4 = { AbuseReportContentInExp = 0 }
            local createElement2 = React.createElement
            local var22 = AbuseReportContentInExp
            local tbl5 = {
                rawConfig = config,
                abuseVector = abuseVector,
                targetId = var1,
                onClose = tbl1.onClose,
                onCustomSubmit = 0,
                clientActionHandlers = 0,
                onFinish = 0,
                onResolveError = 0,
                shouldUseOverlaidControls = 0,
                loaders = 0,
                attemptTrigger = 0,
                inlineAlertController = 0,
                voiceChatServiceManager = 0
            }

            if FFlagAbuseReportSubmissionTargetV4 then
                var12 = nil
            end

            tbl5.onCustomSubmit = var12
            if not FFlagAbuseReportSubmissionTargetV4 then
                var13 = nil
            end

            tbl5.clientActionHandlers = var13
            if not FFlagInlineSurveyOnInExpReport then
                onReportFinish = tbl1.onReportFinish
            end

            tbl5.onFinish = onReportFinish
            tbl5.onResolveError = onResolveError
            tbl5.shouldUseOverlaidControls = shouldUseOverlaidControls
            tbl5.loaders = loaders
            tbl5.attemptTrigger = if preselectedPlayer then "onOpen" else "onFirstAction"
            tbl5.inlineAlertController = inlineAlertController
            tbl5.voiceChatServiceManager = if FFlagAbuseReportInExpPlayerListV3 or FFlagAbuseReportVoiceMute then tbl1.voiceChatServiceManager else nil
            tbl4.AbuseReportContentInExp = createElement2(var22, tbl5)
            var20 = createElement(var21, tbl3, tbl4)
        else
            var20 = nil
        end

        if FFlagInlineSurveyOnInExpReport then
            if var20 == nil and survey == nil then
                return nil
            end

            return React.createElement(React.Fragment, nil, { Content = var20, Survey = survey })
        end

        return var20
    end
end)

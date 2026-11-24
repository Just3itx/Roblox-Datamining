-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local BlockingUtility = require(GenericAbuseReportingParent.BlockingUtility)
local Dash = require(GenericAbuseReportingParent.Dash)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local flaggedMutedError = require(GenericAbuseReportingParent.RobloxAppLoggers).flaggedMutedError
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation
local View = Foundation.View

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local arTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local TextLink = require(GenericAbuseReporting.BeduiV2.Components.TextLink)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useInExpFocusNavigationRefs = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useInExpFocusNavigationRefs)
local useInExpOpenLink = require(GenericAbuseReporting.BeduiV2.Hooks.useInExpOpenLink)
local userBlock = require(GenericAbuseReporting.BeduiV2.Api.userBlock)
local userMute = require(GenericAbuseReporting.BeduiV2.Api.userMute)
local voiceSpeakingSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.voiceSpeakingSignals)

local blockUser = userBlock.blockUser
local isBlockedUser = userBlock.isBlockedUser
local isUserMuted = userMute.isUserMuted
local muteUser = userMute.muteUser
local TelemetryEventType = analyticsService.TelemetryEventType
local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useArTranslation = arTranslation.useArTranslation
local useLayoutSlots = LayoutSlots.useLayoutSlots

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local function computeInitialMuteState(muteToggle): string -- Luacid: Inlined by compiler; 1 call site recovered
    if not (muteToggle and muteToggle.userId) then
        return "Hidden"
    end
    local num1 = tonumber(muteToggle.userId) or 0
    return if num1 == 0 or isUserMuted(num1) then "Hidden" else "Visible"
end

local function useBlockMuteActions(blockToggle, muteToggle, callback: (...any) -> (...any))
    local translateIntoString = useArTranslation().translateIntoString
    local var1 = React.useContext(voiceSpeakingSignals.VoiceChatServiceManagerContext)
    local blockState, var3 = React.useState("Hidden")
    local muteState, var5 = React.useState(function(): string
        return computeInitialMuteState(muteToggle)
    end)
    local var6, var7 = React.useState(false)
    local sendEvent = useAbuseReportAnalytics().sendEvent
    local var8 = useRoactService(RoactNetworking)

    React.useEffect(function()
        if not blockToggle or not blockToggle.userId then
            return
        end

        isBlockedUser(var8, blockToggle.userId):andThen(function(arg1)
            local responseBody = arg1.responseBody
            var3(if responseBody then "Hidden" else "Visible")
            var7(true)
        end):catch(function(arg1)
            sendEvent({
                sub_event_type = TelemetryEventType.Error,
                error_detail = not FFlagAbuseReportImproveErrorEvents and {
                    error_message = "isBlockedUser: " .. Dash.pretty(arg1, { depth = 10 })
                }
                    or formatErrorDetailForAnalytics("isBlockedUser failed", arg1, { includeResponseBody = true })
            })

            var7(true)
        end)
        sendEvent({ sub_event_type = TelemetryEventType.IsUserBlockAvailable })
    end, { if blockToggle then blockToggle.userId else nil, var8, sendEvent })

    local var9 = React.useRef(false)
    React.useEffect(function()
        if muteState == "Visible" and not var9.current then
            var9.current = true
            sendEvent({ sub_event_type = TelemetryEventType.IsUserMuteAvailable })
        end
    end, { muteState, sendEvent })

    local onActivated = React.useCallback(function()
        if not (muteToggle and muteToggle.userId) then
            return
        end
        local var10 = tonumber(muteToggle.userId)
        if not var10 or not LocalPlayer then
            return
        end

        var5("Loading")

        if muteUser(var10, LocalPlayer, var1) then
            sendEvent({ sub_event_type = TelemetryEventType.DidMuteUser })
            callback({ didBlockUser = false, didMuteUser = true })
            return
        end
        sendEvent({
            sub_event_type = TelemetryEventType.Error,
            error_detail = FFlagAbuseReportImproveErrorEvents
                and {
                    error_message = "muteUser failed",
                    error_metadata = {
                        target_user_id = tostring(var10)
                    }
                }
                or {
                    error_message = `muteUser failed for userId: {var10}`
                }
        })
        callback({ didBlockUser = false, didMuteUser = false })
    end, {
        muteToggle,
        sendEvent,
        callback,
        var1
    })

    local var11 = React.useCallback(function(userId: number)
        if not userId or userId == 0 then
            sendEvent(
                {
                    sub_event_type = TelemetryEventType.Error,
                    error_detail = { error_message = "AddPlayerToBlockList invalid userId" }
                }
            )
            return
        end
        local player = Players:GetPlayerByUserId(userId)
        if not player or BlockingUtility:AddPlayerToBlockList(player) then
            return
        end

        sendEvent({
            sub_event_type = TelemetryEventType.Error,
            error_detail = FFlagAbuseReportImproveErrorEvents
                and {
                    error_message = "AddPlayerToBlockList failed",
                    error_metadata = {
                        target_user_id = tostring(userId)
                    }
                }
                or {
                    error_message = `AddPlayerToBlockList failed for userId: {userId}`
                }
        })
    end, { sendEvent })

    local var2 = React.useCallback(function()
        if not (blockToggle and blockToggle.userId) then
            return
        end

        if not FFlagAbuseReportImproveErrorEvents then
            var3("Loading")
            blockUser(var8, blockToggle.userId):andThen(function()
                sendEvent({ sub_event_type = TelemetryEventType.DidBlockUser })
                local var12 = tonumber(blockToggle.userId)
                if var12 then
                    var11(var12)
                end
                callback({ didBlockUser = true, didMuteUser = false })
            end):catch(function()
                var3("Error")
                sendEvent({
                    sub_event_type = TelemetryEventType.Error,
                    error_detail = {
                        error_message = `blockUser failed for userId: {blockToggle.userId}`
                    }
                })
            end)

            return
        end

        var3("Loading")
        blockUser(var8, blockToggle.userId):andThen(function()
            var3("Hidden")
            local var12 = tonumber(blockToggle.userId)
            if var12 then
                local success, result = pcall(function()
                    var11(var12)
                    return nil
                end)
                if not success then
                    flaggedMutedError("AbuseReportInExpLocalBlockError", tostring(result))
                end
            end
            callback({ didBlockUser = true, didMuteUser = false })
        end, function(arg1)
            var3("Error")
            sendEvent({
                sub_event_type = TelemetryEventType.Error,
                error_detail = formatErrorDetailForAnalytics("blockUser failed", arg1, { includeResponseBody = true })
            })
        end)

        sendEvent({ sub_event_type = TelemetryEventType.DidBlockUser })
    end, {
        blockToggle,
        callback,
        var11,
        var8,
        sendEvent
    })

    local hasLoadedActions = blockToggle == nil or var6

    return {
        actions = React.useMemo(function()
            local result = {}
            if not hasLoadedActions then
                return result
            end
            if blockToggle and blockState ~= "Hidden" then
                table.insert(result, {
                    text = translateIntoString(blockToggle.label),
                    variant = ButtonVariant.Alert,
                    onActivated = var2,
                    isLoading = blockState == "Loading"
                })
            end
            if muteToggle and muteState ~= "Hidden" then
                table.insert(result, {
                    text = translateIntoString(muteToggle.label),
                    variant = ButtonVariant.Alert,
                    onActivated = onActivated,
                    isLoading = muteState == "Loading"
                })
            end
            return result
        end, {
            blockToggle,
            muteToggle,
            var2,
            onActivated,
            translateIntoString,
            blockState,
            muteState,
            hasLoadedActions
        }),
        blockState = blockState,
        muteState = muteState,
        hasActions = blockToggle ~= nil or muteToggle ~= nil,
        hasLoadedActions = hasLoadedActions
    }
end

local function useDelayedTrue(num1: number)
    local var1, var2 = React.useState(false)
    React.useEffect(function()
        local var3 = task.delay(num1, function()
            var2(true)
        end)
        return function()
            task.cancel(var3)
        end
    end, { num1 })
    return var1
end

return React.memo(function(tbl1) -- name: InExpConfirmationNode
    local translateIntoString = useArTranslation().translateIntoString
    local var1 = useInExpOpenLink()

    local sendEvent = useAbuseReportAnalytics().sendEvent

    local tbl2 = useBlockMuteActions(tbl1.blockToggle, tbl1.muteToggle, tbl1.onNext)
    local actions = tbl2.actions
    local blockState = tbl2.blockState
    local muteState = tbl2.muteState
    local hasActions = tbl2.hasActions
    local hasLoadedActions = tbl2.hasLoadedActions

    local var2 = useDelayedTrue(0.6)
    local var3 = tbl1.isStoryMode or var2 or not hasActions or hasLoadedActions

    local layout = useLayoutSlots().Layout

    React.useEffect(function()
        if sendEvent and var3 and tbl1.helpline and tbl1.helpline.href then
            sendEvent({ sub_event_type = TelemetryEventType.HelplineShown })
        end
    end, { tbl1.helpline and tbl1.helpline.href, var3 })

    local onActivated = React.useCallback(function()
        if not tbl1.helpline or not tbl1.helpline.href then
            return
        end

        var1(tbl1.helpline.href)
        if sendEvent then
            sendEvent({ sub_event_type = TelemetryEventType.HelplineOpened })
        end
    end, { tbl1.helpline, var1 })

    local onClose = React.useCallback(function()
        tbl1.onNext({ didBlockUser = false, didMuteUser = false })
    end, { tbl1.onNext })

    local ref = useInExpFocusNavigationRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, onClose)

    local createElement = React.createElement
    local fragment = React.Fragment
    local var7 = nil
    local tbl3 = {
        Content = React.createElement(layout, { body = nil, actions = nil }),
        ConfirmationDialog = 0
    }
    local var8

    if var3 then
        local createElement2 = React.createElement
        local root = Dialog.Root
        local tbl4 = {
            ref = ref,
            size = DialogSize.Small,
            hasBackdrop = not tbl1.isStoryMode,
            disablePortal = not not tbl1.isStoryMode,
            onClose = onClose
        }
        local tbl5 = {
            DialogTitle = React.createElement(Dialog.Title, { text = translateIntoString(tbl1.title) }),
            DialogContent = 0,
            DialogActions = 0
        }
        local createElement3 = React.createElement
        local content = Dialog.Content
        local tbl6 = { LayoutOrder = 2 }

        local tbl7 = { DialogContentView = 0 }
        local createElement4 = React.createElement
        local var9 = View
        local tbl8 = { tag = "col gap-small size-full-0 auto-y" }

        local tbl9 = {
            Message = React.createElement(
                TextWithTranslation,
                {
                    input = tbl1.message,
                    tag = "size-full-0 auto-y text-body-medium",
                    layoutOrder = 2
                }
            ),
            Helpline = tbl1.helpline
                and React.createElement(View, {
                    tag = "col gap-small size-full-0 auto-y",
                    LayoutOrder = 3
                }, {
                    Heading = React.createElement(
                        TextWithTranslation,
                        {
                            input = tbl1.helpline.heading,
                            tag = "size-full-0 auto-y text-body-medium",
                            layoutOrder = 1
                        }
                    ),
                    Link = React.createElement(TextLink, {
                        text = translateIntoString(tbl1.helpline.buttonText),
                        tag = "auto-xy text-body-medium text-wrap text-align-x-left radius-small content-emphasis",
                        onActivated = onActivated,
                        layoutOrder = 2
                    })
                }),
            ErrorMessage = 0,
            Footer = 0
        }
        local element

        if blockState == "Error" or muteState == "Error" then
            element = React.createElement(TextWithTranslation, {
                input = if blockState == "Error" and tbl1.blockToggle then tbl1.blockToggle.errorLabel elseif muteState ~= "Error" or not tbl1.muteToggle then "" else tbl1.muteToggle.errorLabel,
                tag = "size-full-0 auto-y text-body-medium content-system-alert",
                layoutOrder = 4
            })
        else
            element = nil
        end

        tbl9.ErrorMessage = element

        tbl9.Footer = tbl1.footerItems
            and React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 5 })
        tbl7.DialogContentView = createElement4(var9, tbl8, tbl9)
        tbl5.DialogContent = createElement3(content, tbl6, tbl7)

        tbl5.DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = 4, actions = actions, orientation = EnumsOrientation.Vertical })
        var8 = createElement2(root, tbl4, tbl5)
    else
        var8 = nil
    end

    tbl3.ConfirmationDialog = var8
    return createElement(fragment, var7, tbl3)
end)

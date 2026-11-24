-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local Toggle = Foundation.Toggle
local View = Foundation.View

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local Eyebrow = require(GenericAbuseReporting.BeduiV2.Components.Eyebrow)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation
local useOpenLink = require(GenericAbuseReporting.BeduiV2.Hooks.useOpenLink)
local userBlock = require(GenericAbuseReporting.BeduiV2.Api.userBlock)

local blockUser = userBlock.blockUser
local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local isBlockedUser = userBlock.isBlockedUser
local TelemetryEventType = analyticsService.TelemetryEventType
local unblockUser = userBlock.unblockUser
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useLayoutSlots = LayoutSlots.useLayoutSlots

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)
local FFlagAbuseReportOptimisticBlockToggle = require(GenericAbuseReporting.Flags.FFlagAbuseReportOptimisticBlockToggle)
local FFlagSupportSubmissionOnAllReportNodes = SharedFlags.FFlagSupportSubmissionOnAllReportNodes

local function useBlockToggle(blockToggle)
    local blockToggleState, var2 = React.useState(if blockToggle then "Loading" else "Hidden")
    local isBlocked, var4 = React.useState(false)
    local var5 = nil
    local var6 = nil
    if FFlagAbuseReportOptimisticBlockToggle then
        var5, var6 = React.useState(false)
    end
    local sendEvent = useAbuseReportAnalytics().sendEvent
    local var7 = useRoactService(RoactNetworking)

    React.useEffect(function()
        if not (blockToggle and blockToggle.userId) then
            var2("Hidden")

            return
        end

        isBlockedUser(var7, blockToggle.userId):andThen(function(arg1)
            local responseBody = arg1.responseBody
            var2(if responseBody then "Hidden" else "Visible")
        end):catch(function(arg1)
            var2("Hidden")
            sendEvent({
                sub_event_type = TelemetryEventType.Error,
                error_detail = not FFlagAbuseReportImproveErrorEvents and {
                    error_message = "isBlockedUser: " .. Dash.pretty(arg1, { depth = 10 })
                }
                    or formatErrorDetailForAnalytics("isBlockedUser failed", arg1, { includeResponseBody = true })
            })
        end)

        sendEvent({ sub_event_type = TelemetryEventType.IsUserBlockAvailable })
    end, { blockToggle and blockToggle.userId, sendEvent, var7 })

    return {
        blockToggleState = blockToggleState,
        handleBlockToggleChange = React.useCallback(function()
            if blockToggle == nil or blockToggle.userId == nil then
                return
            end

            if FFlagAbuseReportOptimisticBlockToggle then
                if var5 then
                    return
                end

                if var6 then
                    var6(true)
                end
                var4(not isBlocked)
            end

            local var8

            if isBlocked then
                var8 = unblockUser(var7, blockToggle.userId):andThen(function()
                    var4(false)
                end):catch(function(arg1)
                    if FFlagAbuseReportOptimisticBlockToggle then
                        var4(true)
                    end
                    var2("Error")
                    sendEvent({
                        sub_event_type = TelemetryEventType.Error,
                        error_detail = not FFlagAbuseReportImproveErrorEvents and {
                            error_message = "unblockUser: " .. Dash.pretty(arg1, { depth = 10 })
                        }
                            or formatErrorDetailForAnalytics("unblockUser failed", arg1, { includeResponseBody = true })
                    })
                end)

                sendEvent({ sub_event_type = TelemetryEventType.DidUnblockUser })
            else
                var8 = blockUser(var7, blockToggle.userId):andThen(function()
                    if not FFlagAbuseReportOptimisticBlockToggle then
                        sendEvent({ sub_event_type = TelemetryEventType.DidBlockUser })
                    end
                    var4(true)
                end):catch(function(arg1)
                    if FFlagAbuseReportOptimisticBlockToggle then
                        var4(false)
                    end
                    var2("Error")
                    sendEvent({
                        sub_event_type = TelemetryEventType.Error,
                        error_detail = not FFlagAbuseReportImproveErrorEvents and {
                            error_message = "blockUser: " .. Dash.pretty(arg1, { depth = 10 })
                        }
                            or formatErrorDetailForAnalytics("blockUser failed", arg1, { includeResponseBody = true })
                    })
                end)

                if FFlagAbuseReportOptimisticBlockToggle then
                    sendEvent({ sub_event_type = TelemetryEventType.DidBlockUser })
                end
            end
            if not FFlagAbuseReportOptimisticBlockToggle then
                return
            end

            var8:finally(function()
                if var6 then
                    var6(false)
                end
            end)
        end, {
            sendEvent,
            var7,
            blockToggle and blockToggle.userId,
            isBlocked,
            var5
        }),
        isBlocked = isBlocked,
        isBlockRequestInFlight = var5
    }
end

return React.memo(function(tbl1) -- name: ConfirmationNode
    local translateIntoString = useArTranslation().translateIntoString
    local var1 = useOpenLink()
    local sendEvent = useAbuseReportAnalytics().sendEvent

    local blockToggle = tbl1.blockToggle
    local tbl2 = useBlockToggle(blockToggle)
    local blockToggleState = tbl2.blockToggleState
    local handleBlockToggleChange = tbl2.handleBlockToggleChange
    local isBlocked = tbl2.isBlocked
    local isBlockRequestInFlight = tbl2.isBlockRequestInFlight

    local var2 = useLayoutSlots()
    local title = var2.Title
    local layout = var2.Layout

    React.useEffect(function()
        if tbl1.helpline and tbl1.helpline.href then
            sendEvent({ sub_event_type = TelemetryEventType.HelplineShown })
        end
    end, { tbl1.helpline and tbl1.helpline.href, sendEvent })

    local onActivated = React.useCallback(function()
        if tbl1.onNext then
            tbl1.onNext()
        end
    end, { tbl1.onNext })

    local var3 = React.useCallback(function()
        if tbl1.helpline and tbl1.helpline.href then
            var1(translateIntoString(tbl1.helpline.heading or ""), tbl1.helpline.href)
            sendEvent({ sub_event_type = TelemetryEventType.HelplineOpened })
        end
    end, {
        tbl1.helpline and tbl1.helpline.href,
        var1,
        translateIntoString,
        tbl1.helpline and tbl1.helpline.heading,
        sendEvent
    })

    local tbl3 = {
        Eyebrow = React.createElement(Eyebrow, { eyebrow = tbl1.eyebrow, layoutOrder = 0 }),
        Title = React.createElement(title, { input = tbl1.title, subtitle = tbl1.subtitle, layoutOrder = 1 }),
        Message = React.createElement(
            TextWithTranslation,
            {
                input = tbl1.message,
                tag = "size-full-0 auto-y text-body-small",
                layoutOrder = 2
            }
        ),
        ToggleContainer = 0,
        Error = 0,
        InformationContainer = 0,
        Footer = 0
    }
    local element

    if tbl1.blockToggle and blockToggleState == "Visible" then
        element = React.createElement(View, {
            onActivated = handleBlockToggleChange,
            tag = "col gap-xsmall size-full-0 auto-y padding-large radius-medium bg-action-standard",
            LayoutOrder = 3,
            testId = "ConfirmationNode.BlockToggleContainer"
        }, {
            TextContainer = React.createElement(
                View,
                { tag = "row flex-x-between gap-small size-full-0 auto-y", LayoutOrder = 1 },
                {
                    Label = React.createElement(
                        TextWithTranslation,
                        {
                            input = tbl1.blockToggle.label or "",
                            tag = "auto-xy text-title-large content-emphasis",
                            layoutOrder = 1
                        }
                    ),
                    Toggle = React.createElement(Toggle, {
                        isChecked = isBlocked,
                        isDisabled = isBlockRequestInFlight,
                        onActivated = handleBlockToggleChange,
                        label = "",
                        Selectable = false,
                        LayoutOrder = 2,
                        testId = "ConfirmationNode.BlockToggle"
                    })
                }
            ),
            Description = if tbl1.blockToggle.description then React.createElement(
                TextWithTranslation,
                {
                    input = tbl1.blockToggle.description or "",
                    tag = "auto-xy text-body-small text-wrap",
                    layoutOrder = 2
                }
            ) else nil
        })
    else
        element = nil
    end

    tbl3.ToggleContainer = element

    tbl3.Error = if blockToggleState == "Error" and tbl1.blockToggle then React.createElement(TextWithTranslation, {
        input = tbl1.blockToggle.errorLabel or "",
        tag = "align-x-left size-full-0 auto-y padding-bottom-medium text-body-small content-system-alert",
        layoutOrder = 3
    }) else nil
    local element2

    if tbl1.helpline and tbl1.helpline.heading and blockToggleState ~= "Loading" then
        element2 = React.createElement(View, {
            tag = "col gap-medium size-full-0 auto-y",
            LayoutOrder = 4
        }, {
            InformationHeader = React.createElement(
                TextWithTranslation,
                {
                    input = tbl1.helpline.heading,
                    tag = "auto-xy text-title-small content-emphasis",
                    layoutOrder = 1
                }
            ),
            ViewInformationButton = if tbl1.helpline and tbl1.helpline.href then React.createElement(Button, {
                text = translateIntoString(tbl1.helpline.buttonText),
                icon = "icons/navigation/externallink",
                variant = ButtonVariant.Standard,
                width = UDim.new(1, 0),
                onActivated = var3,
                LayoutOrder = 2
            }) else nil
        })
    else
        element2 = nil
    end

    tbl3.InformationContainer = element2

    tbl3.Footer = if tbl1.footerItems then React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 5 }) else nil
    local element3 = if tbl1.onNext then React.createElement(Button, {
        text = translateIntoString(tbl1.nextButtonText),
        variant = ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        isLoading = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else false,
        isDisabled = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else false,
        onActivated = onActivated
    }) else nil
    return React.createElement(layout, { body = React.createElement(React.Fragment, nil, tbl3), actions = element3 })
end)

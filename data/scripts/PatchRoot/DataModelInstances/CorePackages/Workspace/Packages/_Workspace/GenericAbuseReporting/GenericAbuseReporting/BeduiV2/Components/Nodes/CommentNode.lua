-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local TextArea = Foundation.TextArea

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local Eyebrow = require(GenericAbuseReporting.BeduiV2.Components.Eyebrow)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local getCodePointLength = require(GenericAbuseReporting.BeduiV2.Utils.getCodePointLength)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local TelemetryEventType = analyticsService.TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useLayoutSlots = LayoutSlots.useLayoutSlots

return React.memo(function(tbl1) -- name: CommentNode
    local text, var2 = React.useBinding(tbl1.initialValue or "")
    local hasError, var4 = React.useState(false)
    local mergeTranslationParams = translate.mergeTranslationParams
    local translateIntoString = useArTranslation().translateIntoString
    local sendEvent = useAbuseReportAnalytics().sendEvent
    local var5 = React.useRef(false)

    local var6 = useLayoutSlots()
    local title = var6.Title
    local layout = var6.Layout

    local onChanged = React.useCallback(function(str1: string)
        var2(str1)
        if not tbl1.maxLength then
            return
        end

        local bool1 = getCodePointLength(str1) > tbl1.maxLength
        var4(bool1)
        if bool1 then
            var5.current = true
        end
    end, { tbl1.maxLength })

    local onActivated = React.useCallback(function()
        sendEvent({
            sub_event_type = TelemetryEventType.CommentInput,
            comment_input_detail = {
                comment_length = getCodePointLength(text:getValue()),
                has_initial_value = not (tbl1.initialValue == nil) and tbl1.initialValue ~= "",
                did_modify_initial = not (tbl1.initialValue == nil) and text:getValue() ~= tbl1.initialValue,
                hit_character_limit = var5.current,
                max_length = tbl1.maxLength or 0
            }
        })
        if tbl1.onNext then
            tbl1.onNext(text:getValue())
        end
    end, {
        text,
        tbl1.onNext,
        sendEvent,
        tbl1.initialValue,
        tbl1.maxLength
    })

    local var9 = React.useCallback(function(str1: string)
        if tbl1.helperText and tbl1.maxLength and mergeTranslationParams then
            return translateIntoString(
                mergeTranslationParams(
                    tbl1.helperText,
                    {
                        currentLength = tostring(getCodePointLength(str1)),
                        maxLength = tostring(tbl1.maxLength)
                    }
                )
            )
        elseif tbl1.helperText then
            return translateIntoString(tbl1.helperText)
        end
        return nil
    end, { tbl1.helperText, tbl1.maxLength })

    local tbl2 = {
        Eyebrow = React.createElement(Eyebrow, { eyebrow = tbl1.eyebrow, layoutOrder = 0 }),
        Title = React.createElement(title, { input = tbl1.title, subtitle = tbl1.subtitle, layoutOrder = 1 }),
        TextArea = React.createElement(TextArea, {
            text = text,
            hint = if tbl1.helperText then text:map(function(arg1)
                return var9(arg1)
            end) else nil,
            numLines = 6,
            onChanged = onChanged,
            label = if tbl1.textAreaLabel then translateIntoString(tbl1.textAreaLabel) else "",
            placeholder = translateIntoString(tbl1.placeholder or ""),
            hasError = hasError,
            width = UDim.new(1, 0),
            LayoutOrder = 2
        }),
        Footer = if tbl1.footerItems then React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 3 }) else nil
    }

    local actions = if tbl1.onNext then React.createElement(Button, {
        text = translateIntoString(tbl1.nextButtonText or ""),
        variant = ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        isLoading = tbl1.isSubmitting,
        isDisabled = tbl1.isSubmitting or hasError,
        onActivated = onActivated
    }) else nil
    return React.createElement(layout, { body = React.createElement(React.Fragment, nil, tbl2), actions = actions })
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local Eyebrow = require(GenericAbuseReporting.BeduiV2.Components.Eyebrow)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local useLayoutSlots = LayoutSlots.useLayoutSlots

local FFlagSupportSubmissionOnAllReportNodes = SharedFlags.FFlagSupportSubmissionOnAllReportNodes

return React.memo(function(tbl1) -- name: ParagraphNode
    local translateIntoString = useArTranslation().translateIntoString

    local var1 = useLayoutSlots()
    local title = var1.Title
    local layout = var1.Layout

    local tbl2 = {
        Eyebrow = React.createElement(Eyebrow, { eyebrow = tbl1.eyebrow, layoutOrder = 0 }),
        Title = React.createElement(title, { input = tbl1.title, subtitle = tbl1.subtitle, layoutOrder = 1 }),
        Paragraph = React.createElement(
            TextWithTranslation,
            {
                input = tbl1.paragraph,
                tag = "size-full-0 auto-y text-body-small",
                layoutOrder = 2
            }
        ),
        Footer = if tbl1.footerItems then React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 3 }) else nil
    }
    local element

    if tbl1.onNext then
        element = React.createElement(Button, {
            text = translateIntoString(tbl1.nextButtonText),
            variant = ButtonVariant.Emphasis,
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            isLoading = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else false,
            isDisabled = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else false,
            onActivated = tbl1.onNext
        })
    else
        element = nil
    end

    return React.createElement(layout, { body = React.createElement(React.Fragment, nil, tbl2), actions = element })
end)

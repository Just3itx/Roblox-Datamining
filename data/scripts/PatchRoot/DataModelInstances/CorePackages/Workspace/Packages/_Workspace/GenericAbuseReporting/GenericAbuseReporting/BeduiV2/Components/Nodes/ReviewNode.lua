-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local View = Foundation.View

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local Eyebrow = require(GenericAbuseReporting.BeduiV2.Components.Eyebrow)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local PreviewBox = require(GenericAbuseReporting.BeduiV2.Components.PreviewBox)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local useLayoutSlots = LayoutSlots.useLayoutSlots

return React.memo(function(tbl1) -- name: ReviewNode
    local translateIntoString = useArTranslation().translateIntoString

    local var1 = useLayoutSlots()
    local layout = var1.Layout
    local title = var1.Title

    local body = React.createElement(View, { tag = "col gap-large size-full-0 auto-y" }, {
        TitleContainer = React.createElement(View, {
            tag = "col gap-medium size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Eyebrow = tbl1.eyebrow and React.createElement(Eyebrow, { eyebrow = tbl1.eyebrow, layoutOrder = 1 }),
            Title = React.createElement(title, { input = tbl1.title, subtitle = tbl1.subtitle, layoutOrder = 2 })
        }),
        Preview = tbl1.preview and React.createElement(PreviewBox, { preview = tbl1.preview, layoutOrder = 2 }),
        DetailsContainer = React.createElement(
            View,
            { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = 3 },
            Dash.map(tbl1.details, function(arg1)
                return React.createElement(View, { tag = "col gap-xsmall size-full-0 auto-y" }, {
                    Heading = React.createElement(TextWithTranslation, {
                        input = arg1.heading,
                        fontStyle = {
                            Font = Enum.Font.BuilderSansBold
                        },
                        tag = "size-full-0 auto-y text-body-medium",
                        layoutOrder = 1
                    }),
                    Text = React.createElement(
                        TextWithTranslation,
                        {
                            input = arg1.text,
                            tag = "size-full-0 auto-y text-body-medium",
                            layoutOrder = 2
                        }
                    )
                })
            end)
        ),
        Footer = if tbl1.footerItems then React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 4 }) else nil
    })

    local actions = if tbl1.onNext then React.createElement(Button, {
        text = translateIntoString(tbl1.nextButtonText),
        variant = ButtonVariant.Emphasis,
        fillBehavior = Foundation.Enums.FillBehavior.Fill,
        isLoading = tbl1.isSubmitting,
        isDisabled = tbl1.isSubmitting,
        onActivated = tbl1.onNext
    }) else nil
    return React.createElement(layout, { body = body, actions = actions })
end)

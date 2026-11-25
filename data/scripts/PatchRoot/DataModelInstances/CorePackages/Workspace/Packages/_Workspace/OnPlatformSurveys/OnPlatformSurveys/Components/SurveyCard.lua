-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local View = Foundation.View

local _surveyPhaseSlots = require(OnPlatformSurveys.Components.surveyPhaseSlots)

return React.memo(function(tbl1) -- name: SurveyCard
    local slots = tbl1.slots
    local primaryAction = slots.primaryAction

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col gap-medium size-full-0 auto-y padding-large stroke-standard stroke-default radius-medium bg-surface-100"
    }
    local tbl3 = {
        Header = React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Leading = if slots.headerTitle then React.createElement(FoundationText, {
                Text = slots.headerTitle,
                tag = "fill auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            }) else React.createElement(View, { tag = "fill auto-y", LayoutOrder = 1 }),
            DismissButton = React.createElement(IconButton, {
                icon = IconName.X,
                variant = ButtonVariant.Utility,
                size = ButtonSize.Small,
                isCircular = true,
                onActivated = tbl1.onDismiss,
                LayoutOrder = 2
            })
        }),
        Body = React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = 2 }, slots.body),
        Actions = primaryAction
            and React.createElement(View, { tag = "row size-full-0 auto-y", LayoutOrder = 3 }, {
                PrimaryButton = React.createElement(Button, {
                    text = primaryAction.text,
                    variant = primaryAction.variant,
                    fillBehavior = FillBehavior.Fill,
                    isLoading = primaryAction.isLoading,
                    isDisabled = primaryAction.isDisabled,
                    onActivated = primaryAction.onActivated
                })
            })
            or nil
    }
    return createElement(var1, tbl2, tbl3)
end)

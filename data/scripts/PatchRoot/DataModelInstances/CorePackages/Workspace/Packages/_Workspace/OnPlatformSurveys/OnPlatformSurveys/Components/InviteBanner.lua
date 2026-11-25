-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)
local useLocalization = require(OnPlatformSurveysParent.Localization).Hooks.useLocalization

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View

local InlineSurveyLocalizationKeys = require(OnPlatformSurveys.Constants.InlineSurveyLocalizationKeys)

return React.memo(function(tbl1) -- name: InviteBanner
    local var1 = useLocalization({ title = InlineSurveyLocalizationKeys.inviteTitle, body = InlineSurveyLocalizationKeys.inviteBody })

    return React.createElement(View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium bg-surface-100",
        onActivated = tbl1.onAccept,
        testId = "InlineSurveyInviteBanner"
    }, {
        Copy = React.createElement(View, { tag = "col fill gap-xsmall auto-y", LayoutOrder = 1 }, {
            Title = React.createElement(FoundationText, {
                Text = var1.title,
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            }),
            Body = React.createElement(FoundationText, {
                Text = var1.body,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                LayoutOrder = 2
            })
        }),
        Chevron = React.createElement(Icon, { name = IconName.ChevronLargeRight, size = IconSize.Medium, LayoutOrder = 2 })
    })
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local React = require(InterventionSharedParent.React)

local InlineAppealLink = require(InterventionShared.Components.genericComponents.InlineAppealLink)

local Foundation = require(InterventionSharedParent.Foundation)
local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FoundationText = Foundation.Text
local View = Foundation.View

return React.memo(function(tbl1) -- name: InterventionDialogFooter
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col no-flex gap-medium size-full-0 auto-y",
        testId = "intervention-dialog-footer",
        LayoutOrder = 3
    }

    local tbl3 = {
        AppealLink = tbl1.isAppealable and React.createElement(InlineAppealLink, { onActivated = tbl1.onAppealActivated, LayoutOrder = 1 }),
        Cta = React.createElement(Button, {
            variant = ButtonVariant.Emphasis,
            size = ButtonSize.Medium,
            text = tbl1.ctaText,
            onActivated = tbl1.onCtaActivated,
            width = UDim.new(1, 0),
            testId = "intervention-dialog-footer-cta",
            LayoutOrder = 2
        }),
        DsaMessage = 0
    }

    local dsaMessage = tbl1.dsaMessage

    if dsaMessage then
        if tbl1.dsaMessage == "" then
            dsaMessage = false
        else
            dsaMessage = React.createElement(FoundationText, {
                Text = tbl1.dsaMessage,
                tag = "auto-xy text-caption-small text-wrap text-align-x-left content-default",
                testId = "intervention-dialog-footer-dsa-message",
                LayoutOrder = 3
            })
        end
    end

    tbl3.DsaMessage = dsaMessage
    return createElement(var1, tbl2, tbl3)
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Coachmark = Foundation.Coachmark
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

return React.memo(React.forwardRef(function(tbl1, ref) -- name: AbuseReportTooltip
    local translateIntoString = useArTranslation().translateIntoString

    local onActivated = React.useCallback(function()
        tbl1.onClose()
    end, { tbl1.onClose })

    return React.createElement(Coachmark, {
        title = translateIntoString(tbl1.tooltipTitle),
        text = translateIntoString(tbl1.tooltipText),
        isOpen = tbl1.isOpen,
        align = PopoverAlign.End,
        side = PopoverSide.Bottom,
        onClose = tbl1.onClose,
        actions = tbl1.buttonLabel
            and {{
                text = translateIntoString(tbl1.buttonLabel),
                onActivated = onActivated,
                variant = ButtonVariant.Emphasis
            }}
            or nil,
        LayoutOrder = tbl1.layoutOrder,
        ref = ref
    }, tbl1.children)
end))

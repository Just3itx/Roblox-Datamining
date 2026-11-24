-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)

return React.memo(function(tbl1) -- name: Eyebrow
    if not tbl1.eyebrow then
        return nil
    end

    return React.createElement(
        TextWithTranslation,
        {
            input = tbl1.eyebrow,
            tag = "size-full-0 auto-y text-label-large",
            LayoutOrder = tbl1.layoutOrder
        }
    )
end)

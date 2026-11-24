-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant

return React.memo(function(tbl1) -- name: RecentlyLeftBadge
    local translateIntoString = useArTranslation().translateIntoString

    return React.createElement(
        Badge,
        {
            text = translateIntoString(tbl1.text),
            variant = BadgeVariant.Neutral,
            LayoutOrder = tbl1.layoutOrder
        }
    )
end)

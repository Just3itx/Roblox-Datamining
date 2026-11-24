-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

return React.memo(function(tbl1) -- name: Subtitle
    local translateIntoString = useArTranslation().translateIntoString

    local var1 = React.useMemo(function()
        if tbl1.subtitle and tbl1.subtitle.leading then
            local var1 = IconName[tbl1.subtitle.leading]
            if var1 then
                return getIconRichText(var1)
            end
        end
        return ""
    end, { tbl1.subtitle })

    if not tbl1.subtitle then
        return nil
    end

    return React.createElement(FoundationText, {
        Text = `{var1} {translateIntoString(tbl1.subtitle.text)}`,
        RichText = true,
        tag = "auto-xy text-body-medium content-default",
        LayoutOrder = tbl1.layoutOrder
    })
end)

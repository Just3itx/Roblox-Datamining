-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization

local Empty = Foundation.Empty
local Sheet = Foundation.Sheet
local View = Foundation.View

return React.memo(function() -- name: DynamicReportV2Error
    local var1 = useLocalization({ errorText = "Feature.AbuseReportDialog.Label.GeneralError" })

    return React.createElement(React.Fragment, nil, {
        Content = React.createElement(Sheet.Content, {}, {
            Center = React.createElement(View, { tag = "align-x-center align-y-center size-full" }, {
                Empty = React.createElement(Empty, { icon = { name = "icons/status/oof_xlarge", size = "XLarge" }, text = var1.errorText })
            })
        })
    })
end)

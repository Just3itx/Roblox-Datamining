-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DsaIllegalContentReportingParent = script:FindFirstAncestor("DsaIllegalContentReporting").Parent

local Foundation = require(DsaIllegalContentReportingParent.Foundation)
local default = require(DsaIllegalContentReportingParent.LinkingProtocol).LinkingProtocol.default
local Localization = require(DsaIllegalContentReportingParent.Localization)
local React = require(DsaIllegalContentReportingParent.React)

local ControlState = Foundation.Enums.ControlState
local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local useLocalization = Localization.Hooks.useLocalization
local View = Foundation.View

local str1 = game:DefineFastString("TakeItDownReportLink", "https://www.roblox.com/non-consensual-intimate-imagery-removal-request")

return React.memo(function(tbl1) -- name: TakeItDownReportLink
    local var1, var2 = React.useState(false)

    local str2 = `<b>{useLocalization({ TakeItDownReportLinkText = "Feature.ReportAbuse.Label.TakeItDownCopy" }).TakeItDownReportLinkText}</b> {getIconRichText(IconName.ArrowUpRightFromSquare)}`

    local onActivated = React.useCallback(function()
        default:openURL(str1)
    end, {})

    local onStateChanged = React.useCallback(function(hover)
        var2(hover == ControlState.Hover)
    end, {})

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }
    local createElement2 = React.createElement
    local var6 = FoundationText
    local tbl3 = {
        Text = 0,
        RichText = true,
        onActivated = 0,
        onStateChanged = 0,
        tag = "auto-xy radius-small padding-xsmall text-wrap text-body-small"
    }

    if var1 then
        str2 = `<u>{str2}</u>`
    end

    tbl3.Text = str2

    tbl3.onActivated = onActivated
    tbl3.onStateChanged = onStateChanged
    return createElement(var5, tbl2, createElement2(var6, tbl3))
end)

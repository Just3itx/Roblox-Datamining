-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:06:29Z
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

local str1 = game:DefineFastString("GenericReportLink", "https://www.roblox.com/illegal-content-reporting")
local bool1 = game:DefineFastFlag("ImproveIllegalContentReportingLinkLook", false)

function GenericReportLink()
    local var1 = nil
    local var2 = nil
    if bool1 then
        local var3
        var1, var3 = React.useState(false)
        var2 = var3
    end

    local var3 = useLocalization({ GenericReportLinkText = "Feature.ReportAbuse.Label.GenericReportIllegalContentMessage" })
    local var4 = if bool1 then `<b>{var3.GenericReportLinkText}</b> {getIconRichText(IconName.ArrowUpRightFromSquare)}` else nil

    local onActivated = React.useCallback(function()
        default:openURL(str1)
    end, {})

    local var6 = if bool1 then React.useCallback(function(hover)
        var2(hover == ControlState.Hover)
    end, {}) else nil

    local createElement = React.createElement
    local var7 = View
    local tbl1 = { tag = "auto-xy col gap-small" }

    local createElement2 = React.createElement
    local var8 = FoundationText
    local tbl2 = {
        Text = 0,
        RichText = true,
        onActivated = 0,
        onStateChanged = 0,
        tag = "auto-xy radius-small padding-xsmall text-wrap text-body-small"
    }

    if bool1 then
        if var1 then
            var4 = `<u>{var4}</u>`
        end
    else
        var4 = `<b>{var3.GenericReportLinkText}</b>`
    end

    tbl2.Text = var4

    tbl2.onActivated = onActivated
    if not bool1 then
        var6 = nil
    end

    tbl2.onStateChanged = var6
    return createElement(var7, tbl1, { createElement2(var8, tbl2) })
end

return React.memo(GenericReportLink)

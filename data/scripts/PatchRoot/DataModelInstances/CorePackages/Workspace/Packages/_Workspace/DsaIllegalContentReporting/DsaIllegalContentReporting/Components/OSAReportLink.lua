-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DsaIllegalContentReportingParent = script:FindFirstAncestor("DsaIllegalContentReporting").Parent
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")

local Foundation = require(DsaIllegalContentReportingParent.Foundation)
local React = require(DsaIllegalContentReportingParent.React)
local Localization = require(DsaIllegalContentReportingParent.Localization)
local Responsive = require(DsaIllegalContentReportingParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput

local ControlState = Foundation.Enums.ControlState
local FoundationText = Foundation.Text
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

return React.memo(function() -- name: OSAReportLink
    local var1 = useTokens()
    local backgroundStyle, var3 = React.useState(nil)
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var4 = Responsive.useIsSpatial()
    local var5 = bool1 or var4

    local var6 = useLocalization({
        HelpPageTitle = "Feature.ReportAbuse.DSAIllegal.ReportPageTitle",
        OSACopy1 = "Feature.ReportAbuse.Message.OSACopy1",
        OSACopy2 = "Feature.ReportAbuse.Message.OSACopy2",
        OSACopy3 = "Feature.ReportAbuse.Message.OSACopy3",
        OSACopy4 = "Feature.ReportAbuse.Message.OSACopy4",
        OSACopyReadOnly = "Feature.ReportAbuse.Message.OSACopyReadOnly"
    })

    local var7 = React.useCallback(function()
        local str1 = HttpService:JSONEncode({
            title = var6.HelpPageTitle,
            presentationStyle = nil,
            visible = true,
            url = "https://www.roblox.com/illegal-content-reporting"
        })

        GuiService:BroadcastNotification(str1, 20)
    end, {})

    local var8 = React.useCallback(function(arg1)
        if arg1 == ControlState.Hover then
            var3(var1.Color.State.Hover)
        elseif arg1 == ControlState.Pressed then
            var3(var1.Color.State.Press)
        else
            var3(nil)
        end
    end, {})

    local createElement = React.createElement
    local var9 = View
    local tbl1 = { tag = "size-full col gap-small" }

    local tbl2 = { OSALink = 0 }
    local createElement2 = React.createElement
    local var10 = FoundationText
    local tbl3 = {
        Text = if var5 then `<b>{var6.OSACopyReadOnly}</b>` else `<b>{var6.OSACopy4}</b>`,
        RichText = true,
        backgroundStyle = backgroundStyle,
        fontStyle = var1.Typography.BodySmall,
        textStyle = var1.Color.Content.Emphasis,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        onActivated = 0,
        onStateChanged = 0,
        tag = "auto-xy radius-small padding-xsmall",
        LayoutOrder = 2
    }

    if var5 then
        var7 = nil
    end

    tbl3.onActivated = var7
    if var5 then
        var8 = nil
    end

    tbl3.onStateChanged = var8
    tbl2.OSALink = createElement2(var10, tbl3)
    return createElement(var9, tbl1, tbl2)
end)

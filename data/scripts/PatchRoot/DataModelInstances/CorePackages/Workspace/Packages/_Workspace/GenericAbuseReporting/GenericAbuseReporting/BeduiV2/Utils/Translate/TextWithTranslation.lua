-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local ControlState = Foundation.Enums.ControlState
local FoundationText = Foundation.Text

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local useOpenLink = require(GenericAbuseReporting.BeduiV2.Hooks.useOpenLink)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local TelemetryEventType = analyticsService.TelemetryEventType
local useOptionalAbuseReportAnalytics = AbuseReportAnalyticsContext.useOptionalAbuseReportAnalytics

local FFlagAbuseReportTranslateColorWrapper = require(GenericAbuseReporting.Flags.FFlagAbuseReportTranslateColorWrapper)
local bool1 = game:DefineFastFlag("AddFontStyleToTextWithTranslation", false)

return React.memo(function(tbl1) -- name: TextWithTranslation
    local translateIntoString = useArTranslation().translateIntoString
    local translateIntoRichTextString = useArTranslation().translateIntoRichTextString
    local var1 = useOpenLink()
    local var2, var3 = React.useState(false)

    local var4 = useOptionalAbuseReportAnalytics()
    local sendEvent = if var4 then var4.sendEvent else nil
    local var5 = FFlagAbuseReportTranslateColorWrapper and var2
    local var6, var7 = React.useMemo(function()
        return translateIntoRichTextString(tbl1.input, var5)
    end, { tbl1.input, translateIntoRichTextString, var5 })

    local var8 = React.useCallback(function()
        local href = if var7 == nil then nil else var7.href

        if sendEvent and href then
            sendEvent({
                sub_event_type = TelemetryEventType.LinkOpened,
                link_detail = {
                    href = href,
                    link_id = tbl1.linkId,
                    source = tbl1.linkSource
                }
            })
        end
        var1(translateIntoString(tbl1.input), href)
    end, {
        var7,
        tbl1.input,
        var1,
        translateIntoString,
        sendEvent,
        tbl1.linkId,
        tbl1.linkSource
    })

    local var9 = React.useCallback(function(hover)
        if hover == ControlState.Hover then
            var3(true)
            return
        end
        var3(false)
    end, {})

    local createElement = React.createElement
    local var10 = FoundationText
    local tbl2 = {
        Text = 0,
        RichText = true,
        TextWrapped = true,
        TextXAlignment = 0,
        fontStyle = 0,
        tag = 0,
        LayoutOrder = 0,
        onActivated = 0,
        onStateChanged = 0
    }

    if var2 and not FFlagAbuseReportTranslateColorWrapper then
        var6 = `<u>{var6}</u>`
    end

    tbl2.Text = var6

    tbl2.TextXAlignment = Enum.TextXAlignment.Left
    tbl2.fontStyle = if bool1 then tbl1.fontStyle else nil
    tbl2.tag = tbl1.tag
    tbl2.LayoutOrder = tbl1.layoutOrder
    if var7 == nil then
        var8 = nil
    end

    tbl2.onActivated = var8
    if var7 == nil then
        var9 = nil
    end

    tbl2.onStateChanged = var9
    return createElement(var10, tbl2)
end)

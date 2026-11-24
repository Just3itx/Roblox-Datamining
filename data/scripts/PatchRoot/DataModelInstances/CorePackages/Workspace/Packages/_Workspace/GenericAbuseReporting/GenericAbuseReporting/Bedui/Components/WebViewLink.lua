-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")

local AppLinking = require(GenericAbuseReportingParent.RoactServiceTags).AppLinking
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local useAppPolicy = require(GenericAbuseReportingParent.UniversalAppPolicy).useAppPolicy
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local ControlState = Foundation.Enums.ControlState
local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local View = Foundation.View

local NotificationType = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes).NotificationType

return React.memo(function(tbl1)
    local var1 = useRoactService(AppLinking)
    local var2 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local onActivated = React.useCallback(function()
        if not var2 then
            var1:openURL(tbl1.component.link.url)
            return
        end
        local success, result = pcall(function(): string
            return HttpService:JSONEncode(
                {
                    title = tbl1.component.link.label,
                    presentationStyle = nil,
                    visible = true,
                    url = tbl1.component.link.url
                }
            )
        end)

        if not success then
            warn("Failed to encode notification data for bedui webview link")
            return
        end
        GuiService:BroadcastNotification(result, NotificationType.OpenCustomWebView)
    end, { tbl1.component.link.label, tbl1.component.link.url })

    local var4, var5 = React.useBinding(false)

    local var6 = React.useMemo(function()
        return tbl1.component.link.linkButtonLabel .. ` {getIconRichText(IconName.ArrowUpRightFromSquare)}`
    end, { tbl1.component.link.linkButtonLabel })

    local onStateChanged = React.useCallback(function(hover)
        if hover == ControlState.Hover then
            var5(true)
            return
        end
        var5(false)
    end, {})

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder
        },
        React.createElement(FoundationText, {
            Text = var4:map(function(arg1)
                if arg1 then
                    return `<u>{var6}</u>`
                end

                return var6
            end),
            RichText = true,
            onActivated = onActivated,
            onStateChanged = onStateChanged,
            tag = "auto-xy padding-xsmall text-body-small text-wrap text-align-x-left radius-medium"
        })
    )
end)

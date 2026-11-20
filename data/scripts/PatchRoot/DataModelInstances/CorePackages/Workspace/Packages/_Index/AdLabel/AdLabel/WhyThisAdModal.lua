-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WebViewService = game:GetService("WebViewService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local Localization = require(scriptParentParent.Localization)
local Dialog = Foundation.Dialog
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local AdDisclosureTelemetry = require(scriptParent.AdDisclosureTelemetry)

local FStringLuaAppAdPreferencesUrl = require(scriptParentParent.SharedFlags).FStringLuaAppAdPreferencesUrl
local GetFFlagEnableUnifiedWebViews = require(scriptParentParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local useLocalization = Localization.Hooks.useLocalization

return React.memo(function(tbl1) -- name: WhyThisAdModal
    local var1 = useLocalization(
        {
            whyThisAd = "Feature.GameDetails.Label.WhyThisAd",
            adPreferences = "Feature.GameDetails.Message.AdPreferences"
        }
    )

    local var2 = useTokens()

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        onClose = tbl1.onClose,
        hasBackdrop = true,
        disablePortal = false
    }

    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.whyThisAd }),
        DialogContent = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = {}

    local tbl5 = {
        ContentView = React.createElement(View, { tag = "col auto-xy gap-small" }, {
            DialogText = React.createElement(Dialog.Text, { Text = tbl1.adDisclosureBody, LayoutOrder = 1 }),
            AdPreferences = if tbl1.showAdPreferencesUrl then React.createElement(FoundationText, {
                Text = var1.adPreferences,
                textStyle = var2.Color.Content.Link,
                fontStyle = var2.Typography.BodyMedium,
                tag = "auto-xy",
                onActivated = function()
                    AdDisclosureTelemetry.logAdPreferencesLinkClicked()

                    if GetFFlagEnableUnifiedWebViews() then
                        local connection = nil
                        connection = WebViewService.OnWindowClosed:Connect(function()
                            WebViewService:CloseWindow()
                            if connection then
                                connection:Disconnect()
                                connection = nil
                            end
                        end)

                        WebViewService:OpenWindow(FStringLuaAppAdPreferencesUrl, var1.adPreferences, true)
                        return
                    end

                    local command = HttpService:JSONEncode({
                        command = "open",
                        url = FStringLuaAppAdPreferencesUrl,
                        title = var1.adPreferences,
                        visible = true,
                        isGenericWebview = true
                    })

                    BrowserService:SendCommand(command)
                end,
                LayoutOrder = 2
            }) else nil
        })
    }

    tbl3.DialogContent = createElement2(content, tbl4, tbl5)
    return createElement(root, tbl2, tbl3)
end)

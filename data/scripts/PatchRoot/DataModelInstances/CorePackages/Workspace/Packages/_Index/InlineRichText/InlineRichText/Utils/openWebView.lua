-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichTextParent = script:FindFirstAncestor("InlineRichText").Parent

local WebViewService = game:GetService("WebViewService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")

local GetFFlagEnableUnifiedWebViews = require(InlineRichTextParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local function openWebView(url: string)
    if GetFFlagEnableUnifiedWebViews() then
        local connection = nil

        connection = WebViewService.OnWindowClosed:Connect(function()
            WebViewService:CloseWindow()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end)
        WebViewService:OpenWindow(url, "", true)
        return
    end
    BrowserService:SendCommand(
        HttpService:JSONEncode(
            {
                command = "open",
                url = url,
                title = "",
                visible = true,
                isGenericWebview = true,
                enableOverlayReplacement = true
            }
        )
    )
end

return openWebView

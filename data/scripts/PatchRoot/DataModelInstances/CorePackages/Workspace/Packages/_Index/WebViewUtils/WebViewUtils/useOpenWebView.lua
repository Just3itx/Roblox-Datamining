-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WebViewUtilsParent = script:FindFirstAncestor("WebViewUtils").Parent

local React = require(WebViewUtilsParent.React)
local useEffect = React.useEffect
local useCallback = React.useCallback
local useRef = React.useRef

local SharedFlags = require(WebViewUtilsParent.SharedFlags)
local GetFFlagEnableUnifiedWebViews = SharedFlags.GetFFlagEnableUnifiedWebViews
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab

local FFlagUseWebViewSessionInOpenWebView = require(script.Parent.Flags.FFlagUseWebViewSessionInOpenWebView)
local openWebViewSession = require(script.Parent.openWebViewSession)

local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local WebViewService = game:GetService("WebViewService")

local function useOpenWebView()
    local var1 = useRef(nil)
    local var2 = useRef(nil)

    local var3 = useCallback(function()
        if var1.current then
            var1.current:Disconnect()
            var1.current = nil
        end
        if var2.current then
            var2.current()
            var2.current = nil
        end
    end, { var1, var2 })

    local var4 = useCallback(function(url: string, title: string, callback: ((...any) -> (...any))?)
        if FFlagUseWebViewSessionInOpenWebView then
            var3()

            local _, current = openWebViewSession(url, title, if FFlagAppNavMyStatsTab then callback else nil)
            var2.current = current
            return
        end

        if GetFFlagEnableUnifiedWebViews() then
            var3()

            var1.current = WebViewService.OnWindowClosed:Connect(function()
                WebViewService:CloseWindow()
                var3()
                if FFlagAppNavMyStatsTab and callback then
                    callback()
                end
            end)

            WebViewService:OpenWindow(url, title, true)
        else
            BrowserService:SendCommand(
                HttpService:JSONEncode(
                    {
                        command = "open",
                        url = url,
                        title = title,
                        visible = true,
                        isGenericWebview = true,
                        enableOverlayReplacement = true
                    }
                )
            )
        end
    end, { var3 })

    useEffect(function()
        return function()
            var3()
        end
    end, { var3 })

    return var4
end

return useOpenWebView

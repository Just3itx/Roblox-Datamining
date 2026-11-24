-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local React = require(InterventionSharedParent.React)
local useEffect = React.useEffect
local useCallback = React.useCallback
local useRef = React.useRef

local GetFFlagEnableUnifiedWebViews = require(InterventionSharedParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local WebViewService = game:GetService("WebViewService")

local function useWebView(url: string, title: string)
    local var1 = useRef(nil)

    local var2 = useCallback(function()
        if var1.current then
            var1.current:Disconnect()
            var1.current = nil
        end
    end, { var1 })

    local var3 = useCallback(function()
        if GetFFlagEnableUnifiedWebViews() then
            var2()

            var1.current = WebViewService.OnWindowClosed:Connect(function()
                WebViewService:CloseWindow()
                var2()
            end)

            WebViewService:OpenWindow(url, title, true)
            return
        end
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
    end, { url, title, var2 })

    useEffect(function()
        return function()
            var2()
        end
    end, { var2 })

    return var3
end

return useWebView

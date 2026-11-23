-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView

local function useOpenWebViewWithResumeRefresh(str1: string, str2: string, callback: ((...any) -> (...any))?, tbl1)
    local var1 = useOpenWebView()
    local var2 = React.useRef(false)
    local var3 = React.useRef(false)
    local var4 = React.useCallback(function()
        if not var2.current then
            return
        end
        var2.current = false
        if callback ~= nil then
            callback()
        end
    end, { callback })
    local var5 = React.useCallback(function()
        if not var3.current then
            return
        end
        var3.current = false
        var2.current = false
        if callback ~= nil then
            callback()
        end
    end, { callback })

    React.useEffect(function()
        if callback == nil then
            return function() end
        end
        local connection = (tbl1 or AppLifecycleObserverService).OnUnhide:Connect(var4)
        return function()
            var2.current = false
            var3.current = false
            connection:Disconnect()
        end
    end, { tbl1, var4, callback })

    return React.useCallback(function()
        var2.current = callback ~= nil
        var3.current = callback ~= nil
        var1(str1, str2, if callback == nil then nil else var5)
    end, {
        var5,
        callback,
        var1,
        str2,
        str1
    })
end
return useOpenWebViewWithResumeRefresh

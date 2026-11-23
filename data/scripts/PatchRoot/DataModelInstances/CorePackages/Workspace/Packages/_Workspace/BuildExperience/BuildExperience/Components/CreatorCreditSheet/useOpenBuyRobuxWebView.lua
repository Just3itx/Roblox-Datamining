-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local ContentProvider = game:GetService("ContentProvider")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView

local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local function getPurchaseRobuxUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
    return `{string.gsub(var1, "http:", "https:")}upgrades/robux?ctx=build-uapp`
end

local function useOpenBuyRobuxWebView<T>(callback: ((...any) -> (...any))?, tbl1)
    local title = useLocalization({ title = LocalizationStrings.CREATOR_CREDIT_BUY_ROBUX_SHEET_TITLE }).title
    local var1 = useOpenWebView()
    local var2 = React.useRef(false)
    local var3 = React.useCallback(function()
        if not var2.current then
            return
        end
        var2.current = false
        if callback then
            callback()
        end
    end, { callback })

    React.useEffect(function()
        if callback == nil then
            return function() end
        end
        local connection = (tbl1 or AppLifecycleObserverService).OnUnhide:Connect(var3)
        return function()
            var2.current = false
            connection:Disconnect()
        end
    end, { tbl1, var3, callback })

    return React.useCallback(function()
        var2.current = callback ~= nil
        var1(getPurchaseRobuxUrl(), title, if callback == nil then nil else var3)
    end, {
        var3,
        callback,
        var1,
        title
    })
end
return useOpenBuyRobuxWebView

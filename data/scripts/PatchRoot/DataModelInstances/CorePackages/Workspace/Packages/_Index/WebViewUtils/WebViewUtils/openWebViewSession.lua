-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WebViewUtilsParent = script:FindFirstAncestor("WebViewUtils").Parent

local GetFFlagEnableUnifiedWebViews = require(WebViewUtilsParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local WebViewService = game:GetService("WebViewService")

local function openUnified(url: string, title: string, callback: ((...any) -> (...any))?)
    local connection = nil
    local bool1 = false

    local function stopListening() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    local function close() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        bool1 = true
        stopListening()
        WebViewService:CloseWindow()
    end

    connection = WebViewService.OnWindowClosed:Connect(function()
        close()

        if callback then
            callback()
        end
    end)

    WebViewService:OpenWindow(url, title, true)

    return close, stopListening
end

local function openBrowser(url: string, title: string, callback: ((...any) -> (...any))?)
    local connection = nil
    local bool1 = false

    local function stopListening() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    if callback then
        connection = BrowserService.BrowserWindowClosed:Connect(function()
            bool1 = true
            stopListening()
            callback()
        end)
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

    local function close()
        if bool1 then
            return
        end
        bool1 = true
        stopListening()
        BrowserService:CloseBrowserWindow()
    end

    return close, stopListening
end

local function openWebViewSession(url: string, title: string, callback: ((...any) -> (...any))?)
    if GetFFlagEnableUnifiedWebViews() then
        return openUnified(url, title, callback)
    end

    return openBrowser(url, title, callback)
end

return openWebViewSession

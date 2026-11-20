-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParent = script.Parent.Parent

local GetFFlagEnableUnifiedWebViews = require(scriptParentParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local function createWebViewWindow(tbl1)
    local isOpen = false
    local onClosed = nil
    local connection = nil

    local function handleClosed() -- Luacid: Inlined by compiler; 3 call sites recovered
        if not isOpen then
            return
        end
        isOpen = false
        local var1 = onClosed
        onClosed = nil
        if var1 then
            var1()
        end
    end

    local function ensureConnected()
        if connection then
            return
        end

        if not tbl1.isUnifiedWebViewEnabled() then
            connection = tbl1.browserService.BrowserWindowClosed:Connect(handleClosed)
            return
        end

        connection = tbl1.webViewService.OnWindowClosed:Connect(function()
            if isOpen then
                tbl1.webViewService:CloseWindow()
            end

            handleClosed()
        end)
    end

    return {
        open = function(url: string, title: string, tbl2)
            ensureConnected()
            handleClosed()
            isOpen = true
            onClosed = tbl2 and tbl2.onClosed

            local windowType = tbl2 and tbl2.windowType
            if tbl1.isUnifiedWebViewEnabled() then
                if windowType == "Dialog" then
                    tbl1.webViewService:OpenWindow(url, title, true, nil, windowType)
                    return
                end
                tbl1.webViewService:OpenWindow(url, title, true)
                return
            end

            tbl1.browserService:SendCommand(
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
        end,
        close = function()
            if not isOpen then
                return
            end
            if tbl1.isUnifiedWebViewEnabled() then
                tbl1.webViewService:CloseWindow()
            else
                tbl1.browserService:CloseBrowserWindow()
            end

            handleClosed()
        end,
        isOpen = function()
            return isOpen
        end
    }
end

local var1 = nil

return {
    createWebViewWindow = createWebViewWindow,
    getDefault = function()
        var1 = var1
            or createWebViewWindow({
                webViewService = game:GetService("WebViewService"),
                browserService = game:GetService("BrowserService"),
                isUnifiedWebViewEnabled = GetFFlagEnableUnifiedWebViews
            })

        return var1
    end
}

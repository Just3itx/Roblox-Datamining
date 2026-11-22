-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local GetFFlagEnableUnifiedWebViews = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local WebViewService = game:GetService("WebViewService")

local module = ({})
module.__index = module

function module.new(tbl1)
    local tbl2 = {}

    if GetFFlagEnableUnifiedWebViews() then
        tbl2.webViewService = tbl1.webViewService or WebViewService
    end

    tbl2.title = tbl1.title
    tbl2.url = tbl1.url
    tbl2.closeCallbackConnection = nil

    local self = setmetatable(tbl2, module)

    self:setCloseCallback(tbl1.closeCallback or function() end)

    return self
end

function module:setCloseCallback(closeCallback)
    if not GetFFlagEnableUnifiedWebViews() then
        self.closeCallback = closeCallback

        return
    end

    function self.closeCallback()
        self:close()
        if closeCallback ~= nil then
            closeCallback()
        end
    end
end

function module.setOpenCallback(arg1, openCallback)
    arg1.openCallback = openCallback
end

function module:open()
    if self.openCallback ~= nil then
        self.openCallback()
    end

    if self.closeCallback ~= nil and GetFFlagEnableUnifiedWebViews() then
        self.closeCallbackConnection = self.webViewService.OnWindowClosed:Connect(self.closeCallback)
    end
    if self.closeCallback ~= nil and not GetFFlagEnableUnifiedWebViews() then
        self.closeCallbackConnection = BrowserService.BrowserWindowClosed:Connect(self.closeCallback)
    end

    if GetFFlagEnableUnifiedWebViews() then
        self.webViewService:OpenWindow(self.url, self.title, true)
        return
    end
    local command = HttpService:JSONEncode({
        command = "open",
        url = self.url,
        title = self.title,
        visible = true,
        isGenericWebview = true,
        enableOverlayReplacement = true
    })

    BrowserService:SendCommand(command)
end

function module:close()
    if GetFFlagEnableUnifiedWebViews() then
        self.webViewService:CloseWindow()
    end

    if self.closeCallbackConnection ~= nil then
        self.closeCallbackConnection:Disconnect()
    end
end

return module

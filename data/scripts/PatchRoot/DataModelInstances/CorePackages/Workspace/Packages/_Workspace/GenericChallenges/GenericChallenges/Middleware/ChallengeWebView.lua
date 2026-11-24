-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local ChallengeHeaders = require(script.Parent.ChallengeHeaders)
local BuildChallengeWebViewUrl = require(script.Parent.BuildChallengeWebViewUrl)
local _BuildHybridCallback = require(script.Parent.BuildHybridCallback)
local _ChallengeParameters = require(GenericChallenges.Types.ChallengeParameters)
local GenericType = require(GenericChallenges.Types.GenericType)
local GetFFlagEnableUnifiedWebViews = require(GenericChallenges.Parent.SharedFlags).GetFFlagEnableUnifiedWebViews
local FFlagHideChallengeWebViewsUntilDisplayed = require(script.Parent.Flags.FFlagHideChallengeWebViewsUntilDisplayed)
local FFlagReleaseTextBoxFocusOnChallengeOpen = require(script.Parent.Flags.FFlagReleaseTextBoxFocusOnChallengeOpen)

local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local WebViewService = if GetFFlagEnableUnifiedWebViews() then game:GetService("WebViewService") else nil
local engineFeature = game:GetEngineFeature("WebViewHasHideHeader")

local num1 = game:DefineFastInt("HiddenChallengeWebViewTimeoutSeconds", 3)

local module = ({})
module.__index = module

function module.new(tbl1)
    local tbl2 = {}

    if GetFFlagEnableUnifiedWebViews() then
        tbl2.webViewService = tbl1.webViewService or WebViewService
    else
        tbl2.browserService = tbl1.browserService or BrowserService
    end

    local challengeHeaders = if tbl1.rawResponseHeaders == nil then nil else ChallengeHeaders.new(tbl1.rawResponseHeaders)
    local typed = if challengeHeaders == nil then nil else challengeHeaders.challengeType.typed
    tbl2.opensVisible = not FFlagHideChallengeWebViewsUntilDisplayed
        or typed ~= GenericType.Captcha
            and typed ~= GenericType.CaptchaV2
            and typed ~= GenericType.ProofOfWork
            and typed ~= GenericType.Turnstile
        or false

    tbl2.visible = tbl2.opensVisible
    tbl2.isOpen = false
    tbl2.openGeneration = 0

    tbl2.challengeUrl = BuildChallengeWebViewUrl(challengeHeaders, tbl1.challengeType, tbl1.challengeParameters)

    tbl2.title = tbl1.title
    if tbl1.hybridCallback ~= nil then
        tbl2.hybridCallback = tbl1.hybridCallback
    end
    if tbl1.closeCallback ~= nil then
        tbl2.closeCallback = tbl1.closeCallback
    end
    if tbl1.openCallback ~= nil then
        tbl2.openCallback = tbl1.openCallback
    end

    tbl2.hybridCallbackConnection = nil

    tbl2.modal = false

    if tbl1.modal ~= nil then
        tbl2.modal = tbl1.modal
    end
    return (setmetatable(tbl2, module))
end

function module:setCloseCallback(closeCallback: (...any) -> (...any))
    if not GetFFlagEnableUnifiedWebViews() then
        self.closeCallback = closeCallback

        return
    end

    function self.closeCallback()
        self.webViewService:CloseWindow()
        closeCallback()
    end
end

function module:setOpenCallback(openCallback: (...any) -> (...any))
    self.openCallback = openCallback
end

function module:setHybridCallback(hybridCallback)
    self.hybridCallback = hybridCallback
end

local function openUnifiedWebView(webViewService, challengeUrl: string, title: string, isVisible: boolean)
    if not FFlagHideChallengeWebViewsUntilDisplayed or not engineFeature or isVisible then
        webViewService:OpenWindow(challengeUrl, title, isVisible)

        return
    end

    webViewService:OpenWindowV2(challengeUrl, { Title = title, IsVisible = isVisible })
end

local function releaseFocusedTextBox() -- Luacid: Inlined by compiler; 2 call sites recovered
    local textBox = UserInputService:GetFocusedTextBox()
    if textBox then
        textBox:ReleaseFocus()
    end
end

local function mutateUnifiedWebViewVisibility(webViewService, challengeUrl: string, title: string, visible: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    webViewService:MutateWindow(challengeUrl, title, visible, "")
end

function module:setVisible(visible: boolean)
    if self.visible == visible or not self.isOpen then
        return
    end

    self.visible = visible

    if FFlagReleaseTextBoxFocusOnChallengeOpen and visible then
        releaseFocusedTextBox()
    end

    if GetFFlagEnableUnifiedWebViews() then
        mutateUnifiedWebViewVisibility(self.webViewService, self.challengeUrl, self.title, visible)
        return
    end
    self.browserService:SendCommand(HttpService:JSONEncode({ command = "config", visible = visible }))
end

function module:open()
    assert(self.hybridCallback ~= nil, "hybrid callback has not been initialized")
    if self.openCallback ~= nil then
        self.openCallback()
    end

    if GetFFlagEnableUnifiedWebViews() then
        self.hybridCallbackConnection = self.webViewService.OnJavaScriptCall:Connect(self.hybridCallback)
    else
        self.hybridCallbackConnection = self.browserService.JavaScriptCallback:Connect(self.hybridCallback)
    end
    local closeCallback = self.closeCallback
    local var1 = not self.opensVisible and function()
        self.isOpen = false
        self.visible = self.opensVisible
        if self.closeCallback ~= nil then
            self.closeCallback()
        end
    end or closeCallback

    if var1 ~= nil then
        if GetFFlagEnableUnifiedWebViews() then
            self.closeCallbackConnection = self.webViewService.OnWindowClosed:Connect(var1)
        else
            self.closeCallbackConnection = self.browserService.BrowserWindowClosed:Connect(var1)
        end
    end
    assert(string.len(self.challengeUrl) > 0, "challenge url must have been constructed")
    assert(self.hybridCallbackConnection ~= nil, "hybrid callback connection should be initialized")

    if FFlagReleaseTextBoxFocusOnChallengeOpen and self.visible then
        releaseFocusedTextBox()
    end

    self.isOpen = true
    self.openGeneration += 1
    if GetFFlagEnableUnifiedWebViews() then
        openUnifiedWebView(self.webViewService, self.challengeUrl, self.title, self.visible)
    else
        local str1 = HttpService:JSONEncode({
            command = "open",
            url = self.challengeUrl,
            title = self.title,
            visible = self.visible,
            modal = self.modal,
            isGenericWebview = true,
            enableOverlayReplacement = true
        })

        self.browserService:SendCommand(str1)
    end

    if self.visible then
        return
    end

    local num2 = num1
    local num3 = if num2 <= 0 then 3 else num2

    local openGeneration = self.openGeneration
    task.delay(num3, function()
        if self.isOpen and self.openGeneration == openGeneration and not self.visible then
            self:setVisible(true)
        end
    end)
end

function module:close()
    self.isOpen = false
    self.visible = self.opensVisible
    if self.hybridCallbackConnection ~= nil then
        self.hybridCallbackConnection:Disconnect()
    end

    if GetFFlagEnableUnifiedWebViews() then
        self.webViewService:CloseWindow()
    else
        self.browserService:CloseBrowserWindow()
    end

    if self.closeCallbackConnection ~= nil then
        self.closeCallbackConnection:Disconnect()
    end
end

return module

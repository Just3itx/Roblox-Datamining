-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local ArgCheck = require(scriptParentParent.ArgCheck)
local isTenFootInterface = require(scriptParentParent.AppCommonLib).isTenFootInterface

local AccountSettingsPage = require(scriptParent.AccountSettingsPage)
local WebViewWindow = require(scriptParent.WebViewWindow)

local function supportsWebViews()
    return require(scriptParentParent.UniversalAppPolicy).getAppFeaturePolicies().getWebViewSupport()
end

local function isInApp(): boolean
    return game.GameId == 0
end

local function getPresentation(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local internal = tbl1 and tbl1.internal
    if internal and internal.presentation then
        return internal.presentation
    end
    local var1 = tbl1 and tbl1.isConsole or isTenFootInterface
    local var2 = tbl1 and tbl1.supportsWebViews or supportsWebViews
    return if var1() or not var2() then "QrCode" else "Webview"
end

local function openAccountSettings(arg1, tbl1, tbl2)
    ArgCheck.isType(tbl1, "table", "openAccountSettings options")
    local tbl3 = type(tbl1) ~= "table" and {} or tbl1
    ArgCheck.isNonEmptyString(tbl3.surfaceKey, "options.surfaceKey")

    local onClosed = tbl3.onClosed

    if getPresentation(tbl2) == "QrCode" then
        (tbl2 and tbl2.showQrCode or require(scriptParent.QrCodePresenter).show)(arg1, onClosed)
        return
    end
    (tbl2 and tbl2.webViewWindow or WebViewWindow.getDefault()).open(
        AccountSettingsPage.getUrl(arg1),
        AccountSettingsPage.getTitle(arg1),
        {
            windowType = if (tbl2 and tbl2.isInApp or isInApp)() then "Fullscreen" else "Dialog",
            onClosed = onClosed
        }
    )
end

return openAccountSettings

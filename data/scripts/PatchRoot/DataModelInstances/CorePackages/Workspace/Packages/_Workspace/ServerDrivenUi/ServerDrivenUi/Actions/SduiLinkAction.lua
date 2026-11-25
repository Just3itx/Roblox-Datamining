-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder).UrlBuilder
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local getAppFeaturePolicies = require(ServerDrivenUiParent.UniversalAppPolicy).getAppFeaturePolicies
local DeepLinkSource = require(ServerDrivenUiParent.LinkingProtocol).Enums.DeepLinkSource

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiCounterName = SduiCoreSystem.SduiErrors.SduiCounterName

local openSduiWebLink = require(ServerDrivenUi.Actions.openSduiWebLink)

local FFlagSduiLinkActionSharedWebLink = require(ServerDrivenUiParent.SharedFlags).FFlagSduiLinkActionSharedWebLink

local function isWebViewSupported() -- Luacid: Inlined by compiler; 1 call site recovered
    return getAppFeaturePolicies().getWebViewSupport()
end

return function(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.Link,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local url = actionParams.url
    local titleKey = actionParams.titleKey
    if typeof(url) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.Link,
                message = `Invalid or missing url: {url}`,
                propName = "url"
            },
            arg2.appPage
        )
        return
    end

    if FFlagSduiLinkActionSharedWebLink then
        openSduiWebLink(arg2, url, titleKey, actionParams.onWebviewClose)
        return
    end

    local success, result = pcall(function()
        return UrlBuilder.fromString(if string.find(url, "/") == 1 then url:gsub("/", "www:", 1) else url)()
    end)

    local var1

    if success then
        var1 = result
    else
        var1 = url
        arg2.dependencies.logger.reportError(
            SduiErrorType.FailedtoParseUrl,
            {
                name = url,
                message = if typeof(result) ~= "string" then "Unknown reason" else result
            },
            arg2.appPage
        )
    end
    local linkingProtocol = arg2.dependencies.linkingProtocol
    local success2, result2 = pcall(function()
        linkingProtocol:isURLRegistered(var1):andThen(function(arg3)
            if arg3 then
                if linkingProtocol:isInternalDlicEnabled() then
                    local var2 = linkingProtocol:createInternalDlic(var1, DeepLinkSource.LuaInternal)
                    linkingProtocol:detectDeeplinkIntent(var2)
                    return
                end
                linkingProtocol:detectURL(var1)
                return
            end

            if not isWebViewSupported() then
                arg2.dependencies.logger.reportCounter(SduiCounterName.WebViewNotSupportedForLink, { name = var1 })
                return
            end

            local navigation = arg2.dependencies.getNavigation()
            local extraProps = { titleKey = titleKey }
            local onWebviewClose = actionParams.onWebviewClose
            if onWebviewClose then
                function extraProps.onClose()
                    onWebviewClose()
                end
            end
            navigation.navigate(AppPage.GenericWebPage, { detail = var1, extraProps = extraProps })
        end)
    end)

    if not success2 then
        arg2.dependencies.logger.reportError(
            SduiErrorType.FailedToOpenLink,
            {
                name = url,
                message = if typeof(result2) ~= "string" then "Unknown reason" else result2
            },
            arg2.appPage
        )
    end
end

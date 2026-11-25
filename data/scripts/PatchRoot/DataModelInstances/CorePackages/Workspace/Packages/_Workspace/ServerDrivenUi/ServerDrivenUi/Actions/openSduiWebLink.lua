-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder).UrlBuilder
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local getAppFeaturePolicies = require(ServerDrivenUiParent.UniversalAppPolicy).getAppFeaturePolicies
local DeepLinkSource = require(ServerDrivenUiParent.LinkingProtocol).Enums.DeepLinkSource

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiCounterName = SduiCoreSystem.SduiErrors.SduiCounterName

local function isWebViewSupported() -- Luacid: Inlined by compiler; 1 call site recovered
    return getAppFeaturePolicies().getWebViewSupport()
end

local function openSduiWebLink(arg1, name: string, titleKey: string?, callback: ((...any) -> (...any))?)
    local success, result = pcall(function()
        return UrlBuilder.fromString(if string.find(name, "/") == 1 then name:gsub("/", "www:", 1) else name)()
    end)

    local str2

    if success then
        str2 = result
    else
        str2 = name
        arg1.dependencies.logger.reportError(
            SduiErrorType.FailedtoParseUrl,
            {
                name = name,
                message = if typeof(result) ~= "string" then "Unknown reason" else result
            },
            arg1.appPage
        )
    end
    local linkingProtocol = arg1.dependencies.linkingProtocol
    local success2, result2 = pcall(function()
        linkingProtocol:isURLRegistered(str2):andThen(function(arg2)
            if arg2 then
                if linkingProtocol:isInternalDlicEnabled() then
                    local var1 = linkingProtocol:createInternalDlic(str2, DeepLinkSource.LuaInternal)
                    linkingProtocol:detectDeeplinkIntent(var1)
                    return
                end
                linkingProtocol:detectURL(str2)
                return
            end

            if not isWebViewSupported() then
                arg1.dependencies.logger.reportCounter(SduiCounterName.WebViewNotSupportedForLink, { name = str2 })
                return
            end

            local navigation = arg1.dependencies.getNavigation()
            local extraProps = { titleKey = titleKey }
            if callback then
                function extraProps.onClose()
                    callback()
                end
            end
            navigation.navigate(AppPage.GenericWebPage, { detail = str2, extraProps = extraProps })
        end)
    end)

    if not success2 then
        arg1.dependencies.logger.reportError(
            SduiErrorType.FailedToOpenLink,
            {
                name = name,
                message = if typeof(result2) ~= "string" then "Unknown reason" else result2
            },
            arg1.appPage
        )
    end
end
return openSduiWebLink

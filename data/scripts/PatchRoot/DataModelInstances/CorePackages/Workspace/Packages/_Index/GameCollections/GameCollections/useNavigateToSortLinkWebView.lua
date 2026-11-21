-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local useNavigation = require(GameCollectionsParent.Navigation).useNavigation
local React = require(GameCollectionsParent.React)
local UrlBuilder = require(GameCollectionsParent.UrlBuilder).UrlBuilder
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local useAppPolicy = require(GameCollectionsParent.UniversalAppPolicy).useAppPolicy
local useRoactService = require(GameCollectionsParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(GameCollectionsParent.RoactServiceTags).AppEventIngestService
local t = require(GameCollectionsParent.t)
local mutedError = require(GameCollectionsParent.Loggers).mutedError
local LinkingProtocol = require(GameCollectionsParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default

local var1 = t.strictInterface({
    action = t.string,
    linkPath = t.string,
    webViewSupported = t.boolean,
    gameSetTypeId = t.optional(t.string),
    durationInSeconds = t.optional(t.number)
})

local function validateEventSchema(tbl1: {action: string, durationInSeconds: number?, gameSetTypeId: string?, linkPath: string, webViewSupported: any}) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var2, var3 = var1(tbl1)

    if not var2 then
        mutedError(var3)
    end
end

local function useNavigateToSortLinkWebView()
    local var2 = useNavigation()
    local webViewSupported = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)
    local var4 = useRoactService(AppEventIngestService)

    return React.useCallback(function(linkPath: string, str1: string, title: string, gameSetTypeId: string?, callback: ((...any) -> (...any))?)
        local function func1(action: string, durationInSeconds: number?) -- Luacid: Inlined by compiler; 3 call sites recovered
            local tbl1 = {
                linkPath = linkPath,
                action = action,
                gameSetTypeId = gameSetTypeId,
                webViewSupported = webViewSupported,
                durationInSeconds = durationInSeconds
            }
            validateEventSchema(tbl1)
            var4:sendEventDeferred(str1, "navigateToSortLink", tbl1)
        end

        func1("click", nil)

        if not webViewSupported then
            warn("WebView is not supported on this platform")

            return
        end

        local detail = UrlBuilder.fromString(if string.find(linkPath, "/") == 1 then linkPath:gsub("/", "www:", 1) else linkPath)()
        local startTime = os.clock()
        func1("open", nil)

        default:isURLRegistered(detail):andThen(function(arg1)
            if arg1 then
                if default:isInternalDlicEnabled() then
                    local var6 = default:createInternalDlic(detail, DeepLinkSource.LuaInternal)
                    default:detectDeeplinkIntent(var6)
                    return
                end
                default:detectURL(detail)
                return
            end

            var2.navigate(AppPage.GenericWebPage, {
                detail = detail,
                extraProps = {
                    title = title,
                    onClose = function()
                        func1("close", os.clock() - startTime)

                        if callback then
                            callback()
                        end
                    end
                }
            })
        end)
    end, { var2, webViewSupported })
end

return useNavigateToSortLinkWebView

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder)
local UniversalAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy)
local Navigation = require(ServerDrivenUiParent.Navigation)
local LinkingProtocol = require(ServerDrivenUiParent.LinkingProtocol)

local AppPage = RobloxAppEnums.AppPage
local UrlBuilder2 = UrlBuilder.UrlBuilder
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local useNavigation = Navigation.useNavigation
local default = LinkingProtocol.LinkingProtocol.default
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource

local FFlagEnableBlackbirdPageCloseCallback = require(ServerDrivenUiParent.SharedFlags).FFlagEnableBlackbirdPageCloseCallback

local getSubscriptionPurchaseCloseCallback = require(ServerDrivenUiParent.RobloxSubscriptionPurchaseApp).Utils.getSubscriptionPurchaseCloseCallback

local function useNavigateToServers(universeId: string)
    local var1 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)
    local var2 = useNavigation()

    local onClose = if FFlagEnableBlackbirdPageCloseCallback then React.useMemo(function()
        if getSubscriptionPurchaseCloseCallback then
            return (getSubscriptionPurchaseCloseCallback())
        end

        return nil
    end, {}) else nil

    return React.useCallback(function()
        local detail = UrlBuilder2.game.info.servers({ universeId = universeId })

        pcall(function()
            default:isURLRegistered(detail):andThen(function(arg1)
                if arg1 then
                    if default:isInternalDlicEnabled() then
                        local var5 = default:createInternalDlic(detail, DeepLinkSource.LuaInternal)
                        default:detectDeeplinkIntent(var5)
                        return
                    end
                    default:detectURL(detail)
                    return
                end

                if not var1 then
                    return
                end

                var2.navigate(
                    AppPage.GenericWebPage,
                    {
                        detail = detail,
                        extraProps = FFlagEnableBlackbirdPageCloseCallback and { onClose = onClose } or nil
                    }
                )
            end)
        end)
    end, {
        universeId,
        var1,
        var2,
        default,
        onClose
    })
end
return useNavigateToServers

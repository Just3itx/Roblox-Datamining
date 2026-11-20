-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local React = require(AppStartupParent.React)
local useNavigation = require(AppStartupParent.Navigation).useNavigation
local AppPage = require(AppStartupParent.RobloxAppEnums).AppPage
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")
local default = require(AppStartupParent.LoggingProtocol).default
local useProperty = require(AppStartupParent.GuiObjectUtils).useProperty
local isPlatformSingleSignOnSupported = require(AppStartupParent.AppCommonLib).isPlatformSingleSignOnSupported
local FFlagLuaAppSkipStartupRouteHop = require(AppStartupParent.SharedFlags).FFlagLuaAppSkipStartupRouteHop

return if FFlagLuaAppSkipStartupRouteHop and isPlatformSingleSignOnSupported(ThirdPartyUserService)
    or not FFlagLuaAppSkipStartupRouteHop
        and ThirdPartyUserService
        and ThirdPartyUserService.IsSingleSignOnSupported
        and ThirdPartyUserService:IsSingleSignOnSupported() then function(_)
    local var1 = useNavigation()
    local var2 = useProperty(ThirdPartyUserService, "HasActiveUser")

    React.useEffect(function()
        default:logEventOnce("platform_account_router_page_did_mount")
    end, {})

    React.useEffect(function()
        if var2 then
            default:logEventOnce("platform_account_router_page_did_continue")
            var1.replace(AppPage.SingleSignOnContainer)
        end
    end, { var2, var1 })
    return nil
end else function(_)
    local var1 = useNavigation()
    React.useEffect(function()
        default:logEventOnce("platform_account_router_page_did_mount")
        default:logEventOnce("platform_account_router_page_did_continue")
        var1.replace(AppPage.Startup)
    end, { var1 })
    return nil
end

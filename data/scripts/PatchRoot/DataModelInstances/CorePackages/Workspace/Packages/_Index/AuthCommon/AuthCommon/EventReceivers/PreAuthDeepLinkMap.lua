-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local GetFFlagEnableUnifiedWebViews = require(AuthCommonParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local HttpService = game:GetService("HttpService")
local BrowserService = game:GetService("BrowserService")
local WebViewService = if GetFFlagEnableUnifiedWebViews() then game:GetService("WebViewService") else nil
local NavigateSideways = require(AuthCommonParent.NavigationRodux).Thunks.NavigateSideways
local FFlagSignalsNavP3Dispatch = require(AuthCommonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AuthCommonParent.RobloxAppNavigation).NavigationCommands else nil
local HandleAuthTicket = require(AuthCommon.Thunks.HandleAuthTicket)
local LaunchContext = require(AuthCommonParent.AppStartup).Enums.LaunchContext
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage

local bool1 = game:DefineFastFlag("EnableJoinV2PreAuthDeepLink", false)
local bool2 = game:DefineFastFlag("EnableAccountRecoveryPreAuthDeepLink2", true)

local num1 = game:DefineFastInt("WaitAfterCloseChallengeWebViewSeconds", 500)

local tbl1 = {{
    regexPattern = "roblox.*//testing/preauth.*",
    handler = function(arg1, arg2): boolean
        print("preauth deeplink example called with query params:")
        for k, value in pairs(arg1) do
            print(k, "=", value)
        end

        print("context:")
        for k, value in pairs(arg2) do
            print(k, "=", value)
        end

        return true
    end,
    preauthOnly = false
}}

if bool1 then
    table.insert(tbl1, {
        regexPattern = "roblox.*://join_v2/join.*",
        handler = function(arg1, arg2)
            return HandleAuthTicket(arg2.networking, arg1.ticket, arg1.placelauncherurl, function()
                return arg2.dispatch(
                    arg2.launchApp(arg2.networking, arg2.omniRecommendationsRequest, arg2.analytics, arg2.appPolicy, LaunchContext.Login)
                )
            end, function()
                return arg2.dispatch(arg2.resetAppState())
            end)
        end,
        preauthOnly = false
    })
end

if bool2 then
    table.insert(tbl1, {
        regexPattern = "roblox.*://navigation/account_recovery.*",
        handler = function(arg1, arg2)
            local origin = arg1.origin
            local extraProps = origin == "login2SV"
                and {
                    continuingRecovery = false,
                    recover2sv = true,
                    recoverPassword = false,
                    identifier = arg1.username
                }
                or origin == "passwordReset2SV"
                    and {
                        continuingRecovery = true,
                        recover2sv = true,
                        recoverPassword = true,
                        recoverySessionID = arg1.recoverysessionid,
                        identifier = arg1.username
                    }
                or {}

            if GetFFlagEnableUnifiedWebViews() then
                WebViewService:CloseWindow()
            else
                BrowserService:CloseBrowserWindow()
            end

            if origin == "login2SV" then
                task.wait(num1 / 1000)
            end

            local tbl2 = {
                name = AppPage.AccountRecovery,
                detail = HttpService:GenerateGUID(false):lower(),
                extraProps = extraProps
            }
            if FFlagSignalsNavP3Dispatch then
                return NavigationCommands.sideways(NavigationCommands.fromLegacyPage(tbl2))
            end
            return arg2.dispatch(NavigateSideways(tbl2))
        end,
        preauthOnly = false
    })
end

return tbl1

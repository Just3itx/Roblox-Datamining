-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local HttpRequest = require(CorePackages.Packages.HttpRequest)

local FFlagLuaAppDefaultHttpRetry = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaAppDefaultHttpRetry
local var1 = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("WithReferralRewardTooltipInfoHttpRetryCount", 4) else nil
})
local Url = require(CorePackages.Workspace.Packages.Http).Url
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local Cryo = require(CorePackages.Packages.Cryo)

function GetReferralRewardTooltipInfo()
    local var2 = Url:makeQueryString({ UniverseId = game.GameId })

    local str1 = string.format("%sreferral-reward-metadata/v1/get-reward-metadata?%s", Url.APIS_URL, var2)
    return var1(str1, "GET")
end

function withReferralRewardTooltipInfo(arg1)
    return function(arg2)
        local var2 = Cryo.Dictionary.join(arg2, { referralRewardTooltipText = "" })

        local referralRewardName, var4 = React.useState("")
        React.useEffect(function()
            GetReferralRewardTooltipInfo():andThen(function(arg3)
                if arg3 and arg3.responseBody and arg3.responseBody.name then
                    var4(arg3.responseBody.name)
                    task.delay(4, function()
                        var4("")
                    end)
                end
            end):catch(function(arg3)
                warn(arg3)
            end)
        end, {})
        local var5 = useLocalization({
            referralRewardTooltipText = {
                "CoreScripts.TopBar.RobloxMenuReferralRewardTooltip",
                referralRewardName = referralRewardName
            }
        })
        if referralRewardName ~= "" then
            var2 = Cryo.Dictionary.join(var2, { referralRewardTooltipText = var5.referralRewardTooltipText })
        end

        return React.createElement(arg1, var2)
    end
end

return withReferralRewardTooltipInfo

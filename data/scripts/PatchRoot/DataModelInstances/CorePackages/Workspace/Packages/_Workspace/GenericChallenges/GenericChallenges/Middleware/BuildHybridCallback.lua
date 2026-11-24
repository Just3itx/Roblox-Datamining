-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local JavascriptHybrid = require(GenericChallenges.Types.JavascriptHybrid)

local HttpService = game:GetService("HttpService")

return function(tbl1): (string) -> ()
    return function(input: string)
        local var1 = HttpService:JSONDecode(input)

        if var1.moduleID ~= JavascriptHybrid.Module.Navigation
            or var1.functionName ~= JavascriptHybrid.Function.navigateToFeature
            or not (var1.params and var1.params.params)
        then
            return
        end

        local params = var1.params.params
        if params.feature == JavascriptHybrid.Feature.ChallengeParsed and params.data.parsed == false
            or params.feature == JavascriptHybrid.Feature.ChallengeInitialized and params.data.initialized == false
        then
            tbl1.OnChallengeLoadFailed(params)
            return
        end

        if tbl1.Hooks ~= nil then
            for _, hook in tbl1.Hooks do
                if hook(params) then
                    return
                end
            end
        end

        if params.feature == JavascriptHybrid.Feature.ChallengeCompleted then
            if params.data ~= nil then
                tbl1.OnChallengeCompleted(params)
            elseif tbl1.OnChallengeAbandoned ~= nil then
                tbl1.OnChallengeAbandoned()
            else
                tbl1.OnChallengeLoadFailed(params)
            end
        elseif params.feature == JavascriptHybrid.Feature.ChallengeInvalidated then
            tbl1.OnChallengeInvalidated(params)
        elseif var1.params.params.feature == JavascriptHybrid.Feature.ChallengeDisplayed and tbl1.OnChallengeDisplayed ~= nil then
            tbl1.OnChallengeDisplayed(params)
        end
    end
end

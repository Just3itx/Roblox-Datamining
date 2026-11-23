-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent

local Promise = require(AchievementsParent.Promise)
local Dash = require(AchievementsParent.Dash)
local MakeOmniRecommendationsRequest = require(AchievementsParent.GraphQlShared).MakeOmniRecommendationsRequest

return function(arg1, _: number?)
    return MakeOmniRecommendationsRequest(arg1, "Home", "0", nil, nil, nil, { tostring(100000003) }):andThen(function(arg2)
        if arg2.responseBody == nil then
            return Promise.reject("Response has no body.")
        end

        local sorts = arg2.responseBody.sorts
        if not sorts then
            return Promise.reject("Response has no sorts.")
        end

        local tbl1 = {}
        for _, sort in pairs(sorts) do
            if sort.topicId ~= 100000003 then
                continue
            end

            tbl1 = sort.recommendationList
            if not tbl1 then
                return Promise.reject("No recommendation list found in sorts.")
            end

            break
        end

        local num1 = #tbl1

        if not Dash.find(tbl1, function(arg3): boolean
            return arg3.contentId == game.GameId
        end) then
            num1 += 1
        end
        return Promise.resolve(num1)
    end)
end

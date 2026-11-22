-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local llama = dependencies.llama

local Constants = require(scriptParentParentParent.Common.Constants)
local _ModelTypes = require(scriptParentParentParent.Common.ModelTypes)

local RecommendationSourceEnum = dependencies.SocialCommon.Enums.RecommendationSourceEnum

return function(tbl1)
    return function(arg1)
        local deepValue = getDeepValue(
            arg1,
            string.format(
                "%s.Friends.recommendations.bySource.%s",
                Constants.RODUX_KEY,
                RecommendationSourceEnum.HomepagePYMKCarousel
            )
        )
            or {}

        return llama.List.filter(tbl1, function(arg2)
            return deepValue[arg2.id]
        end)
    end
end

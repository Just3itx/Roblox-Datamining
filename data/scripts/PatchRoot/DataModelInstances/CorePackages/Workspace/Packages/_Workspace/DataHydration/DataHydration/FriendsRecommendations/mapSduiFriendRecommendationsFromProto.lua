-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _SduiFriendRecommendationTypes = require(script.Parent.SduiFriendRecommendationTypes)
local SduiRecommendationType = require(script.Parent.SduiRecommendationType)

local function mapRecommendationTypeFromProto(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == "RECOMMENDATION_TYPE_USER" or str1 == SduiRecommendationType.User then
        return SduiRecommendationType.User
    end

    if str1 == "RECOMMENDATION_TYPE_CONTACT" or str1 == SduiRecommendationType.Contact then
        return SduiRecommendationType.Contact
    end

    return SduiRecommendationType.Invalid
end

local function mapFriendRecommendationsFromProto(tbl1)
    local result = ({})

    for value, value2 in tbl1 do
        local var1 = table.clone(value2)

        local recommendationType = var1.recommendationType
        var1.recommendationType = if recommendationType == "RECOMMENDATION_TYPE_USER"
            or recommendationType == mapRecommendationTypeFromProto("RECOMMENDATION_TYPE_USER") then mapRecommendationTypeFromProto("RECOMMENDATION_TYPE_USER") elseif recommendationType == "RECOMMENDATION_TYPE_CONTACT" or recommendationType == SduiRecommendationType.Contact then SduiRecommendationType.Contact else SduiRecommendationType.Invalid

        result[value] = var1
    end

    return result
end

return mapFriendRecommendationsFromProto

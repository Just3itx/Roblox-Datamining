-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local PYMKCarouselParent = PYMKCarousel.Parent
local llama = require(PYMKCarousel.dependencies).llama

local SocialCommon = require(PYMKCarouselParent.SocialCommon)
local _OmniTypes = require(PYMKCarousel.Common.OmniTypes)
local getRecommendationsMetadata = require(script.Parent.getRecommendationsMetadata)
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes

local function func1(arg1, treatmentType: string)
    local var1 = arg1.sorts or {}
    local where = llama.List.findWhere(var1, function(arg2): boolean
        return arg2.treatmentType == treatmentType
    end)
    return if where then var1[where] else nil
end

return function(arg1, arg2, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?)
    local result = {}
    local contentType = arg2.contentType
    local treatmentType = arg2.treatmentType

    for _, value in pairs(arg1) do
        local recommendationsMetadata = getRecommendationsMetadata(value, contentType)
        local var1 = func1(value, treatmentType)
        local var2 = not var1 and {} or var1.recommendations or {}
        if #var2 == 0 then
            continue
        end

        if func3 then
            result = llama.List.push(result, func3(var1, recommendationsMetadata))
        end

        result = llama.List.reduce(var2, function(arg3, arg4, arg5)
            local contentStringId = if arg4.contentMetadata.contextType == ContextualInfoTypes.Contacts then arg4.contentStringId else tostring(arg4.contentId)
            local var3 = recommendationsMetadata[contentStringId]
            local contentMetadata = arg4.contentMetadata

            if not var3 then
                return arg3
            elseif func2 then
                return llama.List.push(arg3, func2(var3, arg5, contentMetadata))
            end
            return arg3
        end, result)
    end

    return result
end

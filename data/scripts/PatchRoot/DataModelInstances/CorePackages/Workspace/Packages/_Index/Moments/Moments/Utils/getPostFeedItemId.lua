-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function getPostFeedItemId(arg1)
    if arg1 == nil then
        return nil
    end

    local recommendationMetadata = arg1.recommendationMetadata
    local feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId
    return if feedItemId == nil or feedItemId == "" then nil elseif arg1.momentId == feedItemId then feedItemId else nil
end

return getPostFeedItemId

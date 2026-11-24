-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local convertApiMomentComments = require(DataHydration.Moments.Util.convertApiMomentComments)

local function extractCommentsByFeedItemId(tbl1)
    local result = ({})

    if tbl1 == nil then
        return result
    end

    for _, value in tbl1 do
        local feedItemId = value.feedItemId
        if type(feedItemId) ~= "string" or feedItemId == "" then
            continue
        end

        local var1 = convertApiMomentComments(value.comments)
        if var1 ~= nil then
            result[feedItemId] = var1
        end
    end

    return result
end

return extractCommentsByFeedItemId

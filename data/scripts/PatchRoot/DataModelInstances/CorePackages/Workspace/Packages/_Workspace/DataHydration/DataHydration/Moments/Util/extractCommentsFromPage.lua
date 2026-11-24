-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local convertApiCommentToComment = require(DataHydration.Moments.Util.convertApiCommentToComment)

local function extractCommentsFromPage(arg1)
    local result = {}
    if type(arg1) ~= "table" or type(arg1.comments) ~= "table" then
        return result
    end

    for _, comment in arg1.comments do
        local var1 = convertApiCommentToComment(comment)
        if var1 ~= nil then
            result[var1.commentId] = var1
        end
    end

    return result
end

return extractCommentsFromPage

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local networkRequests = scriptParent.networkRequests

local FFlagContentFeedEnableReactions = require(scriptParentParent.SharedFlags).FFlagContentFeedEnableReactions

local createAddReaction = require(networkRequests.createAddReaction)
local createCheckMomentsEligibility = require(networkRequests.createCheckMomentsEligibility)
local createDeletePost = require(networkRequests.createDeletePost)
local createGetPostsByCursor = require(networkRequests.createGetPostsByCursor)
local createGetPostsByPostId = require(networkRequests.createGetPostsByPostId)
local createGetPostsByUserId = require(networkRequests.createGetPostsByUserId)
local createGetThumbnailByAssetId = require(networkRequests.createGetThumbnailByAssetId)
local createRemoveReaction = require(networkRequests.createRemoveReaction)

return function(tbl1)
    return {
        AddReaction = if FFlagContentFeedEnableReactions then createAddReaction(tbl1) else nil,
        CheckMomentsEligibility = createCheckMomentsEligibility(tbl1),
        DeletePost = createDeletePost(tbl1),
        GetActiveCategories = require(networkRequests.createGetActiveCategories)(tbl1),
        GetPostsByCursor = createGetPostsByCursor(tbl1),
        GetPostsByPostId = createGetPostsByPostId(tbl1),
        GetPostsByUserId = createGetPostsByUserId(tbl1),
        GetThumbnailByAssetId = createGetThumbnailByAssetId(tbl1),
        RemoveReaction = if FFlagContentFeedEnableReactions then createRemoveReaction(tbl1) else nil
    }
end

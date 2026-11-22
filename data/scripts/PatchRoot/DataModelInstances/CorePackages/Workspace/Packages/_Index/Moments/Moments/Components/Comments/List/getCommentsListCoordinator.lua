-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsComments = require(MomentsParent.DataHydration.MomentsComments)
local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)
local SharedFlags = require(MomentsParent.SharedFlags)
local MomentsGetMomentsReactionsStore = require(MomentsParent.DataHydration.MomentsGetMomentsReactionsStore)
local Signals = require(MomentsParent.Signals)

local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local GetCommentSessionFiltersStore = require(Moments.Components.Comments.GetCommentSessionFiltersStore)
local GetCommentReactionsStore = require(Moments.Stores.GetCommentReactionsStore)
local createCommentsListCoordinator = require(script.Parent.createCommentsListCoordinator)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentDeepLinks = SharedFlags.FFlagMomentsCommentDeepLinks

local function getCommentPostedCallback(str1: string, num1: number)
    local var1 = require(script.Parent.Parent.Sheet.getCommentsSheetStore)(false).getRecommendationSession(str1, num1)
    return if var1 == nil then nil else var1.logComment
end

local function getPinnedCommentId(str1: string, num1: number)
    local var1 = require(script.Parent.Parent.Sheet.getCommentsSheetStore)(false).getTarget(str1, num1)
    return if var1 == nil then nil else var1.commentId
end

local function getCommentDeletedCallback(str1: string, num1: number)
    local var1 = require(script.Parent.Parent.Sheet.getCommentsSheetStore)(false).getRecommendationSession(str1, num1)
    return if var1 == nil then nil else var1.logCommentDelete
end

return Signals.createComputed(function(_)
    local commentsStore = MomentsGetMomentsCommentsStore(false)
    return createCommentsListCoordinator({
        collectionStore = GetCommentCollectionStore(false),
        commentsStore = commentsStore,
        reactionStore = if FFlagMomentsComments then GetCommentReactionsStore(false) else nil,
        catalogStore = if FFlagMomentsComments then MomentsGetMomentsReactionsStore(false) else nil,
        sessionFilters = GetCommentSessionFiltersStore(false),
        network = MomentsComments.resolveCommentsNetwork(nil),
        getCommentPostedCallback = if FFlagMomentsComments then getCommentPostedCallback else nil,
        getAnalyticsSession = FFlagMomentsComments and function(arg1, arg2)
            return require(script.Parent.Parent.Sheet.getCommentsSheetStore)(false).getAnalyticsSession(arg1, arg2)
        end or nil,
        getCommentDeletedCallback = if FFlagMomentsComments then getCommentDeletedCallback else nil,
        getPinnedCommentId = if FFlagMomentsCommentDeepLinks then getPinnedCommentId else nil
    })
end)

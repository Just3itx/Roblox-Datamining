-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    resolveCommentsNetwork = require(script.resolveCommentsNetwork),
    createMomentsCommentsStore = require(script.Parent.createMomentsCommentsStore),
    fetchMomentComments = require(script.Parent.Requests.fetchMomentComments),
    fetchMomentComment = require(script.Parent.Requests.fetchMomentComment),
    postMomentComment = require(script.Parent.Requests.postMomentComment),
    deleteMomentComment = require(script.Parent.Requests.deleteMomentComment),
    putMomentCommentReaction = require(script.Parent.Requests.putMomentCommentReaction),
    deleteMomentCommentReaction = require(script.Parent.Requests.deleteMomentCommentReaction),
    extractCommentsFromPage = require(script.Parent.Util.extractCommentsFromPage),
    parseCommentsError = require(script.Parent.Util.parseCommentsError)
}

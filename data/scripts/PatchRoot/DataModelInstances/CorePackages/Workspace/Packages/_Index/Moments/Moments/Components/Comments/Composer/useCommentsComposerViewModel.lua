-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)
local useEventCallback = require(MomentsParent.ReactUtils).useEventCallback

local FIntMomentsCommentMaxLength = require(Moments.Flags.FIntMomentsCommentMaxLength)
local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local getCommentsListCoordinator = require(Moments.Components.Comments.List.getCommentsListCoordinator)
local _CommentsComposerView = require(script.Parent.CommentsComposerView)
local normalizeCommentText = require(script.Parent.normalizeCommentText)
local truncateToMaxLength = require(script.Parent.truncateToMaxLength)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    textFilterRejected = "Feature.Moments.Label.CommentRejectedByFilter",
    rateLimited = "Feature.Moments.Label.CommentRateLimited",
    submissionFailed = "Feature.Moments.Label.CommentPostFailed",
    outcomeUnknown = "Feature.Moments.Label.CommentPostOutcomeUnknown",
    commentsDisabled = "Feature.Moments.Label.CommentsTurnedOff",
    writeNotAllowed = "Feature.Moments.Label.CommentNotAllowed",
    momentUnavailable = "Feature.Moments.Label.MomentNoLongerAvailable",
    signInRequired = "Feature.Moments.Label.CommentSignInRequired",
    commentsOff = "Feature.Moments.Label.CommentingUnavailable"
}

local tbl2 = {
    TextFilterRejected = "textFilterRejected",
    RateLimited = "rateLimited",
    CommentsDisabledByCreator = "commentsDisabled",
    ViewerNotEligibleToWrite = "writeNotAllowed",
    ViewerNotEligibleToRead = "momentUnavailable",
    MomentUnavailable = "momentUnavailable",
    AuthenticationRequired = "signInRequired",
    CommentsEndpointDisabled = "commentsOff",
    CommentsEndpointNotImplemented = "commentsOff",
    SubmissionOutcomeUnknown = "outcomeUnknown"
}

local function getSubmissionErrorMessageName(errorCode: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl2[errorCode] or "submissionFailed"
end

local function isBlank(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return normalizeCommentText(str1) == ""
end

local function useCommentsComposerViewModel(tbl3)
    local var1, var2 = React.useState("")

    local var3, var4 = React.useBinding("")
    local var5 = React.useCallback(function(str1: string)
        var2(str1)
        var4(str1)
    end, { var4 })
    local var6 = useLocalization(tbl1)
    local var7, var8 = React.useState(nil)
    local commentCollectionStore = GetCommentCollectionStore(false)
    local var9 = React.useMemo(function()
        return commentCollectionStore.getState(tbl3.feedItemId)
    end, { commentCollectionStore, tbl3.feedItemId })
    local var10 = SignalsReact.useSignalState(var9)
    local commentsListCoordinator = getCommentsListCoordinator(false)
    local submissionError = var10.submissionError
    local bool1 = SignalsReact.useSignalState(commentsListCoordinator.getPostCooldownUntilMs) > DateTime.now().UnixTimestampMillis

    local useEffect = React.useEffect
    local function func1()
        if submissionError == nil then
            return
        end
        var5(submissionError.text)
        var8((getSubmissionErrorMessageName(submissionError.errorCode)))
        commentCollectionStore.clearSubmissionError(tbl3.feedItemId)
    end

    local feedItemId = tbl3.feedItemId
    local errorCode = if submissionError == nil then nil else submissionError.errorCode
    local text = if submissionError == nil then nil else submissionError.text
    useEffect(func1, { commentCollectionStore, feedItemId, var5, errorCode, text })

    local isInputDisabled = var10.pendingSubmission ~= nil
    local bool3 = not isInputDisabled and not isBlank(var1)
    if bool1 then
        bool3 = false
    end
    local onTextChanged = React.useCallback(function(str1: string)
        local var11 = var5
        if FIntMomentsCommentMaxLength > 0 then
            str1 = truncateToMaxLength(str1, FIntMomentsCommentMaxLength)
        end

        var11(str1)

        var8(nil)
    end, { var5 })

    local onSubmit = useEventCallback(function()
        if not bool3 then
            return
        end

        if commentsListCoordinator.submitComment(tbl3.feedItemId, tbl3.sessionId, normalizeCommentText(var1)) then
            var5("")
            var8(nil)
        end
    end)

    if bool1 then
        var7 = if var7 == nil then "rateLimited" else var7
    end

    return {
        text = var3,
        isInputDisabled = isInputDisabled,
        isSubmitEnabled = bool3,
        errorMessage = if var7 == nil then nil else var6[var7],
        onTextChanged = onTextChanged,
        onSubmit = onSubmit
    }
end

return useCommentsComposerViewModel

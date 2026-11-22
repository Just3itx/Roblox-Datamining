-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedbackParent = script:FindFirstAncestor("PlayerFeedback").Parent
local Constants = require(script.Parent.Parent.Constants)
local Cryo = require(PlayerFeedbackParent.Cryo)
local t = require(PlayerFeedbackParent.t)
local mutedError = require(PlayerFeedbackParent.Loggers).mutedError

local var1 = t.optional(t.strictInterface({ categoryType = t.optional(t.string), value = t.optional(t.string) }))

local function gamePlayerFeedbackEvent(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
    return function(arg2, placeId, arg3)
        local var2, var3 = var1(arg3)
        if not var2 then
            mutedError(var3)
        end

        local tbl1 = { placeId = placeId }

        if arg3 then
            tbl1 = Cryo.Dictionary.join(tbl1, arg3)
        end
        arg2:sendEventDeferred(Constants.Context.GamePlayerFeedback, arg1, tbl1)
    end
end

return {
    ClickPlayerFeedbackPromptCta = gamePlayerFeedbackEvent(Constants.EventNames.ClickPlayerFeedbackPromptCta),
    PlayerFeedbackPromptMounted = gamePlayerFeedbackEvent(Constants.EventNames.PlayerFeedbackPromptMounted),
    DismissPlayerFeedbackPrompt = gamePlayerFeedbackEvent(Constants.EventNames.DismissPlayerFeedbackPrompt),
    PlayerFeedbackFormModalMounted = gamePlayerFeedbackEvent(Constants.EventNames.PlayerFeedbackFormModalMounted),
    DismissPlayerFeedbackFormModal = gamePlayerFeedbackEvent(Constants.EventNames.DismissPlayerFeedbackFormModal),
    ClickPlayerFeedbackFormModalDisclaimer = gamePlayerFeedbackEvent(Constants.EventNames.ClickPlayerFeedbackFormModalDisclaimer),
    ClickPlayerFeedbackFormAbuseReportPrompt = gamePlayerFeedbackEvent(Constants.EventNames.ClickPlayerFeedbackFormAbuseReportPrompt),
    TogglePlayerFeedbackFormModalReason = gamePlayerFeedbackEvent(Constants.EventNames.TogglePlayerFeedbackFormModalReason),
    FocusPlayerFeedbackFormModalComment = gamePlayerFeedbackEvent(Constants.EventNames.FocusPlayerFeedbackFormModalComment),
    ClickPlayerFeedbackFormModalSubmit = gamePlayerFeedbackEvent(Constants.EventNames.ClickPlayerFeedbackFormModalSubmit),
    SubmitPlayerFeedbackFailCommentValidation = gamePlayerFeedbackEvent(Constants.EventNames.SubmitPlayerFeedbackFailCommentValidation)
}

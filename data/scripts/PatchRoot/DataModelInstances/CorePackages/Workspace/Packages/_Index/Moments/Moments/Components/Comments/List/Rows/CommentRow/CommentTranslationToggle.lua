-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    seeTranslation = "Feature.Moments.Action.CommentSeeTranslation",
    seeOriginal = "Feature.Moments.Action.CommentSeeOriginal"
}

local function nonEmpty(str1: string?): string? -- Luacid: unused: defined but never referenced
    return if str1 == nil or str1 == "" then nil else str1
end

return React.memo(function(tbl2) -- name: CommentTranslationToggle
    local var1 = useLocalization(tbl1)
    local var2

    if tbl2.isShowingTranslation then
        local seeOriginal = var1.seeOriginal

        if seeOriginal == nil or seeOriginal == "" then
            seeOriginal = nil
        end

        var2 = seeOriginal or "See original"
    else
        local seeTranslation = var1.seeTranslation

        if seeTranslation == nil or seeTranslation == "" then
            seeTranslation = nil
        end

        var2 = seeTranslation or "See translation"
    end

    local onToggle = tbl2.onToggle
    local commentId = tbl2.commentId
    local onActivated = React.useCallback(function()
        onToggle(commentId)
    end, { onToggle, commentId })

    return React.createElement(Foundation.Button, {
        text = var2,
        size = InputSize.XSmall,
        variant = ButtonVariant.Utility,
        onActivated = onActivated,
        LayoutOrder = tbl2.LayoutOrder,
        testId = `moments-comment-translation-toggle-{commentId}`
    })
end)

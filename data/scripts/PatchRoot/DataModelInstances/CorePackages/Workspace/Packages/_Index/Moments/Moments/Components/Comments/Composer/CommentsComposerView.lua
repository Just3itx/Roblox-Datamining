-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Composer = require(MomentsParent.AppBlox.Composer)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local useLocalization = Localization.Hooks.useLocalization

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local tbl1 = { placeholder = "Feature.Moments.Label.WriteComment" }

local function CommentsComposerView(tbl2)
    local var1 = useLocalization(tbl1)

    local createElement = React.createElement
    local var2 = Composer
    local tbl3 = {
        width = UDim.new(1, 0),
        size = InputSize.Medium,
        minLines = 1,
        maxLines = 5,
        label = "",
        placeholder = var1.placeholder,
        text = tbl2.text,
        hint = tbl2.errorMessage,
        hasError = tbl2.errorMessage ~= nil,
        isDisabled = tbl2.isInputDisabled,
        onChanged = tbl2.onTextChanged,
        onReturnPressed = tbl2.onSubmit,
        testId = "moments-comments-composer",
        trailingElement = 0
    }
    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl4 = { tag = "size-800-1000" }

    local tbl5 = { SubmitHitArea = 0 }

    local createElement3 = React.createElement
    local view2 = Foundation.View
    local tbl6 = {
        tag = "position-center-center anchor-center-center size-1000-1000",
        isDisabled = not tbl2.isSubmitEnabled,
        onActivated = tbl2.onSubmit,
        selection = { Selectable = false },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        testId = "moments-comments-composer-submit-hit-area"
    }
    local tbl7 = {
        SubmitButton = React.createElement(Foundation.IconButton, {
            icon = IconName.ArrowMediumUp,
            variant = if tbl2.isSubmitEnabled then ButtonVariant.Emphasis else ButtonVariant.Standard,
            size = InputSize.XSmall,
            isCircular = true,
            isDisabled = not tbl2.isSubmitEnabled,
            onActivated = tbl2.onSubmit,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            testId = "moments-comments-composer-submit"
        })
    }
    tbl5.SubmitHitArea = createElement3(view2, tbl6, tbl7)
    tbl3.trailingElement = createElement2(view, tbl4, tbl5)
    return createElement(var2, tbl3)
end

return CommentsComposerView

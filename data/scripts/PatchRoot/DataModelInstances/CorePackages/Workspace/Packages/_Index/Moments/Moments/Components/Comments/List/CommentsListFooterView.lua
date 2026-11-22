-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local useLocalization = Localization.Hooks.useLocalization

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local tbl1 = { retry = "Feature.Moments.Action.RetryLoadingComments" }

local function CommentsListFooterView(tbl2)
    local var1 = useLocalization(tbl1)

    if tbl2.status == "Loading" then
        return React.createElement(Foundation.View, {
            LayoutOrder = tbl2.LayoutOrder,
            tag = "col align-x-center size-full-0 auto-y padding-y-medium",
            testId = "moments-comments-load-more-loading"
        }, {
            Spinner = React.createElement(
                Foundation.Progress,
                {
                    shape = ProgressShape.Circle,
                    size = ProgressSize.Medium,
                    testId = "moments-comments-load-more-spinner"
                }
            )
        })
    elseif tbl2.status == "Failed" then
        return React.createElement(Foundation.Button, {
            LayoutOrder = tbl2.LayoutOrder,
            text = var1.retry,
            onActivated = tbl2.onRetry,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            testId = "moments-comments-load-more-retry"
        })
    end

    return nil
end

return CommentsListFooterView

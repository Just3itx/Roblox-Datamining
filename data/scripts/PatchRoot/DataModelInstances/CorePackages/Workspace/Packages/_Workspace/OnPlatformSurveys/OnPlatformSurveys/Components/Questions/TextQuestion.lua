-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local TextInput = Foundation.TextInput
local View = Foundation.View

local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

return React.memo(function(tbl1) -- name: TextQuestion
    local onAnswerChanged = tbl1.onAnswerChanged
    local onChanged = React.useCallback(function(text: string)
        onAnswerChanged({ text = text })
    end, { onAnswerChanged })

    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Input = React.createElement(TextInput, {
            text = tbl1.answer.text or "",
            label = "",
            width = UDim.new(1, 0),
            isDisabled = tbl1.isDisabled,
            onChanged = onChanged
        })
    })
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local Localization = require(BuildExperienceParent.Localization)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _AnswersCardView = require(script.Parent.AnswersCardView)

local useLocalization = Localization.Hooks.useLocalization

local function useAnswersCardViewModel(tbl1)
    local var1 = useLocalization({ answers = LocalizationStrings.ANSWER_FORM_ANSWERS })
    local var2, var3 = React.useBinding(0)
    local onContentSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.Y)
    end, {})
    local rows = {}

    for _, prompt in tbl1.prompts do
        local answers = {}
        if prompt.customResponseText ~= nil then
            table.insert(answers, { title = prompt.customResponseText })
        else
            local selectedOptionId = prompt.selectedOptionId
            for _, option in prompt.question.options do
                if if typeof(selectedOptionId) == "table" then table.find(selectedOptionId, option.id) ~= nil else selectedOptionId == option.id then
                    table.insert(
                        answers,
                        {
                            title = option.title,
                            description = if option.description == "" then nil else option.description
                        }
                    )
                end
            end
        end

        table.insert(rows, { question = prompt.question.question, answers = answers })
    end

    return {
        LayoutOrder = tbl1.LayoutOrder,
        Size = var2:map(function(yOffset: number): UDim2
            return UDim2.new(1, 0, 0, yOffset)
        end),
        headerText = var1.answers,
        rows = rows,
        onContentSizeChanged = onContentSizeChanged
    }
end

return useAnswersCardViewModel

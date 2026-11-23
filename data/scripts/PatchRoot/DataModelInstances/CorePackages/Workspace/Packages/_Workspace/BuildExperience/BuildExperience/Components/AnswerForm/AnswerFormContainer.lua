-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local React = require(BuildExperienceParent.React)

local AnswerFormView = require(script.Parent.AnswerFormView)
local useAnswerFormViewModel = require(script.Parent.useAnswerFormViewModel)

local function AnswerFormContainer(arg1)
    local var1 = useAnswerFormViewModel(arg1)
    if var1 == nil then
        return nil
    end

    return React.createElement(AnswerFormView, var1)
end

return AnswerFormContainer

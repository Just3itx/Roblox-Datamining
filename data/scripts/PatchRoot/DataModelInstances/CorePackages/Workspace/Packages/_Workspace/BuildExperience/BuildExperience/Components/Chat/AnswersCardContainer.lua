-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local React = require(BuildExperienceParent.React)

local AnswersCardView = require(script.Parent.AnswersCardView)
local useAnswersCardViewModel = require(script.Parent.useAnswersCardViewModel)

local function AnswersCardContainer(arg1)
    local var1 = useAnswersCardViewModel(arg1)
    return React.createElement(AnswersCardView, var1)
end

return AnswersCardContainer

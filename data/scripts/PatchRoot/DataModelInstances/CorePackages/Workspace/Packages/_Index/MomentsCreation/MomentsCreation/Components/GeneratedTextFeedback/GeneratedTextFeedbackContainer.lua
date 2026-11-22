-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local React = require(MomentsCreationParent.React)

local GeneratedTextFeedbackView = require(script.Parent.GeneratedTextFeedbackView)
local useGeneratedTextFeedbackViewModel = require(script.Parent.useGeneratedTextFeedbackViewModel)

local function GeneratedTextFeedbackContainer(arg1)
    local var1 = useGeneratedTextFeedbackViewModel(arg1)
    return React.createElement(GeneratedTextFeedbackView, var1)
end

return GeneratedTextFeedbackContainer

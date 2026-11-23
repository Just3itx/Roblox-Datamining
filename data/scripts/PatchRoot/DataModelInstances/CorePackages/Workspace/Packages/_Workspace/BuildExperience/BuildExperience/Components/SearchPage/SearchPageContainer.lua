-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local SearchPageView = require(script.Parent.SearchPageView)
local useSearchPageViewModel = require(script.Parent.useSearchPageViewModel)

return React.forwardRef(function(arg1, arg2) -- name: SearchPageContainer
    local var1 = useSearchPageViewModel(arg1, arg2)
    return React.createElement(SearchPageView, var1)
end)

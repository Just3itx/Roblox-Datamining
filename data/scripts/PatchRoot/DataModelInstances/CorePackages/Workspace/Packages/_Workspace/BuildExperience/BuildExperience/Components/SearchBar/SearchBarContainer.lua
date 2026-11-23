-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local SearchBarView = require(script.Parent.SearchBarView)
local useSearchBarViewModel = require(script.Parent.useSearchBarViewModel)

local function SearchBarContainer(arg1)
    local var1 = useSearchBarViewModel(arg1)
    return React.createElement(SearchBarView, var1)
end

return SearchBarContainer

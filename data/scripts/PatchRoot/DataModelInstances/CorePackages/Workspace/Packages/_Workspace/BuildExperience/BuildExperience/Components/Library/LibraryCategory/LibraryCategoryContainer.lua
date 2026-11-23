-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local LibraryCategoryView = require(script.Parent.LibraryCategoryView)
local useLibraryCategoryViewModel = require(script.Parent.useLibraryCategoryViewModel)

local function LibraryCategoryContainer(arg1)
    local var1 = useLibraryCategoryViewModel(arg1)
    return React.createElement(LibraryCategoryView, var1)
end

return LibraryCategoryContainer

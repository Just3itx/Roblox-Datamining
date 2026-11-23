-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local MyCreationsFilterView = require(script.Parent.MyCreationsFilterView)
local useMyCreationsFilterViewModel = require(script.Parent.useMyCreationsFilterViewModel)

local function MyCreationsFilterContainer(arg1)
    local var1 = useMyCreationsFilterViewModel(arg1)
    return React.createElement(MyCreationsFilterView, var1)
end

return MyCreationsFilterContainer

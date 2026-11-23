-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local _ModelPickerTypes = require(script.Parent.ModelPickerTypes)
local ModelPickerView = require(script.Parent.ModelPickerView)
local useModelPickerViewModel = require(script.Parent.useModelPickerViewModel)

local function ModelPickerContainer(arg1)
    local var1 = useModelPickerViewModel(arg1)
    return React.createElement(ModelPickerView, var1)
end

return ModelPickerContainer

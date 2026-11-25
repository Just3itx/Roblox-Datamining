-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)

local PeoplePickerHeaderView = require(script.Parent.PeoplePickerHeaderView)
local usePeoplePickerHeaderViewModel = require(script.Parent.usePeoplePickerHeaderViewModel)

local function PeoplePickerHeaderContainer(arg1)
    local var1 = usePeoplePickerHeaderViewModel(arg1)

    return React.createElement(PeoplePickerHeaderView, var1)
end

return PeoplePickerHeaderContainer

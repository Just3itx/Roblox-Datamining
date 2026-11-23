-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local SearchInput = Foundation.SearchInput
local View = Foundation.View

local function SearchBarView(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "size-full-0 auto-y",
            testId = "SearchBar"
        },
        {
            Input = React.createElement(SearchInput, {
                onChanged = tbl1.onChanged,
                onFocusGained = tbl1.onFocusGained,
                onFocusLost = tbl1.onFocusLost,
                placeholder = tbl1.placeholder,
                testId = "SearchBar.Input",
                text = tbl1.query,
                ref = tbl1.textInputRef,
                width = UDim.new(1, 0)
            })
        }
    )
end
return SearchBarView

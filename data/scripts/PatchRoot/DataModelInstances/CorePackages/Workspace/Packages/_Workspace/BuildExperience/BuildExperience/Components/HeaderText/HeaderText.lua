-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text

local function HeaderText(tbl1)
    return React.createElement(FoundationText, {
        Text = tbl1.text,
        tag = "fill auto-y text-heading-medium text-align-x-left text-truncate-end content-emphasis",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "build-header-text"
    })
end

return HeaderText

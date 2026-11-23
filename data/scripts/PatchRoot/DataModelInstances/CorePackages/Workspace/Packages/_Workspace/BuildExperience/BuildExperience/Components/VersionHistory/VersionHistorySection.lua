-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local function VersionHistorySection(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y"
    }
    local tbl3 = {
        Heading = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title,
            tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
            testId = if tbl1.testId then `{tbl1.testId}-heading` else nil
        }),
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col gap-medium size-full-0 auto-y",
            testId = if tbl1.testId then `{tbl1.testId}-content` else nil
        }, tbl1.children)
    }
    return createElement(var1, tbl2, tbl3)
end

return VersionHistorySection

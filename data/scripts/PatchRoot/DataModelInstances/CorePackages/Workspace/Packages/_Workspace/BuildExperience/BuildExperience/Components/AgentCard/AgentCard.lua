-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local function AgentCard(tbl1)
    local testId = tbl1.testId or "agent-card"

    local tbl2 = {
        Header = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title,
            tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis"
        }),
        Content = React.createElement(FoundationText, {
            LayoutOrder = 2,
            RichText = true,
            Text = tbl1.textContent,
            tag = if tbl1.fitToContent then "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis" else "size-full-2000 text-body-medium text-wrap text-align-x-left text-align-y-top text-truncate-end content-emphasis",
            testId = `{testId}-text-content`
        }),
        Children = React.createElement(React.Fragment, nil, tbl1.children)
    }

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["col size-full-0 auto-y padding-large stroke-standard stroke-default radius-large"] = true,
            ["gap-large"] = tbl1.footer ~= nil,
            ["gap-xxsmall"] = tbl1.footer == nil
        },
        testId = testId
    }, {
        Body = if tbl1.footer ~= nil then React.createElement(View, { LayoutOrder = 1, tag = "col gap-xxsmall size-full-0 auto-y" }, tbl2) else React.createElement(React.Fragment, nil, tbl2),
        Footer = if tbl1.footer == nil then nil else React.createElement(View, { LayoutOrder = 2, tag = "col size-full-0 auto-y" }, { Content = tbl1.footer })
    })
end

return AgentCard

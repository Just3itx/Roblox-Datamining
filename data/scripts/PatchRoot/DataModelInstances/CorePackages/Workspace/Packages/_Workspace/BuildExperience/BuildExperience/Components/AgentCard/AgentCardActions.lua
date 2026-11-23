-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local View = Foundation.View

local function AgentCardActions(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder or 3,
            tag = "row gap-small size-full-0 auto-y"
        },
        tbl1.children
    )
end
return AgentCardActions

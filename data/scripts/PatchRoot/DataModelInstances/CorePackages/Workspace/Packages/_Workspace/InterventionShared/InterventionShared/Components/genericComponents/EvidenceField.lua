-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local React = require(InterventionSharedParent.React)

local Foundation = require(InterventionSharedParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

return React.memo(function(tbl1) -- name: EvidenceField
    local str1 = if tbl1.hasColon == nil or tbl1.hasColon then ":" else ""

    return React.createElement(View, {
        tag = "size-full-0 auto-y col",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Label = React.createElement(FoundationText, {
            tag = "auto-xy text-title-medium text-align-x-left text-wrap content-emphasis",
            Text = `{tbl1.fieldLabel}{str1}`,
            LayoutOrder = 1
        }),
        Value = React.createElement(
            FoundationText,
            {
                tag = "auto-xy text-body-medium text-align-x-left text-wrap",
                Text = tbl1.fieldValue,
                LayoutOrder = 2
            }
        )
    })
end)

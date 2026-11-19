-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local _PaginationSize = require(Foundation.Enums.PaginationSize)

local scriptParentParent = script.Parent.Parent
local paginationUtils = require(scriptParentParent.paginationUtils)

return React.memo(function(tbl1) -- name: Ellipsis
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = paginationUtils.getCircularSlotTag(tbl1.slotSize),
            testId = tbl1.testId
        },
        {
            Text = React.createElement(Text, { Text = "...", tag = paginationUtils.getPageLabelTag(tbl1.slotSize), LayoutOrder = 1 })
        }
    )
end)

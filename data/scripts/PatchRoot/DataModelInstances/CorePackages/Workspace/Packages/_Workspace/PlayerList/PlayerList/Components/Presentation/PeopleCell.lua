-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local PlayerBadgeGroup = require(scriptParentParentParent.Components.Presentation.PlayerBadgeGroup)

return React.memo(function(tbl1) -- name: PeopleCell
    local tag = tbl1.textTag
        or (if tbl1.truncate then "text-body-small text-align-x-left content-default text-truncate-end shrink auto-xy" else "auto-xy text-body-small text-align-x-left content-default")

    local tbl2 = {
        NameText = React.createElement(FoundationText, { Text = tbl1.displayName, tag = tag, LayoutOrder = 1 })
    }

    if tbl1.player then
        tbl2.Badge = React.createElement(PlayerBadgeGroup, { player = tbl1.player, layoutOrder = 2 })
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-x-left align-y-center fill size-0-full clip gap-medium"
        },
        tbl2
    )
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local View = require(scriptParentParentParentParent.Foundation).View

local PlayerBadge = require(scriptParentParentParent.Components.Presentation.PlayerBadge)
local PlayerVerifiedBadge = require(scriptParentParentParent.Components.Presentation.PlayerVerifiedBadge)

return React.memo(function(tbl1) -- name: PlayerBadgeGroup
    return React.createElement(View, {
        tag = "row align-y-center gap-xsmall auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Badge = React.createElement(PlayerBadge, { player = tbl1.player, layoutOrder = 1 }),
        VerifiedBadge = React.createElement(PlayerVerifiedBadge, { player = tbl1.player, layoutOrder = 2 })
    })
end)

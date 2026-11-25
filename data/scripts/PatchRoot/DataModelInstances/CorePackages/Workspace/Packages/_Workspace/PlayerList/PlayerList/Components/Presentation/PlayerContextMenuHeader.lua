-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image

local PlayerVerifiedBadge = require(scriptParentParentParent.Components.Presentation.PlayerVerifiedBadge)
local Constants = require(scriptParentParentParent.Common.Constants)

return React.memo(function(tbl1) -- name: PlayerContextMenuHeader
    local header = tbl1.header

    local tbl2 = {
        DisplayNameText = React.createElement(FoundationText, {
            Text = header.displayName,
            tag = "shrink auto-xy text-title-medium text-wrap text-align-x-left text-truncate-end content-emphasis",
            LayoutOrder = 1
        })
    }

    if tbl1.player ~= nil then
        tbl2.VerifiedBadge = React.createElement(PlayerVerifiedBadge, { player = tbl1.player, layoutOrder = 2 })
    end

    local tbl3 = {
        DisplayNameRow = React.createElement(
            View,
            {
                tag = "row align-x-left align-y-center gap-xsmall size-full-0 auto-y",
                LayoutOrder = 1
            },
            tbl2
        ),
        Username = React.createElement(FoundationText, {
            Text = header.username,
            tag = "size-full-0 auto-y text-body-medium text-no-wrap text-align-x-left text-truncate-end content-default",
            LayoutOrder = 2
        })
    }

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "row align-x-left align-y-center gap-medium size-full-1600 auto-y",
        selection = Constants.NOT_SELECTABLE
    }, {
        Avatar = React.createElement(
            View,
            {
                tag = "size-1000-1000 radius-circle clip bg-shift-200",
                LayoutOrder = 1,
                testId = "player-context-menu-header-avatar"
            },
            {
                Image = React.createElement(Image, { Image = header.thumbnail or "", tag = "size-full radius-circle" })
            }
        ),
        NameColumn = React.createElement(View, { LayoutOrder = 2, tag = "col align-x-left fill auto-y" }, tbl3)
    })
end)

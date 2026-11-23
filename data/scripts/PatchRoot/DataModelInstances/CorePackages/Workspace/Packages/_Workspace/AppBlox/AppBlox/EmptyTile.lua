-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Cryo = require(AppBloxParent.Cryo)
local Foundation = require(AppBloxParent.Foundation)
local React = require(AppBloxParent.React)

local View = Foundation.View

return React.memo(function(tbl1) -- name: EmptyTile
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            ZIndex = tbl1.ZIndex,
            tag = "size-full"
        },
        Cryo.Dictionary.union(tbl1.children or {}, {
            Content = React.createElement(View, {
                aspectRatio = tbl1.tileAspectRatio,
                Size = tbl1.size,
                tag = "bg-surface-100 padding-y-medium padding-x-small radius-medium"
            }, {
                ContentOverlay = tbl1.contentOverlayComponent
            })
        })
    )
end)

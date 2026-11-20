-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local React = require(MomentsCreationFlowParent.React)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local MusicNote = BuilderIcons.Icon.MusicNote

local useMusicInfo = require(MomentsCreationFlow.Hooks.useMusicInfo)

local function MusicChip(tbl1)
    local var1 = useMusicInfo(tbl1.musicAssetId)

    return React.createElement(View, {
        tag = "align-x-center align-y-center auto-x bg-over-media-0 gap-medium padding-x-medium padding-y-xsmall radius-circle row size-0-800",
        LayoutOrder = 1,
        onActivated = tbl1.onActivated
    }, {
        Icon = React.createElement(Icon, { name = MusicNote, LayoutOrder = 1, size = Foundation.Enums.IconSize.Small }),
        MusicTitle = React.createElement(FoundationText, {
            tag = "auto-xy content-action-standard text-align-x-left text-align-y-center text-caption-medium text-truncate-split",
            sizeConstraint = {
                MaxSize = Vector2.new(100, math.huge)
            },
            LayoutOrder = 2,
            Text = var1.Title
        })
    })
end

return MusicChip

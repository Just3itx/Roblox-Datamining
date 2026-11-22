-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local MusicNote = BuilderIcons.Icon.MusicNote
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local FFlagMomentsCreationMusicChipRemoveButton = require(MomentsCreation.Flags.FFlagMomentsCreationMusicChipRemoveButton)
local useMusicInfo = require(MomentsCreation.Hooks.useMusicInfo)

local function MusicChip(tbl1)
    local var1 = useMusicInfo(tbl1.musicAssetId)
    local var2 = if FFlagMomentsCreationMusicChipRemoveButton then useTokens() else nil
    local tag = FFlagMomentsCreationMusicChipRemoveButton
        and {
            ["row align-x-center align-y-center gap-medium size-0-800 auto-x padding-y-xsmall radius-circle bg-over-media-0"] = true,
            ["padding-x-medium"] = tbl1.onRemove == nil,
            ["padding-left-medium padding-right-small"] = tbl1.onRemove ~= nil
        }
        or "row align-x-center align-y-center gap-medium size-0-800 auto-x padding-x-medium padding-y-xsmall radius-circle bg-over-media-0"

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = tag,
        LayoutOrder = 1,
        onActivated = tbl1.onActivated
    }
    local tbl3 = {
        Icon = React.createElement(Icon, { name = MusicNote, LayoutOrder = 1, size = Foundation.Enums.IconSize.Small }),
        MusicTitle = React.createElement(FoundationText, {
            tag = "auto-xy text-caption-medium text-align-x-left text-align-y-center text-truncate-split content-action-standard",
            sizeConstraint = {
                MaxSize = Vector2.new(100, math.huge)
            },
            LayoutOrder = 2,
            Text = var1 and var1.Title or ""
        }),
        RemoveButton = 0
    }
    local element

    if FFlagMomentsCreationMusicChipRemoveButton and tbl1.onRemove then
        element = React.createElement(View, {
            backgroundStyle = {
                Color3 = Color3.new(0, 0, 0)
            },
            LayoutOrder = 3,
            onActivated = tbl1.onRemove,
            stroke = {
                Color = var2.Color.Stroke.Default.Color3,
                Transparency = var2.Color.Stroke.Default.Transparency,
                Thickness = var2.Stroke.Standard
            },
            tag = "align-x-center align-y-center size-500-500 radius-circle",
            testId = "music-chip-remove-button"
        }, {
            RemoveIcon = React.createElement(Icon, {
                name = IconName.X,
                size = IconSize.XSmall,
                style = var2.Color.Content.Emphasis,
                testId = "music-chip-remove-button-icon"
            })
        })
    else
        element = nil
    end

    tbl3.RemoveButton = element
    return createElement(var4, tbl2, tbl3)
end

return MusicChip

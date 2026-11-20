-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)

local IconSize = require(scriptParentParentParentParent.App.ImageSet.Enum.IconSize)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local ItemTileEnums = require(scriptParentParent.Enum.ItemTileEnums)
local getIconSize = require(scriptParentParentParentParent.App.ImageSet.getIconSize)

local function getIconImage(statusStyle) -- Luacid: Inlined by compiler; 1 call site recovered
    if statusStyle == ItemTileEnums.StatusStyle.PendingIcon then
        return "icons/status/pending_small"
    end

    if statusStyle == ItemTileEnums.StatusStyle.AlertIcon then
        return "icons/actions/info_small"
    end

    return nil
end

local function ItemTileStatusIcon(tbl1)
    local tokens = useStyle().Tokens

    local iconImage = getIconImage(tbl1.statusStyle)

    if not iconImage then
        return nil
    end

    local iconSize = getIconSize(IconSize.Small)
    local emphasis = tokens.Color.Content.Emphasis

    return React.createElement(ImageSetComponent.Label, {
        Position = UDim2.fromOffset(tokens.Size.Size_200, tokens.Size.Size_200),
        Size = UDim2.fromOffset(iconSize, iconSize),
        BackgroundTransparency = 1,
        Image = Images[iconImage],
        ImageColor3 = emphasis.Color3,
        ImageTransparency = emphasis.Transparency
    })
end

return ItemTileStatusIcon

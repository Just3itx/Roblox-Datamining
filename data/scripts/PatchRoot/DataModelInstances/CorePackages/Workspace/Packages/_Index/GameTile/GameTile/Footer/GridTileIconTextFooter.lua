-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local UIBlox = require(GameTileParent.UIBlox)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local getGameTileMetadataFont = require(GameTile.Footer.getGameTileMetadataFont)
local Foundation = require(GameTileParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local GameTileTypes = require(GameTile.GameTileTypes)

local function GridTileIconTextFooter(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTextSizeOffset()
    local var3 = useTokens()
    local size500 = if tbl1.isUnifiedGameTile then var3.Size.Size_500 else var1.Size.Size_500
    local var4 = if tbl1.isUnifiedGameTile then if tbl1.isNarrowScreenXSmall and tbl1.gameTileLayoutType == GameTileTypes.GameTileLayoutType.Narrow then var3.Gap.XXSmall else var3.Gap.XSmall else var1.Size.Size_100
    local default = if tbl1.isUnifiedGameTile then var3.Color.Content.Default else var1.Color.Content.Default
    local gameTileMetadataFont = getGameTileMetadataFont(tbl1.useLargerFont, var1, var3 or nil, if tbl1.isUnifiedGameTile then true else nil)

    local fontSize = gameTileMetadataFont.FontSize
    local iconSize, size500_2

    if tbl1.iconSize then
        iconSize = tbl1.iconSize
        size500_2 = var1.Size.Size_500
    else
        size500_2 = fontSize / 1.26
        iconSize = size500_2
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, size500 + var2),
        AutomaticSize = Enum.AutomaticSize.None,
        Position = tbl1.Position,
        ClipsDescendants = false,
        BackgroundTransparency = 1
    }

    local tbl3 = {
        IconSlot = React.createElement("Frame", {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(size500_2, size500_2),
            ClipsDescendants = false,
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5)
        }, {
            Icon = if tbl1.iconElement then tbl1.iconElement else React.createElement(ImageSetLabel, {
                Image = tbl1.icon,
                ImageColor3 = default.Color3,
                ImageTransparency = 0,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(iconSize, iconSize),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1
            })
        }),
        Text = React.createElement("TextLabel", {
            LayoutOrder = 2,
            Text = tbl1.text,
            Size = UDim2.new(1, -(size500_2 + var4), 0, fontSize + var2),
            AutomaticSize = Enum.AutomaticSize.None,
            Position = UDim2.new(0, size500_2 + var4, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            TextSize = fontSize,
            FontFace = normalizeFontFace(gameTileMetadataFont.Font),
            TextTransparency = default.Transparency,
            TextColor3 = default.Color3,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return GridTileIconTextFooter

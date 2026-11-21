-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)

local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local Foundation = require(GameTileParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTextSizeOffset = require(GameTileParent.UIBlox).Core.Style.useTextSizeOffset

local getGameTileMetadataFont = require(GameTile.Footer.getGameTileMetadataFont)

local function func1(num1: number, linesOfText: number?): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 * (linesOfText or 1)
end

local function GridTileTextFooter(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTextSizeOffset()
    local var3 = useTokens()
    local size500 = if tbl1.isUnifiedGameTile then var3.Size.Size_500 else var1.Size.Size_500
    local default = if tbl1.isUnifiedGameTile then var3.Color.Content.Default else var1.Color.Content.Default
    local gameTileMetadataFont = getGameTileMetadataFont(tbl1.useLargerFont, var1, var3, if tbl1.isUnifiedGameTile then true else nil)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(if tbl1.shouldSizeToContentWidth then 0 else 1, 0, 0, (func1(size500 + var2, tbl1.linesOfText))),
        AutomaticSize = if tbl1.shouldSizeToContentWidth then Enum.AutomaticSize.X else Enum.AutomaticSize.None,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        ClipsDescendants = false,
        BackgroundTransparency = 1
    }

    local tbl3 = {
        Text = React.createElement("TextLabel", {
            Text = tbl1.text,
            Size = UDim2.new(
                if tbl1.shouldSizeToContentWidth then 0 else 1,
                0,
                0,
                (func1(gameTileMetadataFont.FontSize + var2, tbl1.linesOfText))
            ),
            AutomaticSize = if tbl1.shouldSizeToContentWidth then Enum.AutomaticSize.X else Enum.AutomaticSize.None,
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            TextSize = gameTileMetadataFont.FontSize,
            FontFace = normalizeFontFace(gameTileMetadataFont.Font),
            TextTransparency = default.Transparency,
            TextColor3 = default.Color3,
            TextWrapped = tbl1.TextWrapped or false,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = tbl1.TextYAlignment or Enum.TextYAlignment.Center,
            ClipsDescendants = tbl1.ClipsDescendants,
            RichText = tbl1.RichText
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return GridTileTextFooter

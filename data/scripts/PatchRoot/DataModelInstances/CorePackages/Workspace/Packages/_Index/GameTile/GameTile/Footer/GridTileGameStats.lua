-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local Style = require(GameTileParent.Style)
local useDesignTokens = Style.useDesignTokens
local Foundation = require(GameTileParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local UIBlox = require(GameTileParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local getGameTileMetadataFont = require(GameTile.Footer.getGameTileMetadataFont)
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local Responsive = require(GameTileParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local GameTileTypes = require(GameTile.GameTileTypes)

local FFlagLuaAppFixSmallScreenFooterStatsOverlap = require(GameTileParent.SharedFlags).FFlagLuaAppFixSmallScreenFooterStatsOverlap
local FFlagLuaAppNarrowTileHideRating = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount

local iconsStatusGamesRating_small = Images["icons/status/games/rating_small"]
local iconsStatusGamesPeoplePlaying_small = Images["icons/status/games/people-playing_small"]

local vector2 = Vector2.new(math.huge, math.huge)

local function GridTileGameStats(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTextSizeOffset()
    local var3 = useTokens()
    local var4 = if FFlagLuaAppFixSmallScreenFooterStatsOverlap then useBreakpointXOrSmaller(Responsive.Keys.XSmall) and tbl1.gameTileLayoutType == GameTileTypes.GameTileLayoutType.Narrow else false
    local var5 = useBreakpointXOrSmaller(Responsive.Keys.Small) and tbl1.gameTileLayoutType == GameTileTypes.GameTileLayoutType.Narrow

    local var6 = var4 or tbl1.compactMetadataFormat
    local size500 = if tbl1.isUnifiedGameTile then var3.Size.Size_500 else var1.Size.Size_500
    local var7 = if tbl1.isUnifiedGameTile then if var6 then var3.Gap.XXSmall else var3.Gap.XSmall else var1.Size.Size_100
    local offset = if tbl1.isUnifiedGameTile then if var4 then var3.Gap.XXSmall else var3.Gap.Small else var1.Size.Size_200
    local default = if tbl1.isUnifiedGameTile then var3.Color.Content.Default else var1.Color.Content.Default
    local gameTileMetadataFont = getGameTileMetadataFont(
        tbl1.useLargerFont,
        var1,
        var3 or nil,
        if tbl1.isUnifiedGameTile then true else nil,
        tbl1.compactMetadataFormat
    )
    local fontSize = gameTileMetadataFont.FontSize
    local font = gameTileMetadataFont.Font

    if not (var2 > 0) then
        var5 = false
    end
    local var8 = fontSize / 1.26

    local ratingText = tbl1.ratingText
    local useMemo = React.useMemo
    local function func1()
        if FFlagLuaAppNarrowTileHideRating and tbl1.hideRating or ratingText == nil or ratingText == "" then
            return 0
        end

        return Style.GetTextSize(ratingText, fontSize, font, vector2, { addTemporaryPadding = false }).X
    end

    local hideRating = if FFlagLuaAppNarrowTileHideRating then tbl1.hideRating else nil
    local var9 = useMemo(func1, { ratingText, fontSize, font, var2, hideRating })

    local var10 = var8 + var7 + var9 + offset

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, if var5 then 1 else 0, if var5 then 0 else size500 + var2),
        Position = tbl1.Position,
        ClipsDescendants = false,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = if var5 then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = if var5 then nil else UDim.new(0, offset)
        }),
        RatingsFrame = 0,
        PlayerCountFrame = 0
    }
    local element

    if FFlagLuaAppNarrowTileHideRating and tbl1.hideRating then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.new(0, var9 + var8 + var7, 0, size500 + var2),
                LayoutOrder = 1,
                BackgroundTransparency = 1
            },
            {
                RatingIconSlot = React.createElement("Frame", {
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(var8, var8),
                    ClipsDescendants = false,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromScale(0, 0.5),
                    AnchorPoint = Vector2.new(0, 0.5)
                }, {
                    Icon = React.createElement(ImageSetLabel, {
                        Image = iconsStatusGamesRating_small,
                        ImageColor3 = default.Color3,
                        ImageTransparency = 0,
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(var8, var8),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1
                    })
                }),
                RatingText = React.createElement("TextLabel", {
                    LayoutOrder = 2,
                    Text = ratingText,
                    Size = UDim2.new(0, var9 + var7, 0, fontSize + var2),
                    Position = UDim2.new(0, var8 + var7, 0.5, 0),
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
        )
    end

    tbl3.RatingsFrame = element
    local element2

    if FFlagLuaAppNarrowTileHidePlayerCount and tbl1.hidePlayerCount then
        element2 = nil
    else
        element2 = React.createElement("Frame", {
            Size = if var5 then UDim2.new(1, 0, 0, size500 + var2) elseif FFlagLuaAppNarrowTileHideRating and tbl1.hideRating then UDim2.new(1, 0, 0, size500 + var2) else UDim2.new(1, -var10, 0, size500 + var2),
            LayoutOrder = 2,
            BackgroundTransparency = 1
        }, {
            PlayerCountIconSlot = React.createElement("Frame", {
                Position = UDim2.new(0, 0, 0.5, 0),
                LayoutOrder = 1,
                Size = UDim2.fromOffset(var8, var8),
                ClipsDescendants = false,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0, 0.5)
            }, {
                Icon = React.createElement(ImageSetLabel, {
                    Image = iconsStatusGamesPeoplePlaying_small,
                    ImageColor3 = default.Color3,
                    ImageTransparency = 0,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(var8, var8),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1
                })
            }),
            PlayerCountText = React.createElement("TextLabel", {
                LayoutOrder = 2,
                Text = tbl1.playerCountText,
                Size = UDim2.new(1, -var8 - var7, 0, fontSize + var2),
                Position = UDim2.new(0, var8 + var7, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                TextSize = gameTileMetadataFont.FontSize,
                FontFace = normalizeFontFace(gameTileMetadataFont.Font),
                TextTransparency = default.Transparency,
                TextColor3 = default.Color3,
                TextWrapped = false,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        })
    end

    tbl3.PlayerCountFrame = element2
    return createElement(str1, tbl2, tbl3)
end

return GridTileGameStats

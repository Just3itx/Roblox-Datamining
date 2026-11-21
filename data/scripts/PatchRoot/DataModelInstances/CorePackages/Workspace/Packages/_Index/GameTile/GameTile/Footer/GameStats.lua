-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GridTileGameStats = require(GameTile.Footer.GridTileGameStats)
local GridTileIconTextFooter = require(GameTile.Footer.GridTileIconTextFooter)
local getGameStatsRatingPercentageText = require(GameTile.Footer.getGameStatsRatingPercentageText)
local usePlayerCountText = require(GameTile.Footer.usePlayerCountText)
local getUserInputIsSelectionOnly = require(GameTile.Footer.getUserInputIsSelectionOnly)

local GameTileParent = GameTile.Parent
local Roact = require(GameTileParent.Roact)
local Colors = require(GameTileParent.Style).Colors
local Cryo = require(GameTileParent.Cryo)
local UIBlox = require(GameTileParent.UIBlox)
local normalizeFontFace = require(GameTileParent.Foundation).Utility.normalizeFontFace

local withStyle = UIBlox.Style.withStyle
local withTextSizeOffset = UIBlox.Core.Style.withTextSizeOffset
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local Interactable = UIBlox.Core.Control.Interactable
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local withLocalization = require(GameTileParent.Localization).withLocalization
local SponsoredTooltipHover = require(GameTileParent.Ads).SponsoredTooltipHover
local FFlagLuaAppNarrowTileHideRating = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount
local FFlagLuaAppGenreRatingFooter = require(GameTileParent.SharedFlags).FFlagLuaAppGenreRatingFooter

local iconsStatusGamesRating_small = Images["icons/status/games/rating_small"]
local iconsStatusGamesPeoplePlaying_small = Images["icons/status/games/people-playing_small"]

local var1 = Roact.PureComponent:extend("GameStats")

local var2 = nil
var2 = not FFlagLuaAppGenreRatingFooter and function(arg1, arg2): string
    arg1 = if arg1 == nil or arg1 < 0 then 0 else arg1

    local var3 = arg1 + (if arg2 == nil or arg2 < 0 then 0 else arg2)

    return if var3 > 0 then tostring(math.floor(arg1 / var3 * 100)) else "--"
end or var2

function var1.renderSponsored(arg1, arg2)
    local theme = arg2.Theme
    local font = arg2.Font

    local textSize = (if arg1.props.useLargerFont then font.Body else font.CaptionHeader).RelativeSize * font.BaseSize

    local function func1(arg3)
        local sponsoredText = arg3.sponsoredText
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl2 = {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 4)
            }),
            SponsoredText = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextSize = textSize,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                FontFace = normalizeFontFace(
                    if arg1.props.useLargerFont then arg2.Tokens.Typography.BodyLarge.Font else arg2.Tokens.Typography.CaptionLarge.Font
                ),
                Text = sponsoredText,
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 1
            }),
            SponsoredTooltip = Roact.createElement(SponsoredTooltipHover, {
                tooltipOrientation = TooltipOrientation.Bottom,
                onActivateTooltip = arg1.props.onActivateSponsoredTooltip,
                size = UDim2.new(0, 16, 0, 16),
                color = theme.TextEmphasis.Color,
                layoutOrder = 2,
                selectable = getUserInputIsSelectionOnly()
            })
        }
        local sponsoredBlockFrame = createElement(str1, tbl1, tbl2)

        local yOffset = math.ceil(textSize)

        local createElement2 = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, yOffset),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = theme.UIDefault.Color,
            BackgroundTransparency = theme.UIDefault.Transparency,
            BorderSizePixel = 0
        }
        local tbl4 = { SponsoredBlock = 0 }
        local createElement3 = Roact.createElement
        local var4 = Interactable
        local tbl5 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            onStateChanged = function() end,
            [Roact.Event.Activated] = arg1.props.onActivateSponsoredTooltip
        }
        tbl4.SponsoredBlock = createElement3(var4, tbl5, { SponsoredBlockFrame = sponsoredBlockFrame })
        return createElement2("Frame", tbl3, tbl4)
    end

    return withLocalization({ sponsoredText = "Feature.GamePage.Label.Sponsored" })(func1)
end

function var1.renderGameStats(tbl1, arg1, arg2, num1: number?)
    local stats = arg2.stats
    local var3 = if FFlagLuaAppGenreRatingFooter then getGameStatsRatingPercentageText(stats.totalUpVotes, stats.totalDownVotes) else var2(stats.totalUpVotes, stats.totalDownVotes)

    if stats.playerCount == nil then
        return withLocalization({ longRatingText = { "Feature.GameDetails.RatingPercentOnly", percentRating = var3 } })(function(arg3)
            return Roact.createElement(GridTileIconTextFooter, {
                icon = Images["icons/status/games/rating_small"],
                text = arg3.longRatingText,
                styleProps = { iconSize = 15, padding = 4 },
                useLargerFont = tbl1.props.useLargerFont,
                isUnifiedGameTile = arg2.isUnifiedGameTile
            })
        end)
    end

    if stats.totalUpVotes + stats.totalDownVotes > 0 then
        var3 ..= "%"
    end
    if not (arg2.isGridTile or arg2.isUnifiedGameTile) then
        return tbl1:renderFullGameStats(arg1, arg2, var3, num1)
    end

    return Roact.createElement(GridTileGameStats, {
        playerCountText = arg2.playerCountText,
        ratingText = var3,
        useLargerFont = tbl1.props.useLargerFont,
        isUnifiedGameTile = arg2.isUnifiedGameTile,
        gameTileLayoutType = arg2.gameTileLayoutType,
        LayoutOrder = tbl1.props.LayoutOrder,
        compactMetadataFormat = arg2.compactMetadataFormat,
        hideRating = if FFlagLuaAppNarrowTileHideRating then arg2.hideRating else nil,
        hidePlayerCount = if FFlagLuaAppNarrowTileHidePlayerCount then arg2.hidePlayerCount else nil
    })
end

function var1.renderFullGameStats(_, arg1, arg2, text, num1: number?)
    local playerCountText = if arg2.stats.playerCount then arg2.playerCountText else nil
    local theme = arg1.Theme
    local font = arg1.Font
    local textSize = font.BaseSize * font.CaptionSubHeader.RelativeSize
    local num2 = math.ceil(textSize)
    local maxTextSize = textSize + arg1.Tokens.Size.Size_150
    local yOffset = math.min(num2 + (num1 or 0), maxTextSize)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl2 = {
        VoteIcon = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0.125, 0, 0, yOffset),
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0, 0.5),
            BackgroundTransparency = 1,
            Image = iconsStatusGamesRating_small,
            ImageColor3 = theme.TextDefault.Color,
            ImageTransparency = theme.TextDefault.Transparency,
            ScaleType = Enum.ScaleType.Fit
        }),
        Vote = Roact.createElement(
            "TextLabel",
            {
                Size = UDim2.new(0.35, 0, 0, yOffset),
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromScale(0.15, 0.5),
                Text = text,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.CaptionLarge.Font),
                TextColor3 = theme.TextDefault.Color,
                TextTransparency = theme.TextDefault.Transparency,
                TextSize = textSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Bottom,
                TextTruncate = Enum.TextTruncate.AtEnd
            },
            {
                UiTextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = maxTextSize })
            }
        ),
        PlayerIcon = 0,
        PlayerCount = 0
    }
    local element

    if playerCountText == nil then
        element = nil
    else
        element = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0.125, 0, 0, yOffset),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = iconsStatusGamesPeoplePlaying_small,
            ImageColor3 = theme.TextDefault.Color,
            ImageTransparency = theme.TextDefault.Transparency,
            ScaleType = Enum.ScaleType.Fit
        })
    end

    tbl2.PlayerIcon = element
    local element2

    if playerCountText == nil then
        element2 = nil
    else
        element2 = Roact.createElement(
            "TextLabel",
            {
                Size = UDim2.new(0.35, 0, 0, yOffset),
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromScale(0.65, 0.5),
                Text = playerCountText,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.CaptionLarge.Font),
                TextColor3 = theme.TextDefault.Color,
                TextTransparency = theme.TextDefault.Transparency,
                TextSize = textSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Bottom,
                TextTruncate = Enum.TextTruncate.AtEnd
            },
            {
                UiTextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = maxTextSize })
            }
        )
    end

    tbl2.PlayerCount = element2
    return createElement(str1, tbl1, tbl2)
end

function var1.renderConcurrentUsersPill(_, arg1, arg2)
    local playerCountText = arg2.playerCountText
    local font = arg1.Font
    local textSize = font.BaseSize * font.Footer.RelativeSize

    return Roact.createElement("Frame", {
        Size = UDim2.new(0, 0, 0, 23),
        Position = UDim2.new(1, -8, 1, -8),
        AnchorPoint = Vector2.new(1, 1),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 0,
        BackgroundColor3 = Colors.Black
    }, {
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Padding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 15)
        }),
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0.15, 0)
        }),
        PillIcon = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0.7, 0, 0.7, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Image = iconsStatusGamesPeoplePlaying_small,
            ImageColor3 = Colors.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Fit
        }),
        PillPlayerCount = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Text = playerCountText,
            FontFace = normalizeFontFace(arg1.Tokens.Typography.CaptionSmall.Font),
            TextColor3 = Colors.White,
            TextTransparency = 0,
            TextSize = textSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom
        })
    })
end

function var1.render(arg1)
    local stats = arg1.props.stats
    if stats == nil then
        return nil
    end

    local function func1(arg2, num1: number?)
        if stats.isSponsored and stats.isShowSponsoredLabel then
            return arg1:renderSponsored(arg2)
        elseif stats.displayConcurrentUsersPill then
            return arg1:renderConcurrentUsersPill(arg2, arg1.props)
        elseif arg1.props.hideGameStats then
            return nil
        end
        return arg1:renderGameStats(arg2, arg1.props, num1)
    end

    return withTextSizeOffset(function(arg2)
        return withStyle(function(arg3)
            return func1(arg3, arg2)
        end)
    end)
end

return function(arg1)
    local playerCount = if arg1.stats then arg1.stats.playerCount or nil else nil
    local playerCountText = usePlayerCountText(playerCount)

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { playerCountText = playerCountText }))
end

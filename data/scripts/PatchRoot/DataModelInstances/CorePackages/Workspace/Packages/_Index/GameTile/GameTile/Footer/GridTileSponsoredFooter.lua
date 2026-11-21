-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GridTileIconTextFooter = require(GameTile.Footer.GridTileIconTextFooter)
local GridTileTextFooter = require(GameTile.Footer.GridTileTextFooter)

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local SponsoredTooltipHover = require(GameTileParent.Ads).SponsoredTooltipHover
local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization
local TooltipOrientation = require(GameTileParent.UIBlox).App.Dialog.Enum.TooltipOrientation
local _GameTileTypes = require(GameTile.GameTileTypes)
local getUserInputIsSelectionOnly = require(GameTile.Footer.getUserInputIsSelectionOnly)
local View = require(GameTileParent.Foundation).View
local Responsive = require(GameTileParent.Responsive)
local useBreakpointXOrLarger = Responsive.useBreakpointXOrLarger

function GridTileSponsoredFooter(tbl1)
    local var1 = useLocalization({ sponsoredText = "Feature.GamePage.Label.Sponsored", adText = "Feature.GamePage.Label.Ad" })

    local num1 = if tbl1.useLargerFont then 24 else 20
    local var2 = useBreakpointXOrLarger(Responsive.Keys.Medium)

    if not tbl1.enableSponsoredFeedback then
        return React.createElement(GridTileIconTextFooter, {
            iconElement = React.createElement(SponsoredTooltipHover, {
                tooltipOrientation = TooltipOrientation.Bottom,
                onActivateTooltip = tbl1.onActivateSponsoredTooltip,
                size = UDim2.fromOffset(num1, num1),
                position = UDim2.fromScale(0.5, 0.5),
                anchorPoint = Vector2.new(0.5, 0.5),
                selectable = getUserInputIsSelectionOnly(),
                supportTenFootUi = true
            }),
            text = var1.sponsoredText,
            iconSize = if tbl1.useLargerFont then 24 else 20,
            useLargerFont = tbl1.useLargerFont,
            isUnifiedGameTile = tbl1.isUnifiedGameTile,
            gameTileLayoutType = tbl1.gameTileLayoutType,
            isNarrowScreenXSmall = tbl1.isNarrowScreenXSmall
        })
    end

    local content = React.createElement(GridTileTextFooter, {
        text = var1.adText,
        useLargerFont = tbl1.useLargerFont,
        isUnifiedGameTile = tbl1.isUnifiedGameTile,
        shouldSizeToContentWidth = true
    })

    if not (var2 and tbl1.isSponsoredRatingFooterAllowed and tbl1.gameStatsElement) then
        return content
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y row align-y-center gap-xsmall clip"
    }, {
        AdLabelWrapper = React.createElement(View, {
            LayoutOrder = 1,
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BackgroundTransparency = 1
        }, { Content = content }),
        DotSeparator = React.createElement(GridTileTextFooter, {
            LayoutOrder = 2,
            text = "•",
            useLargerFont = tbl1.useLargerFont,
            isUnifiedGameTile = tbl1.isUnifiedGameTile,
            shouldSizeToContentWidth = true
        }),
        GameStatsWrapper = React.createElement(View, {
            LayoutOrder = 3,
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BackgroundTransparency = 1
        }, {
            Content = tbl1.gameStatsElement
        })
    })
end

return GridTileSponsoredFooter

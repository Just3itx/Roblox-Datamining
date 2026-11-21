-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local CoPlayFooter = require(GameTile.Footer.CoPlayFooter)
local usePlayerCountText = require(GameTile.Footer.usePlayerCountText)
local _GameTileTypes = require(GameTile.GameTileTypes)

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local UIBlox = require(GameTileParent.UIBlox)
local normalizeFontFace = require(GameTileParent.Foundation).Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local StatGroup = UIBlox.App.Indicator.StatGroup
local TextFooter = UIBlox.App.Tile.ExperienceTileMetadata.TextFooter
local CoPlayFooter2 = UIBlox.App.Tile.ExperienceTileMetadata.CoPlayFooter
local SocialProofFooter = UIBlox.App.Tile.ExperienceTileMetadata.SocialProofFooter
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization
local Colors = require(GameTileParent.Style).Colors
local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local SponsoredTooltipHover = require(GameTileParent.Ads).SponsoredTooltipHover
local ArgCheck = require(GameTileParent.ArgCheck)
local getUserInputIsSelectionOnly = require(GameTile.Footer.getUserInputIsSelectionOnly)

local uDim2 = UDim2.fromScale(1, 1)

return function(arg1)
    if arg1.automaticSize then
        ArgCheck.isNotNil(
            arg1.size,
            "If props.automaticSize is defined, props.size should also be defined.  Otherwise size falls back to a 1, 1 scale for this component."
        )
    end

    local isShowSponsoredLabel = arg1.isSponsored and arg1.isShowSponsoredLabel

    local isStatsOnly = arg1.isStatsOnly
    local isPlayable = arg1.isPlayable
    local requiresPurchase = arg1.requiresPurchase
    local rating = arg1.rating or ""
    local playingCount = arg1.playingCount or 0
    local coPlayFriends = arg1.coPlayFriends
    local showAgeRating = arg1.showAgeRating
    local ageRatingTextLabel = arg1.ageRatingTextLabel
    local useExperienceTileMetadata = arg1.useExperienceTileMetadata
    local onActivateSponsoredTooltip = arg1.onActivateSponsoredTooltip

    local playingText = usePlayerCountText(playingCount)

    local var2 = useStyle()
    local font = var2.Font
    local theme = var2.Theme

    local size = useDesignTokens().Size

    local var3 = useLocalization({
        sponsoredText = "Feature.GamePage.Label.Sponsored",
        notPlayableText = "Feature.ExperienceDetails.Label.NotPlayable",
        ageRatingText = ageRatingTextLabel or nil,
        friendsText = if useExperienceTileMetadata then "CommonUI.Features.Label.Friends" else nil
    })

    if not isStatsOnly then
        if isShowSponsoredLabel then
            local selectable = getUserInputIsSelectionOnly()

            local sponsoredLabel = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                },
                {
                    Layout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = UDim.new(0, 4)
                    }),
                    SponsoredText = React.createElement(StyledTextLabel, {
                        colorStyle = theme.TextEmphasis,
                        fontStyle = font.CaptionHeader,
                        textXAlignment = Enum.TextXAlignment.Center,
                        textYAlignment = Enum.TextYAlignment.Center,
                        automaticSize = Enum.AutomaticSize.X,
                        size = UDim2.new(0, 0, 1, 0),
                        lineHeight = 1,
                        text = var3.sponsoredText,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        richText = false,
                        layoutOrder = 1
                    }),
                    SponsoredTooltip = React.createElement(SponsoredTooltipHover, {
                        tooltipOrientation = TooltipOrientation.Bottom,
                        onActivateTooltip = onActivateSponsoredTooltip,
                        size = UDim2.new(0, 16, 0, 16),
                        color = theme.TextEmphasis.Color,
                        layoutOrder = 2,
                        selectable = selectable
                    })
                }
            )
            if useExperienceTileMetadata then
                return (React.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundColor3 = var2.Tokens.Color.Shift.Shift_200.Color3,
                        BackgroundTransparency = var2.Tokens.Color.Shift.Shift_200.Transparency,
                        BorderSizePixel = 0
                    },
                    {
                        Layout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            Padding = UDim.new(0, 4)
                        }),
                        Text = React.createElement("TextLabel", {
                            Size = UDim2.new(0, 0, 1, 0),
                            AutomaticSize = Enum.AutomaticSize.X,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Text = var3.sponsoredText,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextYAlignment = Enum.TextYAlignment.Center,
                            FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionLarge.Font),
                            TextSize = var2.Font.BaseSize * var2.Font.CaptionHeader.RelativeSize,
                            TextColor3 = var2.Tokens.Color.Content.Emphasis.Color3,
                            TextTransparency = var2.Tokens.Color.Content.Emphasis.Transparency,
                            LayoutOrder = 1
                        }),
                        SponsoredTooltip = React.createElement(SponsoredTooltipHover, {
                            tooltipOrientation = TooltipOrientation.Bottom,
                            onActivateTooltip = onActivateSponsoredTooltip,
                            size = UDim2.new(0, 16, 0, 16),
                            color = var2.Tokens.Color.Content.Emphasis.Color3,
                            layoutOrder = 2,
                            selectable = selectable,
                            supportTenFootUi = true
                        })
                    },
                    {
                        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Tokens.Radius.Small) })
                    }
                ))
            end

            return React.createElement(
                "Frame",
                {
                    Size = arg1.size or uDim2,
                    Position = arg1.position,
                    AnchorPoint = arg1.anchorPoint,
                    LayoutOrder = arg1.layoutOrder,
                    BackgroundTransparency = theme.UIDefault.Transparency,
                    BackgroundColor3 = theme.UIDefault.Color,
                    AutomaticSize = arg1.automaticSize
                },
                {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    SponsoredLabel = sponsoredLabel
                }
            )
        end
        if coPlayFriends and next(coPlayFriends) then
            if useExperienceTileMetadata then
                return React.createElement(CoPlayFooter2, {
                    users = coPlayFriends,
                    labelText = var3.friendsText,
                    showEmphasisBorder = true,
                    faceGroupCount = 2,
                    styleProps = {
                        faceWidth = size.Size_500,
                        faceHeight = size.Size_500,
                        faceGroupGap = -size.Size_150,
                        containerGap = size.Size_100,
                        badgeBorderWidth = 3,
                        badgeHeight = size.Size_500,
                        fontStyle = var2.Font.CaptionHeader,
                        badgeSpacingLeading = size.Size_100,
                        badgeSpacingTrailing = size.Size_100,
                        badgeBackgroundColor = {
                            Color = Colors.Smoke,
                            Transparency = 0
                        },
                        badgeContentColor = {
                            Color = Colors.White,
                            Transparency = 0
                        }
                    }
                })
            end

            local coPlayFooter = React.createElement(CoPlayFooter, { friends = coPlayFriends })

            return React.createElement("Frame", {
                Size = arg1.size or uDim2,
                Position = arg1.position,
                AnchorPoint = arg1.anchorPoint,
                LayoutOrder = arg1.layoutOrder,
                BackgroundTransparency = 1,
                AutomaticSize = arg1.automaticSize
            }, { CoPlayFooter = coPlayFooter })
        end

        if showAgeRating then
            local text = if arg1.localizedAgeRatingTextLabel then arg1.localizedAgeRatingTextLabel else var3.ageRatingText

            if useExperienceTileMetadata then
                return React.createElement(TextFooter, { text = text })
            end

            return React.createElement("Frame", {
                Size = arg1.size or uDim2,
                Position = arg1.position,
                AnchorPoint = arg1.anchorPoint,
                LayoutOrder = arg1.layoutOrder,
                BackgroundTransparency = 1,
                AutomaticSize = arg1.automaticSize
            }, {
                UIPadding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, 2),
                    PaddingRight = UDim.new(0, 0),
                    PaddingBottom = UDim.new(0, 2),
                    PaddingLeft = UDim.new(0, 0)
                }),
                AgeRatingLabel = React.createElement(StyledTextLabel, {
                    colorStyle = theme.TextEmphasis,
                    fontStyle = font.CaptionHeader,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Center,
                    size = UDim2.new(1, 0, 2, 0),
                    lineHeight = 1,
                    text = text,
                    textTruncate = Enum.TextTruncate.AtEnd,
                    richText = false
                })
            })
        end

        if arg1.showFriendActivity and not useExperienceTileMetadata then
            local textSize = font.BaseSize * font.Body.RelativeSize

            return React.createElement("TextLabel", {
                Size = arg1.size or uDim2,
                TextColor3 = theme.TextMuted.Color,
                FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                Text = arg1.friendActivityTitle,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = textSize,
                TextTransparency = theme.TextMuted.Transparency,
                BackgroundTransparency = 1
            })
        end

        if isPlayable == false and not requiresPurchase then
            if useExperienceTileMetadata then
                return React.createElement(TextFooter, { text = var3.notPlayableText })
            end

            return React.createElement("Frame", {
                Size = arg1.size or uDim2,
                Position = arg1.position,
                AnchorPoint = arg1.anchorPoint,
                LayoutOrder = arg1.layoutOrder,
                BackgroundTransparency = 1,
                AutomaticSize = arg1.automaticSize
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                PlayabilityLabel = React.createElement(StyledTextLabel, {
                    colorStyle = theme.TextMuted,
                    fontStyle = font.CaptionHeader,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Center,
                    size = UDim2.new(1, 0, 1, 0),
                    lineHeight = 1,
                    text = var3.notPlayableText,
                    textTruncate = Enum.TextTruncate.AtEnd,
                    richText = false
                })
            })
        end
    end

    if useExperienceTileMetadata then
        return React.createElement(SocialProofFooter, { ratingText = rating, playingText = playingText })
    end

    local experienceStats = React.createElement(StatGroup, { ratingText = rating, playingText = playingText })

    return React.createElement("Frame", {
        Size = arg1.size or uDim2,
        Position = arg1.position,
        AnchorPoint = arg1.anchorPoint,
        LayoutOrder = arg1.layoutOrder,
        BackgroundTransparency = 1,
        AutomaticSize = arg1.automaticSize
    }, { ExperienceStats = experienceStats })
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Foundation = require(SocialCarouselParent.Foundation)
local useLocalization = require(SocialCarouselParent.Localization).Hooks.useLocalization
local Constants = require(SocialCarousel.Common.Constants)
local useXSmallTileTypography = require(SocialCarousel.Hooks.useXSmallTileTypography)
local FFlagSocialCarouselXSmallTileText = require(SocialCarousel.Flags.FFlagSocialCarouselXSmallTileText)
local useTokens = Foundation.Hooks.useTokens
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local FoundationText = Foundation.Text
local View = Foundation.View

local FFlagSocialCarouselShareQREnabled = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselShareQREnabled

local function FriendsHintTile(tbl1)
    local var1 = useSocialCarouselContext()
    local var2 = if FFlagSocialCarouselXSmallTileText then useTokens() else nil
    local var3 = if FFlagSocialCarouselXSmallTileText then useXSmallTileTypography() else nil
    local tbl2, tbl3

    if FFlagSocialCarouselXSmallTileText and var3 and var2 then
        tbl2 = {
            Font = var2.Typography.BodySmall.Font,
            FontSize = var2.FontSize.FontSize_200,
            LineHeight = var2.Typography.BodySmall.LineHeight
        }
        tbl3 = {
            Font = var2.Typography.TitleMedium.Font,
            FontSize = var2.FontSize.FontSize_200,
            LineHeight = var2.Typography.TitleMedium.LineHeight
        }
    else
        tbl2 = nil
        tbl3 = nil
    end

    local var4 = FFlagSocialCarouselShareQREnabled
        and {
            friendsHintBold = Constants.LOCALIZATION.FRIENDS_HINT_BOLD,
            friendsHintPlain = Constants.LOCALIZATION.FRIENDS_HINT_PLAIN
        }
        or {
            friendsHintTitle = Constants.LOCALIZATION.FRIENDS_HINT_TITLE,
            friendsHintBody = Constants.LOCALIZATION.FRIENDS_HINT_BODY
        }

    local var5 = useLocalization(var4)

    React.useEffect(function()
        var1.onSuccessfulRender(Constants.ANALYTICS.UI_LOADING_EVENTS.EMPTY_HINT)
    end, {})

    return React.createElement(View, {
        Size = UDim2.new(
            tbl1.itemSize.X.Scale,
            tbl1.itemSize.X.Offset + Constants.TILE_TEXT_WIDTH,
            tbl1.itemSize.Y.Scale,
            if FFlagSocialCarouselXSmallTileText and var3 then tbl1.itemSize.X.Offset else tbl1.itemSize.Y.Offset - Constants.TILE_TEXT_HEIGHT
        ),
        LayoutOrder = tbl1.index,
        BackgroundTransparency = 1,
        tag = "col auto-none align-y-center"
    }, {
        Content = React.createElement(
            View,
            {
                BackgroundTransparency = 1,
                tag = {
                    ["auto-xy"] = FFlagSocialCarouselShareQREnabled,
                    ["col gap-xxsmall auto-xy"] = not FFlagSocialCarouselShareQREnabled
                }
            },
            FFlagSocialCarouselShareQREnabled
                and {
                    HintText = React.createElement(FoundationText, {
                        Text = `<b>{var5.friendsHintBold}</b> {var5.friendsHintPlain}`,
                        RichText = true,
                        fontStyle = tbl2,
                        tag = "text-body-small text-align-x-left auto-xy text-wrap"
                    })
                }
                or {
                    Title = React.createElement(FoundationText, {
                        Text = var5.friendsHintTitle,
                        fontStyle = tbl3,
                        tag = "text-title-medium text-align-x-left auto-xy text-wrap",
                        LayoutOrder = 1
                    }),
                    Subtitle = React.createElement(FoundationText, {
                        Text = var5.friendsHintBody,
                        fontStyle = tbl2,
                        tag = "text-body-small text-align-x-left auto-xy text-wrap",
                        LayoutOrder = 2
                    })
                }
        )
    })
end

return FriendsHintTile

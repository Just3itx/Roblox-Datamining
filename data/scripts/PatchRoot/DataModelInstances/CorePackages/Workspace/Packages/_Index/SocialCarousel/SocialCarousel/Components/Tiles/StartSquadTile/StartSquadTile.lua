-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local AppPage = require(SocialCarouselParent.RobloxAppEnums).AppPage
local Localization = require(SocialCarouselParent.Localization)
local useNavigation = require(SocialCarouselParent.Navigation).useNavigation

local React = require(SocialCarouselParent.React)

local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local Tile = require(SocialCarousel.BaseComponents.Tile)
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)

local useLocalization = Localization.Hooks.useLocalization

local Constants = require(SocialCarousel.Common.Constants)

local function StartSquadTile(tbl1)
    local var1 = FFlagSocialCarouselXXSmallTiles and tbl1.isCompact == true
    local var2 = useNavigation()
    local var3 = useSocialCarouselAnalytics()
    local var4 = useSocialCarouselContext()

    local var5 = useLocalization({ startPartyText = Constants.LOCALIZATION.START_SQUAD_TEXT })

    local onActivated = React.useCallback(function()
        if tbl1.item and tbl1.item.onActivated then
            tbl1.item.onActivated()
        else
            var2.navigate(AppPage.Chat)
        end

        var3.startSquadPressed(tbl1.index)
    end, {
        var2,
        tbl1.item,
        tbl1.index,
        var3.startSquadPressed
    })

    React.useEffect(function()
        var4.onSuccessfulRender(Constants.ANALYTICS.UI_LOADING_EVENTS.START_SQUAD)
    end, {})

    return React.createElement(Tile, {
        testId = tbl1.testId or `--social-social-carousel-view-start-squad-{tbl1.index}`,
        index = tbl1.index,
        itemSize = tbl1.itemSize,
        onActivated = onActivated,
        title = var5.startPartyText,
        icon = if var1 then "person-play" else "icons/actions/friends/friendsplaying",
        iconScale = if var1 then Constants.TILE_ICON_SCALE else nil,
        selectionOrder = tbl1.selectionOrder
    })
end

return StartSquadTile

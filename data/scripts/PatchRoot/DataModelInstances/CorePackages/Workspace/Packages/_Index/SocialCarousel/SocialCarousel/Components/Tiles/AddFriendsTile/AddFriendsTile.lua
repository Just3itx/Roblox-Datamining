-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Localization = require(SocialCarouselParent.Localization)
local Foundation = require(SocialCarouselParent.Foundation)
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)

local useLocalization = Localization.Hooks.useLocalization
local Constants = require(SocialCarousel.Common.Constants)
local Tile = require(SocialCarousel.BaseComponents.Tile)

local bool1 = game:DefineFastFlag("UpdateSocialCarouselAddFriendsIcon", false)

local str1 = if bool1 then "icons/actions/friend_sort/add_friends" else "icons/common/plus_heavy"

local function AddFriendsTile(tbl1)
    local var1 = FFlagSocialCarouselXXSmallTiles and tbl1.isCompact == true
    local var2 = useLocalization({
        addFriendsHeading = if var1 then Constants.LOCALIZATION.ADD_FRIENDS_HEADING_SENTENCE_CASE else Constants.LOCALIZATION.ADD_FRIENDS_HEADING
    })

    return React.createElement(Tile, {
        testId = tbl1.testId or `--social-social-carousel-view-add-friends-{tbl1.index}`,
        index = tbl1.index,
        itemSize = tbl1.itemSize,
        onActivated = tbl1.onActivated,
        title = var2.addFriendsHeading,
        icon = var1 and (if bool1 then "person-plus" else "plus-large") or str1,
        iconScale = if var1 then Constants.TILE_ICON_SCALE else nil,
        titleOverhang = if var1 then Constants.ADD_FRIENDS_TITLE_OVERHANG else nil,
        iconVariant = if var1 and not bool1 then Foundation.Enums.IconVariant.Filled else nil,
        selectionOrder = tbl1.selectionOrder,
        badge = tbl1.badge
    })
end

return AddFriendsTile

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Localization = require(SocialCarouselParent.Localization)
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)

local useLocalization = Localization.Hooks.useLocalization
local Constants = require(SocialCarousel.Common.Constants)
local Tile = require(SocialCarousel.BaseComponents.Tile)

local function ShareQRTile(tbl1)
    local var1 = FFlagSocialCarouselXXSmallTiles and tbl1.isCompact == true
    local var2 = useLocalization({ shareQRHeading = Constants.LOCALIZATION.SHARE_QR_HEADING })

    return React.createElement(Tile, {
        testId = tbl1.testId or `--social-social-carousel-view-share-qr-{tbl1.index}`,
        index = tbl1.index,
        itemSize = tbl1.itemSize,
        onActivated = tbl1.onActivated,
        title = var2.shareQRHeading,
        icon = if var1 then "squares-grid-qr" else "icons/actions/friend_sort/qr_code",
        iconScale = if var1 then Constants.TILE_ICON_SCALE else nil,
        selectionOrder = tbl1.selectionOrder
    })
end

return ShareQRTile

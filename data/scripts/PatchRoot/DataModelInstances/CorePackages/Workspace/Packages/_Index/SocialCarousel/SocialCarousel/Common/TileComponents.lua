-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Tile = require(SocialCarousel.Common.Enums).Tile
local UserTile = require(SocialCarousel.Components.Tiles.UserTile)
local AddFriendsTile = require(SocialCarousel.Components.Tiles.AddFriendsTile)
local FriendsHintTile = require(SocialCarousel.Components.Tiles.FriendsHintTile)
local StartSquadTile = require(SocialCarousel.Components.Tiles.StartSquadTile)
local ShareQRTile = require(SocialCarousel.Components.Tiles.ShareQRTile)
local Tile2 = require(SocialCarousel.BaseComponents.Tile)
local FFlagSocialCarouselShareQREnabled = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselShareQREnabled
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)

local function renderUserTile(arg1, index: number, uDim2: UDim2, selectionOrder: number?, onTileContentChanged, _: boolean?, playStatus, onMarqueeFinished: ((...any) -> (...any))?, marqueeRunId: number?, onManualMarqueeStart: ((...any) -> (...any))?, onManualMarqueeEnd: ((...any) -> (...any))?, marqueeOnFocusEnabled: boolean?, marqueeShortTitlesEnabled: boolean?)
    local tbl1 = {
        item = arg1,
        index = index,
        itemSize = uDim2,
        selectionOrder = selectionOrder,
        onTileContentChanged = onTileContentChanged
    }
    if FFlagSocialCarouselInGameTitleMarquee then
        tbl1.playStatus = playStatus
        tbl1.onMarqueeFinished = onMarqueeFinished
        tbl1.marqueeRunId = marqueeRunId
        tbl1.onManualMarqueeStart = onManualMarqueeStart
        tbl1.onManualMarqueeEnd = onManualMarqueeEnd
        tbl1.marqueeOnFocusEnabled = marqueeOnFocusEnabled
        tbl1.marqueeShortTitlesEnabled = marqueeShortTitlesEnabled
    end
    return React.createElement(UserTile, tbl1)
end

local module = {
    [Tile.Friend] = renderUserTile,
    [Tile.Recommendation] = renderUserTile,
    [Tile.FriendRequest] = renderUserTile
}

module[Tile.AddFriends] = function(_, index: number, uDim2: UDim2, selectionOrder: number?, _, isCompact: boolean?)
    local createElement = React.createElement
    local var1 = AddFriendsTile
    local tbl1 = { index = index, itemSize = uDim2, selectionOrder = selectionOrder, isCompact = 0 }
    if not FFlagSocialCarouselXXSmallTiles then
        isCompact = nil
    end

    tbl1.isCompact = isCompact
    return createElement(var1, tbl1)
end

module[Tile.FriendsHint] = function(_, index: number, uDim2: UDim2, selectionOrder: number?, _)
    return React.createElement(FriendsHintTile, { index = index, itemSize = uDim2, selectionOrder = selectionOrder })
end

module[Tile.StartSquad] = function(arg1, index: number, uDim2: UDim2, selectionOrder: number?, _, isCompact: boolean?)
    local createElement = React.createElement
    local var1 = StartSquadTile
    local tbl1 = {
        index = index,
        item = arg1,
        itemSize = uDim2,
        selectionOrder = selectionOrder,
        isCompact = 0
    }

    if not FFlagSocialCarouselXXSmallTiles then
        isCompact = nil
    end

    tbl1.isCompact = isCompact
    return createElement(var1, tbl1)
end

module[Tile.ShareQR] = FFlagSocialCarouselShareQREnabled and function(_, index: number, uDim2: UDim2, selectionOrder: number?, _, isCompact: boolean?)
    local createElement = React.createElement
    local var1 = ShareQRTile
    local tbl1 = { index = index, itemSize = uDim2, selectionOrder = selectionOrder, isCompact = 0 }
    if not FFlagSocialCarouselXXSmallTiles then
        isCompact = nil
    end

    tbl1.isCompact = isCompact
    return createElement(var1, tbl1)
end or nil

module[Tile.Skeleton] = function(_, index: number, uDim2: UDim2, _: number?, _)
    return React.createElement(Tile2, { isLoading = true, index = index, itemSize = uDim2 })
end

return module

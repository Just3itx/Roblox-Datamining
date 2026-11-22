-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.dependencies).React
local BtnValues = require(scriptParentParentParent.Analytics).BtnValues

local getFIntPYMKSeeAllTileLimit = require(scriptParentParentParent.Flags.getFIntPYMKSeeAllTileLimit)
local _DirectRecommendationTypes = require(scriptParentParentParent.Common.DirectRecommendationTypes)

local function usePYMKCarouselItemList(tbl1)
    return React.useMemo(function()
        if not (tbl1.findFriendsTileEnabled or tbl1.seeAllTileEnabled) then
            return tbl1.recommendationIds
        end

        local var1 = table.clone(tbl1.recommendationIds)

        if tbl1.findFriendsTileEnabled then
            table.insert(var1, 1, { id = BtnValues.FindFriends.rawValue(), isButtonTile = true })
            if tbl1.recommendationCount == 0 then
                table.insert(var1, { id = "_findFriendsTooltip", isTooltip = true })
            end
        end

        if tbl1.seeAllTileEnabled and tbl1.recommendationCount > getFIntPYMKSeeAllTileLimit() then
            table.insert(var1, { id = BtnValues.SeeAll.rawValue(), isButtonTile = true })
        end

        return var1
    end, { tbl1.recommendationIds, tbl1.findFriendsTileEnabled })
end

return usePYMKCarouselItemList

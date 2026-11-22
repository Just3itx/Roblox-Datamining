-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local _PYMKCarousel = require(SocialServerDrivenUiParent.PYMKCarousel)
local FriendsRecommendations = require(SocialServerDrivenUiParent.DataHydration.FriendsRecommendations)
local ContextType = FriendsRecommendations.Enums.ContextType
local FFlagShowClassmatesOnPYMK = require(SocialServerDrivenUiParent.SharedFlags.FFlagShowClassmatesOnPYMK)

local RecommendationType = FriendsRecommendations.FriendRecommendations.RecommendationType

local function normalizeDirectRecommendations(tbl1, tbl2)
    local result = {}

    for _, value in tbl1 do
        local var1 = tbl2[value.id]
        if var1 == nil then
            continue
        end

        if var1.recommendationType == RecommendationType.User then
            local mutualFriendsCount = var1.mutualFriendsCount or 0
            local contextType = if var1.contextType == ContextType.MutualFriends and mutualFriendsCount > 0 then ContextType.MutualFriends elseif var1.contextType == ContextType.Frequents then ContextType.Frequents elseif FFlagShowClassmatesOnPYMK and var1.contextType == ContextType.Classmates then ContextType.Classmates else ContextType.None
            table.insert(result, {
                id = value.id,
                rank = value.rank,
                contextType = contextType,
                mutualFriendsCount = mutualFriendsCount,
                hasIncomingFriendRequest = value.hasPendingFriendRequest
            })
        elseif var1.recommendationType == RecommendationType.Contact then
            table.insert(result, {
                id = value.id,
                rank = value.rank,
                contextType = ContextType.Contacts,
                mutualFriendsCount = 0,
                hasIncomingFriendRequest = value.hasPendingFriendRequest,
                entityDisplayName = var1.contactName,
                thumbnailEntities = {
                    avatarImageUrl = var1.avatarThumbnailUrl,
                    headshotImageUrl = var1.headshotThumbnailUrl
                }
            })
        end
    end

    return result
end

return normalizeDirectRecommendations

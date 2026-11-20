-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local badge_data = require(script.Parent.badge_data)

local buy_robux_bonus_item_data = require(script.Parent.buy_robux_bonus_item_data)

local buy_robux_pending_transfer_data = require(script.Parent.buy_robux_pending_transfer_data)
local buy_robux_product_data = require(script.Parent.buy_robux_product_data)
local universe_data = require(script.Parent.universe_data)

local universe_user_favorite_data = require(script.Parent.universe_user_favorite_data)

local universe_user_follow_data = require(script.Parent.universe_user_follow_data)

local universe_user_follow_limit_data = require(script.Parent.universe_user_follow_limit_data)
local universe_user_vote_data = require(script.Parent.universe_user_vote_data)

local universe_user_vote_feedback_metadata_data = require(script.Parent.universe_user_vote_feedback_metadata_data)
local creator_data = require(script.Parent.creator_data)
local event_data = require(script.Parent.event_data)
local song_data = require(script.Parent.song_data)
local game_pass_data = require(script.Parent.game_pass_data)
local playability_data = require(script.Parent.playability_data)
local media_asset_data = require(script.Parent.media_asset_data)
local social_link_data = require(script.Parent.social_link_data)

local marketplace_catalog_category_data = require(script.Parent.marketplace_catalog_category_data)
local marketplace_asset_data = require(script.Parent.marketplace_asset_data)
local marketplace_bundle_data = require(script.Parent.marketplace_bundle_data)
local marketplace_look_data = require(script.Parent.marketplace_look_data)

local marketplace_item_user_favorite_data = require(script.Parent.marketplace_item_user_favorite_data)
local catalog_sort_data = require(script.Parent.catalog_sort_data)

local game_developer_product_data = require(script.Parent.game_developer_product_data)
local game_subscription_data = require(script.Parent.game_subscription_data)
local age_recommendation_data = require(script.Parent.age_recommendation_data)
local user_profile_data = require(script.Parent.user_profile_data)
local moment_data = require(script.Parent.moment_data)
local community_data = require(script.Parent.community_data)

local community_user_membership_data = require(script.Parent.community_user_membership_data)

local friend_recommendation_data = require(script.Parent.friend_recommendation_data)
local notification_badge_data = require(script.Parent.notification_badge_data)

local universe_private_server_data = require(script.Parent.universe_private_server_data)
local collectible_item_data = require(script.Parent.collectible_item_data)
local leaderboard_stats_data = require(script.Parent.leaderboard_stats_data)

local user_library_saved_state_data = require(script.Parent.user_library_saved_state_data)
local vote_data = require(script.Parent.vote_data)

local HydrationContent = {}
HydrationContent.__index = HydrationContent

function HydrationContent.new(tbl3)
    return (setmetatable({
        badge = (tbl3 == nil or tbl3.badge == nil) and {} or tbl3.badge,
        universe = (tbl3 == nil or tbl3.universe == nil) and {} or tbl3.universe,
        creator = (tbl3 == nil or tbl3.creator == nil) and {} or tbl3.creator,
        event = (tbl3 == nil or tbl3.event == nil) and {} or tbl3.event,
        song = (tbl3 == nil or tbl3.song == nil) and {} or tbl3.song,
        game_pass = (tbl3 == nil or tbl3.game_pass == nil) and {} or tbl3.game_pass,
        media_asset = (tbl3 == nil or tbl3.media_asset == nil) and {} or tbl3.media_asset,
        social_link = (tbl3 == nil or tbl3.social_link == nil) and {} or tbl3.social_link,
        game_developer_product = (tbl3 == nil or tbl3.game_developer_product == nil) and {} or tbl3.game_developer_product,
        game_subscription = (tbl3 == nil or tbl3.game_subscription == nil) and {} or tbl3.game_subscription,
        marketplace_catalog_category = (tbl3 == nil or tbl3.marketplace_catalog_category == nil) and {} or tbl3.marketplace_catalog_category,
        marketplace_asset = (tbl3 == nil or tbl3.marketplace_asset == nil) and {} or tbl3.marketplace_asset,
        marketplace_bundle = (tbl3 == nil or tbl3.marketplace_bundle == nil) and {} or tbl3.marketplace_bundle,
        marketplace_look = (tbl3 == nil or tbl3.marketplace_look == nil) and {} or tbl3.marketplace_look,
        catalog_sort = (tbl3 == nil or tbl3.catalog_sort == nil) and {} or tbl3.catalog_sort,
        age_recommendation = (tbl3 == nil or tbl3.age_recommendation == nil) and {} or tbl3.age_recommendation,
        universe_user_follow = (tbl3 == nil or tbl3.universe_user_follow == nil) and {} or tbl3.universe_user_follow,
        universe_user_vote = (tbl3 == nil or tbl3.universe_user_vote == nil) and {} or tbl3.universe_user_vote,
        user_profile = (tbl3 == nil or tbl3.user_profile == nil) and {} or tbl3.user_profile,
        universe_user_favorite = (tbl3 == nil or tbl3.universe_user_favorite == nil) and {} or tbl3.universe_user_favorite,
        playability = (tbl3 == nil or tbl3.playability == nil) and {} or tbl3.playability,
        universe_user_follow_limit = (tbl3 == nil or tbl3.universe_user_follow_limit == nil) and {} or tbl3.universe_user_follow_limit,
        universe_user_vote_feedback_metadata = (tbl3 == nil or tbl3.universe_user_vote_feedback_metadata == nil) and {} or tbl3.universe_user_vote_feedback_metadata,
        moment = (tbl3 == nil or tbl3.moment == nil) and {} or tbl3.moment,
        community = (tbl3 == nil or tbl3.community == nil) and {} or tbl3.community,
        community_user_membership = (tbl3 == nil or tbl3.community_user_membership == nil) and {} or tbl3.community_user_membership,
        friend_recommendation = (tbl3 == nil or tbl3.friend_recommendation == nil) and {} or tbl3.friend_recommendation,
        universe_private_server = (tbl3 == nil or tbl3.universe_private_server == nil) and {} or tbl3.universe_private_server,
        notification_badge = (tbl3 == nil or tbl3.notification_badge == nil) and {} or tbl3.notification_badge,
        collectible_item = (tbl3 == nil or tbl3.collectible_item == nil) and {} or tbl3.collectible_item,
        leaderboard_stats = (tbl3 == nil or tbl3.leaderboard_stats == nil) and {} or tbl3.leaderboard_stats,
        marketplace_asset_user_favorite = (tbl3 == nil or tbl3.marketplace_asset_user_favorite == nil) and {} or tbl3.marketplace_asset_user_favorite,
        marketplace_bundle_user_favorite = (tbl3 == nil or tbl3.marketplace_bundle_user_favorite == nil) and {} or tbl3.marketplace_bundle_user_favorite,
        buy_robux_one_time_product = (tbl3 == nil or tbl3.buy_robux_one_time_product == nil) and {} or tbl3.buy_robux_one_time_product,
        buy_robux_subscription_product = (tbl3 == nil or tbl3.buy_robux_subscription_product == nil) and {} or tbl3.buy_robux_subscription_product,
        buy_robux_pending_transfer = (tbl3 == nil or tbl3.buy_robux_pending_transfer == nil) and {} or tbl3.buy_robux_pending_transfer,
        buy_robux_bonus_item = (tbl3 == nil or tbl3.buy_robux_bonus_item == nil) and {} or tbl3.buy_robux_bonus_item,
        user_library_saved_state = (tbl3 == nil or tbl3.user_library_saved_state == nil) and {} or tbl3.user_library_saved_state,
        game_pass_vote = (tbl3 == nil or tbl3.game_pass_vote == nil) and {} or tbl3.game_pass_vote
    }, HydrationContent))
end

function HydrationContent:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.badge ~= nil and next(self.badge) ~= nil then
        for value, value2 in self.badge do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe ~= nil and next(self.universe) ~= nil then
        for value, value2 in self.universe do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.creator ~= nil and next(self.creator) ~= nil then
        for value, value2 in self.creator do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.event ~= nil and next(self.event) ~= nil then
        for value, value2 in self.event do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.song ~= nil and next(self.song) ~= nil then
        for value, value2 in self.song do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.game_pass ~= nil and next(self.game_pass) ~= nil then
        for value, value2 in self.game_pass do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.media_asset ~= nil and next(self.media_asset) ~= nil then
        for value, value2 in self.media_asset do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.social_link ~= nil and next(self.social_link) ~= nil then
        for value, value2 in self.social_link do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.game_developer_product ~= nil and next(self.game_developer_product) ~= nil then
        for value, value2 in self.game_developer_product do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.game_subscription ~= nil and next(self.game_subscription) ~= nil then
        for value, value2 in self.game_subscription do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_catalog_category ~= nil and next(self.marketplace_catalog_category) ~= nil then
        for value, value2 in self.marketplace_catalog_category do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_asset ~= nil and next(self.marketplace_asset) ~= nil then
        for value, value2 in self.marketplace_asset do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_bundle ~= nil and next(self.marketplace_bundle) ~= nil then
        for value, value2 in self.marketplace_bundle do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_look ~= nil and next(self.marketplace_look) ~= nil then
        for value, value2 in self.marketplace_look do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.catalog_sort ~= nil and next(self.catalog_sort) ~= nil then
        for value, value2 in self.catalog_sort do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.age_recommendation ~= nil and next(self.age_recommendation) ~= nil then
        for value, value2 in self.age_recommendation do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_user_follow ~= nil and next(self.universe_user_follow) ~= nil then
        for value, value2 in self.universe_user_follow do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_user_vote ~= nil and next(self.universe_user_vote) ~= nil then
        for value, value2 in self.universe_user_vote do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 18, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.user_profile ~= nil and next(self.user_profile) ~= nil then
        for value, value2 in self.user_profile do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 19, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_user_favorite ~= nil and next(self.universe_user_favorite) ~= nil then
        for value, value2 in self.universe_user_favorite do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 20, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.playability ~= nil and next(self.playability) ~= nil then
        for value, value2 in self.playability do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 21, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_user_follow_limit ~= nil and next(self.universe_user_follow_limit) ~= nil then
        for value, value2 in self.universe_user_follow_limit do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 22, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_user_vote_feedback_metadata ~= nil and next(self.universe_user_vote_feedback_metadata) ~= nil then
        for value, value2 in self.universe_user_vote_feedback_metadata do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 23, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.moment ~= nil and next(self.moment) ~= nil then
        for value, value2 in self.moment do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 24, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.community ~= nil and next(self.community) ~= nil then
        for value, value2 in self.community do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 25, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.community_user_membership ~= nil and next(self.community_user_membership) ~= nil then
        for value, value2 in self.community_user_membership do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 26, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.friend_recommendation ~= nil and next(self.friend_recommendation) ~= nil then
        for value, value2 in self.friend_recommendation do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 27, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.universe_private_server ~= nil and next(self.universe_private_server) ~= nil then
        for value, value2 in self.universe_private_server do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 28, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.notification_badge ~= nil and next(self.notification_badge) ~= nil then
        for value, value2 in self.notification_badge do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 29, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.collectible_item ~= nil and next(self.collectible_item) ~= nil then
        for value, value2 in self.collectible_item do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 30, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.leaderboard_stats ~= nil and next(self.leaderboard_stats) ~= nil then
        for k, leaderboardStat in self.leaderboard_stats do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local buf = leaderboardStat:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 31, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_asset_user_favorite ~= nil and next(self.marketplace_asset_user_favorite) ~= nil then
        for value, value2 in self.marketplace_asset_user_favorite do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 32, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.marketplace_bundle_user_favorite ~= nil and next(self.marketplace_bundle_user_favorite) ~= nil then
        for value, value2 in self.marketplace_bundle_user_favorite do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 33, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.buy_robux_one_time_product ~= nil and next(self.buy_robux_one_time_product) ~= nil then
        for value, value2 in self.buy_robux_one_time_product do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 34, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.buy_robux_subscription_product ~= nil and next(self.buy_robux_subscription_product) ~= nil then
        for value, value2 in self.buy_robux_subscription_product do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 35, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.buy_robux_pending_transfer ~= nil and next(self.buy_robux_pending_transfer) ~= nil then
        for value, value2 in self.buy_robux_pending_transfer do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 36, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.buy_robux_bonus_item ~= nil and next(self.buy_robux_bonus_item) ~= nil then
        for value, value2 in self.buy_robux_bonus_item do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 37, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.user_library_saved_state ~= nil and next(self.user_library_saved_state) ~= nil then
        for value, value2 in self.user_library_saved_state do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 38, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.game_pass_vote ~= nil and next(self.game_pass_vote) ~= nil then
        for value, value2 in self.game_pass_vote do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 39, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent.decode(buf1: buffer)
    local var1 = HydrationContent.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_BadgeEntry.decode(var4)

                local badgeData = badge_data.BadgeData.new()

                var1.badge[var5.key or ""] = var5.value or badgeData
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseEntry.decode(var4)

                local universeData = universe_data.UniverseData.new()

                var1.universe[var5.key or ""] = var5.value or universeData
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_CreatorEntry.decode(var4)

                local creatorData = creator_data.CreatorData.new()

                var1.creator[var5.key or ""] = var5.value or creatorData
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_EventEntry.decode(var4)

                local eventData = event_data.EventData.new()

                var1.event[var5.key or ""] = var5.value or eventData
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_SongEntry.decode(var4)

                local songData = song_data.SongData.new()

                var1.song[var5.key or ""] = var5.value or songData
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_GamePassEntry.decode(var4)

                local gamePassData = game_pass_data.GamePassData.new()

                var1.game_pass[var5.key or ""] = var5.value or gamePassData
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MediaAssetEntry.decode(var4)

                local mediaAssetData = media_asset_data.MediaAssetData.new()

                var1.media_asset[var5.key or ""] = var5.value or mediaAssetData
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_SocialLinkEntry.decode(var4)

                local socialLinkData = social_link_data.SocialLinkData.new()

                var1.social_link[var5.key or ""] = var5.value or socialLinkData
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_GameDeveloperProductEntry.decode(var4)

                local gameDeveloperProductData = game_developer_product_data.GameDeveloperProductData.new()

                var1.game_developer_product[var5.key or ""] = var5.value or gameDeveloperProductData
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_GameSubscriptionEntry.decode(var4)

                local gameSubscriptionData = game_subscription_data.GameSubscriptionData.new()

                var1.game_subscription[var5.key or ""] = var5.value or gameSubscriptionData
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceCatalogCategoryEntry.decode(var4)

                local marketplaceCatalogCategoryData = marketplace_catalog_category_data.MarketplaceCatalogCategoryData.new()

                var1.marketplace_catalog_category[var5.key or ""] = var5.value or marketplaceCatalogCategoryData
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceAssetEntry.decode(var4)

                local marketplaceAssetData = marketplace_asset_data.MarketplaceAssetData.new()

                var1.marketplace_asset[var5.key or ""] = var5.value or marketplaceAssetData
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceBundleEntry.decode(var4)

                local marketplaceBundleData = marketplace_bundle_data.MarketplaceBundleData.new()

                var1.marketplace_bundle[var5.key or ""] = var5.value or marketplaceBundleData
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceLookEntry.decode(var4)

                local marketplaceLookData = marketplace_look_data.MarketplaceLookData.new()

                var1.marketplace_look[var5.key or ""] = var5.value or marketplaceLookData
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_CatalogSortEntry.decode(var4)

                local catalogSortData = catalog_sort_data.CatalogSortData.new()

                var1.catalog_sort[var5.key or ""] = var5.value or catalogSortData
            elseif var2 == 16 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_AgeRecommendationEntry.decode(var4)

                local ageRecommendationData = age_recommendation_data.AgeRecommendationData.new()

                var1.age_recommendation[var5.key or ""] = var5.value or ageRecommendationData
            elseif var2 == 17 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseUserFollowEntry.decode(var4)

                local universeUserFollowData = universe_user_follow_data.UniverseUserFollowData.new()

                var1.universe_user_follow[var5.key or ""] = var5.value or universeUserFollowData
            elseif var2 == 18 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseUserVoteEntry.decode(var4)

                local universeUserVoteData = universe_user_vote_data.UniverseUserVoteData.new()

                var1.universe_user_vote[var5.key or ""] = var5.value or universeUserVoteData
            elseif var2 == 19 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UserProfileEntry.decode(var4)

                local userProfileData = user_profile_data.UserProfileData.new()

                var1.user_profile[var5.key or ""] = var5.value or userProfileData
            elseif var2 == 20 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseUserFavoriteEntry.decode(var4)

                local universeUserFavoriteData = universe_user_favorite_data.UniverseUserFavoriteData.new()

                var1.universe_user_favorite[var5.key or ""] = var5.value or universeUserFavoriteData
            elseif var2 == 21 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_PlayabilityEntry.decode(var4)

                local playabilityData = playability_data.PlayabilityData.new()

                var1.playability[var5.key or ""] = var5.value or playabilityData
            elseif var2 == 22 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseUserFollowLimitEntry.decode(var4)

                local universeUserFollowLimitData = universe_user_follow_limit_data.UniverseUserFollowLimitData.new()

                var1.universe_user_follow_limit[var5.key or ""] = var5.value or universeUserFollowLimitData
            elseif var2 == 23 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniverseUserVoteFeedbackMetadataEntry.decode(var4)

                local universeUserVoteFeedbackMetadataData = universe_user_vote_feedback_metadata_data.UniverseUserVoteFeedbackMetadataData.new()

                var1.universe_user_vote_feedback_metadata[var5.key or ""] = var5.value or universeUserVoteFeedbackMetadataData
            elseif var2 == 24 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MomentEntry.decode(var4)

                local momentData = moment_data.MomentData.new()

                var1.moment[var5.key or ""] = var5.value or momentData
            elseif var2 == 25 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_CommunityEntry.decode(var4)

                local communityData = community_data.CommunityData.new()

                var1.community[var5.key or ""] = var5.value or communityData
            elseif var2 == 26 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_CommunityUserMembershipEntry.decode(var4)

                local communityUserMembershipData = community_user_membership_data.CommunityUserMembershipData.new()

                var1.community_user_membership[var5.key or ""] = var5.value or communityUserMembershipData
            elseif var2 == 27 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_FriendRecommendationEntry.decode(var4)

                local friendRecommendationData = friend_recommendation_data.FriendRecommendationData.new()

                var1.friend_recommendation[var5.key or ""] = var5.value or friendRecommendationData
            elseif var2 == 28 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UniversePrivateServerEntry.decode(var4)

                local universePrivateServerData = universe_private_server_data.UniversePrivateServerData.new()

                var1.universe_private_server[var5.key or ""] = var5.value or universePrivateServerData
            elseif var2 == 29 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_NotificationBadgeEntry.decode(var4)

                local notificationBadgeData = notification_badge_data.NotificationBadgeData.new()

                var1.notification_badge[var5.key or ""] = var5.value or notificationBadgeData
            elseif var2 == 30 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_CollectibleItemEntry.decode(var4)

                local collectibleItemData = collectible_item_data.CollectibleItemData.new()

                var1.collectible_item[var5.key or ""] = var5.value or collectibleItemData
            elseif var2 == 31 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_LeaderboardStatsEntry.decode(var4)

                local leaderboardStatsData = leaderboard_stats_data.LeaderboardStatsData.new()

                var1.leaderboard_stats[var5.key or ""] = var5.value or leaderboardStatsData
            elseif var2 == 32 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceAssetUserFavoriteEntry.decode(var4)

                local marketplaceItemUserFavoriteData = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.new()

                var1.marketplace_asset_user_favorite[var5.key or ""] = var5.value or marketplaceItemUserFavoriteData
            elseif var2 == 33 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_MarketplaceBundleUserFavoriteEntry.decode(var4)

                local marketplaceItemUserFavoriteData = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.new()

                var1.marketplace_bundle_user_favorite[var5.key or ""] = var5.value or marketplaceItemUserFavoriteData
            elseif var2 == 34 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_BuyRobuxOneTimeProductEntry.decode(var4)

                local buyRobuxOneTimeProductData = buy_robux_product_data.BuyRobuxOneTimeProductData.new()

                var1.buy_robux_one_time_product[var5.key or ""] = var5.value or buyRobuxOneTimeProductData
            elseif var2 == 35 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_BuyRobuxSubscriptionProductEntry.decode(var4)

                local buyRobuxSubscriptionProductData = buy_robux_product_data.BuyRobuxSubscriptionProductData.new()

                var1.buy_robux_subscription_product[var5.key or ""] = var5.value or buyRobuxSubscriptionProductData
            elseif var2 == 36 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_BuyRobuxPendingTransferEntry.decode(var4)

                local buyRobuxPendingTransferData = buy_robux_pending_transfer_data.BuyRobuxPendingTransferData.new()

                var1.buy_robux_pending_transfer[var5.key or ""] = var5.value or buyRobuxPendingTransferData
            elseif var2 == 37 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_BuyRobuxBonusItemEntry.decode(var4)

                local buyRobuxBonusItemData = buy_robux_bonus_item_data.BuyRobuxBonusItemData.new()

                var1.buy_robux_bonus_item[var5.key or ""] = var5.value or buyRobuxBonusItemData
            elseif var2 == 38 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_UserLibrarySavedStateEntry.decode(var4)

                local userLibrarySavedStateData = user_library_saved_state_data.UserLibrarySavedStateData.new()

                var1.user_library_saved_state[var5.key or ""] = var5.value or userLibrarySavedStateData
            elseif var2 == 39 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HydrationContent_GamePassVoteEntry.decode(var4)

                local voteData = vote_data.VoteData.new()

                var1.game_pass_vote[var5.key or ""] = var5.value or voteData
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent:jsonEncode()
    local result = {}

    if self.badge ~= nil and next(self.badge) ~= nil then
        local badge = ({})
        for value, value2 in self.badge do
            badge[value] = value2:jsonEncode()
        end
        result.badge = badge
    end

    if self.universe ~= nil and next(self.universe) ~= nil then
        local universe = ({})
        for value, value2 in self.universe do
            universe[value] = value2:jsonEncode()
        end
        result.universe = universe
    end

    if self.creator ~= nil and next(self.creator) ~= nil then
        local creator = ({})
        for value, value2 in self.creator do
            creator[value] = value2:jsonEncode()
        end
        result.creator = creator
    end

    if self.event ~= nil and next(self.event) ~= nil then
        local event = ({})
        for value, value2 in self.event do
            event[value] = value2:jsonEncode()
        end
        result.event = event
    end

    if self.song ~= nil and next(self.song) ~= nil then
        local song = ({})
        for value, value2 in self.song do
            song[value] = value2:jsonEncode()
        end
        result.song = song
    end

    if self.game_pass ~= nil and next(self.game_pass) ~= nil then
        local gamePass = ({})
        for value, value2 in self.game_pass do
            gamePass[value] = value2:jsonEncode()
        end
        result.gamePass = gamePass
    end

    if self.media_asset ~= nil and next(self.media_asset) ~= nil then
        local mediaAsset = ({})
        for value, value2 in self.media_asset do
            mediaAsset[value] = value2:jsonEncode()
        end
        result.mediaAsset = mediaAsset
    end

    if self.social_link ~= nil and next(self.social_link) ~= nil then
        local socialLink = ({})
        for value, value2 in self.social_link do
            socialLink[value] = value2:jsonEncode()
        end
        result.socialLink = socialLink
    end

    if self.game_developer_product ~= nil and next(self.game_developer_product) ~= nil then
        local gameDeveloperProduct = ({})
        for value, value2 in self.game_developer_product do
            gameDeveloperProduct[value] = value2:jsonEncode()
        end
        result.gameDeveloperProduct = gameDeveloperProduct
    end

    if self.game_subscription ~= nil and next(self.game_subscription) ~= nil then
        local gameSubscription = ({})
        for value, value2 in self.game_subscription do
            gameSubscription[value] = value2:jsonEncode()
        end
        result.gameSubscription = gameSubscription
    end

    if self.marketplace_catalog_category ~= nil and next(self.marketplace_catalog_category) ~= nil then
        local marketplaceCatalogCategory = ({})
        for value, value2 in self.marketplace_catalog_category do
            marketplaceCatalogCategory[value] = value2:jsonEncode()
        end
        result.marketplaceCatalogCategory = marketplaceCatalogCategory
    end

    if self.marketplace_asset ~= nil and next(self.marketplace_asset) ~= nil then
        local marketplaceAsset = ({})
        for value, value2 in self.marketplace_asset do
            marketplaceAsset[value] = value2:jsonEncode()
        end
        result.marketplaceAsset = marketplaceAsset
    end

    if self.marketplace_bundle ~= nil and next(self.marketplace_bundle) ~= nil then
        local marketplaceBundle = ({})
        for value, value2 in self.marketplace_bundle do
            marketplaceBundle[value] = value2:jsonEncode()
        end
        result.marketplaceBundle = marketplaceBundle
    end

    if self.marketplace_look ~= nil and next(self.marketplace_look) ~= nil then
        local marketplaceLook = ({})
        for value, value2 in self.marketplace_look do
            marketplaceLook[value] = value2:jsonEncode()
        end
        result.marketplaceLook = marketplaceLook
    end

    if self.catalog_sort ~= nil and next(self.catalog_sort) ~= nil then
        local catalogSort = ({})
        for value, value2 in self.catalog_sort do
            catalogSort[value] = value2:jsonEncode()
        end
        result.catalogSort = catalogSort
    end

    if self.age_recommendation ~= nil and next(self.age_recommendation) ~= nil then
        local ageRecommendation = ({})
        for value, value2 in self.age_recommendation do
            ageRecommendation[value] = value2:jsonEncode()
        end
        result.ageRecommendation = ageRecommendation
    end

    if self.universe_user_follow ~= nil and next(self.universe_user_follow) ~= nil then
        local universeUserFollow = ({})
        for value, value2 in self.universe_user_follow do
            universeUserFollow[value] = value2:jsonEncode()
        end
        result.universeUserFollow = universeUserFollow
    end

    if self.universe_user_vote ~= nil and next(self.universe_user_vote) ~= nil then
        local universeUserVote = ({})
        for value, value2 in self.universe_user_vote do
            universeUserVote[value] = value2:jsonEncode()
        end
        result.universeUserVote = universeUserVote
    end

    if self.user_profile ~= nil and next(self.user_profile) ~= nil then
        local userProfile = ({})
        for value, value2 in self.user_profile do
            userProfile[value] = value2:jsonEncode()
        end
        result.userProfile = userProfile
    end

    if self.universe_user_favorite ~= nil and next(self.universe_user_favorite) ~= nil then
        local universeUserFavorite = ({})
        for value, value2 in self.universe_user_favorite do
            universeUserFavorite[value] = value2:jsonEncode()
        end
        result.universeUserFavorite = universeUserFavorite
    end

    if self.playability ~= nil and next(self.playability) ~= nil then
        local playability = ({})
        for value, value2 in self.playability do
            playability[value] = value2:jsonEncode()
        end
        result.playability = playability
    end

    if self.universe_user_follow_limit ~= nil and next(self.universe_user_follow_limit) ~= nil then
        local universeUserFollowLimit = ({})
        for value, value2 in self.universe_user_follow_limit do
            universeUserFollowLimit[value] = value2:jsonEncode()
        end
        result.universeUserFollowLimit = universeUserFollowLimit
    end

    if self.universe_user_vote_feedback_metadata ~= nil and next(self.universe_user_vote_feedback_metadata) ~= nil then
        local universeUserVoteFeedbackMetadata = ({})
        for value, value2 in self.universe_user_vote_feedback_metadata do
            universeUserVoteFeedbackMetadata[value] = value2:jsonEncode()
        end
        result.universeUserVoteFeedbackMetadata = universeUserVoteFeedbackMetadata
    end

    if self.moment ~= nil and next(self.moment) ~= nil then
        local moment = ({})
        for value, value2 in self.moment do
            moment[value] = value2:jsonEncode()
        end
        result.moment = moment
    end

    if self.community ~= nil and next(self.community) ~= nil then
        local community = ({})
        for value, value2 in self.community do
            community[value] = value2:jsonEncode()
        end
        result.community = community
    end

    if self.community_user_membership ~= nil and next(self.community_user_membership) ~= nil then
        local communityUserMembership = ({})
        for value, value2 in self.community_user_membership do
            communityUserMembership[value] = value2:jsonEncode()
        end
        result.communityUserMembership = communityUserMembership
    end

    if self.friend_recommendation ~= nil and next(self.friend_recommendation) ~= nil then
        local friendRecommendation = ({})
        for value, value2 in self.friend_recommendation do
            friendRecommendation[value] = value2:jsonEncode()
        end
        result.friendRecommendation = friendRecommendation
    end

    if self.universe_private_server ~= nil and next(self.universe_private_server) ~= nil then
        local universePrivateServer = ({})
        for value, value2 in self.universe_private_server do
            universePrivateServer[value] = value2:jsonEncode()
        end
        result.universePrivateServer = universePrivateServer
    end

    if self.notification_badge ~= nil and next(self.notification_badge) ~= nil then
        local notificationBadge = ({})
        for value, value2 in self.notification_badge do
            notificationBadge[value] = value2:jsonEncode()
        end
        result.notificationBadge = notificationBadge
    end

    if self.collectible_item ~= nil and next(self.collectible_item) ~= nil then
        local collectibleItem = ({})
        for value, value2 in self.collectible_item do
            collectibleItem[value] = value2:jsonEncode()
        end
        result.collectibleItem = collectibleItem
    end

    if self.leaderboard_stats ~= nil and next(self.leaderboard_stats) ~= nil then
        local leaderboardStats = ({})
        for k, leaderboardStat in self.leaderboard_stats do
            leaderboardStats[k] = leaderboardStat:jsonEncode()
        end
        result.leaderboardStats = leaderboardStats
    end

    if self.marketplace_asset_user_favorite ~= nil and next(self.marketplace_asset_user_favorite) ~= nil then
        local marketplaceAssetUserFavorite = ({})
        for value, value2 in self.marketplace_asset_user_favorite do
            marketplaceAssetUserFavorite[value] = value2:jsonEncode()
        end
        result.marketplaceAssetUserFavorite = marketplaceAssetUserFavorite
    end

    if self.marketplace_bundle_user_favorite ~= nil and next(self.marketplace_bundle_user_favorite) ~= nil then
        local marketplaceBundleUserFavorite = ({})
        for value, value2 in self.marketplace_bundle_user_favorite do
            marketplaceBundleUserFavorite[value] = value2:jsonEncode()
        end
        result.marketplaceBundleUserFavorite = marketplaceBundleUserFavorite
    end

    if self.buy_robux_one_time_product ~= nil and next(self.buy_robux_one_time_product) ~= nil then
        local buyRobuxOneTimeProduct = ({})
        for value, value2 in self.buy_robux_one_time_product do
            buyRobuxOneTimeProduct[value] = value2:jsonEncode()
        end
        result.buyRobuxOneTimeProduct = buyRobuxOneTimeProduct
    end

    if self.buy_robux_subscription_product ~= nil and next(self.buy_robux_subscription_product) ~= nil then
        local buyRobuxSubscriptionProduct = ({})
        for value, value2 in self.buy_robux_subscription_product do
            buyRobuxSubscriptionProduct[value] = value2:jsonEncode()
        end
        result.buyRobuxSubscriptionProduct = buyRobuxSubscriptionProduct
    end

    if self.buy_robux_pending_transfer ~= nil and next(self.buy_robux_pending_transfer) ~= nil then
        local buyRobuxPendingTransfer = ({})
        for value, value2 in self.buy_robux_pending_transfer do
            buyRobuxPendingTransfer[value] = value2:jsonEncode()
        end
        result.buyRobuxPendingTransfer = buyRobuxPendingTransfer
    end

    if self.buy_robux_bonus_item ~= nil and next(self.buy_robux_bonus_item) ~= nil then
        local buyRobuxBonusItem = ({})
        for value, value2 in self.buy_robux_bonus_item do
            buyRobuxBonusItem[value] = value2:jsonEncode()
        end
        result.buyRobuxBonusItem = buyRobuxBonusItem
    end

    if self.user_library_saved_state ~= nil and next(self.user_library_saved_state) ~= nil then
        local userLibrarySavedState = ({})
        for value, value2 in self.user_library_saved_state do
            userLibrarySavedState[value] = value2:jsonEncode()
        end
        result.userLibrarySavedState = userLibrarySavedState
    end

    if self.game_pass_vote ~= nil and next(self.game_pass_vote) ~= nil then
        local gamePassVote = ({})
        for value, value2 in self.game_pass_vote do
            gamePassVote[value] = value2:jsonEncode()
        end
        result.gamePassVote = gamePassVote
    end

    return result
end

function HydrationContent:jsonDecode()
    local var1 = HydrationContent.new()

    if self.badge ~= nil then
        local badge = ({})
        for value, value2 in self.badge do
            badge[value] = badge_data.BadgeData.jsonDecode(value2)
        end

        var1.badge = badge
    end

    if self.universe ~= nil then
        local universe = ({})
        for value, value2 in self.universe do
            universe[value] = universe_data.UniverseData.jsonDecode(value2)
        end

        var1.universe = universe
    end

    if self.creator ~= nil then
        local creator = ({})
        for value, value2 in self.creator do
            creator[value] = creator_data.CreatorData.jsonDecode(value2)
        end

        var1.creator = creator
    end

    if self.event ~= nil then
        local event = ({})
        for value, value2 in self.event do
            event[value] = event_data.EventData.jsonDecode(value2)
        end

        var1.event = event
    end

    if self.song ~= nil then
        local song = ({})
        for value, value2 in self.song do
            song[value] = song_data.SongData.jsonDecode(value2)
        end

        var1.song = song
    end

    if self.game_pass ~= nil then
        local gamePass = ({})
        for value, value2 in self.game_pass do
            gamePass[value] = game_pass_data.GamePassData.jsonDecode(value2)
        end

        var1.game_pass = gamePass
    end

    if self.gamePass ~= nil then
        local gamePass = ({})
        for value, value2 in self.gamePass do
            gamePass[value] = game_pass_data.GamePassData.jsonDecode(value2)
        end

        var1.game_pass = gamePass
    end

    if self.media_asset ~= nil then
        local mediaAsset = ({})
        for value, value2 in self.media_asset do
            mediaAsset[value] = media_asset_data.MediaAssetData.jsonDecode(value2)
        end

        var1.media_asset = mediaAsset
    end

    if self.mediaAsset ~= nil then
        local mediaAsset = ({})
        for value, value2 in self.mediaAsset do
            mediaAsset[value] = media_asset_data.MediaAssetData.jsonDecode(value2)
        end

        var1.media_asset = mediaAsset
    end

    if self.social_link ~= nil then
        local socialLink = ({})
        for value, value2 in self.social_link do
            socialLink[value] = social_link_data.SocialLinkData.jsonDecode(value2)
        end

        var1.social_link = socialLink
    end

    if self.socialLink ~= nil then
        local socialLink = ({})
        for value, value2 in self.socialLink do
            socialLink[value] = social_link_data.SocialLinkData.jsonDecode(value2)
        end

        var1.social_link = socialLink
    end

    if self.game_developer_product ~= nil then
        local gameDeveloperProduct = ({})
        for value, value2 in self.game_developer_product do
            gameDeveloperProduct[value] = game_developer_product_data.GameDeveloperProductData.jsonDecode(value2)
        end

        var1.game_developer_product = gameDeveloperProduct
    end

    if self.gameDeveloperProduct ~= nil then
        local gameDeveloperProduct = ({})
        for value, value2 in self.gameDeveloperProduct do
            gameDeveloperProduct[value] = game_developer_product_data.GameDeveloperProductData.jsonDecode(value2)
        end

        var1.game_developer_product = gameDeveloperProduct
    end

    if self.game_subscription ~= nil then
        local gameSubscription = ({})
        for value, value2 in self.game_subscription do
            gameSubscription[value] = game_subscription_data.GameSubscriptionData.jsonDecode(value2)
        end

        var1.game_subscription = gameSubscription
    end

    if self.gameSubscription ~= nil then
        local gameSubscription = ({})
        for value, value2 in self.gameSubscription do
            gameSubscription[value] = game_subscription_data.GameSubscriptionData.jsonDecode(value2)
        end

        var1.game_subscription = gameSubscription
    end

    if self.marketplace_catalog_category ~= nil then
        local marketplaceCatalogCategory = ({})
        for value, value2 in self.marketplace_catalog_category do
            marketplaceCatalogCategory[value] = marketplace_catalog_category_data.MarketplaceCatalogCategoryData.jsonDecode(value2)
        end

        var1.marketplace_catalog_category = marketplaceCatalogCategory
    end

    if self.marketplaceCatalogCategory ~= nil then
        local marketplaceCatalogCategory = ({})
        for value, value2 in self.marketplaceCatalogCategory do
            marketplaceCatalogCategory[value] = marketplace_catalog_category_data.MarketplaceCatalogCategoryData.jsonDecode(value2)
        end

        var1.marketplace_catalog_category = marketplaceCatalogCategory
    end

    if self.marketplace_asset ~= nil then
        local marketplaceAsset = ({})
        for value, value2 in self.marketplace_asset do
            marketplaceAsset[value] = marketplace_asset_data.MarketplaceAssetData.jsonDecode(value2)
        end

        var1.marketplace_asset = marketplaceAsset
    end

    if self.marketplaceAsset ~= nil then
        local marketplaceAsset = ({})
        for value, value2 in self.marketplaceAsset do
            marketplaceAsset[value] = marketplace_asset_data.MarketplaceAssetData.jsonDecode(value2)
        end

        var1.marketplace_asset = marketplaceAsset
    end

    if self.marketplace_bundle ~= nil then
        local marketplaceBundle = ({})
        for value, value2 in self.marketplace_bundle do
            marketplaceBundle[value] = marketplace_bundle_data.MarketplaceBundleData.jsonDecode(value2)
        end

        var1.marketplace_bundle = marketplaceBundle
    end

    if self.marketplaceBundle ~= nil then
        local marketplaceBundle = ({})
        for value, value2 in self.marketplaceBundle do
            marketplaceBundle[value] = marketplace_bundle_data.MarketplaceBundleData.jsonDecode(value2)
        end

        var1.marketplace_bundle = marketplaceBundle
    end

    if self.marketplace_look ~= nil then
        local marketplaceLook = ({})
        for value, value2 in self.marketplace_look do
            marketplaceLook[value] = marketplace_look_data.MarketplaceLookData.jsonDecode(value2)
        end

        var1.marketplace_look = marketplaceLook
    end

    if self.marketplaceLook ~= nil then
        local marketplaceLook = ({})
        for value, value2 in self.marketplaceLook do
            marketplaceLook[value] = marketplace_look_data.MarketplaceLookData.jsonDecode(value2)
        end

        var1.marketplace_look = marketplaceLook
    end

    if self.catalog_sort ~= nil then
        local catalogSort = ({})
        for value, value2 in self.catalog_sort do
            catalogSort[value] = catalog_sort_data.CatalogSortData.jsonDecode(value2)
        end

        var1.catalog_sort = catalogSort
    end

    if self.catalogSort ~= nil then
        local catalogSort = ({})
        for value, value2 in self.catalogSort do
            catalogSort[value] = catalog_sort_data.CatalogSortData.jsonDecode(value2)
        end

        var1.catalog_sort = catalogSort
    end

    if self.age_recommendation ~= nil then
        local ageRecommendation = ({})
        for value, value2 in self.age_recommendation do
            ageRecommendation[value] = age_recommendation_data.AgeRecommendationData.jsonDecode(value2)
        end

        var1.age_recommendation = ageRecommendation
    end

    if self.ageRecommendation ~= nil then
        local ageRecommendation = ({})
        for value, value2 in self.ageRecommendation do
            ageRecommendation[value] = age_recommendation_data.AgeRecommendationData.jsonDecode(value2)
        end

        var1.age_recommendation = ageRecommendation
    end

    if self.universe_user_follow ~= nil then
        local universeUserFollow = ({})
        for value, value2 in self.universe_user_follow do
            universeUserFollow[value] = universe_user_follow_data.UniverseUserFollowData.jsonDecode(value2)
        end

        var1.universe_user_follow = universeUserFollow
    end

    if self.universeUserFollow ~= nil then
        local universeUserFollow = ({})
        for value, value2 in self.universeUserFollow do
            universeUserFollow[value] = universe_user_follow_data.UniverseUserFollowData.jsonDecode(value2)
        end

        var1.universe_user_follow = universeUserFollow
    end

    if self.universe_user_vote ~= nil then
        local universeUserVote = ({})
        for value, value2 in self.universe_user_vote do
            universeUserVote[value] = universe_user_vote_data.UniverseUserVoteData.jsonDecode(value2)
        end

        var1.universe_user_vote = universeUserVote
    end

    if self.universeUserVote ~= nil then
        local universeUserVote = ({})
        for value, value2 in self.universeUserVote do
            universeUserVote[value] = universe_user_vote_data.UniverseUserVoteData.jsonDecode(value2)
        end

        var1.universe_user_vote = universeUserVote
    end

    if self.user_profile ~= nil then
        local userProfile = ({})
        for value, value2 in self.user_profile do
            userProfile[value] = user_profile_data.UserProfileData.jsonDecode(value2)
        end

        var1.user_profile = userProfile
    end

    if self.userProfile ~= nil then
        local userProfile = ({})
        for value, value2 in self.userProfile do
            userProfile[value] = user_profile_data.UserProfileData.jsonDecode(value2)
        end

        var1.user_profile = userProfile
    end

    if self.universe_user_favorite ~= nil then
        local universeUserFavorite = ({})
        for value, value2 in self.universe_user_favorite do
            universeUserFavorite[value] = universe_user_favorite_data.UniverseUserFavoriteData.jsonDecode(value2)
        end

        var1.universe_user_favorite = universeUserFavorite
    end

    if self.universeUserFavorite ~= nil then
        local universeUserFavorite = ({})
        for value, value2 in self.universeUserFavorite do
            universeUserFavorite[value] = universe_user_favorite_data.UniverseUserFavoriteData.jsonDecode(value2)
        end

        var1.universe_user_favorite = universeUserFavorite
    end

    if self.playability ~= nil then
        local playability = ({})
        for value, value2 in self.playability do
            playability[value] = playability_data.PlayabilityData.jsonDecode(value2)
        end

        var1.playability = playability
    end

    if self.universe_user_follow_limit ~= nil then
        local universeUserFollowLimit = ({})
        for value, value2 in self.universe_user_follow_limit do
            universeUserFollowLimit[value] = universe_user_follow_limit_data.UniverseUserFollowLimitData.jsonDecode(value2)
        end

        var1.universe_user_follow_limit = universeUserFollowLimit
    end

    if self.universeUserFollowLimit ~= nil then
        local universeUserFollowLimit = ({})
        for value, value2 in self.universeUserFollowLimit do
            universeUserFollowLimit[value] = universe_user_follow_limit_data.UniverseUserFollowLimitData.jsonDecode(value2)
        end

        var1.universe_user_follow_limit = universeUserFollowLimit
    end

    if self.universe_user_vote_feedback_metadata ~= nil then
        local universeUserVoteFeedbackMetadata = ({})
        for value, value2 in self.universe_user_vote_feedback_metadata do
            universeUserVoteFeedbackMetadata[value] = universe_user_vote_feedback_metadata_data.UniverseUserVoteFeedbackMetadataData.jsonDecode(value2)
        end

        var1.universe_user_vote_feedback_metadata = universeUserVoteFeedbackMetadata
    end

    if self.universeUserVoteFeedbackMetadata ~= nil then
        local universeUserVoteFeedbackMetadata = ({})
        for value, value2 in self.universeUserVoteFeedbackMetadata do
            universeUserVoteFeedbackMetadata[value] = universe_user_vote_feedback_metadata_data.UniverseUserVoteFeedbackMetadataData.jsonDecode(value2)
        end

        var1.universe_user_vote_feedback_metadata = universeUserVoteFeedbackMetadata
    end

    if self.moment ~= nil then
        local moment = ({})
        for value, value2 in self.moment do
            moment[value] = moment_data.MomentData.jsonDecode(value2)
        end

        var1.moment = moment
    end

    if self.community ~= nil then
        local community = ({})
        for value, value2 in self.community do
            community[value] = community_data.CommunityData.jsonDecode(value2)
        end

        var1.community = community
    end

    if self.community_user_membership ~= nil then
        local communityUserMembership = ({})
        for value, value2 in self.community_user_membership do
            communityUserMembership[value] = community_user_membership_data.CommunityUserMembershipData.jsonDecode(value2)
        end

        var1.community_user_membership = communityUserMembership
    end

    if self.communityUserMembership ~= nil then
        local communityUserMembership = ({})
        for value, value2 in self.communityUserMembership do
            communityUserMembership[value] = community_user_membership_data.CommunityUserMembershipData.jsonDecode(value2)
        end

        var1.community_user_membership = communityUserMembership
    end

    if self.friend_recommendation ~= nil then
        local friendRecommendation = ({})
        for value, value2 in self.friend_recommendation do
            friendRecommendation[value] = friend_recommendation_data.FriendRecommendationData.jsonDecode(value2)
        end

        var1.friend_recommendation = friendRecommendation
    end

    if self.friendRecommendation ~= nil then
        local friendRecommendation = ({})
        for value, value2 in self.friendRecommendation do
            friendRecommendation[value] = friend_recommendation_data.FriendRecommendationData.jsonDecode(value2)
        end

        var1.friend_recommendation = friendRecommendation
    end

    if self.universe_private_server ~= nil then
        local universePrivateServer = ({})
        for value, value2 in self.universe_private_server do
            universePrivateServer[value] = universe_private_server_data.UniversePrivateServerData.jsonDecode(value2)
        end

        var1.universe_private_server = universePrivateServer
    end

    if self.universePrivateServer ~= nil then
        local universePrivateServer = ({})
        for value, value2 in self.universePrivateServer do
            universePrivateServer[value] = universe_private_server_data.UniversePrivateServerData.jsonDecode(value2)
        end

        var1.universe_private_server = universePrivateServer
    end

    if self.notification_badge ~= nil then
        local notificationBadge = ({})
        for value, value2 in self.notification_badge do
            notificationBadge[value] = notification_badge_data.NotificationBadgeData.jsonDecode(value2)
        end

        var1.notification_badge = notificationBadge
    end

    if self.notificationBadge ~= nil then
        local notificationBadge = ({})
        for value, value2 in self.notificationBadge do
            notificationBadge[value] = notification_badge_data.NotificationBadgeData.jsonDecode(value2)
        end

        var1.notification_badge = notificationBadge
    end

    if self.collectible_item ~= nil then
        local collectibleItem = ({})
        for value, value2 in self.collectible_item do
            collectibleItem[value] = collectible_item_data.CollectibleItemData.jsonDecode(value2)
        end

        var1.collectible_item = collectibleItem
    end

    if self.collectibleItem ~= nil then
        local collectibleItem = ({})
        for value, value2 in self.collectibleItem do
            collectibleItem[value] = collectible_item_data.CollectibleItemData.jsonDecode(value2)
        end

        var1.collectible_item = collectibleItem
    end

    if self.leaderboard_stats ~= nil then
        local leaderboardStats = ({})
        for k, leaderboardStat in self.leaderboard_stats do
            leaderboardStats[k] = leaderboard_stats_data.LeaderboardStatsData.jsonDecode(leaderboardStat)
        end

        var1.leaderboard_stats = leaderboardStats
    end

    if self.leaderboardStats ~= nil then
        local leaderboardStats = ({})
        for k, leaderboardStat in self.leaderboardStats do
            leaderboardStats[k] = leaderboard_stats_data.LeaderboardStatsData.jsonDecode(leaderboardStat)
        end

        var1.leaderboard_stats = leaderboardStats
    end

    if self.marketplace_asset_user_favorite ~= nil then
        local marketplaceAssetUserFavorite = ({})
        for value, value2 in self.marketplace_asset_user_favorite do
            marketplaceAssetUserFavorite[value] = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(value2)
        end

        var1.marketplace_asset_user_favorite = marketplaceAssetUserFavorite
    end

    if self.marketplaceAssetUserFavorite ~= nil then
        local marketplaceAssetUserFavorite = ({})
        for value, value2 in self.marketplaceAssetUserFavorite do
            marketplaceAssetUserFavorite[value] = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(value2)
        end

        var1.marketplace_asset_user_favorite = marketplaceAssetUserFavorite
    end

    if self.marketplace_bundle_user_favorite ~= nil then
        local marketplaceBundleUserFavorite = ({})
        for value, value2 in self.marketplace_bundle_user_favorite do
            marketplaceBundleUserFavorite[value] = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(value2)
        end

        var1.marketplace_bundle_user_favorite = marketplaceBundleUserFavorite
    end

    if self.marketplaceBundleUserFavorite ~= nil then
        local marketplaceBundleUserFavorite = ({})
        for value, value2 in self.marketplaceBundleUserFavorite do
            marketplaceBundleUserFavorite[value] = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(value2)
        end

        var1.marketplace_bundle_user_favorite = marketplaceBundleUserFavorite
    end

    if self.buy_robux_one_time_product ~= nil then
        local buyRobuxOneTimeProduct = ({})
        for value, value2 in self.buy_robux_one_time_product do
            buyRobuxOneTimeProduct[value] = buy_robux_product_data.BuyRobuxOneTimeProductData.jsonDecode(value2)
        end

        var1.buy_robux_one_time_product = buyRobuxOneTimeProduct
    end

    if self.buyRobuxOneTimeProduct ~= nil then
        local buyRobuxOneTimeProduct = ({})
        for value, value2 in self.buyRobuxOneTimeProduct do
            buyRobuxOneTimeProduct[value] = buy_robux_product_data.BuyRobuxOneTimeProductData.jsonDecode(value2)
        end

        var1.buy_robux_one_time_product = buyRobuxOneTimeProduct
    end

    if self.buy_robux_subscription_product ~= nil then
        local buyRobuxSubscriptionProduct = ({})
        for value, value2 in self.buy_robux_subscription_product do
            buyRobuxSubscriptionProduct[value] = buy_robux_product_data.BuyRobuxSubscriptionProductData.jsonDecode(value2)
        end

        var1.buy_robux_subscription_product = buyRobuxSubscriptionProduct
    end

    if self.buyRobuxSubscriptionProduct ~= nil then
        local buyRobuxSubscriptionProduct = ({})
        for value, value2 in self.buyRobuxSubscriptionProduct do
            buyRobuxSubscriptionProduct[value] = buy_robux_product_data.BuyRobuxSubscriptionProductData.jsonDecode(value2)
        end

        var1.buy_robux_subscription_product = buyRobuxSubscriptionProduct
    end

    if self.buy_robux_pending_transfer ~= nil then
        local buyRobuxPendingTransfer = ({})
        for value, value2 in self.buy_robux_pending_transfer do
            buyRobuxPendingTransfer[value] = buy_robux_pending_transfer_data.BuyRobuxPendingTransferData.jsonDecode(value2)
        end

        var1.buy_robux_pending_transfer = buyRobuxPendingTransfer
    end

    if self.buyRobuxPendingTransfer ~= nil then
        local buyRobuxPendingTransfer = ({})
        for value, value2 in self.buyRobuxPendingTransfer do
            buyRobuxPendingTransfer[value] = buy_robux_pending_transfer_data.BuyRobuxPendingTransferData.jsonDecode(value2)
        end

        var1.buy_robux_pending_transfer = buyRobuxPendingTransfer
    end

    if self.buy_robux_bonus_item ~= nil then
        local buyRobuxBonusItem = ({})
        for value, value2 in self.buy_robux_bonus_item do
            buyRobuxBonusItem[value] = buy_robux_bonus_item_data.BuyRobuxBonusItemData.jsonDecode(value2)
        end

        var1.buy_robux_bonus_item = buyRobuxBonusItem
    end

    if self.buyRobuxBonusItem ~= nil then
        local buyRobuxBonusItem = ({})
        for value, value2 in self.buyRobuxBonusItem do
            buyRobuxBonusItem[value] = buy_robux_bonus_item_data.BuyRobuxBonusItemData.jsonDecode(value2)
        end

        var1.buy_robux_bonus_item = buyRobuxBonusItem
    end

    if self.user_library_saved_state ~= nil then
        local userLibrarySavedState = ({})
        for value, value2 in self.user_library_saved_state do
            userLibrarySavedState[value] = user_library_saved_state_data.UserLibrarySavedStateData.jsonDecode(value2)
        end

        var1.user_library_saved_state = userLibrarySavedState
    end

    if self.userLibrarySavedState ~= nil then
        local userLibrarySavedState = ({})
        for value, value2 in self.userLibrarySavedState do
            userLibrarySavedState[value] = user_library_saved_state_data.UserLibrarySavedStateData.jsonDecode(value2)
        end

        var1.user_library_saved_state = userLibrarySavedState
    end

    if self.game_pass_vote ~= nil then
        local gamePassVote = ({})
        for value, value2 in self.game_pass_vote do
            gamePassVote[value] = vote_data.VoteData.jsonDecode(value2)
        end

        var1.game_pass_vote = gamePassVote
    end

    if self.gamePassVote ~= nil then
        local gamePassVote = ({})
        for value, value2 in self.gamePassVote do
            gamePassVote[value] = vote_data.VoteData.jsonDecode(value2)
        end

        var1.game_pass_vote = gamePassVote
    end

    return var1
end

HydrationContent.descriptor = {
    name = "HydrationContent",
    fullName = "roblox.apppageplatform.shared.v1beta1.HydrationContent"
}

tbl1.HydrationContent = HydrationContent

typeRegistry.default:register(tbl1.HydrationContent)

local HydrationContent_BadgeEntry = {}
HydrationContent_BadgeEntry.__index = HydrationContent_BadgeEntry

function HydrationContent_BadgeEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then nil else tbl4.value
    }, HydrationContent_BadgeEntry))
end

function HydrationContent_BadgeEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_BadgeEntry.decode(buf1: buffer)
    local var1 = HydrationContent_BadgeEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = badge_data.BadgeData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_BadgeEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_BadgeEntry:jsonDecode()
    local var1 = HydrationContent_BadgeEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = badge_data.BadgeData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_BadgeEntry.descriptor = {
    name = "HydrationContent_BadgeEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.BadgeEntry"
}

tbl1.HydrationContent_BadgeEntry = HydrationContent_BadgeEntry

typeRegistry.default:register(tbl1.HydrationContent_BadgeEntry)

local HydrationContent_UniverseEntry = {}
HydrationContent_UniverseEntry.__index = HydrationContent_UniverseEntry

function HydrationContent_UniverseEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then nil else tbl5.value
    }, HydrationContent_UniverseEntry))
end

function HydrationContent_UniverseEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_data.UniverseData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseEntry:jsonDecode()
    local var1 = HydrationContent_UniverseEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_data.UniverseData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseEntry.descriptor = {
    name = "HydrationContent_UniverseEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseEntry"
}

tbl1.HydrationContent_UniverseEntry = HydrationContent_UniverseEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseEntry)

local HydrationContent_CreatorEntry = {}
HydrationContent_CreatorEntry.__index = HydrationContent_CreatorEntry

function HydrationContent_CreatorEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then nil else tbl6.value
    }, HydrationContent_CreatorEntry))
end

function HydrationContent_CreatorEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_CreatorEntry.decode(buf1: buffer)
    local var1 = HydrationContent_CreatorEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = creator_data.CreatorData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_CreatorEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_CreatorEntry:jsonDecode()
    local var1 = HydrationContent_CreatorEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = creator_data.CreatorData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_CreatorEntry.descriptor = {
    name = "HydrationContent_CreatorEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.CreatorEntry"
}

tbl1.HydrationContent_CreatorEntry = HydrationContent_CreatorEntry

typeRegistry.default:register(tbl1.HydrationContent_CreatorEntry)

local HydrationContent_EventEntry = {}
HydrationContent_EventEntry.__index = HydrationContent_EventEntry

function HydrationContent_EventEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then nil else tbl7.value
    }, HydrationContent_EventEntry))
end

function HydrationContent_EventEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_EventEntry.decode(buf1: buffer)
    local var1 = HydrationContent_EventEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = event_data.EventData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_EventEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_EventEntry:jsonDecode()
    local var1 = HydrationContent_EventEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = event_data.EventData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_EventEntry.descriptor = {
    name = "HydrationContent_EventEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.EventEntry"
}

tbl1.HydrationContent_EventEntry = HydrationContent_EventEntry

typeRegistry.default:register(tbl1.HydrationContent_EventEntry)

local HydrationContent_SongEntry = {}
HydrationContent_SongEntry.__index = HydrationContent_SongEntry

function HydrationContent_SongEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then nil else tbl8.value
    }, HydrationContent_SongEntry))
end

function HydrationContent_SongEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_SongEntry.decode(buf1: buffer)
    local var1 = HydrationContent_SongEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = song_data.SongData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_SongEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_SongEntry:jsonDecode()
    local var1 = HydrationContent_SongEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = song_data.SongData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_SongEntry.descriptor = {
    name = "HydrationContent_SongEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.SongEntry"
}

tbl1.HydrationContent_SongEntry = HydrationContent_SongEntry

typeRegistry.default:register(tbl1.HydrationContent_SongEntry)

local HydrationContent_GamePassEntry = {}
HydrationContent_GamePassEntry.__index = HydrationContent_GamePassEntry

function HydrationContent_GamePassEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then nil else tbl9.value
    }, HydrationContent_GamePassEntry))
end

function HydrationContent_GamePassEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_GamePassEntry.decode(buf1: buffer)
    local var1 = HydrationContent_GamePassEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = game_pass_data.GamePassData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_GamePassEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_GamePassEntry:jsonDecode()
    local var1 = HydrationContent_GamePassEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = game_pass_data.GamePassData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_GamePassEntry.descriptor = {
    name = "HydrationContent_GamePassEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.GamePassEntry"
}

tbl1.HydrationContent_GamePassEntry = HydrationContent_GamePassEntry

typeRegistry.default:register(tbl1.HydrationContent_GamePassEntry)

local HydrationContent_MediaAssetEntry = {}
HydrationContent_MediaAssetEntry.__index = HydrationContent_MediaAssetEntry

function HydrationContent_MediaAssetEntry.new(tbl10)
    return (setmetatable({
        key = if tbl10 == nil or tbl10.key == nil then "" else tbl10.key,
        value = if tbl10 == nil or tbl10.value == nil then nil else tbl10.value
    }, HydrationContent_MediaAssetEntry))
end

function HydrationContent_MediaAssetEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MediaAssetEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MediaAssetEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = media_asset_data.MediaAssetData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MediaAssetEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MediaAssetEntry:jsonDecode()
    local var1 = HydrationContent_MediaAssetEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = media_asset_data.MediaAssetData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MediaAssetEntry.descriptor = {
    name = "HydrationContent_MediaAssetEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MediaAssetEntry"
}

tbl1.HydrationContent_MediaAssetEntry = HydrationContent_MediaAssetEntry

typeRegistry.default:register(tbl1.HydrationContent_MediaAssetEntry)

local HydrationContent_SocialLinkEntry = {}
HydrationContent_SocialLinkEntry.__index = HydrationContent_SocialLinkEntry

function HydrationContent_SocialLinkEntry.new(tbl11)
    return (setmetatable({
        key = if tbl11 == nil or tbl11.key == nil then "" else tbl11.key,
        value = if tbl11 == nil or tbl11.value == nil then nil else tbl11.value
    }, HydrationContent_SocialLinkEntry))
end

function HydrationContent_SocialLinkEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_SocialLinkEntry.decode(buf1: buffer)
    local var1 = HydrationContent_SocialLinkEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = social_link_data.SocialLinkData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_SocialLinkEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_SocialLinkEntry:jsonDecode()
    local var1 = HydrationContent_SocialLinkEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = social_link_data.SocialLinkData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_SocialLinkEntry.descriptor = {
    name = "HydrationContent_SocialLinkEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.SocialLinkEntry"
}

tbl1.HydrationContent_SocialLinkEntry = HydrationContent_SocialLinkEntry

typeRegistry.default:register(tbl1.HydrationContent_SocialLinkEntry)

local HydrationContent_GameDeveloperProductEntry = {}
HydrationContent_GameDeveloperProductEntry.__index = HydrationContent_GameDeveloperProductEntry

function HydrationContent_GameDeveloperProductEntry.new(tbl12)
    return (setmetatable({
        key = if tbl12 == nil or tbl12.key == nil then "" else tbl12.key,
        value = if tbl12 == nil or tbl12.value == nil then nil else tbl12.value
    }, HydrationContent_GameDeveloperProductEntry))
end

function HydrationContent_GameDeveloperProductEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_GameDeveloperProductEntry.decode(buf1: buffer)
    local var1 = HydrationContent_GameDeveloperProductEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = game_developer_product_data.GameDeveloperProductData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_GameDeveloperProductEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_GameDeveloperProductEntry:jsonDecode()
    local var1 = HydrationContent_GameDeveloperProductEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = game_developer_product_data.GameDeveloperProductData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_GameDeveloperProductEntry.descriptor = {
    name = "HydrationContent_GameDeveloperProductEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.GameDeveloperProductEntry"
}

tbl1.HydrationContent_GameDeveloperProductEntry = HydrationContent_GameDeveloperProductEntry

typeRegistry.default:register(tbl1.HydrationContent_GameDeveloperProductEntry)

local HydrationContent_GameSubscriptionEntry = {}
HydrationContent_GameSubscriptionEntry.__index = HydrationContent_GameSubscriptionEntry

function HydrationContent_GameSubscriptionEntry.new(tbl13)
    return (setmetatable({
        key = if tbl13 == nil or tbl13.key == nil then "" else tbl13.key,
        value = if tbl13 == nil or tbl13.value == nil then nil else tbl13.value
    }, HydrationContent_GameSubscriptionEntry))
end

function HydrationContent_GameSubscriptionEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_GameSubscriptionEntry.decode(buf1: buffer)
    local var1 = HydrationContent_GameSubscriptionEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = game_subscription_data.GameSubscriptionData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_GameSubscriptionEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_GameSubscriptionEntry:jsonDecode()
    local var1 = HydrationContent_GameSubscriptionEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = game_subscription_data.GameSubscriptionData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_GameSubscriptionEntry.descriptor = {
    name = "HydrationContent_GameSubscriptionEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.GameSubscriptionEntry"
}

tbl1.HydrationContent_GameSubscriptionEntry = HydrationContent_GameSubscriptionEntry

typeRegistry.default:register(tbl1.HydrationContent_GameSubscriptionEntry)

local HydrationContent_MarketplaceCatalogCategoryEntry = {}
HydrationContent_MarketplaceCatalogCategoryEntry.__index = HydrationContent_MarketplaceCatalogCategoryEntry

function HydrationContent_MarketplaceCatalogCategoryEntry.new(tbl14)
    return (setmetatable({
        key = if tbl14 == nil or tbl14.key == nil then "" else tbl14.key,
        value = if tbl14 == nil or tbl14.value == nil then nil else tbl14.value
    }, HydrationContent_MarketplaceCatalogCategoryEntry))
end

function HydrationContent_MarketplaceCatalogCategoryEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceCatalogCategoryEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceCatalogCategoryEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_catalog_category_data.MarketplaceCatalogCategoryData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceCatalogCategoryEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceCatalogCategoryEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceCatalogCategoryEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_catalog_category_data.MarketplaceCatalogCategoryData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceCatalogCategoryEntry.descriptor = {
    name = "HydrationContent_MarketplaceCatalogCategoryEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogCategoryEntry"
}

tbl1.HydrationContent_MarketplaceCatalogCategoryEntry = HydrationContent_MarketplaceCatalogCategoryEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceCatalogCategoryEntry)

local HydrationContent_MarketplaceAssetEntry = {}
HydrationContent_MarketplaceAssetEntry.__index = HydrationContent_MarketplaceAssetEntry

function HydrationContent_MarketplaceAssetEntry.new(tbl15)
    return (setmetatable({
        key = if tbl15 == nil or tbl15.key == nil then "" else tbl15.key,
        value = if tbl15 == nil or tbl15.value == nil then nil else tbl15.value
    }, HydrationContent_MarketplaceAssetEntry))
end

function HydrationContent_MarketplaceAssetEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceAssetEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceAssetEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_asset_data.MarketplaceAssetData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceAssetEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceAssetEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceAssetEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_asset_data.MarketplaceAssetData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceAssetEntry.descriptor = {
    name = "HydrationContent_MarketplaceAssetEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceAssetEntry"
}

tbl1.HydrationContent_MarketplaceAssetEntry = HydrationContent_MarketplaceAssetEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceAssetEntry)

local HydrationContent_MarketplaceBundleEntry = {}
HydrationContent_MarketplaceBundleEntry.__index = HydrationContent_MarketplaceBundleEntry

function HydrationContent_MarketplaceBundleEntry.new(tbl16)
    return (setmetatable({
        key = if tbl16 == nil or tbl16.key == nil then "" else tbl16.key,
        value = if tbl16 == nil or tbl16.value == nil then nil else tbl16.value
    }, HydrationContent_MarketplaceBundleEntry))
end

function HydrationContent_MarketplaceBundleEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceBundleEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceBundleEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_bundle_data.MarketplaceBundleData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceBundleEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceBundleEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceBundleEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_bundle_data.MarketplaceBundleData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceBundleEntry.descriptor = {
    name = "HydrationContent_MarketplaceBundleEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceBundleEntry"
}

tbl1.HydrationContent_MarketplaceBundleEntry = HydrationContent_MarketplaceBundleEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceBundleEntry)

local HydrationContent_MarketplaceLookEntry = {}
HydrationContent_MarketplaceLookEntry.__index = HydrationContent_MarketplaceLookEntry

function HydrationContent_MarketplaceLookEntry.new(tbl17)
    return (setmetatable({
        key = if tbl17 == nil or tbl17.key == nil then "" else tbl17.key,
        value = if tbl17 == nil or tbl17.value == nil then nil else tbl17.value
    }, HydrationContent_MarketplaceLookEntry))
end

function HydrationContent_MarketplaceLookEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceLookEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceLookEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_look_data.MarketplaceLookData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceLookEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceLookEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceLookEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_look_data.MarketplaceLookData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceLookEntry.descriptor = {
    name = "HydrationContent_MarketplaceLookEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceLookEntry"
}

tbl1.HydrationContent_MarketplaceLookEntry = HydrationContent_MarketplaceLookEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceLookEntry)

local HydrationContent_CatalogSortEntry = {}
HydrationContent_CatalogSortEntry.__index = HydrationContent_CatalogSortEntry

function HydrationContent_CatalogSortEntry.new(tbl18)
    return (setmetatable({
        key = if tbl18 == nil or tbl18.key == nil then "" else tbl18.key,
        value = if tbl18 == nil or tbl18.value == nil then nil else tbl18.value
    }, HydrationContent_CatalogSortEntry))
end

function HydrationContent_CatalogSortEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_CatalogSortEntry.decode(buf1: buffer)
    local var1 = HydrationContent_CatalogSortEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = catalog_sort_data.CatalogSortData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_CatalogSortEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_CatalogSortEntry:jsonDecode()
    local var1 = HydrationContent_CatalogSortEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = catalog_sort_data.CatalogSortData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_CatalogSortEntry.descriptor = {
    name = "HydrationContent_CatalogSortEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortEntry"
}

tbl1.HydrationContent_CatalogSortEntry = HydrationContent_CatalogSortEntry

typeRegistry.default:register(tbl1.HydrationContent_CatalogSortEntry)

local HydrationContent_AgeRecommendationEntry = {}
HydrationContent_AgeRecommendationEntry.__index = HydrationContent_AgeRecommendationEntry

function HydrationContent_AgeRecommendationEntry.new(tbl19)
    return (setmetatable({
        key = if tbl19 == nil or tbl19.key == nil then "" else tbl19.key,
        value = if tbl19 == nil or tbl19.value == nil then nil else tbl19.value
    }, HydrationContent_AgeRecommendationEntry))
end

function HydrationContent_AgeRecommendationEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_AgeRecommendationEntry.decode(buf1: buffer)
    local var1 = HydrationContent_AgeRecommendationEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = age_recommendation_data.AgeRecommendationData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_AgeRecommendationEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_AgeRecommendationEntry:jsonDecode()
    local var1 = HydrationContent_AgeRecommendationEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = age_recommendation_data.AgeRecommendationData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_AgeRecommendationEntry.descriptor = {
    name = "HydrationContent_AgeRecommendationEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.AgeRecommendationEntry"
}

tbl1.HydrationContent_AgeRecommendationEntry = HydrationContent_AgeRecommendationEntry

typeRegistry.default:register(tbl1.HydrationContent_AgeRecommendationEntry)

local HydrationContent_UniverseUserFollowEntry = {}
HydrationContent_UniverseUserFollowEntry.__index = HydrationContent_UniverseUserFollowEntry

function HydrationContent_UniverseUserFollowEntry.new(tbl20)
    return (setmetatable({
        key = if tbl20 == nil or tbl20.key == nil then "" else tbl20.key,
        value = if tbl20 == nil or tbl20.value == nil then nil else tbl20.value
    }, HydrationContent_UniverseUserFollowEntry))
end

function HydrationContent_UniverseUserFollowEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseUserFollowEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseUserFollowEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_user_follow_data.UniverseUserFollowData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseUserFollowEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseUserFollowEntry:jsonDecode()
    local var1 = HydrationContent_UniverseUserFollowEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_user_follow_data.UniverseUserFollowData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseUserFollowEntry.descriptor = {
    name = "HydrationContent_UniverseUserFollowEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserFollowEntry"
}

tbl1.HydrationContent_UniverseUserFollowEntry = HydrationContent_UniverseUserFollowEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseUserFollowEntry)

local HydrationContent_UniverseUserVoteEntry = {}
HydrationContent_UniverseUserVoteEntry.__index = HydrationContent_UniverseUserVoteEntry

function HydrationContent_UniverseUserVoteEntry.new(tbl21)
    return (setmetatable({
        key = if tbl21 == nil or tbl21.key == nil then "" else tbl21.key,
        value = if tbl21 == nil or tbl21.value == nil then nil else tbl21.value
    }, HydrationContent_UniverseUserVoteEntry))
end

function HydrationContent_UniverseUserVoteEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseUserVoteEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseUserVoteEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_user_vote_data.UniverseUserVoteData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseUserVoteEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseUserVoteEntry:jsonDecode()
    local var1 = HydrationContent_UniverseUserVoteEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_user_vote_data.UniverseUserVoteData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseUserVoteEntry.descriptor = {
    name = "HydrationContent_UniverseUserVoteEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserVoteEntry"
}

tbl1.HydrationContent_UniverseUserVoteEntry = HydrationContent_UniverseUserVoteEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseUserVoteEntry)

local HydrationContent_UserProfileEntry = {}
HydrationContent_UserProfileEntry.__index = HydrationContent_UserProfileEntry

function HydrationContent_UserProfileEntry.new(tbl22)
    return (setmetatable({
        key = if tbl22 == nil or tbl22.key == nil then "" else tbl22.key,
        value = if tbl22 == nil or tbl22.value == nil then nil else tbl22.value
    }, HydrationContent_UserProfileEntry))
end

function HydrationContent_UserProfileEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UserProfileEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UserProfileEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = user_profile_data.UserProfileData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UserProfileEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UserProfileEntry:jsonDecode()
    local var1 = HydrationContent_UserProfileEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = user_profile_data.UserProfileData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UserProfileEntry.descriptor = {
    name = "HydrationContent_UserProfileEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UserProfileEntry"
}

tbl1.HydrationContent_UserProfileEntry = HydrationContent_UserProfileEntry

typeRegistry.default:register(tbl1.HydrationContent_UserProfileEntry)

local HydrationContent_UniverseUserFavoriteEntry = {}
HydrationContent_UniverseUserFavoriteEntry.__index = HydrationContent_UniverseUserFavoriteEntry

function HydrationContent_UniverseUserFavoriteEntry.new(tbl23)
    return (setmetatable({
        key = if tbl23 == nil or tbl23.key == nil then "" else tbl23.key,
        value = if tbl23 == nil or tbl23.value == nil then nil else tbl23.value
    }, HydrationContent_UniverseUserFavoriteEntry))
end

function HydrationContent_UniverseUserFavoriteEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseUserFavoriteEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseUserFavoriteEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_user_favorite_data.UniverseUserFavoriteData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseUserFavoriteEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseUserFavoriteEntry:jsonDecode()
    local var1 = HydrationContent_UniverseUserFavoriteEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_user_favorite_data.UniverseUserFavoriteData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseUserFavoriteEntry.descriptor = {
    name = "HydrationContent_UniverseUserFavoriteEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserFavoriteEntry"
}

tbl1.HydrationContent_UniverseUserFavoriteEntry = HydrationContent_UniverseUserFavoriteEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseUserFavoriteEntry)

local HydrationContent_PlayabilityEntry = {}
HydrationContent_PlayabilityEntry.__index = HydrationContent_PlayabilityEntry

function HydrationContent_PlayabilityEntry.new(tbl24)
    return (setmetatable({
        key = if tbl24 == nil or tbl24.key == nil then "" else tbl24.key,
        value = if tbl24 == nil or tbl24.value == nil then nil else tbl24.value
    }, HydrationContent_PlayabilityEntry))
end

function HydrationContent_PlayabilityEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_PlayabilityEntry.decode(buf1: buffer)
    local var1 = HydrationContent_PlayabilityEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = playability_data.PlayabilityData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_PlayabilityEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_PlayabilityEntry:jsonDecode()
    local var1 = HydrationContent_PlayabilityEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = playability_data.PlayabilityData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_PlayabilityEntry.descriptor = {
    name = "HydrationContent_PlayabilityEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.PlayabilityEntry"
}

tbl1.HydrationContent_PlayabilityEntry = HydrationContent_PlayabilityEntry

typeRegistry.default:register(tbl1.HydrationContent_PlayabilityEntry)

local HydrationContent_UniverseUserFollowLimitEntry = {}
HydrationContent_UniverseUserFollowLimitEntry.__index = HydrationContent_UniverseUserFollowLimitEntry

function HydrationContent_UniverseUserFollowLimitEntry.new(tbl25)
    return (setmetatable({
        key = if tbl25 == nil or tbl25.key == nil then "" else tbl25.key,
        value = if tbl25 == nil or tbl25.value == nil then nil else tbl25.value
    }, HydrationContent_UniverseUserFollowLimitEntry))
end

function HydrationContent_UniverseUserFollowLimitEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseUserFollowLimitEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseUserFollowLimitEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_user_follow_limit_data.UniverseUserFollowLimitData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseUserFollowLimitEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseUserFollowLimitEntry:jsonDecode()
    local var1 = HydrationContent_UniverseUserFollowLimitEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_user_follow_limit_data.UniverseUserFollowLimitData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseUserFollowLimitEntry.descriptor = {
    name = "HydrationContent_UniverseUserFollowLimitEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserFollowLimitEntry"
}

tbl1.HydrationContent_UniverseUserFollowLimitEntry = HydrationContent_UniverseUserFollowLimitEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseUserFollowLimitEntry)

local HydrationContent_UniverseUserVoteFeedbackMetadataEntry = {}
HydrationContent_UniverseUserVoteFeedbackMetadataEntry.__index = HydrationContent_UniverseUserVoteFeedbackMetadataEntry

function HydrationContent_UniverseUserVoteFeedbackMetadataEntry.new(tbl26)
    return (setmetatable({
        key = if tbl26 == nil or tbl26.key == nil then "" else tbl26.key,
        value = if tbl26 == nil or tbl26.value == nil then nil else tbl26.value
    }, HydrationContent_UniverseUserVoteFeedbackMetadataEntry))
end

function HydrationContent_UniverseUserVoteFeedbackMetadataEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniverseUserVoteFeedbackMetadataEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniverseUserVoteFeedbackMetadataEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_user_vote_feedback_metadata_data.UniverseUserVoteFeedbackMetadataData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniverseUserVoteFeedbackMetadataEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniverseUserVoteFeedbackMetadataEntry:jsonDecode()
    local var1 = HydrationContent_UniverseUserVoteFeedbackMetadataEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_user_vote_feedback_metadata_data.UniverseUserVoteFeedbackMetadataData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniverseUserVoteFeedbackMetadataEntry.descriptor = {
    name = "HydrationContent_UniverseUserVoteFeedbackMetadataEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserVoteFeedbackMetadataEntry"
}

tbl1.HydrationContent_UniverseUserVoteFeedbackMetadataEntry = HydrationContent_UniverseUserVoteFeedbackMetadataEntry

typeRegistry.default:register(tbl1.HydrationContent_UniverseUserVoteFeedbackMetadataEntry)

local HydrationContent_MomentEntry = {}
HydrationContent_MomentEntry.__index = HydrationContent_MomentEntry

function HydrationContent_MomentEntry.new(tbl27)
    return (setmetatable({
        key = if tbl27 == nil or tbl27.key == nil then "" else tbl27.key,
        value = if tbl27 == nil or tbl27.value == nil then nil else tbl27.value
    }, HydrationContent_MomentEntry))
end

function HydrationContent_MomentEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MomentEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MomentEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = moment_data.MomentData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MomentEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MomentEntry:jsonDecode()
    local var1 = HydrationContent_MomentEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = moment_data.MomentData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MomentEntry.descriptor = {
    name = "HydrationContent_MomentEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MomentEntry"
}

tbl1.HydrationContent_MomentEntry = HydrationContent_MomentEntry

typeRegistry.default:register(tbl1.HydrationContent_MomentEntry)

local HydrationContent_CommunityEntry = {}
HydrationContent_CommunityEntry.__index = HydrationContent_CommunityEntry

function HydrationContent_CommunityEntry.new(tbl28)
    return (setmetatable({
        key = if tbl28 == nil or tbl28.key == nil then "" else tbl28.key,
        value = if tbl28 == nil or tbl28.value == nil then nil else tbl28.value
    }, HydrationContent_CommunityEntry))
end

function HydrationContent_CommunityEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_CommunityEntry.decode(buf1: buffer)
    local var1 = HydrationContent_CommunityEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = community_data.CommunityData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_CommunityEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_CommunityEntry:jsonDecode()
    local var1 = HydrationContent_CommunityEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = community_data.CommunityData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_CommunityEntry.descriptor = {
    name = "HydrationContent_CommunityEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.CommunityEntry"
}

tbl1.HydrationContent_CommunityEntry = HydrationContent_CommunityEntry

typeRegistry.default:register(tbl1.HydrationContent_CommunityEntry)

local HydrationContent_CommunityUserMembershipEntry = {}
HydrationContent_CommunityUserMembershipEntry.__index = HydrationContent_CommunityUserMembershipEntry

function HydrationContent_CommunityUserMembershipEntry.new(tbl29)
    return (setmetatable({
        key = if tbl29 == nil or tbl29.key == nil then "" else tbl29.key,
        value = if tbl29 == nil or tbl29.value == nil then nil else tbl29.value
    }, HydrationContent_CommunityUserMembershipEntry))
end

function HydrationContent_CommunityUserMembershipEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_CommunityUserMembershipEntry.decode(buf1: buffer)
    local var1 = HydrationContent_CommunityUserMembershipEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = community_user_membership_data.CommunityUserMembershipData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_CommunityUserMembershipEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_CommunityUserMembershipEntry:jsonDecode()
    local var1 = HydrationContent_CommunityUserMembershipEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = community_user_membership_data.CommunityUserMembershipData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_CommunityUserMembershipEntry.descriptor = {
    name = "HydrationContent_CommunityUserMembershipEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.CommunityUserMembershipEntry"
}

tbl1.HydrationContent_CommunityUserMembershipEntry = HydrationContent_CommunityUserMembershipEntry

typeRegistry.default:register(tbl1.HydrationContent_CommunityUserMembershipEntry)

local HydrationContent_FriendRecommendationEntry = {}
HydrationContent_FriendRecommendationEntry.__index = HydrationContent_FriendRecommendationEntry

function HydrationContent_FriendRecommendationEntry.new(tbl30)
    return (setmetatable({
        key = if tbl30 == nil or tbl30.key == nil then "" else tbl30.key,
        value = if tbl30 == nil or tbl30.value == nil then nil else tbl30.value
    }, HydrationContent_FriendRecommendationEntry))
end

function HydrationContent_FriendRecommendationEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_FriendRecommendationEntry.decode(buf1: buffer)
    local var1 = HydrationContent_FriendRecommendationEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = friend_recommendation_data.FriendRecommendationData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_FriendRecommendationEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_FriendRecommendationEntry:jsonDecode()
    local var1 = HydrationContent_FriendRecommendationEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = friend_recommendation_data.FriendRecommendationData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_FriendRecommendationEntry.descriptor = {
    name = "HydrationContent_FriendRecommendationEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.FriendRecommendationEntry"
}

tbl1.HydrationContent_FriendRecommendationEntry = HydrationContent_FriendRecommendationEntry

typeRegistry.default:register(tbl1.HydrationContent_FriendRecommendationEntry)

local HydrationContent_UniversePrivateServerEntry = {}
HydrationContent_UniversePrivateServerEntry.__index = HydrationContent_UniversePrivateServerEntry

function HydrationContent_UniversePrivateServerEntry.new(tbl31)
    return (setmetatable({
        key = if tbl31 == nil or tbl31.key == nil then "" else tbl31.key,
        value = if tbl31 == nil or tbl31.value == nil then nil else tbl31.value
    }, HydrationContent_UniversePrivateServerEntry))
end

function HydrationContent_UniversePrivateServerEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UniversePrivateServerEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UniversePrivateServerEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = universe_private_server_data.UniversePrivateServerData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UniversePrivateServerEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UniversePrivateServerEntry:jsonDecode()
    local var1 = HydrationContent_UniversePrivateServerEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = universe_private_server_data.UniversePrivateServerData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UniversePrivateServerEntry.descriptor = {
    name = "HydrationContent_UniversePrivateServerEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniversePrivateServerEntry"
}

tbl1.HydrationContent_UniversePrivateServerEntry = HydrationContent_UniversePrivateServerEntry

typeRegistry.default:register(tbl1.HydrationContent_UniversePrivateServerEntry)

local HydrationContent_NotificationBadgeEntry = {}
HydrationContent_NotificationBadgeEntry.__index = HydrationContent_NotificationBadgeEntry

function HydrationContent_NotificationBadgeEntry.new(tbl32)
    return (setmetatable({
        key = if tbl32 == nil or tbl32.key == nil then "" else tbl32.key,
        value = if tbl32 == nil or tbl32.value == nil then nil else tbl32.value
    }, HydrationContent_NotificationBadgeEntry))
end

function HydrationContent_NotificationBadgeEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_NotificationBadgeEntry.decode(buf1: buffer)
    local var1 = HydrationContent_NotificationBadgeEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = notification_badge_data.NotificationBadgeData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_NotificationBadgeEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_NotificationBadgeEntry:jsonDecode()
    local var1 = HydrationContent_NotificationBadgeEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = notification_badge_data.NotificationBadgeData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_NotificationBadgeEntry.descriptor = {
    name = "HydrationContent_NotificationBadgeEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.NotificationBadgeEntry"
}

tbl1.HydrationContent_NotificationBadgeEntry = HydrationContent_NotificationBadgeEntry

typeRegistry.default:register(tbl1.HydrationContent_NotificationBadgeEntry)

local HydrationContent_CollectibleItemEntry = {}
HydrationContent_CollectibleItemEntry.__index = HydrationContent_CollectibleItemEntry

function HydrationContent_CollectibleItemEntry.new(tbl33)
    return (setmetatable({
        key = if tbl33 == nil or tbl33.key == nil then "" else tbl33.key,
        value = if tbl33 == nil or tbl33.value == nil then nil else tbl33.value
    }, HydrationContent_CollectibleItemEntry))
end

function HydrationContent_CollectibleItemEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_CollectibleItemEntry.decode(buf1: buffer)
    local var1 = HydrationContent_CollectibleItemEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = collectible_item_data.CollectibleItemData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_CollectibleItemEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_CollectibleItemEntry:jsonDecode()
    local var1 = HydrationContent_CollectibleItemEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = collectible_item_data.CollectibleItemData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_CollectibleItemEntry.descriptor = {
    name = "HydrationContent_CollectibleItemEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.CollectibleItemEntry"
}

tbl1.HydrationContent_CollectibleItemEntry = HydrationContent_CollectibleItemEntry

typeRegistry.default:register(tbl1.HydrationContent_CollectibleItemEntry)

local HydrationContent_LeaderboardStatsEntry = {}
HydrationContent_LeaderboardStatsEntry.__index = HydrationContent_LeaderboardStatsEntry

function HydrationContent_LeaderboardStatsEntry.new(tbl34)
    return (setmetatable({
        key = if tbl34 == nil or tbl34.key == nil then "" else tbl34.key,
        value = if tbl34 == nil or tbl34.value == nil then nil else tbl34.value
    }, HydrationContent_LeaderboardStatsEntry))
end

function HydrationContent_LeaderboardStatsEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_LeaderboardStatsEntry.decode(buf1: buffer)
    local var1 = HydrationContent_LeaderboardStatsEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = leaderboard_stats_data.LeaderboardStatsData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_LeaderboardStatsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_LeaderboardStatsEntry:jsonDecode()
    local var1 = HydrationContent_LeaderboardStatsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = leaderboard_stats_data.LeaderboardStatsData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_LeaderboardStatsEntry.descriptor = {
    name = "HydrationContent_LeaderboardStatsEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.LeaderboardStatsEntry"
}

tbl1.HydrationContent_LeaderboardStatsEntry = HydrationContent_LeaderboardStatsEntry

typeRegistry.default:register(tbl1.HydrationContent_LeaderboardStatsEntry)

local HydrationContent_MarketplaceAssetUserFavoriteEntry = {}
HydrationContent_MarketplaceAssetUserFavoriteEntry.__index = HydrationContent_MarketplaceAssetUserFavoriteEntry

function HydrationContent_MarketplaceAssetUserFavoriteEntry.new(tbl35)
    return (setmetatable({
        key = if tbl35 == nil or tbl35.key == nil then "" else tbl35.key,
        value = if tbl35 == nil or tbl35.value == nil then nil else tbl35.value
    }, HydrationContent_MarketplaceAssetUserFavoriteEntry))
end

function HydrationContent_MarketplaceAssetUserFavoriteEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceAssetUserFavoriteEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceAssetUserFavoriteEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceAssetUserFavoriteEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceAssetUserFavoriteEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceAssetUserFavoriteEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceAssetUserFavoriteEntry.descriptor = {
    name = "HydrationContent_MarketplaceAssetUserFavoriteEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceAssetUserFavoriteEntry"
}

tbl1.HydrationContent_MarketplaceAssetUserFavoriteEntry = HydrationContent_MarketplaceAssetUserFavoriteEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceAssetUserFavoriteEntry)

local HydrationContent_MarketplaceBundleUserFavoriteEntry = {}
HydrationContent_MarketplaceBundleUserFavoriteEntry.__index = HydrationContent_MarketplaceBundleUserFavoriteEntry

function HydrationContent_MarketplaceBundleUserFavoriteEntry.new(tbl36)
    return (setmetatable({
        key = if tbl36 == nil or tbl36.key == nil then "" else tbl36.key,
        value = if tbl36 == nil or tbl36.value == nil then nil else tbl36.value
    }, HydrationContent_MarketplaceBundleUserFavoriteEntry))
end

function HydrationContent_MarketplaceBundleUserFavoriteEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_MarketplaceBundleUserFavoriteEntry.decode(buf1: buffer)
    local var1 = HydrationContent_MarketplaceBundleUserFavoriteEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_MarketplaceBundleUserFavoriteEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_MarketplaceBundleUserFavoriteEntry:jsonDecode()
    local var1 = HydrationContent_MarketplaceBundleUserFavoriteEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = marketplace_item_user_favorite_data.MarketplaceItemUserFavoriteData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_MarketplaceBundleUserFavoriteEntry.descriptor = {
    name = "HydrationContent_MarketplaceBundleUserFavoriteEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceBundleUserFavoriteEntry"
}

tbl1.HydrationContent_MarketplaceBundleUserFavoriteEntry = HydrationContent_MarketplaceBundleUserFavoriteEntry

typeRegistry.default:register(tbl1.HydrationContent_MarketplaceBundleUserFavoriteEntry)

local HydrationContent_BuyRobuxOneTimeProductEntry = {}
HydrationContent_BuyRobuxOneTimeProductEntry.__index = HydrationContent_BuyRobuxOneTimeProductEntry

function HydrationContent_BuyRobuxOneTimeProductEntry.new(tbl37)
    return (setmetatable({
        key = if tbl37 == nil or tbl37.key == nil then "" else tbl37.key,
        value = if tbl37 == nil or tbl37.value == nil then nil else tbl37.value
    }, HydrationContent_BuyRobuxOneTimeProductEntry))
end

function HydrationContent_BuyRobuxOneTimeProductEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_BuyRobuxOneTimeProductEntry.decode(buf1: buffer)
    local var1 = HydrationContent_BuyRobuxOneTimeProductEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = buy_robux_product_data.BuyRobuxOneTimeProductData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_BuyRobuxOneTimeProductEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_BuyRobuxOneTimeProductEntry:jsonDecode()
    local var1 = HydrationContent_BuyRobuxOneTimeProductEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = buy_robux_product_data.BuyRobuxOneTimeProductData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_BuyRobuxOneTimeProductEntry.descriptor = {
    name = "HydrationContent_BuyRobuxOneTimeProductEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxOneTimeProductEntry"
}

tbl1.HydrationContent_BuyRobuxOneTimeProductEntry = HydrationContent_BuyRobuxOneTimeProductEntry

typeRegistry.default:register(tbl1.HydrationContent_BuyRobuxOneTimeProductEntry)

local HydrationContent_BuyRobuxSubscriptionProductEntry = {}
HydrationContent_BuyRobuxSubscriptionProductEntry.__index = HydrationContent_BuyRobuxSubscriptionProductEntry

function HydrationContent_BuyRobuxSubscriptionProductEntry.new(tbl38)
    return (setmetatable({
        key = if tbl38 == nil or tbl38.key == nil then "" else tbl38.key,
        value = if tbl38 == nil or tbl38.value == nil then nil else tbl38.value
    }, HydrationContent_BuyRobuxSubscriptionProductEntry))
end

function HydrationContent_BuyRobuxSubscriptionProductEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_BuyRobuxSubscriptionProductEntry.decode(buf1: buffer)
    local var1 = HydrationContent_BuyRobuxSubscriptionProductEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = buy_robux_product_data.BuyRobuxSubscriptionProductData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_BuyRobuxSubscriptionProductEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_BuyRobuxSubscriptionProductEntry:jsonDecode()
    local var1 = HydrationContent_BuyRobuxSubscriptionProductEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = buy_robux_product_data.BuyRobuxSubscriptionProductData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_BuyRobuxSubscriptionProductEntry.descriptor = {
    name = "HydrationContent_BuyRobuxSubscriptionProductEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxSubscriptionProductEntry"
}

tbl1.HydrationContent_BuyRobuxSubscriptionProductEntry = HydrationContent_BuyRobuxSubscriptionProductEntry

typeRegistry.default:register(tbl1.HydrationContent_BuyRobuxSubscriptionProductEntry)

local HydrationContent_BuyRobuxPendingTransferEntry = {}
HydrationContent_BuyRobuxPendingTransferEntry.__index = HydrationContent_BuyRobuxPendingTransferEntry

function HydrationContent_BuyRobuxPendingTransferEntry.new(tbl39)
    return (setmetatable({
        key = if tbl39 == nil or tbl39.key == nil then "" else tbl39.key,
        value = if tbl39 == nil or tbl39.value == nil then nil else tbl39.value
    }, HydrationContent_BuyRobuxPendingTransferEntry))
end

function HydrationContent_BuyRobuxPendingTransferEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_BuyRobuxPendingTransferEntry.decode(buf1: buffer)
    local var1 = HydrationContent_BuyRobuxPendingTransferEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = buy_robux_pending_transfer_data.BuyRobuxPendingTransferData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_BuyRobuxPendingTransferEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_BuyRobuxPendingTransferEntry:jsonDecode()
    local var1 = HydrationContent_BuyRobuxPendingTransferEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = buy_robux_pending_transfer_data.BuyRobuxPendingTransferData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_BuyRobuxPendingTransferEntry.descriptor = {
    name = "HydrationContent_BuyRobuxPendingTransferEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxPendingTransferEntry"
}

tbl1.HydrationContent_BuyRobuxPendingTransferEntry = HydrationContent_BuyRobuxPendingTransferEntry

typeRegistry.default:register(tbl1.HydrationContent_BuyRobuxPendingTransferEntry)

local HydrationContent_BuyRobuxBonusItemEntry = {}
HydrationContent_BuyRobuxBonusItemEntry.__index = HydrationContent_BuyRobuxBonusItemEntry

function HydrationContent_BuyRobuxBonusItemEntry.new(tbl40)
    return (setmetatable({
        key = if tbl40 == nil or tbl40.key == nil then "" else tbl40.key,
        value = if tbl40 == nil or tbl40.value == nil then nil else tbl40.value
    }, HydrationContent_BuyRobuxBonusItemEntry))
end

function HydrationContent_BuyRobuxBonusItemEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_BuyRobuxBonusItemEntry.decode(buf1: buffer)
    local var1 = HydrationContent_BuyRobuxBonusItemEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = buy_robux_bonus_item_data.BuyRobuxBonusItemData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_BuyRobuxBonusItemEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_BuyRobuxBonusItemEntry:jsonDecode()
    local var1 = HydrationContent_BuyRobuxBonusItemEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = buy_robux_bonus_item_data.BuyRobuxBonusItemData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_BuyRobuxBonusItemEntry.descriptor = {
    name = "HydrationContent_BuyRobuxBonusItemEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxBonusItemEntry"
}

tbl1.HydrationContent_BuyRobuxBonusItemEntry = HydrationContent_BuyRobuxBonusItemEntry

typeRegistry.default:register(tbl1.HydrationContent_BuyRobuxBonusItemEntry)

local HydrationContent_UserLibrarySavedStateEntry = {}
HydrationContent_UserLibrarySavedStateEntry.__index = HydrationContent_UserLibrarySavedStateEntry

function HydrationContent_UserLibrarySavedStateEntry.new(tbl41)
    return (setmetatable({
        key = if tbl41 == nil or tbl41.key == nil then "" else tbl41.key,
        value = if tbl41 == nil or tbl41.value == nil then nil else tbl41.value
    }, HydrationContent_UserLibrarySavedStateEntry))
end

function HydrationContent_UserLibrarySavedStateEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_UserLibrarySavedStateEntry.decode(buf1: buffer)
    local var1 = HydrationContent_UserLibrarySavedStateEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = user_library_saved_state_data.UserLibrarySavedStateData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_UserLibrarySavedStateEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_UserLibrarySavedStateEntry:jsonDecode()
    local var1 = HydrationContent_UserLibrarySavedStateEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = user_library_saved_state_data.UserLibrarySavedStateData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_UserLibrarySavedStateEntry.descriptor = {
    name = "HydrationContent_UserLibrarySavedStateEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.UserLibrarySavedStateEntry"
}

tbl1.HydrationContent_UserLibrarySavedStateEntry = HydrationContent_UserLibrarySavedStateEntry

typeRegistry.default:register(tbl1.HydrationContent_UserLibrarySavedStateEntry)

local HydrationContent_GamePassVoteEntry = {}
HydrationContent_GamePassVoteEntry.__index = HydrationContent_GamePassVoteEntry

function HydrationContent_GamePassVoteEntry.new(tbl42)
    return (setmetatable({
        key = if tbl42 == nil or tbl42.key == nil then "" else tbl42.key,
        value = if tbl42 == nil or tbl42.value == nil then nil else tbl42.value
    }, HydrationContent_GamePassVoteEntry))
end

function HydrationContent_GamePassVoteEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationContent_GamePassVoteEntry.decode(buf1: buffer)
    local var1 = HydrationContent_GamePassVoteEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = vote_data.VoteData.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function HydrationContent_GamePassVoteEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HydrationContent_GamePassVoteEntry:jsonDecode()
    local var1 = HydrationContent_GamePassVoteEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = vote_data.VoteData.jsonDecode(self.value)
    end

    return var1
end

HydrationContent_GamePassVoteEntry.descriptor = {
    name = "HydrationContent_GamePassVoteEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.GamePassVoteEntry"
}

tbl1.HydrationContent_GamePassVoteEntry = HydrationContent_GamePassVoteEntry

typeRegistry.default:register(tbl1.HydrationContent_GamePassVoteEntry)

return {
    HydrationContent = tbl1.HydrationContent
}

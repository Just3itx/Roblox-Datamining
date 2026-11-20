-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local UniverseData = {}
UniverseData.__index = UniverseData

function UniverseData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then nil else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then nil else tbl3.name,
        description = if tbl3 == nil or tbl3.description == nil then nil else tbl3.description,
        root_place_id = if tbl3 == nil or tbl3.root_place_id == nil then nil else tbl3.root_place_id,
        creator_type = if tbl3 == nil or tbl3.creator_type == nil then nil else tbl3.creator_type,
        creator_id = if tbl3 == nil or tbl3.creator_id == nil then nil else tbl3.creator_id,
        player_count = if tbl3 == nil or tbl3.player_count == nil then nil else tbl3.player_count,
        total_up_votes = if tbl3 == nil or tbl3.total_up_votes == nil then nil else tbl3.total_up_votes,
        total_down_votes = if tbl3 == nil or tbl3.total_down_votes == nil then nil else tbl3.total_down_votes,
        is_voice_supported = if tbl3 == nil or tbl3.is_voice_supported == nil then nil else tbl3.is_voice_supported,
        is_camera_supported = if tbl3 == nil or tbl3.is_camera_supported == nil then nil else tbl3.is_camera_supported,
        localized_fiat_price = if tbl3 == nil or tbl3.localized_fiat_price == nil then nil else tbl3.localized_fiat_price,
        genre_l1 = if tbl3 == nil or tbl3.genre_l1 == nil then nil else tbl3.genre_l1,
        genre_l2 = if tbl3 == nil or tbl3.genre_l2 == nil then nil else tbl3.genre_l2,
        maximum_server_size = if tbl3 == nil or tbl3.maximum_server_size == nil then nil else tbl3.maximum_server_size,
        created_date = if tbl3 == nil or tbl3.created_date == nil then nil else tbl3.created_date,
        updated_date = if tbl3 == nil or tbl3.updated_date == nil then nil else tbl3.updated_date,
        favorite_count = if tbl3 == nil or tbl3.favorite_count == nil then nil else tbl3.favorite_count,
        total_visits = if tbl3 == nil or tbl3.total_visits == nil then nil else tbl3.total_visits,
        canonical_url_path = if tbl3 == nil or tbl3.canonical_url_path == nil then nil else tbl3.canonical_url_path,
        game_minimum_age = if tbl3 == nil or tbl3.game_minimum_age == nil then nil else tbl3.game_minimum_age,
        game_age_display_name = if tbl3 == nil or tbl3.game_age_display_name == nil then nil else tbl3.game_age_display_name,
        content_maturity = if tbl3 == nil or tbl3.content_maturity == nil then nil else tbl3.content_maturity,
        is_officially_licensed = if tbl3 == nil or tbl3.is_officially_licensed == nil then nil else tbl3.is_officially_licensed,
        refund_policy_text = if tbl3 == nil or tbl3.refund_policy_text == nil then nil else tbl3.refund_policy_text,
        refund_article_id = if tbl3 == nil or tbl3.refund_article_id == nil then nil else tbl3.refund_article_id,
        preview_video_id = if tbl3 == nil or tbl3.preview_video_id == nil then nil else tbl3.preview_video_id,
        creation_source = if tbl3 == nil or tbl3.creation_source == nil then nil else tbl3.creation_source,
        promotional_text = if tbl3 == nil or tbl3.promotional_text == nil then nil else tbl3.promotional_text,
        moment_video_asset_id = if tbl3 == nil or tbl3.moment_video_asset_id == nil then nil else tbl3.moment_video_asset_id,
        is_community_licensed = if tbl3 == nil or tbl3.is_community_licensed == nil then nil else tbl3.is_community_licensed,
        summary = if tbl3 == nil or tbl3.summary == nil then nil else tbl3.summary,
        tags = (tbl3 == nil or tbl3.tags == nil) and {} or tbl3.tags
    }, UniverseData))
end

function UniverseData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.id)
    end

    if self.name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.description ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.root_place_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.root_place_id)
    end

    if self.creator_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_type)
    end

    if self.creator_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.creator_id)
    end

    if self.player_count ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.player_count)
    end

    if self.total_up_votes ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_up_votes)
    end

    if self.total_down_votes ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_down_votes)
    end

    if self.is_voice_supported ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_voice_supported then 1 else 0)
    end

    if self.is_camera_supported ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_camera_supported then 1 else 0)
    end

    if self.localized_fiat_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.localized_fiat_price)
    end

    if self.genre_l1 ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.genre_l1)
    end

    if self.genre_l2 ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.genre_l2)
    end

    if self.maximum_server_size ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.maximum_server_size)
    end

    if self.created_date ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.created_date)
    end

    if self.updated_date ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.updated_date)
    end

    if self.favorite_count ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 18, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.favorite_count)
    end

    if self.total_visits ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 19, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_visits)
    end

    if self.canonical_url_path ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 20, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.canonical_url_path)
    end

    if self.game_minimum_age ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 21, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.game_minimum_age)
    end

    if self.game_age_display_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 22, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.game_age_display_name)
    end

    if self.content_maturity ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 23, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.content_maturity)
    end

    if self.is_officially_licensed ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 24, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_officially_licensed then 1 else 0)
    end

    if self.refund_policy_text ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 25, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.refund_policy_text)
    end

    if self.refund_article_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 26, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.refund_article_id)
    end

    if self.preview_video_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 27, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.preview_video_id)
    end

    if self.creation_source ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 28, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creation_source)
    end

    if self.promotional_text ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 29, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.promotional_text)
    end

    if self.moment_video_asset_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 30, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.moment_video_asset_id)
    end

    if self.is_community_licensed ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 31, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_community_licensed then 1 else 0)
    end

    if self.summary ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 32, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.summary)
    end

    if self.tags ~= nil and #self.tags > 0 then
        for _, tag in self.tags do
            local var1, var2 = proto.writeTag(buffer2, num1, 33, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, tag)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseData.decode(buf1: buffer)
    local var1 = UniverseData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.id = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.root_place_id = var4
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.creator_id = var4
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.player_count = var4
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_up_votes = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_down_votes = var4
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_voice_supported = var4 ~= 0
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_camera_supported = var4 ~= 0
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.maximum_server_size = var4
            elseif var2 == 18 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.favorite_count = var4
            elseif var2 == 19 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_visits = var4
            elseif var2 == 21 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.game_minimum_age = var4
            elseif var2 == 24 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_officially_licensed = var4 ~= 0
            elseif var2 == 27 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.preview_video_id = var4
            elseif var2 == 30 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.moment_video_asset_id = var4
            elseif var2 == 31 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_community_licensed = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_type = buffer.tostring(buf)
            elseif var2 == 12 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.localized_fiat_price = buffer.tostring(buf)
            elseif var2 == 13 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.genre_l1 = buffer.tostring(buf)
            elseif var2 == 14 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.genre_l2 = buffer.tostring(buf)
            elseif var2 == 16 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.created_date = buffer.tostring(buf)
            elseif var2 == 17 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.updated_date = buffer.tostring(buf)
            elseif var2 == 20 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.canonical_url_path = buffer.tostring(buf)
            elseif var2 == 22 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.game_age_display_name = buffer.tostring(buf)
            elseif var2 == 23 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.content_maturity = buffer.tostring(buf)
            elseif var2 == 25 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.refund_policy_text = buffer.tostring(buf)
            elseif var2 == 26 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.refund_article_id = buffer.tostring(buf)
            elseif var2 == 28 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creation_source = buffer.tostring(buf)
            elseif var2 == 29 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.promotional_text = buffer.tostring(buf)
            elseif var2 == 32 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.summary = buffer.tostring(buf)
            elseif var2 == 33 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.tags, buffer.tostring(var4))
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

function UniverseData:jsonEncode()
    local result = {}

    if self.id ~= nil then
        result.id = self.id
    end

    if self.name ~= nil then
        result.name = self.name
    end

    if self.description ~= nil then
        result.description = self.description
    end

    if self.root_place_id ~= nil then
        result.rootPlaceId = self.root_place_id
    end

    if self.creator_type ~= nil then
        result.creatorType = self.creator_type
    end

    if self.creator_id ~= nil then
        result.creatorId = self.creator_id
    end

    if self.player_count ~= nil then
        result.playerCount = self.player_count
    end

    if self.total_up_votes ~= nil then
        result.totalUpVotes = self.total_up_votes
    end

    if self.total_down_votes ~= nil then
        result.totalDownVotes = self.total_down_votes
    end

    if self.is_voice_supported ~= nil then
        result.isVoiceSupported = self.is_voice_supported
    end

    if self.is_camera_supported ~= nil then
        result.isCameraSupported = self.is_camera_supported
    end

    if self.localized_fiat_price ~= nil then
        result.localizedFiatPrice = self.localized_fiat_price
    end

    if self.genre_l1 ~= nil then
        result.genreL1 = self.genre_l1
    end

    if self.genre_l2 ~= nil then
        result.genreL2 = self.genre_l2
    end

    if self.maximum_server_size ~= nil then
        result.maximumServerSize = self.maximum_server_size
    end

    if self.created_date ~= nil then
        result.createdDate = self.created_date
    end

    if self.updated_date ~= nil then
        result.updatedDate = self.updated_date
    end

    if self.favorite_count ~= nil then
        result.favoriteCount = self.favorite_count
    end

    if self.total_visits ~= nil then
        result.totalVisits = self.total_visits
    end

    if self.canonical_url_path ~= nil then
        result.canonicalUrlPath = self.canonical_url_path
    end

    if self.game_minimum_age ~= nil then
        result.gameMinimumAge = self.game_minimum_age
    end

    if self.game_age_display_name ~= nil then
        result.gameAgeDisplayName = self.game_age_display_name
    end

    if self.content_maturity ~= nil then
        result.contentMaturity = self.content_maturity
    end

    if self.is_officially_licensed ~= nil then
        result.isOfficiallyLicensed = self.is_officially_licensed
    end

    if self.refund_policy_text ~= nil then
        result.refundPolicyText = self.refund_policy_text
    end

    if self.refund_article_id ~= nil then
        result.refundArticleId = self.refund_article_id
    end

    if self.preview_video_id ~= nil then
        result.previewVideoId = self.preview_video_id
    end

    if self.creation_source ~= nil then
        result.creationSource = self.creation_source
    end

    if self.promotional_text ~= nil then
        result.promotionalText = self.promotional_text
    end

    if self.moment_video_asset_id ~= nil then
        result.momentVideoAssetId = self.moment_video_asset_id
    end

    if self.is_community_licensed ~= nil then
        result.isCommunityLicensed = self.is_community_licensed
    end

    if self.summary ~= nil then
        result.summary = self.summary
    end

    if self.tags ~= nil and #self.tags > 0 then
        local tags = {}
        for _, tag in self.tags do
            table.insert(tags, tag)
        end
        result.tags = tags
    end

    return result
end

function UniverseData:jsonDecode()
    local var1 = UniverseData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.root_place_id ~= nil then
        var1.root_place_id = self.root_place_id
    end

    if self.rootPlaceId ~= nil then
        var1.root_place_id = self.rootPlaceId
    end

    if self.creator_type ~= nil then
        var1.creator_type = self.creator_type
    end

    if self.creatorType ~= nil then
        var1.creator_type = self.creatorType
    end

    if self.creator_id ~= nil then
        var1.creator_id = self.creator_id
    end

    if self.creatorId ~= nil then
        var1.creator_id = self.creatorId
    end

    if self.player_count ~= nil then
        var1.player_count = self.player_count
    end

    if self.playerCount ~= nil then
        var1.player_count = self.playerCount
    end

    if self.total_up_votes ~= nil then
        var1.total_up_votes = self.total_up_votes
    end

    if self.totalUpVotes ~= nil then
        var1.total_up_votes = self.totalUpVotes
    end

    if self.total_down_votes ~= nil then
        var1.total_down_votes = self.total_down_votes
    end

    if self.totalDownVotes ~= nil then
        var1.total_down_votes = self.totalDownVotes
    end

    if self.is_voice_supported ~= nil then
        var1.is_voice_supported = self.is_voice_supported
    end

    if self.isVoiceSupported ~= nil then
        var1.is_voice_supported = self.isVoiceSupported
    end

    if self.is_camera_supported ~= nil then
        var1.is_camera_supported = self.is_camera_supported
    end

    if self.isCameraSupported ~= nil then
        var1.is_camera_supported = self.isCameraSupported
    end

    if self.localized_fiat_price ~= nil then
        var1.localized_fiat_price = self.localized_fiat_price
    end

    if self.localizedFiatPrice ~= nil then
        var1.localized_fiat_price = self.localizedFiatPrice
    end

    if self.genre_l1 ~= nil then
        var1.genre_l1 = self.genre_l1
    end

    if self.genreL1 ~= nil then
        var1.genre_l1 = self.genreL1
    end

    if self.genre_l2 ~= nil then
        var1.genre_l2 = self.genre_l2
    end

    if self.genreL2 ~= nil then
        var1.genre_l2 = self.genreL2
    end

    if self.maximum_server_size ~= nil then
        var1.maximum_server_size = self.maximum_server_size
    end

    if self.maximumServerSize ~= nil then
        var1.maximum_server_size = self.maximumServerSize
    end

    if self.created_date ~= nil then
        var1.created_date = self.created_date
    end

    if self.createdDate ~= nil then
        var1.created_date = self.createdDate
    end

    if self.updated_date ~= nil then
        var1.updated_date = self.updated_date
    end

    if self.updatedDate ~= nil then
        var1.updated_date = self.updatedDate
    end

    if self.favorite_count ~= nil then
        var1.favorite_count = self.favorite_count
    end

    if self.favoriteCount ~= nil then
        var1.favorite_count = self.favoriteCount
    end

    if self.total_visits ~= nil then
        var1.total_visits = self.total_visits
    end

    if self.totalVisits ~= nil then
        var1.total_visits = self.totalVisits
    end

    if self.canonical_url_path ~= nil then
        var1.canonical_url_path = self.canonical_url_path
    end

    if self.canonicalUrlPath ~= nil then
        var1.canonical_url_path = self.canonicalUrlPath
    end

    if self.game_minimum_age ~= nil then
        var1.game_minimum_age = self.game_minimum_age
    end

    if self.gameMinimumAge ~= nil then
        var1.game_minimum_age = self.gameMinimumAge
    end

    if self.game_age_display_name ~= nil then
        var1.game_age_display_name = self.game_age_display_name
    end

    if self.gameAgeDisplayName ~= nil then
        var1.game_age_display_name = self.gameAgeDisplayName
    end

    if self.content_maturity ~= nil then
        var1.content_maturity = self.content_maturity
    end

    if self.contentMaturity ~= nil then
        var1.content_maturity = self.contentMaturity
    end

    if self.is_officially_licensed ~= nil then
        var1.is_officially_licensed = self.is_officially_licensed
    end

    if self.isOfficiallyLicensed ~= nil then
        var1.is_officially_licensed = self.isOfficiallyLicensed
    end

    if self.refund_policy_text ~= nil then
        var1.refund_policy_text = self.refund_policy_text
    end

    if self.refundPolicyText ~= nil then
        var1.refund_policy_text = self.refundPolicyText
    end

    if self.refund_article_id ~= nil then
        var1.refund_article_id = self.refund_article_id
    end

    if self.refundArticleId ~= nil then
        var1.refund_article_id = self.refundArticleId
    end

    if self.preview_video_id ~= nil then
        var1.preview_video_id = self.preview_video_id
    end

    if self.previewVideoId ~= nil then
        var1.preview_video_id = self.previewVideoId
    end

    if self.creation_source ~= nil then
        var1.creation_source = self.creation_source
    end

    if self.creationSource ~= nil then
        var1.creation_source = self.creationSource
    end

    if self.promotional_text ~= nil then
        var1.promotional_text = self.promotional_text
    end

    if self.promotionalText ~= nil then
        var1.promotional_text = self.promotionalText
    end

    if self.moment_video_asset_id ~= nil then
        var1.moment_video_asset_id = self.moment_video_asset_id
    end

    if self.momentVideoAssetId ~= nil then
        var1.moment_video_asset_id = self.momentVideoAssetId
    end

    if self.is_community_licensed ~= nil then
        var1.is_community_licensed = self.is_community_licensed
    end

    if self.isCommunityLicensed ~= nil then
        var1.is_community_licensed = self.isCommunityLicensed
    end

    if self.summary ~= nil then
        var1.summary = self.summary
    end

    if self.tags ~= nil then
        local tags = {}
        for _, tag in self.tags do
            table.insert(tags, tag)
        end

        var1.tags = tags
    end

    return var1
end

UniverseData.descriptor = {
    name = "UniverseData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseData"
}

tbl1.UniverseData = UniverseData

typeRegistry.default:register(tbl1.UniverseData)

return {
    UniverseData = tbl1.UniverseData
}

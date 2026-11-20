-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local FriendRecommendationData = {}
FriendRecommendationData.__index = FriendRecommendationData

function FriendRecommendationData.new(tbl3)
    local tbl4 = {
        recommendation_type = if tbl3 == nil or tbl3.recommendation_type == nil then assert(tbl1.FriendRecommendationData_RecommendationType.fromNumber(0), "Enum has no 0 default") else tbl3.recommendation_type,
        context_type = if tbl3 == nil or tbl3.context_type == nil then nil else tbl3.context_type,
        mutual_friends_count = if tbl3 == nil or tbl3.mutual_friends_count == nil then nil else tbl3.mutual_friends_count,
        contact_name = if tbl3 == nil or tbl3.contact_name == nil then nil else tbl3.contact_name,
        avatar_thumbnail_url = if tbl3 == nil or tbl3.avatar_thumbnail_url == nil then nil else tbl3.avatar_thumbnail_url,
        headshot_thumbnail_url = if tbl3 == nil or tbl3.headshot_thumbnail_url == nil then nil else tbl3.headshot_thumbnail_url
    }
    return (setmetatable(tbl4, FriendRecommendationData))
end

function FriendRecommendationData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.recommendation_type ~= nil
        and (self.recommendation_type ~= nil and self.recommendation_type ~= 0
            or self.recommendation_type ~= tbl1.FriendRecommendationData_RecommendationType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.FriendRecommendationData_RecommendationType.toNumber(self.recommendation_type))
    end

    if self.context_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.context_type)
    end

    if self.mutual_friends_count ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.mutual_friends_count)
    end

    if self.contact_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.contact_name)
    end

    if self.avatar_thumbnail_url ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.avatar_thumbnail_url)
    end

    if self.headshot_thumbnail_url ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.headshot_thumbnail_url)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FriendRecommendationData.decode(buf1: buffer)
    local var1 = FriendRecommendationData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.recommendation_type = tbl1.FriendRecommendationData_RecommendationType.fromNumber(var4) or var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.mutual_friends_count = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.context_type = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.contact_name = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.avatar_thumbnail_url = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.headshot_thumbnail_url = buffer.tostring(buf)
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

function FriendRecommendationData:jsonEncode()
    local result = {}

    if self.recommendation_type ~= nil
        and (self.recommendation_type ~= nil and self.recommendation_type ~= 0
            or self.recommendation_type ~= tbl1.FriendRecommendationData_RecommendationType.fromNumber(0))
    then
        result.recommendationType = if typeof(self.recommendation_type) == "number" then self.recommendation_type else tbl1.FriendRecommendationData_RecommendationType.toNumber(self.recommendation_type)
    end

    if self.context_type ~= nil then
        result.contextType = self.context_type
    end

    if self.mutual_friends_count ~= nil then
        result.mutualFriendsCount = self.mutual_friends_count
    end

    if self.contact_name ~= nil then
        result.contactName = self.contact_name
    end

    if self.avatar_thumbnail_url ~= nil then
        result.avatarThumbnailUrl = self.avatar_thumbnail_url
    end

    if self.headshot_thumbnail_url ~= nil then
        result.headshotThumbnailUrl = self.headshot_thumbnail_url
    end

    return result
end

function FriendRecommendationData:jsonDecode()
    local var1 = FriendRecommendationData.new()

    if self.recommendation_type ~= nil then
        var1.recommendation_type = if typeof(self.recommendation_type) == "number" then tbl1.FriendRecommendationData_RecommendationType.fromNumber(self.recommendation_type) or self.recommendation_type else tbl1.FriendRecommendationData_RecommendationType.fromName(self.recommendation_type) or self.recommendation_type
    end

    if self.recommendationType ~= nil then
        var1.recommendation_type = if typeof(self.recommendationType) == "number" then tbl1.FriendRecommendationData_RecommendationType.fromNumber(self.recommendationType) or self.recommendationType else tbl1.FriendRecommendationData_RecommendationType.fromName(self.recommendationType) or self.recommendationType
    end

    if self.context_type ~= nil then
        var1.context_type = self.context_type
    end

    if self.contextType ~= nil then
        var1.context_type = self.contextType
    end

    if self.mutual_friends_count ~= nil then
        var1.mutual_friends_count = self.mutual_friends_count
    end

    if self.mutualFriendsCount ~= nil then
        var1.mutual_friends_count = self.mutualFriendsCount
    end

    if self.contact_name ~= nil then
        var1.contact_name = self.contact_name
    end

    if self.contactName ~= nil then
        var1.contact_name = self.contactName
    end

    if self.avatar_thumbnail_url ~= nil then
        var1.avatar_thumbnail_url = self.avatar_thumbnail_url
    end

    if self.avatarThumbnailUrl ~= nil then
        var1.avatar_thumbnail_url = self.avatarThumbnailUrl
    end

    if self.headshot_thumbnail_url ~= nil then
        var1.headshot_thumbnail_url = self.headshot_thumbnail_url
    end

    if self.headshotThumbnailUrl ~= nil then
        var1.headshot_thumbnail_url = self.headshotThumbnailUrl
    end

    return var1
end

FriendRecommendationData.descriptor = {
    name = "FriendRecommendationData",
    fullName = "roblox.apppageplatform.shared.v1beta1.FriendRecommendationData"
}

tbl1.FriendRecommendationData = FriendRecommendationData

typeRegistry.default:register(tbl1.FriendRecommendationData)

tbl1.FriendRecommendationData_RecommendationType = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "RECOMMENDATION_TYPE_INVALID" elseif num1 == 1 then "RECOMMENDATION_TYPE_USER" elseif num1 == 2 then "RECOMMENDATION_TYPE_CONTACT" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "RECOMMENDATION_TYPE_INVALID" then 0 elseif arg1 == "RECOMMENDATION_TYPE_USER" then 1 elseif arg1 == "RECOMMENDATION_TYPE_CONTACT" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "RECOMMENDATION_TYPE_INVALID" then "RECOMMENDATION_TYPE_INVALID" elseif str1 == "RECOMMENDATION_TYPE_USER" then "RECOMMENDATION_TYPE_USER" elseif str1 == "RECOMMENDATION_TYPE_CONTACT" then "RECOMMENDATION_TYPE_CONTACT" else nil
    end
}

return {
    FriendRecommendationData = tbl1.FriendRecommendationData,
    FriendRecommendationData_RecommendationType = tbl1.FriendRecommendationData_RecommendationType
}

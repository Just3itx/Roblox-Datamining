-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local timestamp = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.timestamp)
local _custom_options = require(script.Parent.custom_options)

local BadgeData = {}
BadgeData.__index = BadgeData

function BadgeData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then 0 else tbl3.id,
        display_name = if tbl3 == nil or tbl3.display_name == nil then "" else tbl3.display_name,
        display_icon_image_id = if tbl3 == nil or tbl3.display_icon_image_id == nil then 0 else tbl3.display_icon_image_id,
        display_description = if tbl3 == nil or tbl3.display_description == nil then "" else tbl3.display_description,
        total_awarded_count = if tbl3 == nil or tbl3.total_awarded_count == nil then 0 else tbl3.total_awarded_count,
        past_day_awarded_count = if tbl3 == nil or tbl3.past_day_awarded_count == nil then 0 else tbl3.past_day_awarded_count,
        rarity = if tbl3 == nil or tbl3.rarity == nil then "" else tbl3.rarity,
        badge_type_label = if tbl3 == nil or tbl3.badge_type_label == nil then "" else tbl3.badge_type_label,
        created_time = if tbl3 == nil or tbl3.created_time == nil then nil else tbl3.created_time,
        updated_time = if tbl3 == nil or tbl3.updated_time == nil then nil else tbl3.updated_time,
        is_earned_by_user = not (tbl3 == nil or tbl3.is_earned_by_user == nil) and tbl3.is_earned_by_user,
        awarded_time = if tbl3 == nil or tbl3.awarded_time == nil then nil else tbl3.awarded_time
    }, BadgeData))
end

function BadgeData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.id)
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.display_icon_image_id ~= nil and self.display_icon_image_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.display_icon_image_id)
    end

    if self.display_description ~= nil and self.display_description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_description)
    end

    if self.total_awarded_count ~= nil and self.total_awarded_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_awarded_count)
    end

    if self.past_day_awarded_count ~= nil and self.past_day_awarded_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.past_day_awarded_count)
    end

    if self.rarity ~= nil and self.rarity ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.rarity)
    end

    if self.badge_type_label ~= nil and self.badge_type_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.badge_type_label)
    end

    if self.created_time ~= nil then
        local buf = self.created_time:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.updated_time ~= nil then
        local buf = self.updated_time:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.is_earned_by_user then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_earned_by_user then 1 else 0)
    end

    if self.awarded_time ~= nil then
        local buf = self.awarded_time:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeData.decode(buf1: buffer)
    local var1 = BadgeData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.id = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.display_icon_image_id = var4
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_awarded_count = var4
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.past_day_awarded_count = var4
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_earned_by_user = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_description = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.rarity = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.badge_type_label = buffer.tostring(buf)
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.created_time = timestamp.Timestamp.decode(var4)
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.updated_time = timestamp.Timestamp.decode(var4)
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.awarded_time = timestamp.Timestamp.decode(var4)
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

function BadgeData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= 0 then
        result.id = self.id
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.display_icon_image_id ~= nil and self.display_icon_image_id ~= 0 then
        result.displayIconImageId = self.display_icon_image_id
    end

    if self.display_description ~= nil and self.display_description ~= "" then
        result.displayDescription = self.display_description
    end

    if self.total_awarded_count ~= nil and self.total_awarded_count ~= 0 then
        result.totalAwardedCount = self.total_awarded_count
    end

    if self.past_day_awarded_count ~= nil and self.past_day_awarded_count ~= 0 then
        result.pastDayAwardedCount = self.past_day_awarded_count
    end

    if self.rarity ~= nil and self.rarity ~= "" then
        result.rarity = self.rarity
    end

    if self.badge_type_label ~= nil and self.badge_type_label ~= "" then
        result.badgeTypeLabel = self.badge_type_label
    end

    if self.created_time ~= nil then
        result.createdTime = self.created_time:jsonEncode()
    end

    if self.updated_time ~= nil then
        result.updatedTime = self.updated_time:jsonEncode()
    end

    if self.is_earned_by_user then
        result.isEarnedByUser = self.is_earned_by_user
    end

    if self.awarded_time ~= nil then
        result.awardedTime = self.awarded_time:jsonEncode()
    end

    return result
end

function BadgeData:jsonDecode()
    local var1 = BadgeData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.display_icon_image_id ~= nil then
        var1.display_icon_image_id = self.display_icon_image_id
    end

    if self.displayIconImageId ~= nil then
        var1.display_icon_image_id = self.displayIconImageId
    end

    if self.display_description ~= nil then
        var1.display_description = self.display_description
    end

    if self.displayDescription ~= nil then
        var1.display_description = self.displayDescription
    end

    if self.total_awarded_count ~= nil then
        var1.total_awarded_count = self.total_awarded_count
    end

    if self.totalAwardedCount ~= nil then
        var1.total_awarded_count = self.totalAwardedCount
    end

    if self.past_day_awarded_count ~= nil then
        var1.past_day_awarded_count = self.past_day_awarded_count
    end

    if self.pastDayAwardedCount ~= nil then
        var1.past_day_awarded_count = self.pastDayAwardedCount
    end

    if self.rarity ~= nil then
        var1.rarity = self.rarity
    end

    if self.badge_type_label ~= nil then
        var1.badge_type_label = self.badge_type_label
    end

    if self.badgeTypeLabel ~= nil then
        var1.badge_type_label = self.badgeTypeLabel
    end

    if self.created_time ~= nil then
        var1.created_time = timestamp.Timestamp.jsonDecode(self.created_time)
    end

    if self.createdTime ~= nil then
        var1.created_time = timestamp.Timestamp.jsonDecode(self.createdTime)
    end

    if self.updated_time ~= nil then
        var1.updated_time = timestamp.Timestamp.jsonDecode(self.updated_time)
    end

    if self.updatedTime ~= nil then
        var1.updated_time = timestamp.Timestamp.jsonDecode(self.updatedTime)
    end

    if self.is_earned_by_user ~= nil then
        var1.is_earned_by_user = self.is_earned_by_user
    end

    if self.isEarnedByUser ~= nil then
        var1.is_earned_by_user = self.isEarnedByUser
    end

    if self.awarded_time ~= nil then
        var1.awarded_time = timestamp.Timestamp.jsonDecode(self.awarded_time)
    end

    if self.awardedTime ~= nil then
        var1.awarded_time = timestamp.Timestamp.jsonDecode(self.awardedTime)
    end

    return var1
end

BadgeData.descriptor = {
    name = "BadgeData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BadgeData"
}

tbl1.BadgeData = BadgeData

typeRegistry.default:register(tbl1.BadgeData)

return {
    BadgeData = tbl1.BadgeData
}

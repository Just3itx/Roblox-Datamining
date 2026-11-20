-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local EventData = {}
EventData.__index = EventData

function EventData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        title = if tbl3 == nil or tbl3.title == nil then "" else tbl3.title,
        subtitle = if tbl3 == nil or tbl3.subtitle == nil then "" else tbl3.subtitle,
        event_start = if tbl3 == nil or tbl3.event_start == nil then "" else tbl3.event_start,
        event_end = if tbl3 == nil or tbl3.event_end == nil then "" else tbl3.event_end,
        user_rsvp = not (tbl3 == nil or tbl3.user_rsvp == nil) and tbl3.user_rsvp,
        media_asset_id = if tbl3 == nil or tbl3.media_asset_id == nil then 0 else tbl3.media_asset_id,
        description = if tbl3 == nil or tbl3.description == nil then "" else tbl3.description,
        rsvp_count = if tbl3 == nil or tbl3.rsvp_count == nil then 0 else tbl3.rsvp_count,
        place_id = if tbl3 == nil or tbl3.place_id == nil then "" else tbl3.place_id
    }, EventData))
end

function EventData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.subtitle ~= nil and self.subtitle ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.subtitle)
    end

    if self.event_start ~= nil and self.event_start ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.event_start)
    end

    if self.event_end ~= nil and self.event_end ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.event_end)
    end

    if self.user_rsvp then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.user_rsvp then 1 else 0)
    end

    if self.media_asset_id ~= nil and self.media_asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.media_asset_id)
    end

    if self.description ~= nil and self.description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.rsvp_count ~= nil and self.rsvp_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.rsvp_count)
    end

    if self.place_id ~= nil and self.place_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.place_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function EventData.decode(buf1: buffer)
    local var1 = EventData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 6 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.user_rsvp = var4 ~= 0
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.media_asset_id = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.rsvp_count = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.subtitle = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.event_start = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.event_end = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 10 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.place_id = buffer.tostring(buf)
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

function EventData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.subtitle ~= nil and self.subtitle ~= "" then
        result.subtitle = self.subtitle
    end

    if self.event_start ~= nil and self.event_start ~= "" then
        result.eventStart = self.event_start
    end

    if self.event_end ~= nil and self.event_end ~= "" then
        result.eventEnd = self.event_end
    end

    if self.user_rsvp then
        result.userRsvp = self.user_rsvp
    end

    if self.media_asset_id ~= nil and self.media_asset_id ~= 0 then
        result.mediaAssetId = self.media_asset_id
    end

    if self.description ~= nil and self.description ~= "" then
        result.description = self.description
    end

    if self.rsvp_count ~= nil and self.rsvp_count ~= 0 then
        result.rsvpCount = self.rsvp_count
    end

    if self.place_id ~= nil and self.place_id ~= "" then
        result.placeId = self.place_id
    end

    return result
end

function EventData:jsonDecode()
    local var1 = EventData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.subtitle ~= nil then
        var1.subtitle = self.subtitle
    end

    if self.event_start ~= nil then
        var1.event_start = self.event_start
    end

    if self.eventStart ~= nil then
        var1.event_start = self.eventStart
    end

    if self.event_end ~= nil then
        var1.event_end = self.event_end
    end

    if self.eventEnd ~= nil then
        var1.event_end = self.eventEnd
    end

    if self.user_rsvp ~= nil then
        var1.user_rsvp = self.user_rsvp
    end

    if self.userRsvp ~= nil then
        var1.user_rsvp = self.userRsvp
    end

    if self.media_asset_id ~= nil then
        var1.media_asset_id = self.media_asset_id
    end

    if self.mediaAssetId ~= nil then
        var1.media_asset_id = self.mediaAssetId
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.rsvp_count ~= nil then
        var1.rsvp_count = self.rsvp_count
    end

    if self.rsvpCount ~= nil then
        var1.rsvp_count = self.rsvpCount
    end

    if self.place_id ~= nil then
        var1.place_id = self.place_id
    end

    if self.placeId ~= nil then
        var1.place_id = self.placeId
    end

    return var1
end

EventData.descriptor = {
    name = "EventData",
    fullName = "roblox.apppageplatform.shared.v1beta1.EventData"
}

tbl1.EventData = EventData

typeRegistry.default:register(tbl1.EventData)

return {
    EventData = tbl1.EventData
}

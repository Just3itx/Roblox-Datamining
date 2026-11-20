-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local duration = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.duration)

local Post = {}
Post.__index = Post

function Post.new(tbl3)
    return (setmetatable({
        metadata = if tbl3 == nil or tbl3.metadata == nil then nil else tbl3.metadata,
        tracks = (tbl3 == nil or tbl3.tracks == nil) and {} or tbl3.tracks
    }, Post))
end

function Post:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.metadata ~= nil then
        local buf = self.metadata:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.tracks ~= nil and #self.tracks > 0 then
        for _, track in self.tracks do
            local buf = track:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Post.decode(buf1: buffer)
    local var1 = Post.new()
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
                var1.metadata = tbl1.PostMetadata.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.tracks, tbl1.Track.decode(var4))
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

function Post:jsonEncode()
    local result = {}

    if self.metadata ~= nil then
        result.metadata = self.metadata:jsonEncode()
    end

    if self.tracks ~= nil and #self.tracks > 0 then
        local tracks = {}
        for _, track in self.tracks do
            table.insert(tracks, track:jsonEncode())
        end
        result.tracks = tracks
    end

    return result
end

function Post:jsonDecode()
    local var1 = Post.new()

    if self.metadata ~= nil then
        var1.metadata = tbl1.PostMetadata.jsonDecode(self.metadata)
    end

    if self.tracks ~= nil then
        local tracks = {}
        for _, track in self.tracks do
            table.insert(tracks, tbl1.Track.jsonDecode(track))
        end

        var1.tracks = tracks
    end

    return var1
end

Post.descriptor = { name = "Post", fullName = "roblox.posts.postasset.v1.Post" }

tbl1.Post = Post

typeRegistry.default:register(tbl1.Post)

local PostMetadata = {}
PostMetadata.__index = PostMetadata

function PostMetadata.new(tbl4)
    local tbl5 = {
        origin = if tbl4 == nil or tbl4.origin == nil then assert(tbl1.PostOrigin.fromNumber(0), "Enum has no 0 default") else tbl4.origin,
        caption = if tbl4 == nil or tbl4.caption == nil then "" else tbl4.caption,
        total_duration = if tbl4 == nil or tbl4.total_duration == nil then nil else tbl4.total_duration,
        content_language = if tbl4 == nil or tbl4.content_language == nil then "" else tbl4.content_language
    }
    return (setmetatable(tbl5, PostMetadata))
end

function PostMetadata:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.origin ~= nil and (self.origin ~= nil and self.origin ~= 0 or self.origin ~= tbl1.PostOrigin.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.PostOrigin.toNumber(self.origin))
    end

    if self.caption ~= nil and self.caption ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.caption)
    end

    if self.total_duration ~= nil then
        local buf = self.total_duration:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.content_language ~= nil and self.content_language ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.content_language)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PostMetadata.decode(buf1: buffer)
    local var1 = PostMetadata.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.origin = tbl1.PostOrigin.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.caption = buffer.tostring(buf)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.total_duration = duration.Duration.decode(var4)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.content_language = buffer.tostring(buf)
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

function PostMetadata:jsonEncode()
    local result = {}

    if self.origin ~= nil and (self.origin ~= nil and self.origin ~= 0 or self.origin ~= tbl1.PostOrigin.fromNumber(0)) then
        result.origin = if typeof(self.origin) == "number" then self.origin else tbl1.PostOrigin.toNumber(self.origin)
    end

    if self.caption ~= nil and self.caption ~= "" then
        result.caption = self.caption
    end

    if self.total_duration ~= nil then
        result.totalDuration = self.total_duration:jsonEncode()
    end

    if self.content_language ~= nil and self.content_language ~= "" then
        result.contentLanguage = self.content_language
    end

    return result
end

function PostMetadata:jsonDecode()
    local var1 = PostMetadata.new()

    if self.origin ~= nil then
        var1.origin = if typeof(self.origin) == "number" then tbl1.PostOrigin.fromNumber(self.origin) or self.origin else tbl1.PostOrigin.fromName(self.origin) or self.origin
    end

    if self.caption ~= nil then
        var1.caption = self.caption
    end

    if self.total_duration ~= nil then
        var1.total_duration = duration.Duration.jsonDecode(self.total_duration)
    end

    if self.totalDuration ~= nil then
        var1.total_duration = duration.Duration.jsonDecode(self.totalDuration)
    end

    if self.content_language ~= nil then
        var1.content_language = self.content_language
    end

    if self.contentLanguage ~= nil then
        var1.content_language = self.contentLanguage
    end

    return var1
end

PostMetadata.descriptor = {
    name = "PostMetadata",
    fullName = "roblox.posts.postasset.v1.PostMetadata"
}

tbl1.PostMetadata = PostMetadata

typeRegistry.default:register(tbl1.PostMetadata)

local Track = {}
Track.__index = Track

function Track.new(tbl5)
    local tbl6 = {
        type = if tbl5 == nil or tbl5.type == nil then assert(tbl1.TrackType.fromNumber(0), "Enum has no 0 default") else tbl5.type,
        slots = (tbl5 == nil or tbl5.slots == nil) and {} or tbl5.slots
    }
    return (setmetatable(tbl6, Track))
end

function Track:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.type ~= nil and (self.type ~= nil and self.type ~= 0 or self.type ~= tbl1.TrackType.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TrackType.toNumber(self.type))
    end

    if self.slots ~= nil and #self.slots > 0 then
        for _, slot in self.slots do
            local buf = slot:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Track.decode(buf1: buffer)
    local var1 = Track.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.type = tbl1.TrackType.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.slots, tbl1.Slot.decode(var4))
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

function Track:jsonEncode()
    local result = {}

    if self.type ~= nil and (self.type ~= nil and self.type ~= 0 or self.type ~= tbl1.TrackType.fromNumber(0)) then
        result.type = if typeof(self.type) == "number" then self.type else tbl1.TrackType.toNumber(self.type)
    end

    if self.slots ~= nil and #self.slots > 0 then
        local slots = {}
        for _, slot in self.slots do
            table.insert(slots, slot:jsonEncode())
        end
        result.slots = slots
    end

    return result
end

function Track:jsonDecode()
    local var1 = Track.new()

    if self.type ~= nil then
        var1.type = if typeof(self.type) == "number" then tbl1.TrackType.fromNumber(self.type) or self.type else tbl1.TrackType.fromName(self.type) or self.type
    end

    if self.slots ~= nil then
        local slots = {}
        for _, slot in self.slots do
            table.insert(slots, tbl1.Slot.jsonDecode(slot))
        end

        var1.slots = slots
    end

    return var1
end

Track.descriptor = { name = "Track", fullName = "roblox.posts.postasset.v1.Track" }

tbl1.Track = Track

typeRegistry.default:register(tbl1.Track)

local Slot = {}
Slot.__index = Slot

function Slot.new(tbl6)
    return (setmetatable({
        slot_id = if tbl6 == nil or tbl6.slot_id == nil then "" else tbl6.slot_id,
        time_range = if tbl6 == nil or tbl6.time_range == nil then nil else tbl6.time_range,
        content = if tbl6 == nil or tbl6.content == nil then nil else tbl6.content
    }, Slot))
end

function Slot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.slot_id ~= nil and self.slot_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.slot_id)
    end

    if self.time_range ~= nil then
        local buf = self.time_range:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.content ~= nil then
        if self.content.type == "visual" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "audio" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "experience_annotation" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "avatar_annotation" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Slot.decode(buf1: buffer)
    local var1 = Slot.new()
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
                var1.slot_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.time_range = tbl1.TimeRange.decode(var4)
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "visual",
                    value = tbl1.VisualSlot.decode(var4)
                }
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "audio",
                    value = tbl1.AudioSlot.decode(var4)
                }
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "experience_annotation",
                    value = tbl1.ExperienceAnnotationSlot.decode(var4)
                }
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "avatar_annotation",
                    value = tbl1.AvatarAnnotationSlot.decode(var4)
                }
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

function Slot:jsonEncode()
    local result = {}

    if self.slot_id ~= nil and self.slot_id ~= "" then
        result.slotId = self.slot_id
    end

    if self.time_range ~= nil then
        result.timeRange = self.time_range:jsonEncode()
    end

    if self.content ~= nil then
        if self.content.type == "visual" then
            result.visual = self.content.value:jsonEncode()
            return result
        elseif self.content.type == "audio" then
            result.audio = self.content.value:jsonEncode()
            return result
        elseif self.content.type == "experience_annotation" then
            result.experienceAnnotation = self.content.value:jsonEncode()
            return result
        end

        if self.content.type == "avatar_annotation" then
            result.avatarAnnotation = self.content.value:jsonEncode()
        end
    end

    return result
end

function Slot:jsonDecode()
    local var1 = Slot.new()

    if self.slot_id ~= nil then
        var1.slot_id = self.slot_id
    end

    if self.slotId ~= nil then
        var1.slot_id = self.slotId
    end

    if self.time_range ~= nil then
        var1.time_range = tbl1.TimeRange.jsonDecode(self.time_range)
    end

    if self.timeRange ~= nil then
        var1.time_range = tbl1.TimeRange.jsonDecode(self.timeRange)
    end

    if self.visual ~= nil then
        var1.content = {
            type = "visual",
            value = tbl1.VisualSlot.jsonDecode(self.visual)
        }
    end
    if self.audio ~= nil then
        var1.content = {
            type = "audio",
            value = tbl1.AudioSlot.jsonDecode(self.audio)
        }
    end
    if self.experience_annotation ~= nil then
        var1.content = {
            type = "experience_annotation",
            value = tbl1.ExperienceAnnotationSlot.jsonDecode(self.experience_annotation)
        }
    end

    if self.experienceAnnotation ~= nil then
        var1.content = {
            type = "experience_annotation",
            value = tbl1.ExperienceAnnotationSlot.jsonDecode(self.experienceAnnotation)
        }
    end

    if self.avatar_annotation ~= nil then
        var1.content = {
            type = "avatar_annotation",
            value = tbl1.AvatarAnnotationSlot.jsonDecode(self.avatar_annotation)
        }
    end

    if self.avatarAnnotation ~= nil then
        var1.content = {
            type = "avatar_annotation",
            value = tbl1.AvatarAnnotationSlot.jsonDecode(self.avatarAnnotation)
        }
    end
    return var1
end

Slot.descriptor = { name = "Slot", fullName = "roblox.posts.postasset.v1.Slot" }

tbl1.Slot = Slot

typeRegistry.default:register(tbl1.Slot)

local VisualSlot = {}
VisualSlot.__index = VisualSlot

function VisualSlot.new(tbl7)
    return (setmetatable({
        z_index = if tbl7 == nil or tbl7.z_index == nil then 0 else tbl7.z_index,
        transform = if tbl7 == nil or tbl7.transform == nil then nil else tbl7.transform,
        content = if tbl7 == nil or tbl7.content == nil then nil else tbl7.content
    }, VisualSlot))
end

function VisualSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.z_index ~= nil and self.z_index ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.z_index)
    end

    if self.transform ~= nil then
        local buf = self.transform:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.content ~= nil then
        if self.content.type == "video" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "image" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "text_label" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.content.type == "scene" then
            local buf = self.content.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function VisualSlot.decode(buf1: buffer)
    local var1 = VisualSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.z_index = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.transform = tbl1.Transform.decode(var4)
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "video",
                    value = tbl1.VideoSlot.decode(var4)
                }
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "image",
                    value = tbl1.ImageSlot.decode(var4)
                }
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "text_label",
                    value = tbl1.TextLabelSlot.decode(var4)
                }
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.content = {
                    type = "scene",
                    value = tbl1.SceneSlot.decode(var4)
                }
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

function VisualSlot:jsonEncode()
    local result = {}

    if self.z_index ~= nil and self.z_index ~= 0 then
        result.zIndex = self.z_index
    end

    if self.transform ~= nil then
        result.transform = self.transform:jsonEncode()
    end

    if self.content ~= nil then
        if self.content.type == "video" then
            result.video = self.content.value:jsonEncode()
            return result
        elseif self.content.type == "image" then
            result.image = self.content.value:jsonEncode()
            return result
        elseif self.content.type == "text_label" then
            result.textLabel = self.content.value:jsonEncode()
            return result
        end

        if self.content.type == "scene" then
            result.scene = self.content.value:jsonEncode()
        end
    end

    return result
end

function VisualSlot:jsonDecode()
    local var1 = VisualSlot.new()

    if self.z_index ~= nil then
        var1.z_index = self.z_index
    end

    if self.zIndex ~= nil then
        var1.z_index = self.zIndex
    end

    if self.transform ~= nil then
        var1.transform = tbl1.Transform.jsonDecode(self.transform)
    end

    if self.video ~= nil then
        var1.content = {
            type = "video",
            value = tbl1.VideoSlot.jsonDecode(self.video)
        }
    end
    if self.image ~= nil then
        var1.content = {
            type = "image",
            value = tbl1.ImageSlot.jsonDecode(self.image)
        }
    end
    if self.text_label ~= nil then
        var1.content = {
            type = "text_label",
            value = tbl1.TextLabelSlot.jsonDecode(self.text_label)
        }
    end
    if self.textLabel ~= nil then
        var1.content = {
            type = "text_label",
            value = tbl1.TextLabelSlot.jsonDecode(self.textLabel)
        }
    end
    if self.scene ~= nil then
        var1.content = {
            type = "scene",
            value = tbl1.SceneSlot.jsonDecode(self.scene)
        }
    end
    return var1
end

VisualSlot.descriptor = { name = "VisualSlot", fullName = "roblox.posts.postasset.v1.VisualSlot" }

tbl1.VisualSlot = VisualSlot

typeRegistry.default:register(tbl1.VisualSlot)

local VideoSlot = {}
VideoSlot.__index = VideoSlot

function VideoSlot.new(tbl8)
    return (setmetatable({
        asset_id = if tbl8 == nil or tbl8.asset_id == nil then 0 else tbl8.asset_id,
        trim = if tbl8 == nil or tbl8.trim == nil then nil else tbl8.trim
    }, VideoSlot))
end

function VideoSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_id)
    end

    if self.trim ~= nil then
        local buf = self.trim:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function VideoSlot.decode(buf1: buffer)
    local var1 = VideoSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.trim = tbl1.TimeRange.decode(var4)
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

function VideoSlot:jsonEncode()
    local result = {}

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        result.assetId = self.asset_id
    end

    if self.trim ~= nil then
        result.trim = self.trim:jsonEncode()
    end

    return result
end

function VideoSlot:jsonDecode()
    local var1 = VideoSlot.new()

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    if self.trim ~= nil then
        var1.trim = tbl1.TimeRange.jsonDecode(self.trim)
    end

    return var1
end

VideoSlot.descriptor = { name = "VideoSlot", fullName = "roblox.posts.postasset.v1.VideoSlot" }

tbl1.VideoSlot = VideoSlot

typeRegistry.default:register(tbl1.VideoSlot)

local ImageSlot = {}
ImageSlot.__index = ImageSlot

function ImageSlot.new(tbl9)
    return (setmetatable({ asset_id = if tbl9 == nil or tbl9.asset_id == nil then 0 else tbl9.asset_id }, ImageSlot))
end

function ImageSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageSlot.decode(buf1: buffer)
    local var1 = ImageSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
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

function ImageSlot:jsonEncode()
    local result = {}

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        result.assetId = self.asset_id
    end

    return result
end

function ImageSlot:jsonDecode()
    local var1 = ImageSlot.new()

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    return var1
end

ImageSlot.descriptor = { name = "ImageSlot", fullName = "roblox.posts.postasset.v1.ImageSlot" }

tbl1.ImageSlot = ImageSlot

typeRegistry.default:register(tbl1.ImageSlot)

local TextLabelSlot = {}
TextLabelSlot.__index = TextLabelSlot

function TextLabelSlot.new(tbl10)
    local tbl11 = {
        text = if tbl10 == nil or tbl10.text == nil then "" else tbl10.text,
        font = if tbl10 == nil or tbl10.font == nil then nil else tbl10.font,
        text_x_alignment = if tbl10 == nil or tbl10.text_x_alignment == nil then assert(tbl1.TextXAlignment.fromNumber(0), "Enum has no 0 default") else tbl10.text_x_alignment,
        font_color = if tbl10 == nil or tbl10.font_color == nil then nil else tbl10.font_color,
        font_size = if tbl10 == nil or tbl10.font_size == nil then 0 else tbl10.font_size
    }
    return (setmetatable(tbl11, TextLabelSlot))
end

function TextLabelSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.text ~= nil and self.text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    if self.font ~= nil then
        local buf = self.font:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.text_x_alignment ~= nil
        and (self.text_x_alignment ~= nil and self.text_x_alignment ~= 0
            or self.text_x_alignment ~= tbl1.TextXAlignment.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)

        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextXAlignment.toNumber(self.text_x_alignment))
    end

    if self.font_color ~= nil then
        local buf = self.font_color:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.font_size ~= nil and self.font_size ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.font_size)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TextLabelSlot.decode(buf1: buffer)
    local var1 = TextLabelSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.text_x_alignment = tbl1.TextXAlignment.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.font = tbl1.FontInfo.decode(var4)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.font_color = tbl1.Color3.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 5 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.font_size = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function TextLabelSlot:jsonEncode()
    local result = {}

    if self.text ~= nil and self.text ~= "" then
        result.text = self.text
    end

    if self.font ~= nil then
        result.font = self.font:jsonEncode()
    end

    if self.text_x_alignment ~= nil
        and (self.text_x_alignment ~= nil and self.text_x_alignment ~= 0
            or self.text_x_alignment ~= tbl1.TextXAlignment.fromNumber(0))
    then
        result.textXAlignment = if typeof(self.text_x_alignment) == "number" then self.text_x_alignment else tbl1.TextXAlignment.toNumber(self.text_x_alignment)
    end

    if self.font_color ~= nil then
        result.fontColor = self.font_color:jsonEncode()
    end

    if self.font_size ~= nil and self.font_size ~= 0 then
        result.fontSize = proto.json.serializeNumber(self.font_size)
    end

    return result
end

function TextLabelSlot:jsonDecode()
    local var1 = TextLabelSlot.new()

    if self.text ~= nil then
        var1.text = self.text
    end

    if self.font ~= nil then
        var1.font = tbl1.FontInfo.jsonDecode(self.font)
    end

    if self.text_x_alignment ~= nil then
        var1.text_x_alignment = if typeof(self.text_x_alignment) == "number" then tbl1.TextXAlignment.fromNumber(self.text_x_alignment) or self.text_x_alignment else tbl1.TextXAlignment.fromName(self.text_x_alignment) or self.text_x_alignment
    end

    if self.textXAlignment ~= nil then
        var1.text_x_alignment = if typeof(self.textXAlignment) == "number" then tbl1.TextXAlignment.fromNumber(self.textXAlignment) or self.textXAlignment else tbl1.TextXAlignment.fromName(self.textXAlignment) or self.textXAlignment
    end

    if self.font_color ~= nil then
        var1.font_color = tbl1.Color3.jsonDecode(self.font_color)
    end

    if self.fontColor ~= nil then
        var1.font_color = tbl1.Color3.jsonDecode(self.fontColor)
    end

    if self.font_size ~= nil then
        var1.font_size = proto.json.deserializeNumber(self.font_size)
    end

    if self.fontSize ~= nil then
        var1.font_size = proto.json.deserializeNumber(self.fontSize)
    end

    return var1
end

TextLabelSlot.descriptor = {
    name = "TextLabelSlot",
    fullName = "roblox.posts.postasset.v1.TextLabelSlot"
}

tbl1.TextLabelSlot = TextLabelSlot

typeRegistry.default:register(tbl1.TextLabelSlot)

local SceneSlot = {}
SceneSlot.__index = SceneSlot

function SceneSlot.new(tbl11)
    return (setmetatable({
        asset_id = if tbl11 == nil or tbl11.asset_id == nil then 0 else tbl11.asset_id,
        rbxm_data = if tbl11 == nil or tbl11.rbxm_data == nil then buffer.create(0) else tbl11.rbxm_data
    }, SceneSlot))
end

function SceneSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_id)
    end

    if self.rbxm_data ~= nil and buffer.len(self.rbxm_data) > 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, self.rbxm_data, buffer.len(self.rbxm_data))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SceneSlot.decode(buf1: buffer)
    local var1 = SceneSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.rbxm_data = var4
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

function SceneSlot:jsonEncode()
    local result = {}

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        result.assetId = self.asset_id
    end

    if self.rbxm_data ~= nil and buffer.len(self.rbxm_data) > 0 then
        result.rbxmData = proto.json.serializeBuffer(self.rbxm_data)
    end

    return result
end

function SceneSlot:jsonDecode()
    local var1 = SceneSlot.new()

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    if self.rbxm_data ~= nil then
        var1.rbxm_data = proto.json.deserializeBuffer(self.rbxm_data)
    end

    if self.rbxmData ~= nil then
        var1.rbxm_data = proto.json.deserializeBuffer(self.rbxmData)
    end

    return var1
end

SceneSlot.descriptor = { name = "SceneSlot", fullName = "roblox.posts.postasset.v1.SceneSlot" }

tbl1.SceneSlot = SceneSlot

typeRegistry.default:register(tbl1.SceneSlot)

local AudioSlot = {}
AudioSlot.__index = AudioSlot

function AudioSlot.new(tbl12)
    local tbl13 = {
        asset_id = if tbl12 == nil or tbl12.asset_id == nil then 0 else tbl12.asset_id,
        trim = if tbl12 == nil or tbl12.trim == nil then nil else tbl12.trim,
        audio_type = if tbl12 == nil or tbl12.audio_type == nil then assert(tbl1.AudioType.fromNumber(0), "Enum has no 0 default") else tbl12.audio_type,
        source_trim = if tbl12 == nil or tbl12.source_trim == nil then nil else tbl12.source_trim,
        context = if tbl12 == nil or tbl12.context == nil then nil else tbl12.context
    }
    return (setmetatable(tbl13, AudioSlot))
end

function AudioSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_id)
    end

    if self.trim ~= nil then
        local buf = self.trim:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.audio_type ~= nil
        and (self.audio_type ~= nil and self.audio_type ~= 0 or self.audio_type ~= tbl1.AudioType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.AudioType.toNumber(self.audio_type))
    end

    if self.source_trim ~= nil then
        local buf = self.source_trim:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.context ~= nil and self.context.type == "tts" then
        local buf = self.context.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AudioSlot.decode(buf1: buffer)
    local var1 = AudioSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_id = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.audio_type = tbl1.AudioType.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.trim = tbl1.TimeRange.decode(var4)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.source_trim = tbl1.TimeRange.decode(var4)
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.context = {
                    type = "tts",
                    value = tbl1.TtsAudioContext.decode(var4)
                }
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

function AudioSlot:jsonEncode()
    local result = {}

    if self.asset_id ~= nil and self.asset_id ~= 0 then
        result.assetId = self.asset_id
    end

    if self.trim ~= nil then
        result.trim = self.trim:jsonEncode()
    end

    if self.audio_type ~= nil
        and (self.audio_type ~= nil and self.audio_type ~= 0 or self.audio_type ~= tbl1.AudioType.fromNumber(0))
    then
        result.audioType = if typeof(self.audio_type) == "number" then self.audio_type else tbl1.AudioType.toNumber(self.audio_type)
    end

    if self.source_trim ~= nil then
        result.sourceTrim = self.source_trim:jsonEncode()
    end

    if self.context ~= nil and self.context.type == "tts" then
        result.tts = self.context.value:jsonEncode()
    end

    return result
end

function AudioSlot:jsonDecode()
    local var1 = AudioSlot.new()

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    if self.trim ~= nil then
        var1.trim = tbl1.TimeRange.jsonDecode(self.trim)
    end

    if self.audio_type ~= nil then
        var1.audio_type = if typeof(self.audio_type) == "number" then tbl1.AudioType.fromNumber(self.audio_type) or self.audio_type else tbl1.AudioType.fromName(self.audio_type) or self.audio_type
    end

    if self.audioType ~= nil then
        var1.audio_type = if typeof(self.audioType) == "number" then tbl1.AudioType.fromNumber(self.audioType) or self.audioType else tbl1.AudioType.fromName(self.audioType) or self.audioType
    end

    if self.source_trim ~= nil then
        var1.source_trim = tbl1.TimeRange.jsonDecode(self.source_trim)
    end

    if self.sourceTrim ~= nil then
        var1.source_trim = tbl1.TimeRange.jsonDecode(self.sourceTrim)
    end

    if self.tts ~= nil then
        var1.context = {
            type = "tts",
            value = tbl1.TtsAudioContext.jsonDecode(self.tts)
        }
    end
    return var1
end

AudioSlot.descriptor = { name = "AudioSlot", fullName = "roblox.posts.postasset.v1.AudioSlot" }

tbl1.AudioSlot = AudioSlot

typeRegistry.default:register(tbl1.AudioSlot)

local TtsAudioContext = {}
TtsAudioContext.__index = TtsAudioContext

function TtsAudioContext.new(tbl13)
    return (setmetatable({
        text = if tbl13 == nil or tbl13.text == nil then "" else tbl13.text,
        voice_id = if tbl13 == nil or tbl13.voice_id == nil then 0 else tbl13.voice_id,
        pitch = if tbl13 == nil or tbl13.pitch == nil then 0 else tbl13.pitch,
        speed = if tbl13 == nil or tbl13.speed == nil then 0 else tbl13.speed
    }, TtsAudioContext))
end

function TtsAudioContext:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.text ~= nil and self.text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    if self.voice_id ~= nil and self.voice_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.voice_id)
    end

    if self.pitch ~= nil and self.pitch ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i64)
        buffer2, num1 = proto.writeDouble(var1, var2, self.pitch)
    end

    if self.speed ~= nil and self.speed ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.i64)
        buffer2, num1 = proto.writeDouble(var1, var2, self.speed)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TtsAudioContext.decode(buf1: buffer)
    local var1 = TtsAudioContext.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.voice_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 ~= proto.wireTypes.i64 then
            error("Unsupported wire type: " .. var3)
        elseif var2 == 3 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.pitch = var4
        elseif var2 == 4 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.speed = var4
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function TtsAudioContext:jsonEncode()
    local result = {}

    if self.text ~= nil and self.text ~= "" then
        result.text = self.text
    end

    if self.voice_id ~= nil and self.voice_id ~= 0 then
        result.voiceId = self.voice_id
    end

    if self.pitch ~= nil and self.pitch ~= 0 then
        result.pitch = proto.json.serializeNumber(self.pitch)
    end

    if self.speed ~= nil and self.speed ~= 0 then
        result.speed = proto.json.serializeNumber(self.speed)
    end

    return result
end

function TtsAudioContext:jsonDecode()
    local var1 = TtsAudioContext.new()

    if self.text ~= nil then
        var1.text = self.text
    end

    if self.voice_id ~= nil then
        var1.voice_id = self.voice_id
    end

    if self.voiceId ~= nil then
        var1.voice_id = self.voiceId
    end

    if self.pitch ~= nil then
        var1.pitch = proto.json.deserializeNumber(self.pitch)
    end

    if self.speed ~= nil then
        var1.speed = proto.json.deserializeNumber(self.speed)
    end

    return var1
end

TtsAudioContext.descriptor = {
    name = "TtsAudioContext",
    fullName = "roblox.posts.postasset.v1.TtsAudioContext"
}

tbl1.TtsAudioContext = TtsAudioContext

typeRegistry.default:register(tbl1.TtsAudioContext)

local ExperienceAnnotationSlot = {}
ExperienceAnnotationSlot.__index = ExperienceAnnotationSlot

function ExperienceAnnotationSlot.new(tbl14)
    return (setmetatable({
        universe_id = if tbl14 == nil or tbl14.universe_id == nil then 0 else tbl14.universe_id,
        place_id = if tbl14 == nil or tbl14.place_id == nil then 0 else tbl14.place_id
    }, ExperienceAnnotationSlot))
end

function ExperienceAnnotationSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.universe_id)
    end

    if self.place_id ~= nil and self.place_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.place_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ExperienceAnnotationSlot.decode(buf1: buffer)
    local var1 = ExperienceAnnotationSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.universe_id = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.place_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
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

function ExperienceAnnotationSlot:jsonEncode()
    local result = {}

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        result.universeId = self.universe_id
    end

    if self.place_id ~= nil and self.place_id ~= 0 then
        result.placeId = self.place_id
    end

    return result
end

function ExperienceAnnotationSlot:jsonDecode()
    local var1 = ExperienceAnnotationSlot.new()

    if self.universe_id ~= nil then
        var1.universe_id = self.universe_id
    end

    if self.universeId ~= nil then
        var1.universe_id = self.universeId
    end

    if self.place_id ~= nil then
        var1.place_id = self.place_id
    end

    if self.placeId ~= nil then
        var1.place_id = self.placeId
    end

    return var1
end

ExperienceAnnotationSlot.descriptor = {
    name = "ExperienceAnnotationSlot",
    fullName = "roblox.posts.postasset.v1.ExperienceAnnotationSlot"
}

tbl1.ExperienceAnnotationSlot = ExperienceAnnotationSlot

typeRegistry.default:register(tbl1.ExperienceAnnotationSlot)

local AvatarAnnotationSlot = {}
AvatarAnnotationSlot.__index = AvatarAnnotationSlot

function AvatarAnnotationSlot.new(tbl15)
    return (setmetatable(
        {
            outfit_id = if tbl15 == nil or tbl15.outfit_id == nil then 0 else tbl15.outfit_id
        },
        AvatarAnnotationSlot
    ))
end

function AvatarAnnotationSlot:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.outfit_id ~= nil and self.outfit_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.outfit_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AvatarAnnotationSlot.decode(buf1: buffer)
    local var1 = AvatarAnnotationSlot.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.outfit_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
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

function AvatarAnnotationSlot:jsonEncode()
    local result = {}

    if self.outfit_id ~= nil and self.outfit_id ~= 0 then
        result.outfitId = self.outfit_id
    end

    return result
end

function AvatarAnnotationSlot:jsonDecode()
    local var1 = AvatarAnnotationSlot.new()

    if self.outfit_id ~= nil then
        var1.outfit_id = self.outfit_id
    end

    if self.outfitId ~= nil then
        var1.outfit_id = self.outfitId
    end

    return var1
end

AvatarAnnotationSlot.descriptor = {
    name = "AvatarAnnotationSlot",
    fullName = "roblox.posts.postasset.v1.AvatarAnnotationSlot"
}

tbl1.AvatarAnnotationSlot = AvatarAnnotationSlot

typeRegistry.default:register(tbl1.AvatarAnnotationSlot)

local TimeRange = {}
TimeRange.__index = TimeRange

function TimeRange.new(tbl16)
    return (setmetatable({
        offset_duration = if tbl16 == nil or tbl16.offset_duration == nil then nil else tbl16.offset_duration,
        duration = if tbl16 == nil or tbl16.duration == nil then nil else tbl16.duration
    }, TimeRange))
end

function TimeRange:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.offset_duration ~= nil then
        local buf = self.offset_duration:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.duration ~= nil then
        local buf = self.duration:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TimeRange.decode(buf1: buffer)
    local var1 = TimeRange.new()
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
                var1.offset_duration = duration.Duration.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.duration = duration.Duration.decode(var4)
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

function TimeRange:jsonEncode()
    local result = {}

    if self.offset_duration ~= nil then
        result.offsetDuration = self.offset_duration:jsonEncode()
    end

    if self.duration ~= nil then
        result.duration = self.duration:jsonEncode()
    end

    return result
end

function TimeRange:jsonDecode()
    local var1 = TimeRange.new()

    if self.offset_duration ~= nil then
        var1.offset_duration = duration.Duration.jsonDecode(self.offset_duration)
    end

    if self.offsetDuration ~= nil then
        var1.offset_duration = duration.Duration.jsonDecode(self.offsetDuration)
    end

    if self.duration ~= nil then
        var1.duration = duration.Duration.jsonDecode(self.duration)
    end

    return var1
end

TimeRange.descriptor = { name = "TimeRange", fullName = "roblox.posts.postasset.v1.TimeRange" }

tbl1.TimeRange = TimeRange

typeRegistry.default:register(tbl1.TimeRange)

local Transform = {}
Transform.__index = Transform

function Transform.new(tbl17)
    return (setmetatable({
        position = if tbl17 == nil or tbl17.position == nil then nil else tbl17.position,
        rotation = if tbl17 == nil or tbl17.rotation == nil then 0 else tbl17.rotation,
        scale = if tbl17 == nil or tbl17.scale == nil then 0 else tbl17.scale
    }, Transform))
end

function Transform:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.position ~= nil then
        local buf = self.position:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.rotation ~= nil and self.rotation ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.rotation)
    end

    if self.scale ~= nil and self.scale ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.scale)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Transform.decode(buf1: buffer)
    local var1 = Transform.new()
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
                var1.position = tbl1.Vec2.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.rotation = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.scale = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function Transform:jsonEncode()
    local result = {}

    if self.position ~= nil then
        result.position = self.position:jsonEncode()
    end

    if self.rotation ~= nil and self.rotation ~= 0 then
        result.rotation = proto.json.serializeNumber(self.rotation)
    end

    if self.scale ~= nil and self.scale ~= 0 then
        result.scale = proto.json.serializeNumber(self.scale)
    end

    return result
end

function Transform:jsonDecode()
    local var1 = Transform.new()

    if self.position ~= nil then
        var1.position = tbl1.Vec2.jsonDecode(self.position)
    end

    if self.rotation ~= nil then
        var1.rotation = proto.json.deserializeNumber(self.rotation)
    end

    if self.scale ~= nil then
        var1.scale = proto.json.deserializeNumber(self.scale)
    end

    return var1
end

Transform.descriptor = { name = "Transform", fullName = "roblox.posts.postasset.v1.Transform" }

tbl1.Transform = Transform

typeRegistry.default:register(tbl1.Transform)

local Vec2 = {}
Vec2.__index = Vec2

function Vec2.new(tbl18)
    return (setmetatable(
        {
            x = if tbl18 == nil or tbl18.x == nil then 0 else tbl18.x,
            y = if tbl18 == nil or tbl18.y == nil then 0 else tbl18.y
        },
        Vec2
    ))
end

function Vec2:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.x ~= nil and self.x ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.x)
    end

    if self.y ~= nil and self.y ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.y)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Vec2.decode(buf1: buffer)
    local var1 = Vec2.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.x = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.y = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function Vec2:jsonEncode()
    local result = {}

    if self.x ~= nil and self.x ~= 0 then
        result.x = proto.json.serializeNumber(self.x)
    end

    if self.y ~= nil and self.y ~= 0 then
        result.y = proto.json.serializeNumber(self.y)
    end

    return result
end

function Vec2:jsonDecode()
    local var1 = Vec2.new()

    if self.x ~= nil then
        var1.x = proto.json.deserializeNumber(self.x)
    end

    if self.y ~= nil then
        var1.y = proto.json.deserializeNumber(self.y)
    end

    return var1
end

Vec2.descriptor = { name = "Vec2", fullName = "roblox.posts.postasset.v1.Vec2" }

tbl1.Vec2 = Vec2

typeRegistry.default:register(tbl1.Vec2)

local Color3 = {}
Color3.__index = Color3

function Color3.new(tbl19)
    return (setmetatable({
        r = if tbl19 == nil or tbl19.r == nil then 0 else tbl19.r,
        g = if tbl19 == nil or tbl19.g == nil then 0 else tbl19.g,
        b = if tbl19 == nil or tbl19.b == nil then 0 else tbl19.b
    }, Color3))
end

function Color3:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.r ~= nil and self.r ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.r)
    end

    if self.g ~= nil and self.g ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.g)
    end

    if self.b ~= nil and self.b ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.b)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Color3.decode(buf1: buffer)
    local var1 = Color3.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.r = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.g = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.b = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function Color3:jsonEncode()
    local result = {}

    if self.r ~= nil and self.r ~= 0 then
        result.r = proto.json.serializeNumber(self.r)
    end

    if self.g ~= nil and self.g ~= 0 then
        result.g = proto.json.serializeNumber(self.g)
    end

    if self.b ~= nil and self.b ~= 0 then
        result.b = proto.json.serializeNumber(self.b)
    end

    return result
end

function Color3:jsonDecode()
    local var1 = Color3.new()

    if self.r ~= nil then
        var1.r = proto.json.deserializeNumber(self.r)
    end

    if self.g ~= nil then
        var1.g = proto.json.deserializeNumber(self.g)
    end

    if self.b ~= nil then
        var1.b = proto.json.deserializeNumber(self.b)
    end

    return var1
end

Color3.descriptor = { name = "Color3", fullName = "roblox.posts.postasset.v1.Color3" }

tbl1.Color3 = Color3

typeRegistry.default:register(tbl1.Color3)

local FontInfo = {}
FontInfo.__index = FontInfo

function FontInfo.new(tbl20)
    return (setmetatable({ font_source = if tbl20 == nil or tbl20.font_source == nil then nil else tbl20.font_source }, FontInfo))
end

function FontInfo:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.font_source ~= nil then
        if self.font_source.type == "enumerated_font" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.EnumeratedFont.toNumber(self.font_source.value))
        elseif self.font_source.type == "family_asset_id" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, self.font_source.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FontInfo.decode(buf1: buffer)
    local var1 = FontInfo.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.font_source = {
                    type = "enumerated_font",
                    value = tbl1.EnumeratedFont.fromNumber(var4) or var4
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.font_source = { type = "family_asset_id", value = var4 }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
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

function FontInfo:jsonEncode()
    local result = {}

    if self.font_source ~= nil then
        if self.font_source.type == "enumerated_font" then
            result.enumeratedFont = if typeof(self.font_source.value) == "number" then self.font_source.value else tbl1.EnumeratedFont.toNumber(self.font_source.value)
            return result
        end

        if self.font_source.type == "family_asset_id" then
            result.familyAssetId = self.font_source.value
        end
    end

    return result
end

function FontInfo.jsonDecode(tbl20)
    local var1 = FontInfo.new()

    if tbl20.enumerated_font ~= nil then
        var1.font_source = {
            type = "enumerated_font",
            value = if typeof(tbl20.enumerated_font) == "number" then tbl1.EnumeratedFont.fromNumber(tbl20.enumerated_font) or tbl20.enumerated_font else tbl1.EnumeratedFont.fromName(tbl20.enumerated_font) or tbl20.enumerated_font
        }
    end

    if tbl20.enumeratedFont ~= nil then
        var1.font_source = {
            type = "enumerated_font",
            value = if typeof(tbl20.enumeratedFont) == "number" then tbl1.EnumeratedFont.fromNumber(tbl20.enumeratedFont) or tbl20.enumeratedFont else tbl1.EnumeratedFont.fromName(tbl20.enumeratedFont) or tbl20.enumeratedFont
        }
    end

    if tbl20.family_asset_id ~= nil then
        var1.font_source = {
            type = "family_asset_id",
            value = tbl20.family_asset_id
        }
    end
    if tbl20.familyAssetId ~= nil then
        var1.font_source = {
            type = "family_asset_id",
            value = tbl20.familyAssetId
        }
    end
    return var1
end

FontInfo.descriptor = { name = "FontInfo", fullName = "roblox.posts.postasset.v1.FontInfo" }

tbl1.FontInfo = FontInfo

typeRegistry.default:register(tbl1.FontInfo)

tbl1.PostOrigin = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "POST_ORIGIN_INVALID"
        elseif num1 == 1 then
            return "POST_ORIGIN_CAPTURE_VIDEO"
        elseif num1 == 2 then
            return "POST_ORIGIN_CAPTURE_SCREENSHOT"
        elseif num1 == 3 then
            return "POST_ORIGIN_INFLUENCER_UPLOAD"
        elseif num1 == 4 then
            return "POST_ORIGIN_AVATAR"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "POST_ORIGIN_INVALID" then
            return 0
        elseif arg1 == "POST_ORIGIN_CAPTURE_VIDEO" then
            return 1
        elseif arg1 == "POST_ORIGIN_CAPTURE_SCREENSHOT" then
            return 2
        elseif arg1 == "POST_ORIGIN_INFLUENCER_UPLOAD" then
            return 3
        elseif arg1 == "POST_ORIGIN_AVATAR" then
            return 4
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "POST_ORIGIN_INVALID" then
            return "POST_ORIGIN_INVALID"
        elseif str1 == "POST_ORIGIN_CAPTURE_VIDEO" then
            return "POST_ORIGIN_CAPTURE_VIDEO"
        elseif str1 == "POST_ORIGIN_CAPTURE_SCREENSHOT" then
            return "POST_ORIGIN_CAPTURE_SCREENSHOT"
        elseif str1 == "POST_ORIGIN_INFLUENCER_UPLOAD" then
            return "POST_ORIGIN_INFLUENCER_UPLOAD"
        elseif str1 == "POST_ORIGIN_AVATAR" then
            return "POST_ORIGIN_AVATAR"
        end

        return nil
    end
}

tbl1.TrackType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TRACK_TYPE_INVALID"
        elseif num1 == 1 then
            return "TRACK_TYPE_VISUAL"
        elseif num1 == 2 then
            return "TRACK_TYPE_AUDIO"
        elseif num1 == 3 then
            return "TRACK_TYPE_ANNOTATION"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TRACK_TYPE_INVALID" then
            return 0
        elseif arg1 == "TRACK_TYPE_VISUAL" then
            return 1
        elseif arg1 == "TRACK_TYPE_AUDIO" then
            return 2
        elseif arg1 == "TRACK_TYPE_ANNOTATION" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TRACK_TYPE_INVALID" then
            return "TRACK_TYPE_INVALID"
        elseif str1 == "TRACK_TYPE_VISUAL" then
            return "TRACK_TYPE_VISUAL"
        elseif str1 == "TRACK_TYPE_AUDIO" then
            return "TRACK_TYPE_AUDIO"
        elseif str1 == "TRACK_TYPE_ANNOTATION" then
            return "TRACK_TYPE_ANNOTATION"
        end

        return nil
    end
}

tbl1.AudioType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "AUDIO_TYPE_INVALID"
        elseif num1 == 1 then
            return "AUDIO_TYPE_MUSIC"
        elseif num1 == 2 then
            return "AUDIO_TYPE_TTS"
        elseif num1 == 3 then
            return "AUDIO_TYPE_VOICE_OVER"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "AUDIO_TYPE_INVALID" then
            return 0
        elseif arg1 == "AUDIO_TYPE_MUSIC" then
            return 1
        elseif arg1 == "AUDIO_TYPE_TTS" then
            return 2
        elseif arg1 == "AUDIO_TYPE_VOICE_OVER" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "AUDIO_TYPE_INVALID" then
            return "AUDIO_TYPE_INVALID"
        elseif str1 == "AUDIO_TYPE_MUSIC" then
            return "AUDIO_TYPE_MUSIC"
        elseif str1 == "AUDIO_TYPE_TTS" then
            return "AUDIO_TYPE_TTS"
        elseif str1 == "AUDIO_TYPE_VOICE_OVER" then
            return "AUDIO_TYPE_VOICE_OVER"
        end

        return nil
    end
}

tbl1.EnumeratedFont = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "ENUMERATED_FONT_INVALID"
        elseif num1 == 1 then
            return "ENUMERATED_FONT_GOTHAM_BOLD"
        elseif num1 == 2 then
            return "ENUMERATED_FONT_GOTHAM_BLACK"
        elseif num1 == 3 then
            return "ENUMERATED_FONT_SOURCE_SANS"
        elseif num1 == 4 then
            return "ENUMERATED_FONT_SOURCE_SANS_BOLD"
        elseif num1 == 5 then
            return "ENUMERATED_FONT_FREDOKA_ONE"
        elseif num1 == 6 then
            return "ENUMERATED_FONT_BANGERS"
        elseif num1 == 7 then
            return "ENUMERATED_FONT_BUILDER_SANS_MEDIUM"
        elseif num1 == 8 then
            return "ENUMERATED_FONT_LUCKIEST_GUY"
        elseif num1 == 9 then
            return "ENUMERATED_FONT_PERMANENT_MARKER"
        elseif num1 == 10 then
            return "ENUMERATED_FONT_CREEPSTER"
        elseif num1 == 11 then
            return "ENUMERATED_FONT_ARCADE"
        elseif num1 == 12 then
            return "ENUMERATED_FONT_SCI_FI"
        elseif num1 == 13 then
            return "ENUMERATED_FONT_INDIE_FLOWER"
        elseif num1 == 14 then
            return "ENUMERATED_FONT_GRENZE_GOTISCH"
        elseif num1 == 15 then
            return "ENUMERATED_FONT_SPECIAL_ELITE"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "ENUMERATED_FONT_INVALID" then
            return 0
        elseif arg1 == "ENUMERATED_FONT_GOTHAM_BOLD" then
            return 1
        elseif arg1 == "ENUMERATED_FONT_GOTHAM_BLACK" then
            return 2
        elseif arg1 == "ENUMERATED_FONT_SOURCE_SANS" then
            return 3
        elseif arg1 == "ENUMERATED_FONT_SOURCE_SANS_BOLD" then
            return 4
        elseif arg1 == "ENUMERATED_FONT_FREDOKA_ONE" then
            return 5
        elseif arg1 == "ENUMERATED_FONT_BANGERS" then
            return 6
        elseif arg1 == "ENUMERATED_FONT_BUILDER_SANS_MEDIUM" then
            return 7
        elseif arg1 == "ENUMERATED_FONT_LUCKIEST_GUY" then
            return 8
        elseif arg1 == "ENUMERATED_FONT_PERMANENT_MARKER" then
            return 9
        elseif arg1 == "ENUMERATED_FONT_CREEPSTER" then
            return 10
        elseif arg1 == "ENUMERATED_FONT_ARCADE" then
            return 11
        elseif arg1 == "ENUMERATED_FONT_SCI_FI" then
            return 12
        elseif arg1 == "ENUMERATED_FONT_INDIE_FLOWER" then
            return 13
        elseif arg1 == "ENUMERATED_FONT_GRENZE_GOTISCH" then
            return 14
        elseif arg1 == "ENUMERATED_FONT_SPECIAL_ELITE" then
            return 15
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "ENUMERATED_FONT_INVALID" then
            return "ENUMERATED_FONT_INVALID"
        elseif str1 == "ENUMERATED_FONT_GOTHAM_BOLD" then
            return "ENUMERATED_FONT_GOTHAM_BOLD"
        elseif str1 == "ENUMERATED_FONT_GOTHAM_BLACK" then
            return "ENUMERATED_FONT_GOTHAM_BLACK"
        elseif str1 == "ENUMERATED_FONT_SOURCE_SANS" then
            return "ENUMERATED_FONT_SOURCE_SANS"
        elseif str1 == "ENUMERATED_FONT_SOURCE_SANS_BOLD" then
            return "ENUMERATED_FONT_SOURCE_SANS_BOLD"
        elseif str1 == "ENUMERATED_FONT_FREDOKA_ONE" then
            return "ENUMERATED_FONT_FREDOKA_ONE"
        elseif str1 == "ENUMERATED_FONT_BANGERS" then
            return "ENUMERATED_FONT_BANGERS"
        elseif str1 == "ENUMERATED_FONT_BUILDER_SANS_MEDIUM" then
            return "ENUMERATED_FONT_BUILDER_SANS_MEDIUM"
        elseif str1 == "ENUMERATED_FONT_LUCKIEST_GUY" then
            return "ENUMERATED_FONT_LUCKIEST_GUY"
        elseif str1 == "ENUMERATED_FONT_PERMANENT_MARKER" then
            return "ENUMERATED_FONT_PERMANENT_MARKER"
        elseif str1 == "ENUMERATED_FONT_CREEPSTER" then
            return "ENUMERATED_FONT_CREEPSTER"
        elseif str1 == "ENUMERATED_FONT_ARCADE" then
            return "ENUMERATED_FONT_ARCADE"
        elseif str1 == "ENUMERATED_FONT_SCI_FI" then
            return "ENUMERATED_FONT_SCI_FI"
        elseif str1 == "ENUMERATED_FONT_INDIE_FLOWER" then
            return "ENUMERATED_FONT_INDIE_FLOWER"
        elseif str1 == "ENUMERATED_FONT_GRENZE_GOTISCH" then
            return "ENUMERATED_FONT_GRENZE_GOTISCH"
        elseif str1 == "ENUMERATED_FONT_SPECIAL_ELITE" then
            return "ENUMERATED_FONT_SPECIAL_ELITE"
        end

        return nil
    end
}

tbl1.TextXAlignment = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TEXT_X_ALIGNMENT_INVALID"
        elseif num1 == 1 then
            return "TEXT_X_ALIGNMENT_LEFT"
        elseif num1 == 2 then
            return "TEXT_X_ALIGNMENT_CENTER"
        elseif num1 == 3 then
            return "TEXT_X_ALIGNMENT_RIGHT"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TEXT_X_ALIGNMENT_INVALID" then
            return 0
        elseif arg1 == "TEXT_X_ALIGNMENT_LEFT" then
            return 1
        elseif arg1 == "TEXT_X_ALIGNMENT_CENTER" then
            return 2
        elseif arg1 == "TEXT_X_ALIGNMENT_RIGHT" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TEXT_X_ALIGNMENT_INVALID" then
            return "TEXT_X_ALIGNMENT_INVALID"
        elseif str1 == "TEXT_X_ALIGNMENT_LEFT" then
            return "TEXT_X_ALIGNMENT_LEFT"
        elseif str1 == "TEXT_X_ALIGNMENT_CENTER" then
            return "TEXT_X_ALIGNMENT_CENTER"
        elseif str1 == "TEXT_X_ALIGNMENT_RIGHT" then
            return "TEXT_X_ALIGNMENT_RIGHT"
        end

        return nil
    end
}

return {
    Post = tbl1.Post,
    PostMetadata = tbl1.PostMetadata,
    Track = tbl1.Track,
    Slot = tbl1.Slot,
    VisualSlot = tbl1.VisualSlot,
    VideoSlot = tbl1.VideoSlot,
    ImageSlot = tbl1.ImageSlot,
    TextLabelSlot = tbl1.TextLabelSlot,
    SceneSlot = tbl1.SceneSlot,
    AudioSlot = tbl1.AudioSlot,
    TtsAudioContext = tbl1.TtsAudioContext,
    ExperienceAnnotationSlot = tbl1.ExperienceAnnotationSlot,
    AvatarAnnotationSlot = tbl1.AvatarAnnotationSlot,
    TimeRange = tbl1.TimeRange,
    Transform = tbl1.Transform,
    Vec2 = tbl1.Vec2,
    Color3 = tbl1.Color3,
    FontInfo = tbl1.FontInfo,
    PostOrigin = tbl1.PostOrigin,
    TrackType = tbl1.TrackType,
    AudioType = tbl1.AudioType,
    EnumeratedFont = tbl1.EnumeratedFont,
    TextXAlignment = tbl1.TextXAlignment
}

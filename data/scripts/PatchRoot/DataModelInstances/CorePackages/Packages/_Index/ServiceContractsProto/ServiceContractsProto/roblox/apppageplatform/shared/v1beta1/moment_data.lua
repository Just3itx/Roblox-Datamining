-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MomentData = {}
MomentData.__index = MomentData

function MomentData.new(tbl3)
    return (setmetatable({
        moment_id = if tbl3 == nil or tbl3.moment_id == nil then nil else tbl3.moment_id,
        asset_id = if tbl3 == nil or tbl3.asset_id == nil then nil else tbl3.asset_id,
        creator_id = if tbl3 == nil or tbl3.creator_id == nil then nil else tbl3.creator_id,
        status = if tbl3 == nil or tbl3.status == nil then nil else tbl3.status,
        metadata = if tbl3 == nil or tbl3.metadata == nil then nil else tbl3.metadata
    }, MomentData))
end

function MomentData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.moment_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.moment_id)
    end

    if self.asset_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.asset_id)
    end

    if self.creator_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_id)
    end

    if self.status ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.status)
    end

    if self.metadata ~= nil then
        local buf = self.metadata:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData.decode(buf1: buffer)
    local var1 = MomentData.new()
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
                var1.moment_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.asset_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.status = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.metadata = tbl1.MomentData_MomentMetadata.decode(var4)
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

function MomentData:jsonEncode()
    local result = {}

    if self.moment_id ~= nil then
        result.momentId = self.moment_id
    end

    if self.asset_id ~= nil then
        result.assetId = self.asset_id
    end

    if self.creator_id ~= nil then
        result.creatorId = self.creator_id
    end

    if self.status ~= nil then
        result.status = self.status
    end

    if self.metadata ~= nil then
        result.metadata = self.metadata:jsonEncode()
    end

    return result
end

function MomentData:jsonDecode()
    local var1 = MomentData.new()

    if self.moment_id ~= nil then
        var1.moment_id = self.moment_id
    end

    if self.momentId ~= nil then
        var1.moment_id = self.momentId
    end

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    if self.creator_id ~= nil then
        var1.creator_id = self.creator_id
    end

    if self.creatorId ~= nil then
        var1.creator_id = self.creatorId
    end

    if self.status ~= nil then
        var1.status = self.status
    end

    if self.metadata ~= nil then
        var1.metadata = tbl1.MomentData_MomentMetadata.jsonDecode(self.metadata)
    end

    return var1
end

MomentData.descriptor = {
    name = "MomentData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MomentData"
}

tbl1.MomentData = MomentData

typeRegistry.default:register(tbl1.MomentData)

local MomentData_MomentMetadata = {}
MomentData_MomentMetadata.__index = MomentData_MomentMetadata

function MomentData_MomentMetadata.new(tbl4)
    return (setmetatable({
        asset_total_duration_seconds = if tbl4 == nil or tbl4.asset_total_duration_seconds == nil then nil else tbl4.asset_total_duration_seconds,
        capture_type = if tbl4 == nil or tbl4.capture_type == nil then nil else tbl4.capture_type,
        description = if tbl4 == nil or tbl4.description == nil then nil else tbl4.description,
        capture_universe_id = if tbl4 == nil or tbl4.capture_universe_id == nil then nil else tbl4.capture_universe_id,
        capture_place_id = if tbl4 == nil or tbl4.capture_place_id == nil then nil else tbl4.capture_place_id,
        edits = if tbl4 == nil or tbl4.edits == nil then nil else tbl4.edits
    }, MomentData_MomentMetadata))
end

function MomentData_MomentMetadata:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_total_duration_seconds ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.asset_total_duration_seconds)
    end

    if self.capture_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.capture_type)
    end

    if self.description ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.capture_universe_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.capture_universe_id)
    end

    if self.capture_place_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.capture_place_id)
    end

    if self.edits ~= nil then
        local buf = self.edits:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.capture_type = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.capture_universe_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.capture_place_id = buffer.tostring(buf)
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.edits = tbl1.MomentData_MomentMetadata_MomentEdits.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.asset_total_duration_seconds = var4
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

function MomentData_MomentMetadata:jsonEncode()
    local result = {}

    if self.asset_total_duration_seconds ~= nil then
        result.assetTotalDurationSeconds = proto.json.serializeNumber(self.asset_total_duration_seconds)
    end

    if self.capture_type ~= nil then
        result.captureType = self.capture_type
    end

    if self.description ~= nil then
        result.description = self.description
    end

    if self.capture_universe_id ~= nil then
        result.captureUniverseId = self.capture_universe_id
    end

    if self.capture_place_id ~= nil then
        result.capturePlaceId = self.capture_place_id
    end

    if self.edits ~= nil then
        result.edits = self.edits:jsonEncode()
    end

    return result
end

function MomentData_MomentMetadata:jsonDecode()
    local var1 = MomentData_MomentMetadata.new()

    if self.asset_total_duration_seconds ~= nil then
        var1.asset_total_duration_seconds = proto.json.deserializeNumber(self.asset_total_duration_seconds)
    end

    if self.assetTotalDurationSeconds ~= nil then
        var1.asset_total_duration_seconds = proto.json.deserializeNumber(self.assetTotalDurationSeconds)
    end

    if self.capture_type ~= nil then
        var1.capture_type = self.capture_type
    end

    if self.captureType ~= nil then
        var1.capture_type = self.captureType
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.capture_universe_id ~= nil then
        var1.capture_universe_id = self.capture_universe_id
    end

    if self.captureUniverseId ~= nil then
        var1.capture_universe_id = self.captureUniverseId
    end

    if self.capture_place_id ~= nil then
        var1.capture_place_id = self.capture_place_id
    end

    if self.capturePlaceId ~= nil then
        var1.capture_place_id = self.capturePlaceId
    end

    if self.edits ~= nil then
        var1.edits = tbl1.MomentData_MomentMetadata_MomentEdits.jsonDecode(self.edits)
    end

    return var1
end

MomentData_MomentMetadata.descriptor = {
    name = "MomentData_MomentMetadata",
    fullName = "roblox.apppageplatform.shared.v1beta1.MomentMetadata"
}

tbl1.MomentData_MomentMetadata = MomentData_MomentMetadata

typeRegistry.default:register(tbl1.MomentData_MomentMetadata)

local MomentData_MomentMetadata_MomentEdits = {}
MomentData_MomentMetadata_MomentEdits.__index = MomentData_MomentMetadata_MomentEdits

function MomentData_MomentMetadata_MomentEdits.new(tbl5)
    return (setmetatable({
        music = if tbl5 == nil or tbl5.music == nil then nil else tbl5.music,
        trim = if tbl5 == nil or tbl5.trim == nil then nil else tbl5.trim,
        text_overlays = (tbl5 == nil or tbl5.text_overlays == nil) and {} or tbl5.text_overlays
    }, MomentData_MomentMetadata_MomentEdits))
end

function MomentData_MomentMetadata_MomentEdits:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.music ~= nil then
        local buf = self.music:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.trim ~= nil then
        local buf = self.trim:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.text_overlays ~= nil and #self.text_overlays > 0 then
        for _, textOverlay in self.text_overlays do
            local buf = textOverlay:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata_MomentEdits.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata_MomentEdits.new()
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
                var1.music = tbl1.MomentData_MomentMetadata_MomentEdits_MusicEdit.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.trim = tbl1.MomentData_MomentMetadata_MomentEdits_TrimEdit.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.text_overlays, tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay.decode(var4))
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

function MomentData_MomentMetadata_MomentEdits:jsonEncode()
    local result = {}

    if self.music ~= nil then
        result.music = self.music:jsonEncode()
    end

    if self.trim ~= nil then
        result.trim = self.trim:jsonEncode()
    end

    if self.text_overlays ~= nil and #self.text_overlays > 0 then
        local textOverlays = {}
        for _, textOverlay in self.text_overlays do
            table.insert(textOverlays, textOverlay:jsonEncode())
        end
        result.textOverlays = textOverlays
    end

    return result
end

function MomentData_MomentMetadata_MomentEdits:jsonDecode()
    local var1 = MomentData_MomentMetadata_MomentEdits.new()

    if self.music ~= nil then
        var1.music = tbl1.MomentData_MomentMetadata_MomentEdits_MusicEdit.jsonDecode(self.music)
    end

    if self.trim ~= nil then
        var1.trim = tbl1.MomentData_MomentMetadata_MomentEdits_TrimEdit.jsonDecode(self.trim)
    end

    if self.text_overlays ~= nil then
        local textOverlays = {}
        for _, textOverlay in self.text_overlays do
            table.insert(textOverlays, tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay.jsonDecode(textOverlay))
        end

        var1.text_overlays = textOverlays
    end

    if self.textOverlays ~= nil then
        local textOverlays = {}
        for _, textOverlay in self.textOverlays do
            table.insert(textOverlays, tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay.jsonDecode(textOverlay))
        end

        var1.text_overlays = textOverlays
    end

    return var1
end

MomentData_MomentMetadata_MomentEdits.descriptor = {
    name = "MomentData_MomentMetadata_MomentEdits",
    fullName = "roblox.apppageplatform.shared.v1beta1.MomentEdits"
}

tbl1.MomentData_MomentMetadata_MomentEdits = MomentData_MomentMetadata_MomentEdits

typeRegistry.default:register(tbl1.MomentData_MomentMetadata_MomentEdits)

local MomentData_MomentMetadata_MomentEdits_MusicEdit = {}
MomentData_MomentMetadata_MomentEdits_MusicEdit.__index = MomentData_MomentMetadata_MomentEdits_MusicEdit

function MomentData_MomentMetadata_MomentEdits_MusicEdit.new(tbl6)
    return (setmetatable({
        asset_id = if tbl6 == nil or tbl6.asset_id == nil then nil else tbl6.asset_id,
        start_time_seconds = if tbl6 == nil or tbl6.start_time_seconds == nil then nil else tbl6.start_time_seconds
    }, MomentData_MomentMetadata_MomentEdits_MusicEdit))
end

function MomentData_MomentMetadata_MomentEdits_MusicEdit:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.asset_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.asset_id)
    end

    if self.start_time_seconds ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.start_time_seconds)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata_MomentEdits_MusicEdit.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata_MomentEdits_MusicEdit.new()
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
                var1.asset_id = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.start_time_seconds = var4
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

function MomentData_MomentMetadata_MomentEdits_MusicEdit:jsonEncode()
    local result = {}

    if self.asset_id ~= nil then
        result.assetId = self.asset_id
    end

    if self.start_time_seconds ~= nil then
        result.startTimeSeconds = proto.json.serializeNumber(self.start_time_seconds)
    end

    return result
end

function MomentData_MomentMetadata_MomentEdits_MusicEdit:jsonDecode()
    local var1 = MomentData_MomentMetadata_MomentEdits_MusicEdit.new()

    if self.asset_id ~= nil then
        var1.asset_id = self.asset_id
    end

    if self.assetId ~= nil then
        var1.asset_id = self.assetId
    end

    if self.start_time_seconds ~= nil then
        var1.start_time_seconds = proto.json.deserializeNumber(self.start_time_seconds)
    end

    if self.startTimeSeconds ~= nil then
        var1.start_time_seconds = proto.json.deserializeNumber(self.startTimeSeconds)
    end

    return var1
end

MomentData_MomentMetadata_MomentEdits_MusicEdit.descriptor = {
    name = "MomentData_MomentMetadata_MomentEdits_MusicEdit",
    fullName = "roblox.apppageplatform.shared.v1beta1.MusicEdit"
}

tbl1.MomentData_MomentMetadata_MomentEdits_MusicEdit = MomentData_MomentMetadata_MomentEdits_MusicEdit

typeRegistry.default:register(tbl1.MomentData_MomentMetadata_MomentEdits_MusicEdit)

local MomentData_MomentMetadata_MomentEdits_TrimEdit = {}
MomentData_MomentMetadata_MomentEdits_TrimEdit.__index = MomentData_MomentMetadata_MomentEdits_TrimEdit

function MomentData_MomentMetadata_MomentEdits_TrimEdit.new(tbl7)
    return (setmetatable({
        start_time_seconds = if tbl7 == nil or tbl7.start_time_seconds == nil then nil else tbl7.start_time_seconds,
        end_time_seconds = if tbl7 == nil or tbl7.end_time_seconds == nil then nil else tbl7.end_time_seconds
    }, MomentData_MomentMetadata_MomentEdits_TrimEdit))
end

function MomentData_MomentMetadata_MomentEdits_TrimEdit:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.start_time_seconds ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.start_time_seconds)
    end

    if self.end_time_seconds ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.end_time_seconds)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata_MomentEdits_TrimEdit.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata_MomentEdits_TrimEdit.new()
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
                var1.start_time_seconds = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.end_time_seconds = var4
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

function MomentData_MomentMetadata_MomentEdits_TrimEdit:jsonEncode()
    local result = {}

    if self.start_time_seconds ~= nil then
        result.startTimeSeconds = proto.json.serializeNumber(self.start_time_seconds)
    end

    if self.end_time_seconds ~= nil then
        result.endTimeSeconds = proto.json.serializeNumber(self.end_time_seconds)
    end

    return result
end

function MomentData_MomentMetadata_MomentEdits_TrimEdit:jsonDecode()
    local var1 = MomentData_MomentMetadata_MomentEdits_TrimEdit.new()

    if self.start_time_seconds ~= nil then
        var1.start_time_seconds = proto.json.deserializeNumber(self.start_time_seconds)
    end

    if self.startTimeSeconds ~= nil then
        var1.start_time_seconds = proto.json.deserializeNumber(self.startTimeSeconds)
    end

    if self.end_time_seconds ~= nil then
        var1.end_time_seconds = proto.json.deserializeNumber(self.end_time_seconds)
    end

    if self.endTimeSeconds ~= nil then
        var1.end_time_seconds = proto.json.deserializeNumber(self.endTimeSeconds)
    end

    return var1
end

MomentData_MomentMetadata_MomentEdits_TrimEdit.descriptor = {
    name = "MomentData_MomentMetadata_MomentEdits_TrimEdit",
    fullName = "roblox.apppageplatform.shared.v1beta1.TrimEdit"
}

tbl1.MomentData_MomentMetadata_MomentEdits_TrimEdit = MomentData_MomentMetadata_MomentEdits_TrimEdit

typeRegistry.default:register(tbl1.MomentData_MomentMetadata_MomentEdits_TrimEdit)

local MomentData_MomentMetadata_MomentEdits_TextOverlay = {}
MomentData_MomentMetadata_MomentEdits_TextOverlay.__index = MomentData_MomentMetadata_MomentEdits_TextOverlay

function MomentData_MomentMetadata_MomentEdits_TextOverlay.new(tbl8)
    return (setmetatable({
        position = (tbl8 == nil or tbl8.position == nil) and {} or tbl8.position,
        rotation = if tbl8 == nil or tbl8.rotation == nil then nil else tbl8.rotation,
        scale = if tbl8 == nil or tbl8.scale == nil then nil else tbl8.scale,
        text = if tbl8 == nil or tbl8.text == nil then nil else tbl8.text,
        style = if tbl8 == nil or tbl8.style == nil then nil else tbl8.style,
        z_index = if tbl8 == nil or tbl8.z_index == nil then nil else tbl8.z_index
    }, MomentData_MomentMetadata_MomentEdits_TextOverlay))
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.position ~= nil and #self.position > 0 then
        local buffer3 = buffer.create(0)
        local num2 = 0

        for _, value in self.position do
            buffer3, num2 = proto.writeFloat(buffer3, num2, value)
        end

        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buffer3, num2)
    end

    if self.rotation ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.rotation)
    end

    if self.scale ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.scale)
    end

    if self.text ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    if self.style ~= nil then
        local buf = self.style:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.z_index ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.z_index)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata_MomentEdits_TextOverlay.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.z_index = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)

                local var5 = num1 + var4

                while num1 < var5 do
                    local var6
                    var6, num1 = proto.readFloat(buf1, num1)
                    table.insert(var1.position, var6)
                end
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.style = tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.decode(var4)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                table.insert(var1.position, var4)
            elseif var2 == 2 then
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

function MomentData_MomentMetadata_MomentEdits_TextOverlay:jsonEncode()
    local result = {}

    if self.position ~= nil and #self.position > 0 then
        local position = {}
        for _, value in self.position do
            table.insert(position, proto.json.serializeNumber(value))
        end
        result.position = position
    end

    if self.rotation ~= nil then
        result.rotation = proto.json.serializeNumber(self.rotation)
    end

    if self.scale ~= nil then
        result.scale = proto.json.serializeNumber(self.scale)
    end

    if self.text ~= nil then
        result.text = self.text
    end

    if self.style ~= nil then
        result.style = self.style:jsonEncode()
    end

    if self.z_index ~= nil then
        result.zIndex = self.z_index
    end

    return result
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay:jsonDecode()
    local var1 = MomentData_MomentMetadata_MomentEdits_TextOverlay.new()

    if self.position ~= nil then
        local position = {}
        for _, value in self.position do
            table.insert(position, proto.json.deserializeNumber(value))
        end

        var1.position = position
    end

    if self.rotation ~= nil then
        var1.rotation = proto.json.deserializeNumber(self.rotation)
    end

    if self.scale ~= nil then
        var1.scale = proto.json.deserializeNumber(self.scale)
    end

    if self.text ~= nil then
        var1.text = self.text
    end

    if self.style ~= nil then
        var1.style = tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.jsonDecode(self.style)
    end

    if self.z_index ~= nil then
        var1.z_index = self.z_index
    end

    if self.zIndex ~= nil then
        var1.z_index = self.zIndex
    end

    return var1
end

MomentData_MomentMetadata_MomentEdits_TextOverlay.descriptor = {
    name = "MomentData_MomentMetadata_MomentEdits_TextOverlay",
    fullName = "roblox.apppageplatform.shared.v1beta1.TextOverlay"
}

tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay = MomentData_MomentMetadata_MomentEdits_TextOverlay

typeRegistry.default:register(tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay)

local MomentData_MomentMetadata_MomentEdits_TextOverlay_Style = {}
MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.__index = MomentData_MomentMetadata_MomentEdits_TextOverlay_Style

function MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.new(tbl9)
    return (setmetatable({
        font = if tbl9 == nil or tbl9.font == nil then nil else tbl9.font,
        font_color = (tbl9 == nil or tbl9.font_color == nil) and {} or tbl9.font_color,
        font_size = if tbl9 == nil or tbl9.font_size == nil then nil else tbl9.font_size,
        text_x_alignment = if tbl9 == nil or tbl9.text_x_alignment == nil then nil else tbl9.text_x_alignment
    }, MomentData_MomentMetadata_MomentEdits_TextOverlay_Style))
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay_Style:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.font ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.font)
    end

    if self.font_color ~= nil and #self.font_color > 0 then
        local buffer3 = buffer.create(0)
        local num2 = 0

        for _, value in self.font_color do
            buffer3, num2 = proto.writeFloat(buffer3, num2, value)
        end

        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buffer3, num2)
    end

    if self.font_size ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.font_size)
    end

    if self.text_x_alignment ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text_x_alignment)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.decode(buf1: buffer)
    local var1 = MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.new()
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
                var1.font = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)

                local var5 = num1 + var4

                while num1 < var5 do
                    local var6
                    var6, num1 = proto.readFloat(buf1, num1)
                    table.insert(var1.font_color, var6)
                end
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text_x_alignment = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                table.insert(var1.font_color, var4)
            elseif var2 == 3 then
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

function MomentData_MomentMetadata_MomentEdits_TextOverlay_Style:jsonEncode()
    local result = {}

    if self.font ~= nil then
        result.font = self.font
    end

    if self.font_color ~= nil and #self.font_color > 0 then
        local fontColor = {}
        for _, value in self.font_color do
            table.insert(fontColor, proto.json.serializeNumber(value))
        end
        result.fontColor = fontColor
    end

    if self.font_size ~= nil then
        result.fontSize = proto.json.serializeNumber(self.font_size)
    end

    if self.text_x_alignment ~= nil then
        result.textXAlignment = self.text_x_alignment
    end

    return result
end

function MomentData_MomentMetadata_MomentEdits_TextOverlay_Style:jsonDecode()
    local var1 = MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.new()

    if self.font ~= nil then
        var1.font = self.font
    end

    if self.font_color ~= nil then
        local fontColor = {}
        for _, value in self.font_color do
            table.insert(fontColor, proto.json.deserializeNumber(value))
        end

        var1.font_color = fontColor
    end

    if self.fontColor ~= nil then
        local fontColor = {}
        for _, value in self.fontColor do
            table.insert(fontColor, proto.json.deserializeNumber(value))
        end

        var1.font_color = fontColor
    end

    if self.font_size ~= nil then
        var1.font_size = proto.json.deserializeNumber(self.font_size)
    end

    if self.fontSize ~= nil then
        var1.font_size = proto.json.deserializeNumber(self.fontSize)
    end

    if self.text_x_alignment ~= nil then
        var1.text_x_alignment = self.text_x_alignment
    end

    if self.textXAlignment ~= nil then
        var1.text_x_alignment = self.textXAlignment
    end

    return var1
end

MomentData_MomentMetadata_MomentEdits_TextOverlay_Style.descriptor = {
    name = "MomentData_MomentMetadata_MomentEdits_TextOverlay_Style",
    fullName = "roblox.apppageplatform.shared.v1beta1.Style"
}

tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay_Style = MomentData_MomentMetadata_MomentEdits_TextOverlay_Style

typeRegistry.default:register(tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay_Style)

return {
    MomentData = tbl1.MomentData,
    MomentData_MomentMetadata = tbl1.MomentData_MomentMetadata,
    MomentData_MomentMetadata_MomentEdits = tbl1.MomentData_MomentMetadata_MomentEdits,
    MomentData_MomentMetadata_MomentEdits_MusicEdit = tbl1.MomentData_MomentMetadata_MomentEdits_MusicEdit,
    MomentData_MomentMetadata_MomentEdits_TrimEdit = tbl1.MomentData_MomentMetadata_MomentEdits_TrimEdit,
    MomentData_MomentMetadata_MomentEdits_TextOverlay = tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay,
    MomentData_MomentMetadata_MomentEdits_TextOverlay_Style = tbl1.MomentData_MomentMetadata_MomentEdits_TextOverlay_Style
}

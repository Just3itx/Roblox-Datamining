-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MediaAssetData = {}
MediaAssetData.__index = MediaAssetData

function MediaAssetData.new(tbl3)
    return (setmetatable({
        image_id = if tbl3 == nil or tbl3.image_id == nil then "" else tbl3.image_id,
        asset_type_id = if tbl3 == nil or tbl3.asset_type_id == nil then 0 else tbl3.asset_type_id,
        video_hash = if tbl3 == nil or tbl3.video_hash == nil then "" else tbl3.video_hash,
        video_id = if tbl3 == nil or tbl3.video_id == nil then "" else tbl3.video_id,
        video_title = if tbl3 == nil or tbl3.video_title == nil then "" else tbl3.video_title
    }, MediaAssetData))
end

function MediaAssetData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.image_id ~= nil and self.image_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.image_id)
    end

    if self.asset_type_id ~= nil and self.asset_type_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_type_id)
    end

    if self.video_hash ~= nil and self.video_hash ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.video_hash)
    end

    if self.video_id ~= nil and self.video_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.video_id)
    end

    if self.video_title ~= nil and self.video_title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.video_title)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MediaAssetData.decode(buf1: buffer)
    local var1 = MediaAssetData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_type_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.image_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.video_hash = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.video_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.video_title = buffer.tostring(buf)
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

function MediaAssetData:jsonEncode()
    local result = {}

    if self.image_id ~= nil and self.image_id ~= "" then
        result.imageId = self.image_id
    end

    if self.asset_type_id ~= nil and self.asset_type_id ~= 0 then
        result.assetTypeId = self.asset_type_id
    end

    if self.video_hash ~= nil and self.video_hash ~= "" then
        result.videoHash = self.video_hash
    end

    if self.video_id ~= nil and self.video_id ~= "" then
        result.videoId = self.video_id
    end

    if self.video_title ~= nil and self.video_title ~= "" then
        result.videoTitle = self.video_title
    end

    return result
end

function MediaAssetData:jsonDecode()
    local var1 = MediaAssetData.new()

    if self.image_id ~= nil then
        var1.image_id = self.image_id
    end

    if self.imageId ~= nil then
        var1.image_id = self.imageId
    end

    if self.asset_type_id ~= nil then
        var1.asset_type_id = self.asset_type_id
    end

    if self.assetTypeId ~= nil then
        var1.asset_type_id = self.assetTypeId
    end

    if self.video_hash ~= nil then
        var1.video_hash = self.video_hash
    end

    if self.videoHash ~= nil then
        var1.video_hash = self.videoHash
    end

    if self.video_id ~= nil then
        var1.video_id = self.video_id
    end

    if self.videoId ~= nil then
        var1.video_id = self.videoId
    end

    if self.video_title ~= nil then
        var1.video_title = self.video_title
    end

    if self.videoTitle ~= nil then
        var1.video_title = self.videoTitle
    end

    return var1
end

MediaAssetData.descriptor = {
    name = "MediaAssetData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MediaAssetData"
}

tbl1.MediaAssetData = MediaAssetData

typeRegistry.default:register(tbl1.MediaAssetData)

return {
    MediaAssetData = tbl1.MediaAssetData
}

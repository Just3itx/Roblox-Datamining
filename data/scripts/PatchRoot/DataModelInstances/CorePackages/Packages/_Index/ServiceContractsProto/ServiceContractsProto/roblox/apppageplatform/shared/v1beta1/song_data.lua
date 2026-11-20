-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local SongData = {}
SongData.__index = SongData

function SongData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        media_asset_id = if tbl3 == nil or tbl3.media_asset_id == nil then "" else tbl3.media_asset_id,
        title = if tbl3 == nil or tbl3.title == nil then "" else tbl3.title,
        artist = if tbl3 == nil or tbl3.artist == nil then "" else tbl3.artist,
        album = if tbl3 == nil or tbl3.album == nil then "" else tbl3.album,
        album_art_asset_id = if tbl3 == nil or tbl3.album_art_asset_id == nil then 0 else tbl3.album_art_asset_id,
        is_private = not (tbl3 == nil or tbl3.is_private == nil) and tbl3.is_private,
        duration = if tbl3 == nil or tbl3.duration == nil then 0 else tbl3.duration
    }, SongData))
end

function SongData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.media_asset_id ~= nil and self.media_asset_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.media_asset_id)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.artist ~= nil and self.artist ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.artist)
    end

    if self.album ~= nil and self.album ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.album)
    end

    if self.album_art_asset_id ~= nil and self.album_art_asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.album_art_asset_id)
    end

    if self.is_private then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_private then 1 else 0)
    end

    if self.duration ~= nil and self.duration ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.i64)
        buffer2, num1 = proto.writeDouble(var1, var2, self.duration)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SongData.decode(buf1: buffer)
    local var1 = SongData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.album_art_asset_id = var4
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_private = var4 ~= 0
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
                var1.media_asset_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.artist = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.album = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 ~= proto.wireTypes.i64 then
            error("Unsupported wire type: " .. var3)
        elseif var2 == 8 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.duration = var4
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function SongData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.media_asset_id ~= nil and self.media_asset_id ~= "" then
        result.mediaAssetId = self.media_asset_id
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.artist ~= nil and self.artist ~= "" then
        result.artist = self.artist
    end

    if self.album ~= nil and self.album ~= "" then
        result.album = self.album
    end

    if self.album_art_asset_id ~= nil and self.album_art_asset_id ~= 0 then
        result.albumArtAssetId = self.album_art_asset_id
    end

    if self.is_private then
        result.isPrivate = self.is_private
    end

    if self.duration ~= nil and self.duration ~= 0 then
        result.duration = proto.json.serializeNumber(self.duration)
    end

    return result
end

function SongData:jsonDecode()
    local var1 = SongData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.media_asset_id ~= nil then
        var1.media_asset_id = self.media_asset_id
    end

    if self.mediaAssetId ~= nil then
        var1.media_asset_id = self.mediaAssetId
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.artist ~= nil then
        var1.artist = self.artist
    end

    if self.album ~= nil then
        var1.album = self.album
    end

    if self.album_art_asset_id ~= nil then
        var1.album_art_asset_id = self.album_art_asset_id
    end

    if self.albumArtAssetId ~= nil then
        var1.album_art_asset_id = self.albumArtAssetId
    end

    if self.is_private ~= nil then
        var1.is_private = self.is_private
    end

    if self.isPrivate ~= nil then
        var1.is_private = self.isPrivate
    end

    if self.duration ~= nil then
        var1.duration = proto.json.deserializeNumber(self.duration)
    end

    return var1
end

SongData.descriptor = {
    name = "SongData",
    fullName = "roblox.apppageplatform.shared.v1beta1.SongData"
}

tbl1.SongData = SongData

typeRegistry.default:register(tbl1.SongData)

return {
    SongData = tbl1.SongData
}

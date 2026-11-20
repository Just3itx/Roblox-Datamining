-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local CreatorData = {}
CreatorData.__index = CreatorData

function CreatorData.new(tbl3)
    return (setmetatable({
        creator_type = if tbl3 == nil or tbl3.creator_type == nil then "" else tbl3.creator_type,
        creator_id = if tbl3 == nil or tbl3.creator_id == nil then 0 else tbl3.creator_id,
        creator_name = if tbl3 == nil or tbl3.creator_name == nil then "" else tbl3.creator_name,
        is_verified = not (tbl3 == nil or tbl3.is_verified == nil) and tbl3.is_verified
    }, CreatorData))
end

function CreatorData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.creator_type ~= nil and self.creator_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_type)
    end

    if self.creator_id ~= nil and self.creator_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.creator_id)
    end

    if self.creator_name ~= nil and self.creator_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_name)
    end

    if self.is_verified then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_verified then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CreatorData.decode(buf1: buffer)
    local var1 = CreatorData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.creator_id = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_verified = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_type = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_name = buffer.tostring(buf)
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

function CreatorData:jsonEncode()
    local result = {}

    if self.creator_type ~= nil and self.creator_type ~= "" then
        result.creatorType = self.creator_type
    end

    if self.creator_id ~= nil and self.creator_id ~= 0 then
        result.creatorId = self.creator_id
    end

    if self.creator_name ~= nil and self.creator_name ~= "" then
        result.creatorName = self.creator_name
    end

    if self.is_verified then
        result.isVerified = self.is_verified
    end

    return result
end

function CreatorData:jsonDecode()
    local var1 = CreatorData.new()

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

    if self.creator_name ~= nil then
        var1.creator_name = self.creator_name
    end

    if self.creatorName ~= nil then
        var1.creator_name = self.creatorName
    end

    if self.is_verified ~= nil then
        var1.is_verified = self.is_verified
    end

    if self.isVerified ~= nil then
        var1.is_verified = self.isVerified
    end

    return var1
end

CreatorData.descriptor = {
    name = "CreatorData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CreatorData"
}

tbl1.CreatorData = CreatorData

typeRegistry.default:register(tbl1.CreatorData)

return {
    CreatorData = tbl1.CreatorData
}

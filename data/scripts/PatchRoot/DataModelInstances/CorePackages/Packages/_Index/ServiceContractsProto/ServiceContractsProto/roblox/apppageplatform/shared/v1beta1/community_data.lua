-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local CommunityData = {}
CommunityData.__index = CommunityData

function CommunityData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        member_count = if tbl3 == nil or tbl3.member_count == nil then 0 else tbl3.member_count,
        description = if tbl3 == nil or tbl3.description == nil then "" else tbl3.description,
        is_verified = not (tbl3 == nil or tbl3.is_verified == nil) and tbl3.is_verified
    }, CommunityData))
end

function CommunityData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.member_count ~= nil and self.member_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.member_count)
    end

    if self.description ~= nil and self.description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.is_verified then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_verified then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CommunityData.decode(buf1: buffer)
    local var1 = CommunityData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.member_count = var4
            elseif var2 == 5 then
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
                var1.id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
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

function CommunityData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.member_count ~= nil and self.member_count ~= 0 then
        result.memberCount = self.member_count
    end

    if self.description ~= nil and self.description ~= "" then
        result.description = self.description
    end

    if self.is_verified then
        result.isVerified = self.is_verified
    end

    return result
end

function CommunityData:jsonDecode()
    local var1 = CommunityData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.member_count ~= nil then
        var1.member_count = self.member_count
    end

    if self.memberCount ~= nil then
        var1.member_count = self.memberCount
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.is_verified ~= nil then
        var1.is_verified = self.is_verified
    end

    if self.isVerified ~= nil then
        var1.is_verified = self.isVerified
    end

    return var1
end

CommunityData.descriptor = {
    name = "CommunityData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CommunityData"
}

tbl1.CommunityData = CommunityData

typeRegistry.default:register(tbl1.CommunityData)

return {
    CommunityData = tbl1.CommunityData
}

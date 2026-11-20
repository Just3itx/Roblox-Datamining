-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UniverseUserFollowLimitData = {}
UniverseUserFollowLimitData.__index = UniverseUserFollowLimitData

function UniverseUserFollowLimitData.new(tbl3)
    return (setmetatable({
        following_count_by_type = if tbl3 == nil or tbl3.following_count_by_type == nil then 0 else tbl3.following_count_by_type,
        following_limit_by_type = if tbl3 == nil or tbl3.following_limit_by_type == nil then 0 else tbl3.following_limit_by_type
    }, UniverseUserFollowLimitData))
end

function UniverseUserFollowLimitData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.following_count_by_type ~= nil and self.following_count_by_type ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.following_count_by_type)
    end

    if self.following_limit_by_type ~= nil and self.following_limit_by_type ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.following_limit_by_type)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserFollowLimitData.decode(buf1: buffer)
    local var1 = UniverseUserFollowLimitData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.following_count_by_type = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.following_limit_by_type = var4
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

function UniverseUserFollowLimitData:jsonEncode()
    local result = {}

    if self.following_count_by_type ~= nil and self.following_count_by_type ~= 0 then
        result.followingCountByType = self.following_count_by_type
    end

    if self.following_limit_by_type ~= nil and self.following_limit_by_type ~= 0 then
        result.followingLimitByType = self.following_limit_by_type
    end

    return result
end

function UniverseUserFollowLimitData:jsonDecode()
    local var1 = UniverseUserFollowLimitData.new()

    if self.following_count_by_type ~= nil then
        var1.following_count_by_type = self.following_count_by_type
    end

    if self.followingCountByType ~= nil then
        var1.following_count_by_type = self.followingCountByType
    end

    if self.following_limit_by_type ~= nil then
        var1.following_limit_by_type = self.following_limit_by_type
    end

    if self.followingLimitByType ~= nil then
        var1.following_limit_by_type = self.followingLimitByType
    end

    return var1
end

UniverseUserFollowLimitData.descriptor = {
    name = "UniverseUserFollowLimitData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserFollowLimitData"
}

tbl1.UniverseUserFollowLimitData = UniverseUserFollowLimitData

typeRegistry.default:register(tbl1.UniverseUserFollowLimitData)

return {
    UniverseUserFollowLimitData = tbl1.UniverseUserFollowLimitData
}

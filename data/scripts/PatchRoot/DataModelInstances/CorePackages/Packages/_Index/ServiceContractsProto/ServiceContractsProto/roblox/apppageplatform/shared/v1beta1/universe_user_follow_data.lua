-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UniverseUserFollowData = {}
UniverseUserFollowData.__index = UniverseUserFollowData

function UniverseUserFollowData.new(tbl3)
    return (setmetatable({
        can_follow = not (tbl3 == nil or tbl3.can_follow == nil) and tbl3.can_follow,
        is_following = not (tbl3 == nil or tbl3.is_following == nil) and tbl3.is_following
    }, UniverseUserFollowData))
end

function UniverseUserFollowData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.can_follow then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_follow then 1 else 0)
    end

    if self.is_following then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_following then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserFollowData.decode(buf1: buffer)
    local var1 = UniverseUserFollowData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_follow = var4 ~= 0
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_following = var4 ~= 0
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

function UniverseUserFollowData:jsonEncode()
    local result = {}

    if self.can_follow then
        result.canFollow = self.can_follow
    end

    if self.is_following then
        result.isFollowing = self.is_following
    end

    return result
end

function UniverseUserFollowData:jsonDecode()
    local var1 = UniverseUserFollowData.new()

    if self.can_follow ~= nil then
        var1.can_follow = self.can_follow
    end

    if self.canFollow ~= nil then
        var1.can_follow = self.canFollow
    end

    if self.is_following ~= nil then
        var1.is_following = self.is_following
    end

    if self.isFollowing ~= nil then
        var1.is_following = self.isFollowing
    end

    return var1
end

UniverseUserFollowData.descriptor = {
    name = "UniverseUserFollowData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserFollowData"
}

tbl1.UniverseUserFollowData = UniverseUserFollowData

typeRegistry.default:register(tbl1.UniverseUserFollowData)

return {
    UniverseUserFollowData = tbl1.UniverseUserFollowData
}

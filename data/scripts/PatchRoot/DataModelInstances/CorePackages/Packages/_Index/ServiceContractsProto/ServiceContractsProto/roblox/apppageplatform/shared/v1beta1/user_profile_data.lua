-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UserProfileData = {}
UserProfileData.__index = UserProfileData

function UserProfileData.new(tbl3)
    return (setmetatable({
        user_id = if tbl3 == nil or tbl3.user_id == nil then nil else tbl3.user_id,
        username = if tbl3 == nil or tbl3.username == nil then nil else tbl3.username,
        display_name = if tbl3 == nil or tbl3.display_name == nil then nil else tbl3.display_name,
        is_verified = if tbl3 == nil or tbl3.is_verified == nil then nil else tbl3.is_verified,
        previous_usernames = (tbl3 == nil or tbl3.previous_usernames == nil) and {} or tbl3.previous_usernames
    }, UserProfileData))
end

function UserProfileData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.user_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.user_id)
    end

    if self.username ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.username)
    end

    if self.display_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.is_verified ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_verified then 1 else 0)
    end

    if self.previous_usernames ~= nil and #self.previous_usernames > 0 then
        for _, value in self.previous_usernames do
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UserProfileData.decode(buf1: buffer)
    local var1 = UserProfileData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.user_id = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_verified = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.username = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.previous_usernames, buffer.tostring(var4))
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

function UserProfileData:jsonEncode()
    local result = {}

    if self.user_id ~= nil then
        result.userId = self.user_id
    end

    if self.username ~= nil then
        result.username = self.username
    end

    if self.display_name ~= nil then
        result.displayName = self.display_name
    end

    if self.is_verified ~= nil then
        result.isVerified = self.is_verified
    end

    if self.previous_usernames ~= nil and #self.previous_usernames > 0 then
        local previousUsernames = {}
        for _, value in self.previous_usernames do
            table.insert(previousUsernames, value)
        end
        result.previousUsernames = previousUsernames
    end

    return result
end

function UserProfileData:jsonDecode()
    local var1 = UserProfileData.new()

    if self.user_id ~= nil then
        var1.user_id = self.user_id
    end

    if self.userId ~= nil then
        var1.user_id = self.userId
    end

    if self.username ~= nil then
        var1.username = self.username
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.is_verified ~= nil then
        var1.is_verified = self.is_verified
    end

    if self.isVerified ~= nil then
        var1.is_verified = self.isVerified
    end

    if self.previous_usernames ~= nil then
        local previousUsernames = {}
        for _, value in self.previous_usernames do
            table.insert(previousUsernames, value)
        end

        var1.previous_usernames = previousUsernames
    end

    if self.previousUsernames ~= nil then
        local previousUsernames = {}
        for _, value in self.previousUsernames do
            table.insert(previousUsernames, value)
        end

        var1.previous_usernames = previousUsernames
    end

    return var1
end

UserProfileData.descriptor = {
    name = "UserProfileData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UserProfileData"
}

tbl1.UserProfileData = UserProfileData

typeRegistry.default:register(tbl1.UserProfileData)

return {
    UserProfileData = tbl1.UserProfileData
}

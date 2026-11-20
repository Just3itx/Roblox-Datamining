-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local SocialLinkData = {}
SocialLinkData.__index = SocialLinkData

function SocialLinkData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then 0 else tbl3.id,
        title = if tbl3 == nil or tbl3.title == nil then "" else tbl3.title,
        url = if tbl3 == nil or tbl3.url == nil then "" else tbl3.url,
        type = if tbl3 == nil or tbl3.type == nil then "" else tbl3.type,
        community_id = if tbl3 == nil or tbl3.community_id == nil then 0 else tbl3.community_id
    }, SocialLinkData))
end

function SocialLinkData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.id)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.url ~= nil and self.url ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.url)
    end

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.community_id ~= nil and self.community_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.community_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SocialLinkData.decode(buf1: buffer)
    local var1 = SocialLinkData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.id = var4
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.community_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.url = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.type = buffer.tostring(buf)
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

function SocialLinkData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= 0 then
        result.id = self.id
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.url ~= nil and self.url ~= "" then
        result.url = self.url
    end

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    if self.community_id ~= nil and self.community_id ~= 0 then
        result.communityId = self.community_id
    end

    return result
end

function SocialLinkData:jsonDecode()
    local var1 = SocialLinkData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.url ~= nil then
        var1.url = self.url
    end

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.community_id ~= nil then
        var1.community_id = self.community_id
    end

    if self.communityId ~= nil then
        var1.community_id = self.communityId
    end

    return var1
end

SocialLinkData.descriptor = {
    name = "SocialLinkData",
    fullName = "roblox.apppageplatform.shared.v1beta1.SocialLinkData"
}

tbl1.SocialLinkData = SocialLinkData

typeRegistry.default:register(tbl1.SocialLinkData)

return {
    SocialLinkData = tbl1.SocialLinkData
}

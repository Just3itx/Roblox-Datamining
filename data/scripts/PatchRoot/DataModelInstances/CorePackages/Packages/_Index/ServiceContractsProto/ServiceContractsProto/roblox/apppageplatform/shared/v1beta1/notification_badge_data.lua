-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local NotificationBadgeData = {}
NotificationBadgeData.__index = NotificationBadgeData

function NotificationBadgeData.new(tbl3)
    return (setmetatable({
        count = if tbl3 == nil or tbl3.count == nil then 0 else tbl3.count,
        is_visible = not (tbl3 == nil or tbl3.is_visible == nil) and tbl3.is_visible
    }, NotificationBadgeData))
end

function NotificationBadgeData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.count ~= nil and self.count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.count)
    end

    if self.is_visible then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_visible then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function NotificationBadgeData.decode(buf1: buffer)
    local var1 = NotificationBadgeData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.count = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_visible = var4 ~= 0
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

function NotificationBadgeData:jsonEncode()
    local result = {}

    if self.count ~= nil and self.count ~= 0 then
        result.count = self.count
    end

    if self.is_visible then
        result.isVisible = self.is_visible
    end

    return result
end

function NotificationBadgeData:jsonDecode()
    local var1 = NotificationBadgeData.new()

    if self.count ~= nil then
        var1.count = self.count
    end

    if self.is_visible ~= nil then
        var1.is_visible = self.is_visible
    end

    if self.isVisible ~= nil then
        var1.is_visible = self.isVisible
    end

    return var1
end

NotificationBadgeData.descriptor = {
    name = "NotificationBadgeData",
    fullName = "roblox.apppageplatform.shared.v1beta1.NotificationBadgeData"
}

tbl1.NotificationBadgeData = NotificationBadgeData

typeRegistry.default:register(tbl1.NotificationBadgeData)

return {
    NotificationBadgeData = tbl1.NotificationBadgeData
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MarketplaceLookData = {}
MarketplaceLookData.__index = MarketplaceLookData

function MarketplaceLookData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        creator_name = if tbl3 == nil or tbl3.creator_name == nil then nil else tbl3.creator_name,
        creator_has_verified_badge = if tbl3 == nil or tbl3.creator_has_verified_badge == nil then nil else tbl3.creator_has_verified_badge,
        price = if tbl3 == nil or tbl3.price == nil then nil else tbl3.price
    }, MarketplaceLookData))
end

function MarketplaceLookData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.creator_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_name)
    end

    if self.creator_has_verified_badge ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.creator_has_verified_badge then 1 else 0)
    end

    if self.price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceLookData.decode(buf1: buffer)
    local var1 = MarketplaceLookData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.creator_has_verified_badge = var4 ~= 0
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price = var4
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

function MarketplaceLookData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.creator_name ~= nil then
        result.creatorName = self.creator_name
    end

    if self.creator_has_verified_badge ~= nil then
        result.creatorHasVerifiedBadge = self.creator_has_verified_badge
    end

    if self.price ~= nil then
        result.price = self.price
    end

    return result
end

function MarketplaceLookData:jsonDecode()
    local var1 = MarketplaceLookData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.creator_name ~= nil then
        var1.creator_name = self.creator_name
    end

    if self.creatorName ~= nil then
        var1.creator_name = self.creatorName
    end

    if self.creator_has_verified_badge ~= nil then
        var1.creator_has_verified_badge = self.creator_has_verified_badge
    end

    if self.creatorHasVerifiedBadge ~= nil then
        var1.creator_has_verified_badge = self.creatorHasVerifiedBadge
    end

    if self.price ~= nil then
        var1.price = self.price
    end

    return var1
end

MarketplaceLookData.descriptor = {
    name = "MarketplaceLookData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceLookData"
}

tbl1.MarketplaceLookData = MarketplaceLookData

typeRegistry.default:register(tbl1.MarketplaceLookData)

return {
    MarketplaceLookData = tbl1.MarketplaceLookData
}

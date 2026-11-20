-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MarketplaceItemUserFavoriteData = {}
MarketplaceItemUserFavoriteData.__index = MarketplaceItemUserFavoriteData

function MarketplaceItemUserFavoriteData.new(tbl3)
    return (setmetatable(
        {
            is_favorited = not (tbl3 == nil or tbl3.is_favorited == nil) and tbl3.is_favorited
        },
        MarketplaceItemUserFavoriteData
    ))
end

function MarketplaceItemUserFavoriteData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.is_favorited then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_favorited then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceItemUserFavoriteData.decode(buf1: buffer)
    local var1 = MarketplaceItemUserFavoriteData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_favorited = var4 ~= 0
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

function MarketplaceItemUserFavoriteData:jsonEncode()
    local result = {}

    if self.is_favorited then
        result.isFavorited = self.is_favorited
    end

    return result
end

function MarketplaceItemUserFavoriteData:jsonDecode()
    local var1 = MarketplaceItemUserFavoriteData.new()

    if self.is_favorited ~= nil then
        var1.is_favorited = self.is_favorited
    end

    if self.isFavorited ~= nil then
        var1.is_favorited = self.isFavorited
    end

    return var1
end

MarketplaceItemUserFavoriteData.descriptor = {
    name = "MarketplaceItemUserFavoriteData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceItemUserFavoriteData"
}

tbl1.MarketplaceItemUserFavoriteData = MarketplaceItemUserFavoriteData

typeRegistry.default:register(tbl1.MarketplaceItemUserFavoriteData)

return {
    MarketplaceItemUserFavoriteData = tbl1.MarketplaceItemUserFavoriteData
}

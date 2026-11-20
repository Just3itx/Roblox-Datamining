-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local GameSubscriptionData = {}
GameSubscriptionData.__index = GameSubscriptionData

function GameSubscriptionData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        description = if tbl3 == nil or tbl3.description == nil then "" else tbl3.description,
        image_asset_id = if tbl3 == nil or tbl3.image_asset_id == nil then 0 else tbl3.image_asset_id,
        price_display = if tbl3 == nil or tbl3.price_display == nil then "" else tbl3.price_display,
        period_type = if tbl3 == nil or tbl3.period_type == nil then "" else tbl3.period_type,
        is_subscribed = not (tbl3 == nil or tbl3.is_subscribed == nil) and tbl3.is_subscribed,
        price_in_robux = if tbl3 == nil or tbl3.price_in_robux == nil then 0 else tbl3.price_in_robux,
        price_tier = if tbl3 == nil or tbl3.price_tier == nil then 0 else tbl3.price_tier
    }, GameSubscriptionData))
end

function GameSubscriptionData:encode(): buffer
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

    if self.description ~= nil and self.description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.image_asset_id ~= nil and self.image_asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.image_asset_id)
    end

    if self.price_display ~= nil and self.price_display ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.price_display)
    end

    if self.period_type ~= nil and self.period_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.period_type)
    end

    if self.is_subscribed then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_subscribed then 1 else 0)
    end

    if self.price_in_robux ~= nil and self.price_in_robux ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price_in_robux)
    end

    if self.price_tier ~= nil and self.price_tier ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price_tier)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GameSubscriptionData.decode(buf1: buffer)
    local var1 = GameSubscriptionData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.image_asset_id = var4
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_subscribed = var4 ~= 0
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price_in_robux = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price_tier = var4
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
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.price_display = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.period_type = buffer.tostring(buf)
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

function GameSubscriptionData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.description ~= nil and self.description ~= "" then
        result.description = self.description
    end

    if self.image_asset_id ~= nil and self.image_asset_id ~= 0 then
        result.imageAssetId = self.image_asset_id
    end

    if self.price_display ~= nil and self.price_display ~= "" then
        result.priceDisplay = self.price_display
    end

    if self.period_type ~= nil and self.period_type ~= "" then
        result.periodType = self.period_type
    end

    if self.is_subscribed then
        result.isSubscribed = self.is_subscribed
    end

    if self.price_in_robux ~= nil and self.price_in_robux ~= 0 then
        result.priceInRobux = self.price_in_robux
    end

    if self.price_tier ~= nil and self.price_tier ~= 0 then
        result.priceTier = self.price_tier
    end

    return result
end

function GameSubscriptionData:jsonDecode()
    local var1 = GameSubscriptionData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.image_asset_id ~= nil then
        var1.image_asset_id = self.image_asset_id
    end

    if self.imageAssetId ~= nil then
        var1.image_asset_id = self.imageAssetId
    end

    if self.price_display ~= nil then
        var1.price_display = self.price_display
    end

    if self.priceDisplay ~= nil then
        var1.price_display = self.priceDisplay
    end

    if self.period_type ~= nil then
        var1.period_type = self.period_type
    end

    if self.periodType ~= nil then
        var1.period_type = self.periodType
    end

    if self.is_subscribed ~= nil then
        var1.is_subscribed = self.is_subscribed
    end

    if self.isSubscribed ~= nil then
        var1.is_subscribed = self.isSubscribed
    end

    if self.price_in_robux ~= nil then
        var1.price_in_robux = self.price_in_robux
    end

    if self.priceInRobux ~= nil then
        var1.price_in_robux = self.priceInRobux
    end

    if self.price_tier ~= nil then
        var1.price_tier = self.price_tier
    end

    if self.priceTier ~= nil then
        var1.price_tier = self.priceTier
    end

    return var1
end

GameSubscriptionData.descriptor = {
    name = "GameSubscriptionData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GameSubscriptionData"
}

tbl1.GameSubscriptionData = GameSubscriptionData

typeRegistry.default:register(tbl1.GameSubscriptionData)

return {
    GameSubscriptionData = tbl1.GameSubscriptionData
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local GameDeveloperProductData = {}
GameDeveloperProductData.__index = GameDeveloperProductData

function GameDeveloperProductData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        description = if tbl3 == nil or tbl3.description == nil then "" else tbl3.description,
        image_asset_id = if tbl3 == nil or tbl3.image_asset_id == nil then 0 else tbl3.image_asset_id,
        price_in_robux = if tbl3 == nil or tbl3.price_in_robux == nil then 0 else tbl3.price_in_robux,
        pending_receipt_count = if tbl3 == nil or tbl3.pending_receipt_count == nil then 0 else tbl3.pending_receipt_count,
        status_tooltip = if tbl3 == nil or tbl3.status_tooltip == nil then "" else tbl3.status_tooltip,
        base_price_in_robux = if tbl3 == nil or tbl3.base_price_in_robux == nil then 0 else tbl3.base_price_in_robux,
        is_discounted = not (tbl3 == nil or tbl3.is_discounted == nil) and tbl3.is_discounted,
        is_purchasable = not (tbl3 == nil or tbl3.is_purchasable == nil) and tbl3.is_purchasable
    }, GameDeveloperProductData))
end

function GameDeveloperProductData:encode(): buffer
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

    if self.price_in_robux ~= nil and self.price_in_robux ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price_in_robux)
    end

    if self.pending_receipt_count ~= nil and self.pending_receipt_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.pending_receipt_count)
    end

    if self.status_tooltip ~= nil and self.status_tooltip ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.status_tooltip)
    end

    if self.base_price_in_robux ~= nil and self.base_price_in_robux ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.base_price_in_robux)
    end

    if self.is_discounted then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_discounted then 1 else 0)
    end

    if self.is_purchasable then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_purchasable then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GameDeveloperProductData.decode(buf1: buffer)
    local var1 = GameDeveloperProductData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.image_asset_id = var4
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price_in_robux = var4
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.pending_receipt_count = var4
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.base_price_in_robux = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_discounted = var4 ~= 0
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_purchasable = var4 ~= 0
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
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.status_tooltip = buffer.tostring(buf)
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

function GameDeveloperProductData:jsonEncode()
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

    if self.price_in_robux ~= nil and self.price_in_robux ~= 0 then
        result.priceInRobux = self.price_in_robux
    end

    if self.pending_receipt_count ~= nil and self.pending_receipt_count ~= 0 then
        result.pendingReceiptCount = self.pending_receipt_count
    end

    if self.status_tooltip ~= nil and self.status_tooltip ~= "" then
        result.statusTooltip = self.status_tooltip
    end

    if self.base_price_in_robux ~= nil and self.base_price_in_robux ~= 0 then
        result.basePriceInRobux = self.base_price_in_robux
    end

    if self.is_discounted then
        result.isDiscounted = self.is_discounted
    end

    if self.is_purchasable then
        result.isPurchasable = self.is_purchasable
    end

    return result
end

function GameDeveloperProductData:jsonDecode()
    local var1 = GameDeveloperProductData.new()

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

    if self.price_in_robux ~= nil then
        var1.price_in_robux = self.price_in_robux
    end

    if self.priceInRobux ~= nil then
        var1.price_in_robux = self.priceInRobux
    end

    if self.pending_receipt_count ~= nil then
        var1.pending_receipt_count = self.pending_receipt_count
    end

    if self.pendingReceiptCount ~= nil then
        var1.pending_receipt_count = self.pendingReceiptCount
    end

    if self.status_tooltip ~= nil then
        var1.status_tooltip = self.status_tooltip
    end

    if self.statusTooltip ~= nil then
        var1.status_tooltip = self.statusTooltip
    end

    if self.base_price_in_robux ~= nil then
        var1.base_price_in_robux = self.base_price_in_robux
    end

    if self.basePriceInRobux ~= nil then
        var1.base_price_in_robux = self.basePriceInRobux
    end

    if self.is_discounted ~= nil then
        var1.is_discounted = self.is_discounted
    end

    if self.isDiscounted ~= nil then
        var1.is_discounted = self.isDiscounted
    end

    if self.is_purchasable ~= nil then
        var1.is_purchasable = self.is_purchasable
    end

    if self.isPurchasable ~= nil then
        var1.is_purchasable = self.isPurchasable
    end

    return var1
end

GameDeveloperProductData.descriptor = {
    name = "GameDeveloperProductData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GameDeveloperProductData"
}

tbl1.GameDeveloperProductData = GameDeveloperProductData

typeRegistry.default:register(tbl1.GameDeveloperProductData)

return {
    GameDeveloperProductData = tbl1.GameDeveloperProductData
}

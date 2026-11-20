-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local CollectibleItemCreator = {}
CollectibleItemCreator.__index = CollectibleItemCreator

function CollectibleItemCreator.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then nil else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then nil else tbl3.name,
        type = if tbl3 == nil or tbl3.type == nil then nil else tbl3.type,
        target_id = if tbl3 == nil or tbl3.target_id == nil then nil else tbl3.target_id,
        has_verified_badge = if tbl3 == nil or tbl3.has_verified_badge == nil then nil else tbl3.has_verified_badge
    }, CollectibleItemCreator))
end

function CollectibleItemCreator:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.target_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.target_id)
    end

    if self.has_verified_badge ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.has_verified_badge then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CollectibleItemCreator.decode(buf1: buffer)
    local var1 = CollectibleItemCreator.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 5 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.has_verified_badge = var4 ~= 0
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
                var1.type = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.target_id = buffer.tostring(buf)
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

function CollectibleItemCreator:jsonEncode()
    local result = {}

    if self.id ~= nil then
        result.id = self.id
    end

    if self.name ~= nil then
        result.name = self.name
    end

    if self.type ~= nil then
        result.type = self.type
    end

    if self.target_id ~= nil then
        result.targetId = self.target_id
    end

    if self.has_verified_badge ~= nil then
        result.hasVerifiedBadge = self.has_verified_badge
    end

    return result
end

function CollectibleItemCreator:jsonDecode()
    local var1 = CollectibleItemCreator.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.target_id ~= nil then
        var1.target_id = self.target_id
    end

    if self.targetId ~= nil then
        var1.target_id = self.targetId
    end

    if self.has_verified_badge ~= nil then
        var1.has_verified_badge = self.has_verified_badge
    end

    if self.hasVerifiedBadge ~= nil then
        var1.has_verified_badge = self.hasVerifiedBadge
    end

    return var1
end

CollectibleItemCreator.descriptor = {
    name = "CollectibleItemCreator",
    fullName = "roblox.apppageplatform.shared.v1beta1.CollectibleItemCreator"
}

tbl1.CollectibleItemCreator = CollectibleItemCreator

typeRegistry.default:register(tbl1.CollectibleItemCreator)

local CollectibleItemExperience = {}
CollectibleItemExperience.__index = CollectibleItemExperience

function CollectibleItemExperience.new(tbl4)
    return (setmetatable({
        id = if tbl4 == nil or tbl4.id == nil then "" else tbl4.id,
        name = if tbl4 == nil or tbl4.name == nil then nil else tbl4.name,
        detail_page_link = if tbl4 == nil or tbl4.detail_page_link == nil then nil else tbl4.detail_page_link
    }, CollectibleItemExperience))
end

function CollectibleItemExperience:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.detail_page_link ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.detail_page_link)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CollectibleItemExperience.decode(buf1: buffer)
    local var1 = CollectibleItemExperience.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
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
                var1.detail_page_link = buffer.tostring(buf)
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

function CollectibleItemExperience:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.name ~= nil then
        result.name = self.name
    end

    if self.detail_page_link ~= nil then
        result.detailPageLink = self.detail_page_link
    end

    return result
end

function CollectibleItemExperience:jsonDecode()
    local var1 = CollectibleItemExperience.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.detail_page_link ~= nil then
        var1.detail_page_link = self.detail_page_link
    end

    if self.detailPageLink ~= nil then
        var1.detail_page_link = self.detailPageLink
    end

    return var1
end

CollectibleItemExperience.descriptor = {
    name = "CollectibleItemExperience",
    fullName = "roblox.apppageplatform.shared.v1beta1.CollectibleItemExperience"
}

tbl1.CollectibleItemExperience = CollectibleItemExperience

typeRegistry.default:register(tbl1.CollectibleItemExperience)

local CollectibleItemData = {}
CollectibleItemData.__index = CollectibleItemData

function CollectibleItemData.new(tbl5)
    return (setmetatable({
        id = if tbl5 == nil or tbl5.id == nil then "" else tbl5.id,
        collectible_product_id = if tbl5 == nil or tbl5.collectible_product_id == nil then nil else tbl5.collectible_product_id,
        name = if tbl5 == nil or tbl5.name == nil then nil else tbl5.name,
        description = if tbl5 == nil or tbl5.description == nil then nil else tbl5.description,
        creator = if tbl5 == nil or tbl5.creator == nil then nil else tbl5.creator,
        price = if tbl5 == nil or tbl5.price == nil then nil else tbl5.price,
        lowest_price = if tbl5 == nil or tbl5.lowest_price == nil then nil else tbl5.lowest_price,
        units_available_for_consumption = if tbl5 == nil or tbl5.units_available_for_consumption == nil then nil else tbl5.units_available_for_consumption,
        offsale_deadline = if tbl5 == nil or tbl5.offsale_deadline == nil then nil else tbl5.offsale_deadline,
        asset_stock = if tbl5 == nil or tbl5.asset_stock == nil then nil else tbl5.asset_stock,
        has_resellers = if tbl5 == nil or tbl5.has_resellers == nil then nil else tbl5.has_resellers,
        universe_ids = (tbl5 == nil or tbl5.universe_ids == nil) and {} or tbl5.universe_ids,
        sale_location_type = if tbl5 == nil or tbl5.sale_location_type == nil then nil else tbl5.sale_location_type,
        quantity_limit_per_user = if tbl5 == nil or tbl5.quantity_limit_per_user == nil then nil else tbl5.quantity_limit_per_user,
        resale_restriction = if tbl5 == nil or tbl5.resale_restriction == nil then nil else tbl5.resale_restriction,
        lowest_available_resale_product_id = if tbl5 == nil or tbl5.lowest_available_resale_product_id == nil then nil else tbl5.lowest_available_resale_product_id,
        lowest_available_resale_item_instance_id = if tbl5 == nil or tbl5.lowest_available_resale_item_instance_id == nil then nil else tbl5.lowest_available_resale_item_instance_id,
        experiences = (tbl5 == nil or tbl5.experiences == nil) and {} or tbl5.experiences
    }, CollectibleItemData))
end

function CollectibleItemData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.collectible_product_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.collectible_product_id)
    end

    if self.name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.description ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.creator ~= nil then
        local buf = self.creator:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price)
    end

    if self.lowest_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.lowest_price)
    end

    if self.units_available_for_consumption ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.units_available_for_consumption)
    end

    if self.offsale_deadline ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.offsale_deadline)
    end

    if self.asset_stock ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.asset_stock)
    end

    if self.has_resellers ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.has_resellers then 1 else 0)
    end

    if self.universe_ids ~= nil and #self.universe_ids > 0 then
        for _, universeId in self.universe_ids do
            local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, universeId)
        end
    end

    if self.sale_location_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.sale_location_type)
    end

    if self.quantity_limit_per_user ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.quantity_limit_per_user)
    end

    if self.resale_restriction ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.resale_restriction)
    end

    if self.lowest_available_resale_product_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.lowest_available_resale_product_id)
    end

    if self.lowest_available_resale_item_instance_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.lowest_available_resale_item_instance_id)
    end

    if self.experiences ~= nil and #self.experiences > 0 then
        for _, value in self.experiences do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 18, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CollectibleItemData.decode(buf1: buffer)
    local var1 = CollectibleItemData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price = var4
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.lowest_price = var4
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.units_available_for_consumption = var4
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.asset_stock = var4
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.has_resellers = var4 ~= 0
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.quantity_limit_per_user = var4
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.resale_restriction = var4
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
                var1.collectible_product_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.creator = tbl1.CollectibleItemCreator.decode(var4)
            elseif var2 == 9 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.offsale_deadline = buffer.tostring(buf)
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.universe_ids, buffer.tostring(var4))
            elseif var2 == 13 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.sale_location_type = buffer.tostring(buf)
            elseif var2 == 16 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.lowest_available_resale_product_id = buffer.tostring(buf)
            elseif var2 == 17 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.lowest_available_resale_item_instance_id = buffer.tostring(buf)
            elseif var2 == 18 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.experiences, tbl1.CollectibleItemExperience.decode(var4))
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

function CollectibleItemData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.collectible_product_id ~= nil then
        result.collectibleProductId = self.collectible_product_id
    end

    if self.name ~= nil then
        result.name = self.name
    end

    if self.description ~= nil then
        result.description = self.description
    end

    if self.creator ~= nil then
        result.creator = self.creator:jsonEncode()
    end

    if self.price ~= nil then
        result.price = self.price
    end

    if self.lowest_price ~= nil then
        result.lowestPrice = self.lowest_price
    end

    if self.units_available_for_consumption ~= nil then
        result.unitsAvailableForConsumption = self.units_available_for_consumption
    end

    if self.offsale_deadline ~= nil then
        result.offsaleDeadline = self.offsale_deadline
    end

    if self.asset_stock ~= nil then
        result.assetStock = self.asset_stock
    end

    if self.has_resellers ~= nil then
        result.hasResellers = self.has_resellers
    end

    if self.universe_ids ~= nil and #self.universe_ids > 0 then
        local universeIds = {}
        for _, universeId in self.universe_ids do
            table.insert(universeIds, universeId)
        end
        result.universeIds = universeIds
    end

    if self.sale_location_type ~= nil then
        result.saleLocationType = self.sale_location_type
    end

    if self.quantity_limit_per_user ~= nil then
        result.quantityLimitPerUser = self.quantity_limit_per_user
    end

    if self.resale_restriction ~= nil then
        result.resaleRestriction = self.resale_restriction
    end

    if self.lowest_available_resale_product_id ~= nil then
        result.lowestAvailableResaleProductId = self.lowest_available_resale_product_id
    end

    if self.lowest_available_resale_item_instance_id ~= nil then
        result.lowestAvailableResaleItemInstanceId = self.lowest_available_resale_item_instance_id
    end

    if self.experiences ~= nil and #self.experiences > 0 then
        local experiences = {}
        for _, value in self.experiences do
            table.insert(experiences, value:jsonEncode())
        end
        result.experiences = experiences
    end

    return result
end

function CollectibleItemData:jsonDecode()
    local var1 = CollectibleItemData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.collectible_product_id ~= nil then
        var1.collectible_product_id = self.collectible_product_id
    end

    if self.collectibleProductId ~= nil then
        var1.collectible_product_id = self.collectibleProductId
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.creator ~= nil then
        var1.creator = tbl1.CollectibleItemCreator.jsonDecode(self.creator)
    end

    if self.price ~= nil then
        var1.price = self.price
    end

    if self.lowest_price ~= nil then
        var1.lowest_price = self.lowest_price
    end

    if self.lowestPrice ~= nil then
        var1.lowest_price = self.lowestPrice
    end

    if self.units_available_for_consumption ~= nil then
        var1.units_available_for_consumption = self.units_available_for_consumption
    end

    if self.unitsAvailableForConsumption ~= nil then
        var1.units_available_for_consumption = self.unitsAvailableForConsumption
    end

    if self.offsale_deadline ~= nil then
        var1.offsale_deadline = self.offsale_deadline
    end

    if self.offsaleDeadline ~= nil then
        var1.offsale_deadline = self.offsaleDeadline
    end

    if self.asset_stock ~= nil then
        var1.asset_stock = self.asset_stock
    end

    if self.assetStock ~= nil then
        var1.asset_stock = self.assetStock
    end

    if self.has_resellers ~= nil then
        var1.has_resellers = self.has_resellers
    end

    if self.hasResellers ~= nil then
        var1.has_resellers = self.hasResellers
    end

    if self.universe_ids ~= nil then
        local universeIds = {}
        for _, universeId in self.universe_ids do
            table.insert(universeIds, universeId)
        end

        var1.universe_ids = universeIds
    end

    if self.universeIds ~= nil then
        local universeIds = {}
        for _, universeId in self.universeIds do
            table.insert(universeIds, universeId)
        end

        var1.universe_ids = universeIds
    end

    if self.sale_location_type ~= nil then
        var1.sale_location_type = self.sale_location_type
    end

    if self.saleLocationType ~= nil then
        var1.sale_location_type = self.saleLocationType
    end

    if self.quantity_limit_per_user ~= nil then
        var1.quantity_limit_per_user = self.quantity_limit_per_user
    end

    if self.quantityLimitPerUser ~= nil then
        var1.quantity_limit_per_user = self.quantityLimitPerUser
    end

    if self.resale_restriction ~= nil then
        var1.resale_restriction = self.resale_restriction
    end

    if self.resaleRestriction ~= nil then
        var1.resale_restriction = self.resaleRestriction
    end

    if self.lowest_available_resale_product_id ~= nil then
        var1.lowest_available_resale_product_id = self.lowest_available_resale_product_id
    end

    if self.lowestAvailableResaleProductId ~= nil then
        var1.lowest_available_resale_product_id = self.lowestAvailableResaleProductId
    end

    if self.lowest_available_resale_item_instance_id ~= nil then
        var1.lowest_available_resale_item_instance_id = self.lowest_available_resale_item_instance_id
    end

    if self.lowestAvailableResaleItemInstanceId ~= nil then
        var1.lowest_available_resale_item_instance_id = self.lowestAvailableResaleItemInstanceId
    end

    if self.experiences ~= nil then
        local experiences = {}
        for _, value in self.experiences do
            table.insert(experiences, tbl1.CollectibleItemExperience.jsonDecode(value))
        end

        var1.experiences = experiences
    end

    return var1
end

CollectibleItemData.descriptor = {
    name = "CollectibleItemData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CollectibleItemData"
}

tbl1.CollectibleItemData = CollectibleItemData

typeRegistry.default:register(tbl1.CollectibleItemData)

return {
    CollectibleItemCreator = tbl1.CollectibleItemCreator,
    CollectibleItemExperience = tbl1.CollectibleItemExperience,
    CollectibleItemData = tbl1.CollectibleItemData
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local marketplace_catalog_item_common = require(script.Parent.marketplace_catalog_item_common)

local MarketplaceBundleData = {}
MarketplaceBundleData.__index = MarketplaceBundleData

function MarketplaceBundleData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        creator_name = if tbl3 == nil or tbl3.creator_name == nil then "" else tbl3.creator_name,
        creator_has_verified_badge = not (tbl3 == nil or tbl3.creator_has_verified_badge == nil) and tbl3.creator_has_verified_badge,
        bundle_type = if tbl3 == nil or tbl3.bundle_type == nil then "" else tbl3.bundle_type,
        price = if tbl3 == nil or tbl3.price == nil then 0 else tbl3.price,
        description = if tbl3 == nil or tbl3.description == nil then nil else tbl3.description,
        creator_id = if tbl3 == nil or tbl3.creator_id == nil then nil else tbl3.creator_id,
        creator_type = if tbl3 == nil or tbl3.creator_type == nil then nil else tbl3.creator_type,
        creating_universe_id = if tbl3 == nil or tbl3.creating_universe_id == nil then nil else tbl3.creating_universe_id,
        taxonomy = (tbl3 == nil or tbl3.taxonomy == nil) and {} or tbl3.taxonomy,
        render_properties = (tbl3 == nil or tbl3.render_properties == nil) and {} or tbl3.render_properties,
        item_restrictions = (tbl3 == nil or tbl3.item_restrictions == nil) and {} or tbl3.item_restrictions,
        is_high_definition = if tbl3 == nil or tbl3.is_high_definition == nil then nil else tbl3.is_high_definition,
        is_pbr = if tbl3 == nil or tbl3.is_pbr == nil then nil else tbl3.is_pbr,
        has_resellers = if tbl3 == nil or tbl3.has_resellers == nil then nil else tbl3.has_resellers,
        lowest_price = if tbl3 == nil or tbl3.lowest_price == nil then nil else tbl3.lowest_price,
        lowest_resale_price = if tbl3 == nil or tbl3.lowest_resale_price == nil then nil else tbl3.lowest_resale_price,
        total_quantity = if tbl3 == nil or tbl3.total_quantity == nil then nil else tbl3.total_quantity,
        units_available_for_consumption = if tbl3 == nil or tbl3.units_available_for_consumption == nil then nil else tbl3.units_available_for_consumption,
        favorite_count = if tbl3 == nil or tbl3.favorite_count == nil then nil else tbl3.favorite_count,
        timed_options = (tbl3 == nil or tbl3.timed_options == nil) and {} or tbl3.timed_options,
        collectible_item_id = if tbl3 == nil or tbl3.collectible_item_id == nil then nil else tbl3.collectible_item_id,
        is_off_sale = if tbl3 == nil or tbl3.is_off_sale == nil then nil else tbl3.is_off_sale,
        sale_location_type = if tbl3 == nil or tbl3.sale_location_type == nil then nil else tbl3.sale_location_type,
        item_status = (tbl3 == nil or tbl3.item_status == nil) and {} or tbl3.item_status,
        price_status = if tbl3 == nil or tbl3.price_status == nil then nil else tbl3.price_status,
        product_id = if tbl3 == nil or tbl3.product_id == nil then nil else tbl3.product_id,
        owned = if tbl3 == nil or tbl3.owned == nil then nil else tbl3.owned,
        is_purchasable = if tbl3 == nil or tbl3.is_purchasable == nil then nil else tbl3.is_purchasable,
        variant_attributes = (tbl3 == nil or tbl3.variant_attributes == nil) and {} or tbl3.variant_attributes,
        genres = (tbl3 == nil or tbl3.genres == nil) and {} or tbl3.genres,
        bundled_items = (tbl3 == nil or tbl3.bundled_items == nil) and {} or tbl3.bundled_items,
        is_recolorable = if tbl3 == nil or tbl3.is_recolorable == nil then nil else tbl3.is_recolorable,
        licensing = if tbl3 == nil or tbl3.licensing == nil then nil else tbl3.licensing,
        original_price = if tbl3 == nil or tbl3.original_price == nil then nil else tbl3.original_price
    }, MarketplaceBundleData))
end

function MarketplaceBundleData:encode(): buffer
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

    if self.creator_name ~= nil and self.creator_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_name)
    end

    if self.creator_has_verified_badge then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.creator_has_verified_badge then 1 else 0)
    end

    if self.bundle_type ~= nil and self.bundle_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.bundle_type)
    end

    if self.price ~= nil and self.price ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price)
    end

    if self.description ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.creator_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_id)
    end

    if self.creator_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_type)
    end

    if self.creating_universe_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creating_universe_id)
    end

    if self.taxonomy ~= nil and #self.taxonomy > 0 then
        for _, value in self.taxonomy do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.render_properties ~= nil and #self.render_properties > 0 then
        for _, value in self.render_properties do
            local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.item_restrictions ~= nil and #self.item_restrictions > 0 then
        for _, itemRestriction in self.item_restrictions do
            local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, itemRestriction)
        end
    end

    if self.is_high_definition ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_high_definition then 1 else 0)
    end

    if self.is_pbr ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_pbr then 1 else 0)
    end

    if self.has_resellers ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.has_resellers then 1 else 0)
    end

    if self.lowest_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.lowest_price)
    end

    if self.lowest_resale_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 18, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.lowest_resale_price)
    end

    if self.total_quantity ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 19, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_quantity)
    end

    if self.units_available_for_consumption ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 20, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.units_available_for_consumption)
    end

    if self.favorite_count ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 21, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.favorite_count)
    end

    if self.timed_options ~= nil and #self.timed_options > 0 then
        for _, timedOption in self.timed_options do
            local buf = timedOption:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 22, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.collectible_item_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 23, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.collectible_item_id)
    end

    if self.is_off_sale ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 24, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_off_sale then 1 else 0)
    end

    if self.sale_location_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 25, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.sale_location_type)
    end

    if self.item_status ~= nil and #self.item_status > 0 then
        for _, value in self.item_status do
            local var1, var2 = proto.writeTag(buffer2, num1, 26, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.price_status ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 27, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.price_status)
    end

    if self.product_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 28, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.product_id)
    end

    if self.owned ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 29, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.owned then 1 else 0)
    end

    if self.is_purchasable ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 30, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_purchasable then 1 else 0)
    end

    if self.variant_attributes ~= nil and #self.variant_attributes > 0 then
        for _, value in self.variant_attributes do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 31, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.genres ~= nil and #self.genres > 0 then
        for _, value in self.genres do
            local var1, var2 = proto.writeTag(buffer2, num1, 32, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.bundled_items ~= nil and #self.bundled_items > 0 then
        for _, bundledItem in self.bundled_items do
            local buf = bundledItem:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 33, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.is_recolorable ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 34, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_recolorable then 1 else 0)
    end

    if self.licensing ~= nil then
        local buf = self.licensing:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 35, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.original_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 36, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.original_price)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceBundleData.decode(buf1: buffer)
    local var1 = MarketplaceBundleData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.creator_has_verified_badge = var4 ~= 0
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price = var4
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_high_definition = var4 ~= 0
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_pbr = var4 ~= 0
            elseif var2 == 16 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.has_resellers = var4 ~= 0
            elseif var2 == 17 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.lowest_price = var4
            elseif var2 == 18 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.lowest_resale_price = var4
            elseif var2 == 19 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_quantity = var4
            elseif var2 == 20 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.units_available_for_consumption = var4
            elseif var2 == 21 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.favorite_count = var4
            elseif var2 == 24 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_off_sale = var4 ~= 0
            elseif var2 == 29 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.owned = var4 ~= 0
            elseif var2 == 30 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_purchasable = var4 ~= 0
            elseif var2 == 34 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_recolorable = var4 ~= 0
            elseif var2 == 36 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.original_price = var4
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
                var1.creator_name = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.bundle_type = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_id = buffer.tostring(buf)
            elseif var2 == 9 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_type = buffer.tostring(buf)
            elseif var2 == 10 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creating_universe_id = buffer.tostring(buf)
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.taxonomy, marketplace_catalog_item_common.MarketplaceCatalogTaxonomyNode.decode(var4))
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.render_properties, buffer.tostring(var4))
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.item_restrictions, buffer.tostring(var4))
            elseif var2 == 22 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.timed_options, marketplace_catalog_item_common.MarketplaceCatalogTimedOption.decode(var4))
            elseif var2 == 23 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.collectible_item_id = buffer.tostring(buf)
            elseif var2 == 25 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.sale_location_type = buffer.tostring(buf)
            elseif var2 == 26 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.item_status, buffer.tostring(var4))
            elseif var2 == 27 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.price_status = buffer.tostring(buf)
            elseif var2 == 28 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.product_id = buffer.tostring(buf)
            elseif var2 == 31 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.variant_attributes, marketplace_catalog_item_common.MarketplaceCatalogVariantAttribute.decode(var4))
            elseif var2 == 32 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.genres, buffer.tostring(var4))
            elseif var2 == 33 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.bundled_items, marketplace_catalog_item_common.MarketplaceCatalogBundledItem.decode(var4))
            elseif var2 == 35 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.licensing = marketplace_catalog_item_common.MarketplaceCatalogItemLicensing.decode(var4)
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

function MarketplaceBundleData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.creator_name ~= nil and self.creator_name ~= "" then
        result.creatorName = self.creator_name
    end

    if self.creator_has_verified_badge then
        result.creatorHasVerifiedBadge = self.creator_has_verified_badge
    end

    if self.bundle_type ~= nil and self.bundle_type ~= "" then
        result.bundleType = self.bundle_type
    end

    if self.price ~= nil and self.price ~= 0 then
        result.price = self.price
    end

    if self.description ~= nil then
        result.description = self.description
    end

    if self.creator_id ~= nil then
        result.creatorId = self.creator_id
    end

    if self.creator_type ~= nil then
        result.creatorType = self.creator_type
    end

    if self.creating_universe_id ~= nil then
        result.creatingUniverseId = self.creating_universe_id
    end

    if self.taxonomy ~= nil and #self.taxonomy > 0 then
        local taxonomy = {}
        for _, value in self.taxonomy do
            table.insert(taxonomy, value:jsonEncode())
        end
        result.taxonomy = taxonomy
    end

    if self.render_properties ~= nil and #self.render_properties > 0 then
        local renderProperties = {}
        for _, value in self.render_properties do
            table.insert(renderProperties, value)
        end
        result.renderProperties = renderProperties
    end

    if self.item_restrictions ~= nil and #self.item_restrictions > 0 then
        local itemRestrictions = {}
        for _, itemRestriction in self.item_restrictions do
            table.insert(itemRestrictions, itemRestriction)
        end
        result.itemRestrictions = itemRestrictions
    end

    if self.is_high_definition ~= nil then
        result.isHighDefinition = self.is_high_definition
    end

    if self.is_pbr ~= nil then
        result.isPbr = self.is_pbr
    end

    if self.has_resellers ~= nil then
        result.hasResellers = self.has_resellers
    end

    if self.lowest_price ~= nil then
        result.lowestPrice = self.lowest_price
    end

    if self.lowest_resale_price ~= nil then
        result.lowestResalePrice = self.lowest_resale_price
    end

    if self.total_quantity ~= nil then
        result.totalQuantity = self.total_quantity
    end

    if self.units_available_for_consumption ~= nil then
        result.unitsAvailableForConsumption = self.units_available_for_consumption
    end

    if self.favorite_count ~= nil then
        result.favoriteCount = self.favorite_count
    end

    if self.timed_options ~= nil and #self.timed_options > 0 then
        local timedOptions = {}
        for _, timedOption in self.timed_options do
            table.insert(timedOptions, timedOption:jsonEncode())
        end
        result.timedOptions = timedOptions
    end

    if self.collectible_item_id ~= nil then
        result.collectibleItemId = self.collectible_item_id
    end

    if self.is_off_sale ~= nil then
        result.isOffSale = self.is_off_sale
    end

    if self.sale_location_type ~= nil then
        result.saleLocationType = self.sale_location_type
    end

    if self.item_status ~= nil and #self.item_status > 0 then
        local itemStatus = {}
        for _, value in self.item_status do
            table.insert(itemStatus, value)
        end
        result.itemStatus = itemStatus
    end

    if self.price_status ~= nil then
        result.priceStatus = self.price_status
    end

    if self.product_id ~= nil then
        result.productId = self.product_id
    end

    if self.owned ~= nil then
        result.owned = self.owned
    end

    if self.is_purchasable ~= nil then
        result.isPurchasable = self.is_purchasable
    end

    if self.variant_attributes ~= nil and #self.variant_attributes > 0 then
        local variantAttributes = {}
        for _, value in self.variant_attributes do
            table.insert(variantAttributes, value:jsonEncode())
        end
        result.variantAttributes = variantAttributes
    end

    if self.genres ~= nil and #self.genres > 0 then
        local genres = {}
        for _, value in self.genres do
            table.insert(genres, value)
        end
        result.genres = genres
    end

    if self.bundled_items ~= nil and #self.bundled_items > 0 then
        local bundledItems = {}
        for _, bundledItem in self.bundled_items do
            table.insert(bundledItems, bundledItem:jsonEncode())
        end
        result.bundledItems = bundledItems
    end

    if self.is_recolorable ~= nil then
        result.isRecolorable = self.is_recolorable
    end

    if self.licensing ~= nil then
        result.licensing = self.licensing:jsonEncode()
    end

    if self.original_price ~= nil then
        result.originalPrice = self.original_price
    end

    return result
end

function MarketplaceBundleData:jsonDecode()
    local var1 = MarketplaceBundleData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.name ~= nil then
        var1.name = self.name
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

    if self.bundle_type ~= nil then
        var1.bundle_type = self.bundle_type
    end

    if self.bundleType ~= nil then
        var1.bundle_type = self.bundleType
    end

    if self.price ~= nil then
        var1.price = self.price
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.creator_id ~= nil then
        var1.creator_id = self.creator_id
    end

    if self.creatorId ~= nil then
        var1.creator_id = self.creatorId
    end

    if self.creator_type ~= nil then
        var1.creator_type = self.creator_type
    end

    if self.creatorType ~= nil then
        var1.creator_type = self.creatorType
    end

    if self.creating_universe_id ~= nil then
        var1.creating_universe_id = self.creating_universe_id
    end

    if self.creatingUniverseId ~= nil then
        var1.creating_universe_id = self.creatingUniverseId
    end

    if self.taxonomy ~= nil then
        local taxonomy = {}
        for _, value in self.taxonomy do
            table.insert(taxonomy, marketplace_catalog_item_common.MarketplaceCatalogTaxonomyNode.jsonDecode(value))
        end

        var1.taxonomy = taxonomy
    end

    if self.render_properties ~= nil then
        local renderProperties = {}
        for _, value in self.render_properties do
            table.insert(renderProperties, value)
        end

        var1.render_properties = renderProperties
    end

    if self.renderProperties ~= nil then
        local renderProperties = {}
        for _, value in self.renderProperties do
            table.insert(renderProperties, value)
        end

        var1.render_properties = renderProperties
    end

    if self.item_restrictions ~= nil then
        local itemRestrictions = {}
        for _, itemRestriction in self.item_restrictions do
            table.insert(itemRestrictions, itemRestriction)
        end

        var1.item_restrictions = itemRestrictions
    end

    if self.itemRestrictions ~= nil then
        local itemRestrictions = {}
        for _, itemRestriction in self.itemRestrictions do
            table.insert(itemRestrictions, itemRestriction)
        end

        var1.item_restrictions = itemRestrictions
    end

    if self.is_high_definition ~= nil then
        var1.is_high_definition = self.is_high_definition
    end

    if self.isHighDefinition ~= nil then
        var1.is_high_definition = self.isHighDefinition
    end

    if self.is_pbr ~= nil then
        var1.is_pbr = self.is_pbr
    end

    if self.isPbr ~= nil then
        var1.is_pbr = self.isPbr
    end

    if self.has_resellers ~= nil then
        var1.has_resellers = self.has_resellers
    end

    if self.hasResellers ~= nil then
        var1.has_resellers = self.hasResellers
    end

    if self.lowest_price ~= nil then
        var1.lowest_price = self.lowest_price
    end

    if self.lowestPrice ~= nil then
        var1.lowest_price = self.lowestPrice
    end

    if self.lowest_resale_price ~= nil then
        var1.lowest_resale_price = self.lowest_resale_price
    end

    if self.lowestResalePrice ~= nil then
        var1.lowest_resale_price = self.lowestResalePrice
    end

    if self.total_quantity ~= nil then
        var1.total_quantity = self.total_quantity
    end

    if self.totalQuantity ~= nil then
        var1.total_quantity = self.totalQuantity
    end

    if self.units_available_for_consumption ~= nil then
        var1.units_available_for_consumption = self.units_available_for_consumption
    end

    if self.unitsAvailableForConsumption ~= nil then
        var1.units_available_for_consumption = self.unitsAvailableForConsumption
    end

    if self.favorite_count ~= nil then
        var1.favorite_count = self.favorite_count
    end

    if self.favoriteCount ~= nil then
        var1.favorite_count = self.favoriteCount
    end

    if self.timed_options ~= nil then
        local timedOptions = {}
        for _, timedOption in self.timed_options do
            table.insert(timedOptions, marketplace_catalog_item_common.MarketplaceCatalogTimedOption.jsonDecode(timedOption))
        end

        var1.timed_options = timedOptions
    end

    if self.timedOptions ~= nil then
        local timedOptions = {}
        for _, timedOption in self.timedOptions do
            table.insert(timedOptions, marketplace_catalog_item_common.MarketplaceCatalogTimedOption.jsonDecode(timedOption))
        end

        var1.timed_options = timedOptions
    end

    if self.collectible_item_id ~= nil then
        var1.collectible_item_id = self.collectible_item_id
    end

    if self.collectibleItemId ~= nil then
        var1.collectible_item_id = self.collectibleItemId
    end

    if self.is_off_sale ~= nil then
        var1.is_off_sale = self.is_off_sale
    end

    if self.isOffSale ~= nil then
        var1.is_off_sale = self.isOffSale
    end

    if self.sale_location_type ~= nil then
        var1.sale_location_type = self.sale_location_type
    end

    if self.saleLocationType ~= nil then
        var1.sale_location_type = self.saleLocationType
    end

    if self.item_status ~= nil then
        local itemStatus = {}
        for _, value in self.item_status do
            table.insert(itemStatus, value)
        end

        var1.item_status = itemStatus
    end

    if self.itemStatus ~= nil then
        local itemStatus = {}
        for _, value in self.itemStatus do
            table.insert(itemStatus, value)
        end

        var1.item_status = itemStatus
    end

    if self.price_status ~= nil then
        var1.price_status = self.price_status
    end

    if self.priceStatus ~= nil then
        var1.price_status = self.priceStatus
    end

    if self.product_id ~= nil then
        var1.product_id = self.product_id
    end

    if self.productId ~= nil then
        var1.product_id = self.productId
    end

    if self.owned ~= nil then
        var1.owned = self.owned
    end

    if self.is_purchasable ~= nil then
        var1.is_purchasable = self.is_purchasable
    end

    if self.isPurchasable ~= nil then
        var1.is_purchasable = self.isPurchasable
    end

    if self.variant_attributes ~= nil then
        local variantAttributes = {}
        for _, value in self.variant_attributes do
            table.insert(variantAttributes, marketplace_catalog_item_common.MarketplaceCatalogVariantAttribute.jsonDecode(value))
        end

        var1.variant_attributes = variantAttributes
    end

    if self.variantAttributes ~= nil then
        local variantAttributes = {}
        for _, value in self.variantAttributes do
            table.insert(variantAttributes, marketplace_catalog_item_common.MarketplaceCatalogVariantAttribute.jsonDecode(value))
        end

        var1.variant_attributes = variantAttributes
    end

    if self.genres ~= nil then
        local genres = {}
        for _, value in self.genres do
            table.insert(genres, value)
        end

        var1.genres = genres
    end

    if self.bundled_items ~= nil then
        local bundledItems = {}
        for _, bundledItem in self.bundled_items do
            table.insert(bundledItems, marketplace_catalog_item_common.MarketplaceCatalogBundledItem.jsonDecode(bundledItem))
        end

        var1.bundled_items = bundledItems
    end

    if self.bundledItems ~= nil then
        local bundledItems = {}
        for _, bundledItem in self.bundledItems do
            table.insert(bundledItems, marketplace_catalog_item_common.MarketplaceCatalogBundledItem.jsonDecode(bundledItem))
        end

        var1.bundled_items = bundledItems
    end

    if self.is_recolorable ~= nil then
        var1.is_recolorable = self.is_recolorable
    end

    if self.isRecolorable ~= nil then
        var1.is_recolorable = self.isRecolorable
    end

    if self.licensing ~= nil then
        var1.licensing = marketplace_catalog_item_common.MarketplaceCatalogItemLicensing.jsonDecode(self.licensing)
    end

    if self.original_price ~= nil then
        var1.original_price = self.original_price
    end

    if self.originalPrice ~= nil then
        var1.original_price = self.originalPrice
    end

    return var1
end

MarketplaceBundleData.descriptor = {
    name = "MarketplaceBundleData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceBundleData"
}

tbl1.MarketplaceBundleData = MarketplaceBundleData

typeRegistry.default:register(tbl1.MarketplaceBundleData)

return {
    MarketplaceBundleData = tbl1.MarketplaceBundleData
}

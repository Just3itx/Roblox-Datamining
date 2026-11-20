-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MarketplaceCatalogTaxonomyNode = {}
MarketplaceCatalogTaxonomyNode.__index = MarketplaceCatalogTaxonomyNode

function MarketplaceCatalogTaxonomyNode.new(tbl3)
    return (setmetatable({
        taxonomy_id = if tbl3 == nil or tbl3.taxonomy_id == nil then nil else tbl3.taxonomy_id,
        taxonomy_name = if tbl3 == nil or tbl3.taxonomy_name == nil then "" else tbl3.taxonomy_name
    }, MarketplaceCatalogTaxonomyNode))
end

function MarketplaceCatalogTaxonomyNode:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.taxonomy_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.taxonomy_id)
    end

    if self.taxonomy_name ~= nil and self.taxonomy_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.taxonomy_name)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogTaxonomyNode.decode(buf1: buffer)
    local var1 = MarketplaceCatalogTaxonomyNode.new()
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
                var1.taxonomy_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.taxonomy_name = buffer.tostring(buf)
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

function MarketplaceCatalogTaxonomyNode:jsonEncode()
    local result = {}

    if self.taxonomy_id ~= nil then
        result.taxonomyId = self.taxonomy_id
    end

    if self.taxonomy_name ~= nil and self.taxonomy_name ~= "" then
        result.taxonomyName = self.taxonomy_name
    end

    return result
end

function MarketplaceCatalogTaxonomyNode:jsonDecode()
    local var1 = MarketplaceCatalogTaxonomyNode.new()

    if self.taxonomy_id ~= nil then
        var1.taxonomy_id = self.taxonomy_id
    end

    if self.taxonomyId ~= nil then
        var1.taxonomy_id = self.taxonomyId
    end

    if self.taxonomy_name ~= nil then
        var1.taxonomy_name = self.taxonomy_name
    end

    if self.taxonomyName ~= nil then
        var1.taxonomy_name = self.taxonomyName
    end

    return var1
end

MarketplaceCatalogTaxonomyNode.descriptor = {
    name = "MarketplaceCatalogTaxonomyNode",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogTaxonomyNode"
}

tbl1.MarketplaceCatalogTaxonomyNode = MarketplaceCatalogTaxonomyNode

typeRegistry.default:register(tbl1.MarketplaceCatalogTaxonomyNode)

local MarketplaceCatalogTimedOption = {}
MarketplaceCatalogTimedOption.__index = MarketplaceCatalogTimedOption

function MarketplaceCatalogTimedOption.new(tbl4)
    return (setmetatable({
        days = if tbl4 == nil or tbl4.days == nil then 0 else tbl4.days,
        price = if tbl4 == nil or tbl4.price == nil then 0 else tbl4.price,
        selected = if tbl4 == nil or tbl4.selected == nil then nil else tbl4.selected
    }, MarketplaceCatalogTimedOption))
end

function MarketplaceCatalogTimedOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.days ~= nil and self.days ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.days)
    end

    if self.price ~= nil and self.price ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price)
    end

    if self.selected ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.selected then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogTimedOption.decode(buf1: buffer)
    local var1 = MarketplaceCatalogTimedOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.days = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.selected = var4 ~= 0
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

function MarketplaceCatalogTimedOption:jsonEncode()
    local result = {}

    if self.days ~= nil and self.days ~= 0 then
        result.days = self.days
    end

    if self.price ~= nil and self.price ~= 0 then
        result.price = self.price
    end

    if self.selected ~= nil then
        result.selected = self.selected
    end

    return result
end

function MarketplaceCatalogTimedOption:jsonDecode()
    local var1 = MarketplaceCatalogTimedOption.new()

    if self.days ~= nil then
        var1.days = self.days
    end

    if self.price ~= nil then
        var1.price = self.price
    end

    if self.selected ~= nil then
        var1.selected = self.selected
    end

    return var1
end

MarketplaceCatalogTimedOption.descriptor = {
    name = "MarketplaceCatalogTimedOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogTimedOption"
}

tbl1.MarketplaceCatalogTimedOption = MarketplaceCatalogTimedOption

typeRegistry.default:register(tbl1.MarketplaceCatalogTimedOption)

local MarketplaceCatalogVariantAttribute = {}
MarketplaceCatalogVariantAttribute.__index = MarketplaceCatalogVariantAttribute

function MarketplaceCatalogVariantAttribute.new(tbl5)
    return (setmetatable({
        name = if tbl5 == nil or tbl5.name == nil then "" else tbl5.name,
        value = if tbl5 == nil or tbl5.value == nil then "" else tbl5.value
    }, MarketplaceCatalogVariantAttribute))
end

function MarketplaceCatalogVariantAttribute:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogVariantAttribute.decode(buf1: buffer)
    local var1 = MarketplaceCatalogVariantAttribute.new()
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
                var1.name = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.value = buffer.tostring(buf)
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

function MarketplaceCatalogVariantAttribute:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function MarketplaceCatalogVariantAttribute:jsonDecode()
    local var1 = MarketplaceCatalogVariantAttribute.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

MarketplaceCatalogVariantAttribute.descriptor = {
    name = "MarketplaceCatalogVariantAttribute",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogVariantAttribute"
}

tbl1.MarketplaceCatalogVariantAttribute = MarketplaceCatalogVariantAttribute

typeRegistry.default:register(tbl1.MarketplaceCatalogVariantAttribute)

local MarketplaceCatalogBundledItem = {}
MarketplaceCatalogBundledItem.__index = MarketplaceCatalogBundledItem

function MarketplaceCatalogBundledItem.new(tbl6)
    return (setmetatable({
        id = if tbl6 == nil or tbl6.id == nil then "" else tbl6.id,
        asset_type = if tbl6 == nil or tbl6.asset_type == nil then nil else tbl6.asset_type,
        type = if tbl6 == nil or tbl6.type == nil then "" else tbl6.type
    }, MarketplaceCatalogBundledItem))
end

function MarketplaceCatalogBundledItem:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.asset_type ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.asset_type)
    end

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogBundledItem.decode(buf1: buffer)
    local var1 = MarketplaceCatalogBundledItem.new()
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
                var1.asset_type = buffer.tostring(buf)
            elseif var2 == 3 then
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

function MarketplaceCatalogBundledItem:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.asset_type ~= nil then
        result.assetType = self.asset_type
    end

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    return result
end

function MarketplaceCatalogBundledItem:jsonDecode()
    local var1 = MarketplaceCatalogBundledItem.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.asset_type ~= nil then
        var1.asset_type = self.asset_type
    end

    if self.assetType ~= nil then
        var1.asset_type = self.assetType
    end

    if self.type ~= nil then
        var1.type = self.type
    end

    return var1
end

MarketplaceCatalogBundledItem.descriptor = {
    name = "MarketplaceCatalogBundledItem",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogBundledItem"
}

tbl1.MarketplaceCatalogBundledItem = MarketplaceCatalogBundledItem

typeRegistry.default:register(tbl1.MarketplaceCatalogBundledItem)

local MarketplaceCatalogItemLicensing = {}
MarketplaceCatalogItemLicensing.__index = MarketplaceCatalogItemLicensing

function MarketplaceCatalogItemLicensing.new(tbl7)
    return (setmetatable({
        id = if tbl7 == nil or tbl7.id == nil then nil else tbl7.id,
        license_type = if tbl7 == nil or tbl7.license_type == nil then "" else tbl7.license_type,
        badge_asset_id = if tbl7 == nil or tbl7.badge_asset_id == nil then nil else tbl7.badge_asset_id,
        name = if tbl7 == nil or tbl7.name == nil then nil else tbl7.name,
        license_display_name = if tbl7 == nil or tbl7.license_display_name == nil then nil else tbl7.license_display_name
    }, MarketplaceCatalogItemLicensing))
end

function MarketplaceCatalogItemLicensing:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.license_type ~= nil and self.license_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.license_type)
    end

    if self.badge_asset_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.badge_asset_id)
    end

    if self.name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.license_display_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.license_display_name)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogItemLicensing.decode(buf1: buffer)
    local var1 = MarketplaceCatalogItemLicensing.new()
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
                var1.license_type = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.badge_asset_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.license_display_name = buffer.tostring(buf)
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

function MarketplaceCatalogItemLicensing:jsonEncode()
    local result = {}

    if self.id ~= nil then
        result.id = self.id
    end

    if self.license_type ~= nil and self.license_type ~= "" then
        result.licenseType = self.license_type
    end

    if self.badge_asset_id ~= nil then
        result.badgeAssetId = self.badge_asset_id
    end

    if self.name ~= nil then
        result.name = self.name
    end

    if self.license_display_name ~= nil then
        result.licenseDisplayName = self.license_display_name
    end

    return result
end

function MarketplaceCatalogItemLicensing:jsonDecode()
    local var1 = MarketplaceCatalogItemLicensing.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.license_type ~= nil then
        var1.license_type = self.license_type
    end

    if self.licenseType ~= nil then
        var1.license_type = self.licenseType
    end

    if self.badge_asset_id ~= nil then
        var1.badge_asset_id = self.badge_asset_id
    end

    if self.badgeAssetId ~= nil then
        var1.badge_asset_id = self.badgeAssetId
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.license_display_name ~= nil then
        var1.license_display_name = self.license_display_name
    end

    if self.licenseDisplayName ~= nil then
        var1.license_display_name = self.licenseDisplayName
    end

    return var1
end

MarketplaceCatalogItemLicensing.descriptor = {
    name = "MarketplaceCatalogItemLicensing",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogItemLicensing"
}

tbl1.MarketplaceCatalogItemLicensing = MarketplaceCatalogItemLicensing

typeRegistry.default:register(tbl1.MarketplaceCatalogItemLicensing)

return {
    MarketplaceCatalogTaxonomyNode = tbl1.MarketplaceCatalogTaxonomyNode,
    MarketplaceCatalogTimedOption = tbl1.MarketplaceCatalogTimedOption,
    MarketplaceCatalogVariantAttribute = tbl1.MarketplaceCatalogVariantAttribute,
    MarketplaceCatalogBundledItem = tbl1.MarketplaceCatalogBundledItem,
    MarketplaceCatalogItemLicensing = tbl1.MarketplaceCatalogItemLicensing
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local MarketplaceCatalogCategoryData = {}
MarketplaceCatalogCategoryData.__index = MarketplaceCatalogCategoryData

function MarketplaceCatalogCategoryData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        title = if tbl3 == nil or tbl3.title == nil then "" else tbl3.title,
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        taxonomy_id = if tbl3 == nil or tbl3.taxonomy_id == nil then "" else tbl3.taxonomy_id,
        buttons_enabled = (tbl3 == nil or tbl3.buttons_enabled == nil) and {} or tbl3.buttons_enabled,
        subcategories = (tbl3 == nil or tbl3.subcategories == nil) and {} or tbl3.subcategories,
        default_subcategory_id = if tbl3 == nil or tbl3.default_subcategory_id == nil then "" else tbl3.default_subcategory_id,
        asset_types = (tbl3 == nil or tbl3.asset_types == nil) and {} or tbl3.asset_types,
        bundle_types = (tbl3 == nil or tbl3.bundle_types == nil) and {} or tbl3.bundle_types,
        can_animate_camera_based_mood = not (tbl3 == nil or tbl3.can_animate_camera_based_mood == nil) and tbl3.can_animate_camera_based_mood,
        camera_focus = if tbl3 == nil or tbl3.camera_focus == nil then "" else tbl3.camera_focus,
        camera_zoom_radius = if tbl3 == nil or tbl3.camera_zoom_radius == nil then 0 else tbl3.camera_zoom_radius,
        tile_type = if tbl3 == nil or tbl3.tile_type == nil then "" else tbl3.tile_type,
        looks_widget_context_for_organic_content = if tbl3 == nil or tbl3.looks_widget_context_for_organic_content == nil then "" else tbl3.looks_widget_context_for_organic_content,
        time_to_refresh = if tbl3 == nil or tbl3.time_to_refresh == nil then 0 else tbl3.time_to_refresh,
        category_id = if tbl3 == nil or tbl3.category_id == nil then 0 else tbl3.category_id,
        subcategory_id = if tbl3 == nil or tbl3.subcategory_id == nil then 0 else tbl3.subcategory_id
    }, MarketplaceCatalogCategoryData))
end

function MarketplaceCatalogCategoryData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.taxonomy_id ~= nil and self.taxonomy_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.taxonomy_id)
    end

    if self.buttons_enabled ~= nil and #self.buttons_enabled > 0 then
        for _, value in self.buttons_enabled do
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.subcategories ~= nil and #self.subcategories > 0 then
        for _, value in self.subcategories do
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.default_subcategory_id ~= nil and self.default_subcategory_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.default_subcategory_id)
    end

    if self.asset_types ~= nil and #self.asset_types > 0 then
        for _, value in self.asset_types do
            local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.bundle_types ~= nil and #self.bundle_types > 0 then
        for _, value in self.bundle_types do
            local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.can_animate_camera_based_mood then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_animate_camera_based_mood then 1 else 0)
    end

    if self.camera_focus ~= nil and self.camera_focus ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.camera_focus)
    end

    if self.camera_zoom_radius ~= nil and self.camera_zoom_radius ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.camera_zoom_radius)
    end

    if self.tile_type ~= nil and self.tile_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.tile_type)
    end

    if self.looks_widget_context_for_organic_content ~= nil and self.looks_widget_context_for_organic_content ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.looks_widget_context_for_organic_content)
    end

    if self.time_to_refresh ~= nil and self.time_to_refresh ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.time_to_refresh)
    end

    if self.category_id ~= nil and self.category_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.category_id)
    end

    if self.subcategory_id ~= nil and self.subcategory_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.subcategory_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogCategoryData.decode(buf1: buffer)
    local var1 = MarketplaceCatalogCategoryData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 10 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_animate_camera_based_mood = var4 ~= 0
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.time_to_refresh = var4
            elseif var2 == 16 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.category_id = var4
            elseif var2 == 17 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.subcategory_id = var4
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
                var1.title = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.taxonomy_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.buttons_enabled, buffer.tostring(var4))
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.subcategories, buffer.tostring(var4))
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.default_subcategory_id = buffer.tostring(buf)
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.asset_types, buffer.tostring(var4))
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.bundle_types, buffer.tostring(var4))
            elseif var2 == 11 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.camera_focus = buffer.tostring(buf)
            elseif var2 == 13 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.tile_type = buffer.tostring(buf)
            elseif var2 == 14 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.looks_widget_context_for_organic_content = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 12 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.camera_zoom_radius = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function MarketplaceCatalogCategoryData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.taxonomy_id ~= nil and self.taxonomy_id ~= "" then
        result.taxonomyId = self.taxonomy_id
    end

    if self.buttons_enabled ~= nil and #self.buttons_enabled > 0 then
        local buttonsEnabled = {}
        for _, value in self.buttons_enabled do
            table.insert(buttonsEnabled, value)
        end
        result.buttonsEnabled = buttonsEnabled
    end

    if self.subcategories ~= nil and #self.subcategories > 0 then
        local subcategories = {}
        for _, value in self.subcategories do
            table.insert(subcategories, value)
        end
        result.subcategories = subcategories
    end

    if self.default_subcategory_id ~= nil and self.default_subcategory_id ~= "" then
        result.defaultSubcategoryId = self.default_subcategory_id
    end

    if self.asset_types ~= nil and #self.asset_types > 0 then
        local assetTypes = {}
        for _, value in self.asset_types do
            table.insert(assetTypes, value)
        end
        result.assetTypes = assetTypes
    end

    if self.bundle_types ~= nil and #self.bundle_types > 0 then
        local bundleTypes = {}
        for _, value in self.bundle_types do
            table.insert(bundleTypes, value)
        end
        result.bundleTypes = bundleTypes
    end

    if self.can_animate_camera_based_mood then
        result.canAnimateCameraBasedMood = self.can_animate_camera_based_mood
    end

    if self.camera_focus ~= nil and self.camera_focus ~= "" then
        result.cameraFocus = self.camera_focus
    end

    if self.camera_zoom_radius ~= nil and self.camera_zoom_radius ~= 0 then
        result.cameraZoomRadius = proto.json.serializeNumber(self.camera_zoom_radius)
    end

    if self.tile_type ~= nil and self.tile_type ~= "" then
        result.tileType = self.tile_type
    end

    if self.looks_widget_context_for_organic_content ~= nil and self.looks_widget_context_for_organic_content ~= "" then
        result.looksWidgetContextForOrganicContent = self.looks_widget_context_for_organic_content
    end

    if self.time_to_refresh ~= nil and self.time_to_refresh ~= 0 then
        result.timeToRefresh = self.time_to_refresh
    end

    if self.category_id ~= nil and self.category_id ~= 0 then
        result.categoryId = self.category_id
    end

    if self.subcategory_id ~= nil and self.subcategory_id ~= 0 then
        result.subcategoryId = self.subcategory_id
    end

    return result
end

function MarketplaceCatalogCategoryData:jsonDecode()
    local var1 = MarketplaceCatalogCategoryData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.taxonomy_id ~= nil then
        var1.taxonomy_id = self.taxonomy_id
    end

    if self.taxonomyId ~= nil then
        var1.taxonomy_id = self.taxonomyId
    end

    if self.buttons_enabled ~= nil then
        local buttonsEnabled = {}
        for _, value in self.buttons_enabled do
            table.insert(buttonsEnabled, value)
        end

        var1.buttons_enabled = buttonsEnabled
    end

    if self.buttonsEnabled ~= nil then
        local buttonsEnabled = {}
        for _, value in self.buttonsEnabled do
            table.insert(buttonsEnabled, value)
        end

        var1.buttons_enabled = buttonsEnabled
    end

    if self.subcategories ~= nil then
        local subcategories = {}
        for _, value in self.subcategories do
            table.insert(subcategories, value)
        end

        var1.subcategories = subcategories
    end

    if self.default_subcategory_id ~= nil then
        var1.default_subcategory_id = self.default_subcategory_id
    end

    if self.defaultSubcategoryId ~= nil then
        var1.default_subcategory_id = self.defaultSubcategoryId
    end

    if self.asset_types ~= nil then
        local assetTypes = {}
        for _, value in self.asset_types do
            table.insert(assetTypes, value)
        end

        var1.asset_types = assetTypes
    end

    if self.assetTypes ~= nil then
        local assetTypes = {}
        for _, value in self.assetTypes do
            table.insert(assetTypes, value)
        end

        var1.asset_types = assetTypes
    end

    if self.bundle_types ~= nil then
        local bundleTypes = {}
        for _, value in self.bundle_types do
            table.insert(bundleTypes, value)
        end

        var1.bundle_types = bundleTypes
    end

    if self.bundleTypes ~= nil then
        local bundleTypes = {}
        for _, value in self.bundleTypes do
            table.insert(bundleTypes, value)
        end

        var1.bundle_types = bundleTypes
    end

    if self.can_animate_camera_based_mood ~= nil then
        var1.can_animate_camera_based_mood = self.can_animate_camera_based_mood
    end

    if self.canAnimateCameraBasedMood ~= nil then
        var1.can_animate_camera_based_mood = self.canAnimateCameraBasedMood
    end

    if self.camera_focus ~= nil then
        var1.camera_focus = self.camera_focus
    end

    if self.cameraFocus ~= nil then
        var1.camera_focus = self.cameraFocus
    end

    if self.camera_zoom_radius ~= nil then
        var1.camera_zoom_radius = proto.json.deserializeNumber(self.camera_zoom_radius)
    end

    if self.cameraZoomRadius ~= nil then
        var1.camera_zoom_radius = proto.json.deserializeNumber(self.cameraZoomRadius)
    end

    if self.tile_type ~= nil then
        var1.tile_type = self.tile_type
    end

    if self.tileType ~= nil then
        var1.tile_type = self.tileType
    end

    if self.looks_widget_context_for_organic_content ~= nil then
        var1.looks_widget_context_for_organic_content = self.looks_widget_context_for_organic_content
    end

    if self.looksWidgetContextForOrganicContent ~= nil then
        var1.looks_widget_context_for_organic_content = self.looksWidgetContextForOrganicContent
    end

    if self.time_to_refresh ~= nil then
        var1.time_to_refresh = self.time_to_refresh
    end

    if self.timeToRefresh ~= nil then
        var1.time_to_refresh = self.timeToRefresh
    end

    if self.category_id ~= nil then
        var1.category_id = self.category_id
    end

    if self.categoryId ~= nil then
        var1.category_id = self.categoryId
    end

    if self.subcategory_id ~= nil then
        var1.subcategory_id = self.subcategory_id
    end

    if self.subcategoryId ~= nil then
        var1.subcategory_id = self.subcategoryId
    end

    return var1
end

MarketplaceCatalogCategoryData.descriptor = {
    name = "MarketplaceCatalogCategoryData",
    fullName = "roblox.apppageplatform.shared.v1beta1.MarketplaceCatalogCategoryData"
}

tbl1.MarketplaceCatalogCategoryData = MarketplaceCatalogCategoryData

typeRegistry.default:register(tbl1.MarketplaceCatalogCategoryData)

return {
    MarketplaceCatalogCategoryData = tbl1.MarketplaceCatalogCategoryData
}

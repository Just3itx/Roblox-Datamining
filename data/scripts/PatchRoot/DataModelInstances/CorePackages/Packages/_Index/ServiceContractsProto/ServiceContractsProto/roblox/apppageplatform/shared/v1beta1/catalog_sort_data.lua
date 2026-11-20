-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local background_layer = require(script.Parent.background_layer)

local CatalogSortContentData = {}
CatalogSortContentData.__index = CatalogSortContentData

function CatalogSortContentData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        type = if tbl3 == nil or tbl3.type == nil then "" else tbl3.type,
        encrypted_ad_tracking_data = if tbl3 == nil or tbl3.encrypted_ad_tracking_data == nil then nil else tbl3.encrypted_ad_tracking_data
    }, CatalogSortContentData))
end

function CatalogSortContentData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.encrypted_ad_tracking_data ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.encrypted_ad_tracking_data)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CatalogSortContentData.decode(buf1: buffer)
    local var1 = CatalogSortContentData.new()
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
                var1.type = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.encrypted_ad_tracking_data = buffer.tostring(buf)
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

function CatalogSortContentData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    if self.encrypted_ad_tracking_data ~= nil then
        result.encryptedAdTrackingData = self.encrypted_ad_tracking_data
    end

    return result
end

function CatalogSortContentData:jsonDecode()
    local var1 = CatalogSortContentData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.encrypted_ad_tracking_data ~= nil then
        var1.encrypted_ad_tracking_data = self.encrypted_ad_tracking_data
    end

    if self.encryptedAdTrackingData ~= nil then
        var1.encrypted_ad_tracking_data = self.encryptedAdTrackingData
    end

    return var1
end

CatalogSortContentData.descriptor = {
    name = "CatalogSortContentData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortContentData"
}

tbl1.CatalogSortContentData = CatalogSortContentData

typeRegistry.default:register(tbl1.CatalogSortContentData)

local CatalogSortCardItemFooter = {}
CatalogSortCardItemFooter.__index = CatalogSortCardItemFooter

function CatalogSortCardItemFooter.new(tbl4)
    return (setmetatable(
        {
            content_type = if tbl4 == nil or tbl4.content_type == nil then "" else tbl4.content_type
        },
        CatalogSortCardItemFooter
    ))
end

function CatalogSortCardItemFooter:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.content_type ~= nil and self.content_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.content_type)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CatalogSortCardItemFooter.decode(buf1: buffer)
    local var1 = CatalogSortCardItemFooter.new()
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
                var1.content_type = buffer.tostring(buf)
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

function CatalogSortCardItemFooter:jsonEncode()
    local result = {}

    if self.content_type ~= nil and self.content_type ~= "" then
        result.contentType = self.content_type
    end

    return result
end

function CatalogSortCardItemFooter:jsonDecode()
    local var1 = CatalogSortCardItemFooter.new()

    if self.content_type ~= nil then
        var1.content_type = self.content_type
    end

    if self.contentType ~= nil then
        var1.content_type = self.contentType
    end

    return var1
end

CatalogSortCardItemFooter.descriptor = {
    name = "CatalogSortCardItemFooter",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortCardItemFooter"
}

tbl1.CatalogSortCardItemFooter = CatalogSortCardItemFooter

typeRegistry.default:register(tbl1.CatalogSortCardItemFooter)

local CatalogSortCardStyle = {}
CatalogSortCardStyle.__index = CatalogSortCardStyle

function CatalogSortCardStyle.new(tbl5)
    return (setmetatable({
        thumbnail_aspect_ratio = if tbl5 == nil or tbl5.thumbnail_aspect_ratio == nil then "" else tbl5.thumbnail_aspect_ratio,
        background_layers = (tbl5 == nil or tbl5.background_layers == nil) and {} or tbl5.background_layers
    }, CatalogSortCardStyle))
end

function CatalogSortCardStyle:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.thumbnail_aspect_ratio ~= nil and self.thumbnail_aspect_ratio ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.thumbnail_aspect_ratio)
    end

    if self.background_layers ~= nil and #self.background_layers > 0 then
        for _, backgroundLayer in self.background_layers do
            local buf = backgroundLayer:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CatalogSortCardStyle.decode(buf1: buffer)
    local var1 = CatalogSortCardStyle.new()
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
                var1.thumbnail_aspect_ratio = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.background_layers, background_layer.BackgroundLayer.decode(var4))
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

function CatalogSortCardStyle:jsonEncode()
    local result = {}

    if self.thumbnail_aspect_ratio ~= nil and self.thumbnail_aspect_ratio ~= "" then
        result.thumbnailAspectRatio = self.thumbnail_aspect_ratio
    end

    if self.background_layers ~= nil and #self.background_layers > 0 then
        local backgroundLayers = {}
        for _, backgroundLayer in self.background_layers do
            table.insert(backgroundLayers, backgroundLayer:jsonEncode())
        end
        result.backgroundLayers = backgroundLayers
    end

    return result
end

function CatalogSortCardStyle:jsonDecode()
    local var1 = CatalogSortCardStyle.new()

    if self.thumbnail_aspect_ratio ~= nil then
        var1.thumbnail_aspect_ratio = self.thumbnail_aspect_ratio
    end

    if self.thumbnailAspectRatio ~= nil then
        var1.thumbnail_aspect_ratio = self.thumbnailAspectRatio
    end

    if self.background_layers ~= nil then
        local backgroundLayers = {}
        for _, backgroundLayer in self.background_layers do
            table.insert(backgroundLayers, background_layer.BackgroundLayer.jsonDecode(backgroundLayer))
        end

        var1.background_layers = backgroundLayers
    end

    if self.backgroundLayers ~= nil then
        local backgroundLayers = {}
        for _, backgroundLayer in self.backgroundLayers do
            table.insert(backgroundLayers, background_layer.BackgroundLayer.jsonDecode(backgroundLayer))
        end

        var1.background_layers = backgroundLayers
    end

    return var1
end

CatalogSortCardStyle.descriptor = {
    name = "CatalogSortCardStyle",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortCardStyle"
}

tbl1.CatalogSortCardStyle = CatalogSortCardStyle

typeRegistry.default:register(tbl1.CatalogSortCardStyle)

local CatalogSortData = {}
CatalogSortData.__index = CatalogSortData

function CatalogSortData.new(tbl6)
    return (setmetatable({
        id = if tbl6 == nil or tbl6.id == nil then "" else tbl6.id,
        type = if tbl6 == nil or tbl6.type == nil then "" else tbl6.type,
        hydration_priority = if tbl6 == nil or tbl6.hydration_priority == nil then 0 else tbl6.hydration_priority,
        hydration_count = if tbl6 == nil or tbl6.hydration_count == nil then 0 else tbl6.hydration_count,
        content = (tbl6 == nil or tbl6.content == nil) and {} or tbl6.content,
        preview_columns = if tbl6 == nil or tbl6.preview_columns == nil then 0 else tbl6.preview_columns,
        title = if tbl6 == nil or tbl6.title == nil then "" else tbl6.title,
        description = if tbl6 == nil or tbl6.description == nil then "" else tbl6.description,
        card_style = if tbl6 == nil or tbl6.card_style == nil then nil else tbl6.card_style,
        card_footers = (tbl6 == nil or tbl6.card_footers == nil) and {} or tbl6.card_footers,
        tag_id = if tbl6 == nil or tbl6.tag_id == nil then "" else tbl6.tag_id
    }, CatalogSortData))
end

function CatalogSortData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.hydration_priority ~= nil and self.hydration_priority ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.hydration_priority)
    end

    if self.hydration_count ~= nil and self.hydration_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.hydration_count)
    end

    if self.content ~= nil and #self.content > 0 then
        for _, value in self.content do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.preview_columns ~= nil and self.preview_columns ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.preview_columns)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.description ~= nil and self.description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.card_style ~= nil then
        local buf = self.card_style:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.card_footers ~= nil and #self.card_footers > 0 then
        for _, cardFooter in self.card_footers do
            local buf = cardFooter:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.tag_id ~= nil and self.tag_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.tag_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CatalogSortData.decode(buf1: buffer)
    local var1 = CatalogSortData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.hydration_priority = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.hydration_count = var4
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.preview_columns = var4
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
                var1.type = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.content, tbl1.CatalogSortContentData.decode(var4))
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.card_style = tbl1.CatalogSortCardStyle.decode(var4)
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.card_footers, tbl1.CatalogSortCardItemFooter.decode(var4))
            elseif var2 == 11 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.tag_id = buffer.tostring(buf)
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

function CatalogSortData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    if self.hydration_priority ~= nil and self.hydration_priority ~= 0 then
        result.hydrationPriority = self.hydration_priority
    end

    if self.hydration_count ~= nil and self.hydration_count ~= 0 then
        result.hydrationCount = self.hydration_count
    end

    if self.content ~= nil and #self.content > 0 then
        local content = {}
        for _, value in self.content do
            table.insert(content, value:jsonEncode())
        end
        result.content = content
    end

    if self.preview_columns ~= nil and self.preview_columns ~= 0 then
        result.previewColumns = self.preview_columns
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.description ~= nil and self.description ~= "" then
        result.description = self.description
    end

    if self.card_style ~= nil then
        result.cardStyle = self.card_style:jsonEncode()
    end

    if self.card_footers ~= nil and #self.card_footers > 0 then
        local cardFooters = {}
        for _, cardFooter in self.card_footers do
            table.insert(cardFooters, cardFooter:jsonEncode())
        end
        result.cardFooters = cardFooters
    end

    if self.tag_id ~= nil and self.tag_id ~= "" then
        result.tagId = self.tag_id
    end

    return result
end

function CatalogSortData:jsonDecode()
    local var1 = CatalogSortData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.hydration_priority ~= nil then
        var1.hydration_priority = self.hydration_priority
    end

    if self.hydrationPriority ~= nil then
        var1.hydration_priority = self.hydrationPriority
    end

    if self.hydration_count ~= nil then
        var1.hydration_count = self.hydration_count
    end

    if self.hydrationCount ~= nil then
        var1.hydration_count = self.hydrationCount
    end

    if self.content ~= nil then
        local content = {}
        for _, value in self.content do
            table.insert(content, tbl1.CatalogSortContentData.jsonDecode(value))
        end

        var1.content = content
    end

    if self.preview_columns ~= nil then
        var1.preview_columns = self.preview_columns
    end

    if self.previewColumns ~= nil then
        var1.preview_columns = self.previewColumns
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.card_style ~= nil then
        var1.card_style = tbl1.CatalogSortCardStyle.jsonDecode(self.card_style)
    end

    if self.cardStyle ~= nil then
        var1.card_style = tbl1.CatalogSortCardStyle.jsonDecode(self.cardStyle)
    end

    if self.card_footers ~= nil then
        local cardFooters = {}
        for _, cardFooter in self.card_footers do
            table.insert(cardFooters, tbl1.CatalogSortCardItemFooter.jsonDecode(cardFooter))
        end

        var1.card_footers = cardFooters
    end

    if self.cardFooters ~= nil then
        local cardFooters = {}
        for _, cardFooter in self.cardFooters do
            table.insert(cardFooters, tbl1.CatalogSortCardItemFooter.jsonDecode(cardFooter))
        end

        var1.card_footers = cardFooters
    end

    if self.tag_id ~= nil then
        var1.tag_id = self.tag_id
    end

    if self.tagId ~= nil then
        var1.tag_id = self.tagId
    end

    return var1
end

CatalogSortData.descriptor = {
    name = "CatalogSortData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortData"
}

tbl1.CatalogSortData = CatalogSortData

typeRegistry.default:register(tbl1.CatalogSortData)

return {
    CatalogSortContentData = tbl1.CatalogSortContentData,
    CatalogSortCardItemFooter = tbl1.CatalogSortCardItemFooter,
    CatalogSortCardStyle = tbl1.CatalogSortCardStyle,
    CatalogSortData = tbl1.CatalogSortData
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local HomePageRequest = {}
HomePageRequest.__index = HomePageRequest

function HomePageRequest.new(tbl3)
    return (setmetatable({
        session_id = if tbl3 == nil or tbl3.session_id == nil then "" else tbl3.session_id,
        topic_ids = (tbl3 == nil or tbl3.topic_ids == nil) and {} or tbl3.topic_ids,
        contextual_features = (tbl3 == nil or tbl3.contextual_features == nil) and {} or tbl3.contextual_features,
        cached_roblox_component_to_template_id = (tbl3 == nil or tbl3.cached_roblox_component_to_template_id == nil) and {}
            or tbl3.cached_roblox_component_to_template_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities,
        collection_layout = if tbl3 == nil or tbl3.collection_layout == nil then nil else tbl3.collection_layout
    }, HomePageRequest))
end

function HomePageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.session_id ~= nil and self.session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.session_id)
    end

    if self.topic_ids ~= nil and #self.topic_ids > 0 then
        for _, topicId in self.topic_ids do
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, topicId)
        end
    end

    if self.contextual_features ~= nil and next(self.contextual_features) ~= nil then
        for value, value2 in self.contextual_features do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.collection_layout ~= nil then
        local buf = self.collection_layout:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageRequest.decode(buf1: buffer)
    local var1 = HomePageRequest.new()
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
                var1.session_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.topic_ids, buffer.tostring(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HomePageRequest_ContextualFeaturesEntry.decode(var4)

                var1.contextual_features[var5.key or ""] = var5.value or ""
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HomePageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.collection_layout = tbl1.HomeCollectionLayoutInfo.decode(var4)
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

function HomePageRequest:jsonEncode()
    local result = {}

    if self.session_id ~= nil and self.session_id ~= "" then
        result.sessionId = self.session_id
    end

    if self.topic_ids ~= nil and #self.topic_ids > 0 then
        local topicIds = {}
        for _, topicId in self.topic_ids do
            table.insert(topicIds, topicId)
        end
        result.topicIds = topicIds
    end

    if self.contextual_features ~= nil and next(self.contextual_features) ~= nil then
        local contextualFeatures = ({})
        for value, value2 in self.contextual_features do
            contextualFeatures[value] = value2
        end
        result.contextualFeatures = contextualFeatures
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        local cachedRobloxComponentToTemplateId = ({})
        for value, value2 in self.cached_roblox_component_to_template_id do
            cachedRobloxComponentToTemplateId[value] = value2
        end
        result.cachedRobloxComponentToTemplateId = cachedRobloxComponentToTemplateId
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    if self.collection_layout ~= nil then
        result.collectionLayout = self.collection_layout:jsonEncode()
    end

    return result
end

function HomePageRequest:jsonDecode()
    local var1 = HomePageRequest.new()

    if self.session_id ~= nil then
        var1.session_id = self.session_id
    end

    if self.sessionId ~= nil then
        var1.session_id = self.sessionId
    end

    if self.topic_ids ~= nil then
        local topicIds = {}
        for _, topicId in self.topic_ids do
            table.insert(topicIds, topicId)
        end

        var1.topic_ids = topicIds
    end

    if self.topicIds ~= nil then
        local topicIds = {}
        for _, topicId in self.topicIds do
            table.insert(topicIds, topicId)
        end

        var1.topic_ids = topicIds
    end

    if self.contextual_features ~= nil then
        local contextualFeatures = ({})
        for value, value2 in self.contextual_features do
            contextualFeatures[value] = value2
        end

        var1.contextual_features = contextualFeatures
    end

    if self.contextualFeatures ~= nil then
        local contextualFeatures = ({})
        for value, value2 in self.contextualFeatures do
            contextualFeatures[value] = value2
        end

        var1.contextual_features = contextualFeatures
    end

    if self.cached_roblox_component_to_template_id ~= nil then
        local cachedRobloxComponentToTemplateId = ({})
        for value, value2 in self.cached_roblox_component_to_template_id do
            cachedRobloxComponentToTemplateId[value] = value2
        end

        var1.cached_roblox_component_to_template_id = cachedRobloxComponentToTemplateId
    end

    if self.cachedRobloxComponentToTemplateId ~= nil then
        local cachedRobloxComponentToTemplateId = ({})
        for value, value2 in self.cachedRobloxComponentToTemplateId do
            cachedRobloxComponentToTemplateId[value] = value2
        end

        var1.cached_roblox_component_to_template_id = cachedRobloxComponentToTemplateId
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    if self.collection_layout ~= nil then
        var1.collection_layout = tbl1.HomeCollectionLayoutInfo.jsonDecode(self.collection_layout)
    end

    if self.collectionLayout ~= nil then
        var1.collection_layout = tbl1.HomeCollectionLayoutInfo.jsonDecode(self.collectionLayout)
    end

    return var1
end

HomePageRequest.descriptor = {
    name = "HomePageRequest",
    fullName = "roblox.apppageplatform.home.v1beta1.HomePageRequest"
}

tbl1.HomePageRequest = HomePageRequest

typeRegistry.default:register(tbl1.HomePageRequest)

local HomePageRequest_ContextualFeaturesEntry = {}
HomePageRequest_ContextualFeaturesEntry.__index = HomePageRequest_ContextualFeaturesEntry

function HomePageRequest_ContextualFeaturesEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, HomePageRequest_ContextualFeaturesEntry))
end

function HomePageRequest_ContextualFeaturesEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageRequest_ContextualFeaturesEntry.decode(buf1: buffer)
    local var1 = HomePageRequest_ContextualFeaturesEntry.new()
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
                var1.key = buffer.tostring(buf)
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

function HomePageRequest_ContextualFeaturesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function HomePageRequest_ContextualFeaturesEntry:jsonDecode()
    local var1 = HomePageRequest_ContextualFeaturesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

HomePageRequest_ContextualFeaturesEntry.descriptor = {
    name = "HomePageRequest_ContextualFeaturesEntry",
    fullName = "roblox.apppageplatform.home.v1beta1.ContextualFeaturesEntry"
}

tbl1.HomePageRequest_ContextualFeaturesEntry = HomePageRequest_ContextualFeaturesEntry

typeRegistry.default:register(tbl1.HomePageRequest_ContextualFeaturesEntry)

local HomePageRequest_CachedRobloxComponentToTemplateIdEntry = {}
HomePageRequest_CachedRobloxComponentToTemplateIdEntry.__index = HomePageRequest_CachedRobloxComponentToTemplateIdEntry

function HomePageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then "" else tbl5.value
    }, HomePageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function HomePageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = HomePageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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
                var1.key = buffer.tostring(buf)
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

function HomePageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function HomePageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = HomePageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

HomePageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "HomePageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.home.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.HomePageRequest_CachedRobloxComponentToTemplateIdEntry = HomePageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.HomePageRequest_CachedRobloxComponentToTemplateIdEntry)

local HomeCollectionLayoutInfo = {}
HomeCollectionLayoutInfo.__index = HomeCollectionLayoutInfo

function HomeCollectionLayoutInfo.new(tbl6)
    return (setmetatable({
        items_per_row = (tbl6 == nil or tbl6.items_per_row == nil) and {} or tbl6.items_per_row,
        rows_above_fold = if tbl6 == nil or tbl6.rows_above_fold == nil then 0 else tbl6.rows_above_fold
    }, HomeCollectionLayoutInfo))
end

function HomeCollectionLayoutInfo:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.items_per_row ~= nil and next(self.items_per_row) ~= nil then
        for value, value2 in self.items_per_row do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.varint)
            local var7, var8 = proto.writeVarInt(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.rows_above_fold ~= nil and self.rows_above_fold ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.rows_above_fold)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomeCollectionLayoutInfo.decode(buf1: buffer)
    local var1 = HomeCollectionLayoutInfo.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.rows_above_fold = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HomeCollectionLayoutInfo_ItemsPerRowEntry.decode(var4)

                var1.items_per_row[var5.key or ""] = var5.value or 0
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

function HomeCollectionLayoutInfo:jsonEncode()
    local result = {}

    if self.items_per_row ~= nil and next(self.items_per_row) ~= nil then
        local itemsPerRow = ({})
        for value, value2 in self.items_per_row do
            itemsPerRow[value] = value2
        end
        result.itemsPerRow = itemsPerRow
    end

    if self.rows_above_fold ~= nil and self.rows_above_fold ~= 0 then
        result.rowsAboveFold = self.rows_above_fold
    end

    return result
end

function HomeCollectionLayoutInfo:jsonDecode()
    local var1 = HomeCollectionLayoutInfo.new()

    if self.items_per_row ~= nil then
        local itemsPerRow = ({})
        for value, value2 in self.items_per_row do
            itemsPerRow[value] = value2
        end

        var1.items_per_row = itemsPerRow
    end

    if self.itemsPerRow ~= nil then
        local itemsPerRow = ({})
        for value, value2 in self.itemsPerRow do
            itemsPerRow[value] = value2
        end

        var1.items_per_row = itemsPerRow
    end

    if self.rows_above_fold ~= nil then
        var1.rows_above_fold = self.rows_above_fold
    end

    if self.rowsAboveFold ~= nil then
        var1.rows_above_fold = self.rowsAboveFold
    end

    return var1
end

HomeCollectionLayoutInfo.descriptor = {
    name = "HomeCollectionLayoutInfo",
    fullName = "roblox.apppageplatform.home.v1beta1.HomeCollectionLayoutInfo"
}

tbl1.HomeCollectionLayoutInfo = HomeCollectionLayoutInfo

typeRegistry.default:register(tbl1.HomeCollectionLayoutInfo)

local HomeCollectionLayoutInfo_ItemsPerRowEntry = {}
HomeCollectionLayoutInfo_ItemsPerRowEntry.__index = HomeCollectionLayoutInfo_ItemsPerRowEntry

function HomeCollectionLayoutInfo_ItemsPerRowEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then 0 else tbl7.value
    }, HomeCollectionLayoutInfo_ItemsPerRowEntry))
end

function HomeCollectionLayoutInfo_ItemsPerRowEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomeCollectionLayoutInfo_ItemsPerRowEntry.decode(buf1: buffer)
    local var1 = HomeCollectionLayoutInfo_ItemsPerRowEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.value = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
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

function HomeCollectionLayoutInfo_ItemsPerRowEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= 0 then
        result.value = self.value
    end

    return result
end

function HomeCollectionLayoutInfo_ItemsPerRowEntry:jsonDecode()
    local var1 = HomeCollectionLayoutInfo_ItemsPerRowEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

HomeCollectionLayoutInfo_ItemsPerRowEntry.descriptor = {
    name = "HomeCollectionLayoutInfo_ItemsPerRowEntry",
    fullName = "roblox.apppageplatform.home.v1beta1.ItemsPerRowEntry"
}

tbl1.HomeCollectionLayoutInfo_ItemsPerRowEntry = HomeCollectionLayoutInfo_ItemsPerRowEntry

typeRegistry.default:register(tbl1.HomeCollectionLayoutInfo_ItemsPerRowEntry)

local HomePageResponse = {}
HomePageResponse.__index = HomePageResponse

function HomePageResponse.new(tbl8)
    return (setmetatable({
        page_entries = (tbl8 == nil or tbl8.page_entries == nil) and {} or tbl8.page_entries,
        hydration_data = if tbl8 == nil or tbl8.hydration_data == nil then nil else tbl8.hydration_data,
        templates = (tbl8 == nil or tbl8.templates == nil) and {} or tbl8.templates,
        localized_literals = (tbl8 == nil or tbl8.localized_literals == nil) and {} or tbl8.localized_literals,
        request_id = if tbl8 == nil or tbl8.request_id == nil then "" else tbl8.request_id
    }, HomePageResponse))
end

function HomePageResponse:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.page_entries ~= nil and #self.page_entries > 0 then
        for _, value in self.page_entries do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.hydration_data ~= nil then
        local buf = self.hydration_data:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.templates ~= nil and next(self.templates) ~= nil then
        for value, value2 in self.templates do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        for k, localizedLiteral in self.localized_literals do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, localizedLiteral)
            local var9, var10 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.request_id ~= nil and self.request_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.request_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageResponse.decode(buf1: buffer)
    local var1 = HomePageResponse.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.page_entries, page_entry_content.UniversalPageEntry.decode(var4))
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.hydration_data = hydration_content.HydrationContent.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HomePageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.HomePageResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.request_id = buffer.tostring(buf)
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

function HomePageResponse:jsonEncode()
    local result = {}

    if self.page_entries ~= nil and #self.page_entries > 0 then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, value:jsonEncode())
        end
        result.pageEntries = pageEntries
    end

    if self.hydration_data ~= nil then
        result.hydrationData = self.hydration_data:jsonEncode()
    end

    if self.templates ~= nil and next(self.templates) ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = value2:jsonEncode()
        end
        result.templates = templates
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localized_literals do
            localizedLiterals[k] = localizedLiteral
        end
        result.localizedLiterals = localizedLiterals
    end

    if self.request_id ~= nil and self.request_id ~= "" then
        result.requestId = self.request_id
    end

    return result
end

function HomePageResponse:jsonDecode()
    local var1 = HomePageResponse.new()

    if self.page_entries ~= nil then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, page_entry_content.UniversalPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.pageEntries ~= nil then
        local pageEntries = {}
        for _, value in self.pageEntries do
            table.insert(pageEntries, page_entry_content.UniversalPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.hydration_data ~= nil then
        var1.hydration_data = hydration_content.HydrationContent.jsonDecode(self.hydration_data)
    end

    if self.hydrationData ~= nil then
        var1.hydration_data = hydration_content.HydrationContent.jsonDecode(self.hydrationData)
    end

    if self.templates ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = template_entry.TemplateEntry.jsonDecode(value2)
        end

        var1.templates = templates
    end

    if self.localized_literals ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localized_literals do
            localizedLiterals[k] = localizedLiteral
        end

        var1.localized_literals = localizedLiterals
    end

    if self.localizedLiterals ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localizedLiterals do
            localizedLiterals[k] = localizedLiteral
        end

        var1.localized_literals = localizedLiterals
    end

    if self.request_id ~= nil then
        var1.request_id = self.request_id
    end

    if self.requestId ~= nil then
        var1.request_id = self.requestId
    end

    return var1
end

HomePageResponse.descriptor = {
    name = "HomePageResponse",
    fullName = "roblox.apppageplatform.home.v1beta1.HomePageResponse"
}

tbl1.HomePageResponse = HomePageResponse

typeRegistry.default:register(tbl1.HomePageResponse)

local HomePageResponse_TemplatesEntry = {}
HomePageResponse_TemplatesEntry.__index = HomePageResponse_TemplatesEntry

function HomePageResponse_TemplatesEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then nil else tbl9.value
    }, HomePageResponse_TemplatesEntry))
end

function HomePageResponse_TemplatesEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = HomePageResponse_TemplatesEntry.new()
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
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = template_entry.TemplateEntry.decode(var4)
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

function HomePageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function HomePageResponse_TemplatesEntry:jsonDecode()
    local var1 = HomePageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

HomePageResponse_TemplatesEntry.descriptor = {
    name = "HomePageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.home.v1beta1.TemplatesEntry"
}

tbl1.HomePageResponse_TemplatesEntry = HomePageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.HomePageResponse_TemplatesEntry)

local HomePageResponse_LocalizedLiteralsEntry = {}
HomePageResponse_LocalizedLiteralsEntry.__index = HomePageResponse_LocalizedLiteralsEntry

function HomePageResponse_LocalizedLiteralsEntry.new(tbl10)
    return (setmetatable({
        key = if tbl10 == nil or tbl10.key == nil then "" else tbl10.key,
        value = if tbl10 == nil or tbl10.value == nil then "" else tbl10.value
    }, HomePageResponse_LocalizedLiteralsEntry))
end

function HomePageResponse_LocalizedLiteralsEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HomePageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = HomePageResponse_LocalizedLiteralsEntry.new()
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
                var1.key = buffer.tostring(buf)
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

function HomePageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function HomePageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = HomePageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

HomePageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "HomePageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.home.v1beta1.LocalizedLiteralsEntry"
}

tbl1.HomePageResponse_LocalizedLiteralsEntry = HomePageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.HomePageResponse_LocalizedLiteralsEntry)

return {
    HomePageRequest = tbl1.HomePageRequest,
    HomeCollectionLayoutInfo = tbl1.HomeCollectionLayoutInfo,
    HomePageResponse = tbl1.HomePageResponse
}

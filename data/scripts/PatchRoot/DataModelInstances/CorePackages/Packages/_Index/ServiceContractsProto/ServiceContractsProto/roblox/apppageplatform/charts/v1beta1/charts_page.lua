-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local hydration_stream_mode = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_stream_mode)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local GetChartsPageRequest = {}
GetChartsPageRequest.__index = GetChartsPageRequest

function GetChartsPageRequest.new(tbl3)
    local tbl4 = {
        feed_page_token = if tbl3 == nil or tbl3.feed_page_token == nil then "" else tbl3.feed_page_token,
        device = if tbl3 == nil or tbl3.device == nil then "" else tbl3.device,
        country = if tbl3 == nil or tbl3.country == nil then "" else tbl3.country,
        age_group = if tbl3 == nil or tbl3.age_group == nil then "" else tbl3.age_group,
        session_id = if tbl3 == nil or tbl3.session_id == nil then "" else tbl3.session_id,
        entry_pagination_key = if tbl3 == nil or tbl3.entry_pagination_key == nil then "" else tbl3.entry_pagination_key,
        entry_page_token = if tbl3 == nil or tbl3.entry_page_token == nil then "" else tbl3.entry_page_token,
        max_memory = if tbl3 == nil or tbl3.max_memory == nil then "" else tbl3.max_memory,
        page_type = if tbl3 == nil or tbl3.page_type == nil then "" else tbl3.page_type,
        include_placeholders = if tbl3 == nil or tbl3.include_placeholders == nil then nil else tbl3.include_placeholders,
        hydration_stream_enabled = if tbl3 == nil or tbl3.hydration_stream_enabled == nil then nil else tbl3.hydration_stream_enabled,
        hydration_stream_mode = if tbl3 == nil or tbl3.hydration_stream_mode == nil then assert(hydration_stream_mode.HydrationStreamMode.fromNumber(0), "Enum has no 0 default") else tbl3.hydration_stream_mode,
        collection_layout = if tbl3 == nil or tbl3.collection_layout == nil then nil else tbl3.collection_layout,
        cached_roblox_component_to_template_id = (tbl3 == nil or tbl3.cached_roblox_component_to_template_id == nil) and {}
            or tbl3.cached_roblox_component_to_template_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities,
        audience = if tbl3 == nil or tbl3.audience == nil then "" else tbl3.audience
    }
    return (setmetatable(tbl4, GetChartsPageRequest))
end

function GetChartsPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.feed_page_token ~= nil and self.feed_page_token ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.feed_page_token)
    end

    if self.device ~= nil and self.device ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.device)
    end

    if self.country ~= nil and self.country ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.country)
    end

    if self.age_group ~= nil and self.age_group ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.age_group)
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.session_id)
    end

    if self.entry_pagination_key ~= nil and self.entry_pagination_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.entry_pagination_key)
    end

    if self.entry_page_token ~= nil and self.entry_page_token ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.entry_page_token)
    end

    if self.max_memory ~= nil and self.max_memory ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.max_memory)
    end

    if self.page_type ~= nil and self.page_type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.page_type)
    end

    if self.include_placeholders ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.include_placeholders then 1 else 0)
    end

    if self.hydration_stream_enabled ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.hydration_stream_enabled then 1 else 0)
    end

    if self.hydration_stream_mode ~= nil
        and (self.hydration_stream_mode ~= nil and self.hydration_stream_mode ~= 0
            or self.hydration_stream_mode ~= hydration_stream_mode.HydrationStreamMode.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, hydration_stream_mode.HydrationStreamMode.toNumber(self.hydration_stream_mode))
    end

    if self.collection_layout ~= nil then
        local buf = self.collection_layout:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.audience ~= nil and self.audience ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.audience)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetChartsPageRequest.decode(buf1: buffer)
    local var1 = GetChartsPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 10 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.include_placeholders = var4 ~= 0
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.hydration_stream_enabled = var4 ~= 0
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.hydration_stream_mode = hydration_stream_mode.HydrationStreamMode.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.feed_page_token = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.device = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.country = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.age_group = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.session_id = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.entry_pagination_key = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.entry_page_token = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.max_memory = buffer.tostring(buf)
            elseif var2 == 9 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.page_type = buffer.tostring(buf)
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.collection_layout = tbl1.CollectionLayoutInfo.decode(var4)
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 16 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.audience = buffer.tostring(buf)
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

function GetChartsPageRequest:jsonEncode()
    local result = {}

    if self.feed_page_token ~= nil and self.feed_page_token ~= "" then
        result.feedPageToken = self.feed_page_token
    end

    if self.device ~= nil and self.device ~= "" then
        result.device = self.device
    end

    if self.country ~= nil and self.country ~= "" then
        result.country = self.country
    end

    if self.age_group ~= nil and self.age_group ~= "" then
        result.ageGroup = self.age_group
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        result.sessionId = self.session_id
    end

    if self.entry_pagination_key ~= nil and self.entry_pagination_key ~= "" then
        result.entryPaginationKey = self.entry_pagination_key
    end

    if self.entry_page_token ~= nil and self.entry_page_token ~= "" then
        result.entryPageToken = self.entry_page_token
    end

    if self.max_memory ~= nil and self.max_memory ~= "" then
        result.maxMemory = self.max_memory
    end

    if self.page_type ~= nil and self.page_type ~= "" then
        result.pageType = self.page_type
    end

    if self.include_placeholders ~= nil then
        result.includePlaceholders = self.include_placeholders
    end

    if self.hydration_stream_enabled ~= nil then
        result.hydrationStreamEnabled = self.hydration_stream_enabled
    end

    if self.hydration_stream_mode ~= nil
        and (self.hydration_stream_mode ~= nil and self.hydration_stream_mode ~= 0
            or self.hydration_stream_mode ~= hydration_stream_mode.HydrationStreamMode.fromNumber(0))
    then
        result.hydrationStreamMode = if typeof(self.hydration_stream_mode) == "number" then self.hydration_stream_mode else hydration_stream_mode.HydrationStreamMode.toNumber(self.hydration_stream_mode)
    end

    if self.collection_layout ~= nil then
        result.collectionLayout = self.collection_layout:jsonEncode()
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

    if self.audience ~= nil and self.audience ~= "" then
        result.audience = self.audience
    end

    return result
end

function GetChartsPageRequest:jsonDecode()
    local var1 = GetChartsPageRequest.new()

    if self.feed_page_token ~= nil then
        var1.feed_page_token = self.feed_page_token
    end

    if self.feedPageToken ~= nil then
        var1.feed_page_token = self.feedPageToken
    end

    if self.device ~= nil then
        var1.device = self.device
    end

    if self.country ~= nil then
        var1.country = self.country
    end

    if self.age_group ~= nil then
        var1.age_group = self.age_group
    end

    if self.ageGroup ~= nil then
        var1.age_group = self.ageGroup
    end

    if self.session_id ~= nil then
        var1.session_id = self.session_id
    end

    if self.sessionId ~= nil then
        var1.session_id = self.sessionId
    end

    if self.entry_pagination_key ~= nil then
        var1.entry_pagination_key = self.entry_pagination_key
    end

    if self.entryPaginationKey ~= nil then
        var1.entry_pagination_key = self.entryPaginationKey
    end

    if self.entry_page_token ~= nil then
        var1.entry_page_token = self.entry_page_token
    end

    if self.entryPageToken ~= nil then
        var1.entry_page_token = self.entryPageToken
    end

    if self.max_memory ~= nil then
        var1.max_memory = self.max_memory
    end

    if self.maxMemory ~= nil then
        var1.max_memory = self.maxMemory
    end

    if self.page_type ~= nil then
        var1.page_type = self.page_type
    end

    if self.pageType ~= nil then
        var1.page_type = self.pageType
    end

    if self.include_placeholders ~= nil then
        var1.include_placeholders = self.include_placeholders
    end

    if self.includePlaceholders ~= nil then
        var1.include_placeholders = self.includePlaceholders
    end

    if self.hydration_stream_enabled ~= nil then
        var1.hydration_stream_enabled = self.hydration_stream_enabled
    end

    if self.hydrationStreamEnabled ~= nil then
        var1.hydration_stream_enabled = self.hydrationStreamEnabled
    end

    if self.hydration_stream_mode ~= nil then
        var1.hydration_stream_mode = if typeof(self.hydration_stream_mode) == "number" then hydration_stream_mode.HydrationStreamMode.fromNumber(self.hydration_stream_mode) or self.hydration_stream_mode else hydration_stream_mode.HydrationStreamMode.fromName(self.hydration_stream_mode) or self.hydration_stream_mode
    end

    if self.hydrationStreamMode ~= nil then
        var1.hydration_stream_mode = if typeof(self.hydrationStreamMode) == "number" then hydration_stream_mode.HydrationStreamMode.fromNumber(self.hydrationStreamMode) or self.hydrationStreamMode else hydration_stream_mode.HydrationStreamMode.fromName(self.hydrationStreamMode) or self.hydrationStreamMode
    end

    if self.collection_layout ~= nil then
        var1.collection_layout = tbl1.CollectionLayoutInfo.jsonDecode(self.collection_layout)
    end

    if self.collectionLayout ~= nil then
        var1.collection_layout = tbl1.CollectionLayoutInfo.jsonDecode(self.collectionLayout)
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

    if self.audience ~= nil then
        var1.audience = self.audience
    end

    return var1
end

GetChartsPageRequest.descriptor = {
    name = "GetChartsPageRequest",
    fullName = "roblox.apppageplatform.charts.v1beta1.GetChartsPageRequest"
}

tbl1.GetChartsPageRequest = GetChartsPageRequest

typeRegistry.default:register(tbl1.GetChartsPageRequest)

local GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry = {}
GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.__index = GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry

function GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry = GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.GetChartsPageRequest_CachedRobloxComponentToTemplateIdEntry)

local CollectionLayoutInfo = {}
CollectionLayoutInfo.__index = CollectionLayoutInfo

function CollectionLayoutInfo.new(tbl5)
    return (setmetatable({
        items_per_row = (tbl5 == nil or tbl5.items_per_row == nil) and {} or tbl5.items_per_row,
        rows_above_fold = if tbl5 == nil or tbl5.rows_above_fold == nil then 0 else tbl5.rows_above_fold
    }, CollectionLayoutInfo))
end

function CollectionLayoutInfo:encode(): buffer
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

function CollectionLayoutInfo.decode(buf1: buffer)
    local var1 = CollectionLayoutInfo.new()
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

                local var5 = tbl1.CollectionLayoutInfo_ItemsPerRowEntry.decode(var4)

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

function CollectionLayoutInfo:jsonEncode()
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

function CollectionLayoutInfo:jsonDecode()
    local var1 = CollectionLayoutInfo.new()

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

CollectionLayoutInfo.descriptor = {
    name = "CollectionLayoutInfo",
    fullName = "roblox.apppageplatform.charts.v1beta1.CollectionLayoutInfo"
}

tbl1.CollectionLayoutInfo = CollectionLayoutInfo

typeRegistry.default:register(tbl1.CollectionLayoutInfo)

local CollectionLayoutInfo_ItemsPerRowEntry = {}
CollectionLayoutInfo_ItemsPerRowEntry.__index = CollectionLayoutInfo_ItemsPerRowEntry

function CollectionLayoutInfo_ItemsPerRowEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then 0 else tbl6.value
    }, CollectionLayoutInfo_ItemsPerRowEntry))
end

function CollectionLayoutInfo_ItemsPerRowEntry:encode(): buffer
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

function CollectionLayoutInfo_ItemsPerRowEntry.decode(buf1: buffer)
    local var1 = CollectionLayoutInfo_ItemsPerRowEntry.new()
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

function CollectionLayoutInfo_ItemsPerRowEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= 0 then
        result.value = self.value
    end

    return result
end

function CollectionLayoutInfo_ItemsPerRowEntry:jsonDecode()
    local var1 = CollectionLayoutInfo_ItemsPerRowEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

CollectionLayoutInfo_ItemsPerRowEntry.descriptor = {
    name = "CollectionLayoutInfo_ItemsPerRowEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.ItemsPerRowEntry"
}

tbl1.CollectionLayoutInfo_ItemsPerRowEntry = CollectionLayoutInfo_ItemsPerRowEntry

typeRegistry.default:register(tbl1.CollectionLayoutInfo_ItemsPerRowEntry)

local GetChartsPageResponse = {}
GetChartsPageResponse.__index = GetChartsPageResponse

function GetChartsPageResponse.new(tbl7)
    return (setmetatable({
        page_entries = (tbl7 == nil or tbl7.page_entries == nil) and {} or tbl7.page_entries,
        hydration_data = if tbl7 == nil or tbl7.hydration_data == nil then nil else tbl7.hydration_data,
        templates = (tbl7 == nil or tbl7.templates == nil) and {} or tbl7.templates,
        localized_literals = (tbl7 == nil or tbl7.localized_literals == nil) and {} or tbl7.localized_literals
    }, GetChartsPageResponse))
end

function GetChartsPageResponse:encode(): buffer
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

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetChartsPageResponse.decode(buf1: buffer)
    local var1 = GetChartsPageResponse.new()
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

                local var5 = tbl1.GetChartsPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetChartsPageResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
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

function GetChartsPageResponse:jsonEncode()
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

    return result
end

function GetChartsPageResponse:jsonDecode()
    local var1 = GetChartsPageResponse.new()

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

    return var1
end

GetChartsPageResponse.descriptor = {
    name = "GetChartsPageResponse",
    fullName = "roblox.apppageplatform.charts.v1beta1.GetChartsPageResponse"
}

tbl1.GetChartsPageResponse = GetChartsPageResponse

typeRegistry.default:register(tbl1.GetChartsPageResponse)

local GetChartsPageResponse_TemplatesEntry = {}
GetChartsPageResponse_TemplatesEntry.__index = GetChartsPageResponse_TemplatesEntry

function GetChartsPageResponse_TemplatesEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then nil else tbl8.value
    }, GetChartsPageResponse_TemplatesEntry))
end

function GetChartsPageResponse_TemplatesEntry:encode(): buffer
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

function GetChartsPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GetChartsPageResponse_TemplatesEntry.new()
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

function GetChartsPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetChartsPageResponse_TemplatesEntry:jsonDecode()
    local var1 = GetChartsPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GetChartsPageResponse_TemplatesEntry.descriptor = {
    name = "GetChartsPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.TemplatesEntry"
}

tbl1.GetChartsPageResponse_TemplatesEntry = GetChartsPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GetChartsPageResponse_TemplatesEntry)

local GetChartsPageResponse_LocalizedLiteralsEntry = {}
GetChartsPageResponse_LocalizedLiteralsEntry.__index = GetChartsPageResponse_LocalizedLiteralsEntry

function GetChartsPageResponse_LocalizedLiteralsEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then "" else tbl9.value
    }, GetChartsPageResponse_LocalizedLiteralsEntry))
end

function GetChartsPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function GetChartsPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GetChartsPageResponse_LocalizedLiteralsEntry.new()
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

function GetChartsPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetChartsPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GetChartsPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetChartsPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GetChartsPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GetChartsPageResponse_LocalizedLiteralsEntry = GetChartsPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GetChartsPageResponse_LocalizedLiteralsEntry)

local GetChartsSortDetailRequest = {}
GetChartsSortDetailRequest.__index = GetChartsSortDetailRequest

function GetChartsSortDetailRequest.new(tbl10)
    return (setmetatable({
        sort_id = if tbl10 == nil or tbl10.sort_id == nil then "" else tbl10.sort_id,
        content_page_token = if tbl10 == nil or tbl10.content_page_token == nil then "" else tbl10.content_page_token,
        device = if tbl10 == nil or tbl10.device == nil then "" else tbl10.device,
        country = if tbl10 == nil or tbl10.country == nil then "" else tbl10.country,
        session_id = if tbl10 == nil or tbl10.session_id == nil then "" else tbl10.session_id,
        age_group = if tbl10 == nil or tbl10.age_group == nil then "" else tbl10.age_group,
        max_memory = if tbl10 == nil or tbl10.max_memory == nil then "" else tbl10.max_memory,
        selected_genre = if tbl10 == nil or tbl10.selected_genre == nil then "" else tbl10.selected_genre,
        cached_roblox_component_to_template_id = (tbl10 == nil or tbl10.cached_roblox_component_to_template_id == nil) and {}
            or tbl10.cached_roblox_component_to_template_id,
        client_capabilities = if tbl10 == nil or tbl10.client_capabilities == nil then nil else tbl10.client_capabilities,
        audience = if tbl10 == nil or tbl10.audience == nil then "" else tbl10.audience
    }, GetChartsSortDetailRequest))
end

function GetChartsSortDetailRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.sort_id ~= nil and self.sort_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.sort_id)
    end

    if self.content_page_token ~= nil and self.content_page_token ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.content_page_token)
    end

    if self.device ~= nil and self.device ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.device)
    end

    if self.country ~= nil and self.country ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.country)
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.session_id)
    end

    if self.age_group ~= nil and self.age_group ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.age_group)
    end

    if self.max_memory ~= nil and self.max_memory ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.max_memory)
    end

    if self.selected_genre ~= nil and self.selected_genre ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.selected_genre)
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.audience ~= nil and self.audience ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.audience)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetChartsSortDetailRequest.decode(buf1: buffer)
    local var1 = GetChartsSortDetailRequest.new()
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
                var1.sort_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.content_page_token = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.device = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.country = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.session_id = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.age_group = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.max_memory = buffer.tostring(buf)
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.selected_genre = buffer.tostring(buf)
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 11 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.audience = buffer.tostring(buf)
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

function GetChartsSortDetailRequest:jsonEncode()
    local result = {}

    if self.sort_id ~= nil and self.sort_id ~= "" then
        result.sortId = self.sort_id
    end

    if self.content_page_token ~= nil and self.content_page_token ~= "" then
        result.contentPageToken = self.content_page_token
    end

    if self.device ~= nil and self.device ~= "" then
        result.device = self.device
    end

    if self.country ~= nil and self.country ~= "" then
        result.country = self.country
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        result.sessionId = self.session_id
    end

    if self.age_group ~= nil and self.age_group ~= "" then
        result.ageGroup = self.age_group
    end

    if self.max_memory ~= nil and self.max_memory ~= "" then
        result.maxMemory = self.max_memory
    end

    if self.selected_genre ~= nil and self.selected_genre ~= "" then
        result.selectedGenre = self.selected_genre
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

    if self.audience ~= nil and self.audience ~= "" then
        result.audience = self.audience
    end

    return result
end

function GetChartsSortDetailRequest:jsonDecode()
    local var1 = GetChartsSortDetailRequest.new()

    if self.sort_id ~= nil then
        var1.sort_id = self.sort_id
    end

    if self.sortId ~= nil then
        var1.sort_id = self.sortId
    end

    if self.content_page_token ~= nil then
        var1.content_page_token = self.content_page_token
    end

    if self.contentPageToken ~= nil then
        var1.content_page_token = self.contentPageToken
    end

    if self.device ~= nil then
        var1.device = self.device
    end

    if self.country ~= nil then
        var1.country = self.country
    end

    if self.session_id ~= nil then
        var1.session_id = self.session_id
    end

    if self.sessionId ~= nil then
        var1.session_id = self.sessionId
    end

    if self.age_group ~= nil then
        var1.age_group = self.age_group
    end

    if self.ageGroup ~= nil then
        var1.age_group = self.ageGroup
    end

    if self.max_memory ~= nil then
        var1.max_memory = self.max_memory
    end

    if self.maxMemory ~= nil then
        var1.max_memory = self.maxMemory
    end

    if self.selected_genre ~= nil then
        var1.selected_genre = self.selected_genre
    end

    if self.selectedGenre ~= nil then
        var1.selected_genre = self.selectedGenre
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

    if self.audience ~= nil then
        var1.audience = self.audience
    end

    return var1
end

GetChartsSortDetailRequest.descriptor = {
    name = "GetChartsSortDetailRequest",
    fullName = "roblox.apppageplatform.charts.v1beta1.GetChartsSortDetailRequest"
}

tbl1.GetChartsSortDetailRequest = GetChartsSortDetailRequest

typeRegistry.default:register(tbl1.GetChartsSortDetailRequest)

local GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry = {}
GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.__index = GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry

function GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl11)
    return (setmetatable({
        key = if tbl11 == nil or tbl11.key == nil then "" else tbl11.key,
        value = if tbl11 == nil or tbl11.value == nil then "" else tbl11.value
    }, GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry))
end

function GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry = GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.GetChartsSortDetailRequest_CachedRobloxComponentToTemplateIdEntry)

local GetChartsSortDetailResponse = {}
GetChartsSortDetailResponse.__index = GetChartsSortDetailResponse

function GetChartsSortDetailResponse.new(tbl12)
    return (setmetatable({
        page_entries = (tbl12 == nil or tbl12.page_entries == nil) and {} or tbl12.page_entries,
        hydration_data = if tbl12 == nil or tbl12.hydration_data == nil then nil else tbl12.hydration_data,
        templates = (tbl12 == nil or tbl12.templates == nil) and {} or tbl12.templates,
        next_content_page_token = if tbl12 == nil or tbl12.next_content_page_token == nil then "" else tbl12.next_content_page_token,
        localized_literals = (tbl12 == nil or tbl12.localized_literals == nil) and {} or tbl12.localized_literals
    }, GetChartsSortDetailResponse))
end

function GetChartsSortDetailResponse:encode(): buffer
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

    if self.next_content_page_token ~= nil and self.next_content_page_token ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.next_content_page_token)
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        for k, localizedLiteral in self.localized_literals do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, localizedLiteral)
            local var9, var10 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetChartsSortDetailResponse.decode(buf1: buffer)
    local var1 = GetChartsSortDetailResponse.new()
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

                local var5 = tbl1.GetChartsSortDetailResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.next_content_page_token = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetChartsSortDetailResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
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

function GetChartsSortDetailResponse:jsonEncode()
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

    if self.next_content_page_token ~= nil and self.next_content_page_token ~= "" then
        result.nextContentPageToken = self.next_content_page_token
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localized_literals do
            localizedLiterals[k] = localizedLiteral
        end
        result.localizedLiterals = localizedLiterals
    end

    return result
end

function GetChartsSortDetailResponse:jsonDecode()
    local var1 = GetChartsSortDetailResponse.new()

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

    if self.next_content_page_token ~= nil then
        var1.next_content_page_token = self.next_content_page_token
    end

    if self.nextContentPageToken ~= nil then
        var1.next_content_page_token = self.nextContentPageToken
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

    return var1
end

GetChartsSortDetailResponse.descriptor = {
    name = "GetChartsSortDetailResponse",
    fullName = "roblox.apppageplatform.charts.v1beta1.GetChartsSortDetailResponse"
}

tbl1.GetChartsSortDetailResponse = GetChartsSortDetailResponse

typeRegistry.default:register(tbl1.GetChartsSortDetailResponse)

local GetChartsSortDetailResponse_TemplatesEntry = {}
GetChartsSortDetailResponse_TemplatesEntry.__index = GetChartsSortDetailResponse_TemplatesEntry

function GetChartsSortDetailResponse_TemplatesEntry.new(tbl13)
    return (setmetatable({
        key = if tbl13 == nil or tbl13.key == nil then "" else tbl13.key,
        value = if tbl13 == nil or tbl13.value == nil then nil else tbl13.value
    }, GetChartsSortDetailResponse_TemplatesEntry))
end

function GetChartsSortDetailResponse_TemplatesEntry:encode(): buffer
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

function GetChartsSortDetailResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GetChartsSortDetailResponse_TemplatesEntry.new()
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

function GetChartsSortDetailResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetChartsSortDetailResponse_TemplatesEntry:jsonDecode()
    local var1 = GetChartsSortDetailResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GetChartsSortDetailResponse_TemplatesEntry.descriptor = {
    name = "GetChartsSortDetailResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.TemplatesEntry"
}

tbl1.GetChartsSortDetailResponse_TemplatesEntry = GetChartsSortDetailResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GetChartsSortDetailResponse_TemplatesEntry)

local GetChartsSortDetailResponse_LocalizedLiteralsEntry = {}
GetChartsSortDetailResponse_LocalizedLiteralsEntry.__index = GetChartsSortDetailResponse_LocalizedLiteralsEntry

function GetChartsSortDetailResponse_LocalizedLiteralsEntry.new(tbl14)
    return (setmetatable({
        key = if tbl14 == nil or tbl14.key == nil then "" else tbl14.key,
        value = if tbl14 == nil or tbl14.value == nil then "" else tbl14.value
    }, GetChartsSortDetailResponse_LocalizedLiteralsEntry))
end

function GetChartsSortDetailResponse_LocalizedLiteralsEntry:encode(): buffer
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

function GetChartsSortDetailResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GetChartsSortDetailResponse_LocalizedLiteralsEntry.new()
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

function GetChartsSortDetailResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetChartsSortDetailResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GetChartsSortDetailResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetChartsSortDetailResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GetChartsSortDetailResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.charts.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GetChartsSortDetailResponse_LocalizedLiteralsEntry = GetChartsSortDetailResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GetChartsSortDetailResponse_LocalizedLiteralsEntry)

return {
    GetChartsPageRequest = tbl1.GetChartsPageRequest,
    CollectionLayoutInfo = tbl1.CollectionLayoutInfo,
    GetChartsPageResponse = tbl1.GetChartsPageResponse,
    GetChartsSortDetailRequest = tbl1.GetChartsSortDetailRequest,
    GetChartsSortDetailResponse = tbl1.GetChartsSortDetailResponse
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local LibraryPageRequest = {}
LibraryPageRequest.__index = LibraryPageRequest

function LibraryPageRequest.new(tbl3)
    local tbl4 = {
        view = if tbl3 == nil or tbl3.view == nil then assert(tbl1.View.fromNumber(0), "Enum has no 0 default") else tbl3.view,
        cursor = if tbl3 == nil or tbl3.cursor == nil then "" else tbl3.cursor,
        page_size = if tbl3 == nil or tbl3.page_size == nil then 0 else tbl3.page_size,
        config_key = if tbl3 == nil or tbl3.config_key == nil then "" else tbl3.config_key,
        surface_key = if tbl3 == nil or tbl3.surface_key == nil then "" else tbl3.surface_key,
        cached_roblox_component_to_template_id = (tbl3 == nil or tbl3.cached_roblox_component_to_template_id == nil) and {}
            or tbl3.cached_roblox_component_to_template_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }
    return (setmetatable(tbl4, LibraryPageRequest))
end

function LibraryPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.view ~= nil and (self.view ~= nil and self.view ~= 0 or self.view ~= tbl1.View.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.View.toNumber(self.view))
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.cursor)
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.page_size)
    end

    if self.config_key ~= nil and self.config_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.config_key)
    end

    if self.surface_key ~= nil and self.surface_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.surface_key)
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function LibraryPageRequest.decode(buf1: buffer)
    local var1 = LibraryPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.view = tbl1.View.fromNumber(var4) or var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_size = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.cursor = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.config_key = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.surface_key = buffer.tostring(buf)
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
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

function LibraryPageRequest:jsonEncode()
    local result = {}

    if self.view ~= nil and (self.view ~= nil and self.view ~= 0 or self.view ~= tbl1.View.fromNumber(0)) then
        result.view = if typeof(self.view) == "number" then self.view else tbl1.View.toNumber(self.view)
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        result.cursor = self.cursor
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        result.pageSize = self.page_size
    end

    if self.config_key ~= nil and self.config_key ~= "" then
        result.configKey = self.config_key
    end

    if self.surface_key ~= nil and self.surface_key ~= "" then
        result.surfaceKey = self.surface_key
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

    return result
end

function LibraryPageRequest:jsonDecode()
    local var1 = LibraryPageRequest.new()

    if self.view ~= nil then
        var1.view = if typeof(self.view) == "number" then tbl1.View.fromNumber(self.view) or self.view else tbl1.View.fromName(self.view) or self.view
    end

    if self.cursor ~= nil then
        var1.cursor = self.cursor
    end

    if self.page_size ~= nil then
        var1.page_size = self.page_size
    end

    if self.pageSize ~= nil then
        var1.page_size = self.pageSize
    end

    if self.config_key ~= nil then
        var1.config_key = self.config_key
    end

    if self.configKey ~= nil then
        var1.config_key = self.configKey
    end

    if self.surface_key ~= nil then
        var1.surface_key = self.surface_key
    end

    if self.surfaceKey ~= nil then
        var1.surface_key = self.surfaceKey
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

    return var1
end

LibraryPageRequest.descriptor = {
    name = "LibraryPageRequest",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.LibraryPageRequest"
}

tbl1.LibraryPageRequest = LibraryPageRequest

typeRegistry.default:register(tbl1.LibraryPageRequest)

local LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry = {}
LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.__index = LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry

function LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry = LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.LibraryPageRequest_CachedRobloxComponentToTemplateIdEntry)

local CollectionPageRequest = {}
CollectionPageRequest.__index = CollectionPageRequest

function CollectionPageRequest.new(tbl5)
    local tbl6 = {
        collection_id = if tbl5 == nil or tbl5.collection_id == nil then "" else tbl5.collection_id,
        view = if tbl5 == nil or tbl5.view == nil then assert(tbl1.View.fromNumber(0), "Enum has no 0 default") else tbl5.view,
        cursor = if tbl5 == nil or tbl5.cursor == nil then "" else tbl5.cursor,
        page_size = if tbl5 == nil or tbl5.page_size == nil then 0 else tbl5.page_size,
        config_key = if tbl5 == nil or tbl5.config_key == nil then "" else tbl5.config_key,
        surface_key = if tbl5 == nil or tbl5.surface_key == nil then "" else tbl5.surface_key,
        cached_roblox_component_to_template_id = (tbl5 == nil or tbl5.cached_roblox_component_to_template_id == nil) and {}
            or tbl5.cached_roblox_component_to_template_id,
        client_capabilities = if tbl5 == nil or tbl5.client_capabilities == nil then nil else tbl5.client_capabilities
    }
    return (setmetatable(tbl6, CollectionPageRequest))
end

function CollectionPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.collection_id ~= nil and self.collection_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.collection_id)
    end

    if self.view ~= nil and (self.view ~= nil and self.view ~= 0 or self.view ~= tbl1.View.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.View.toNumber(self.view))
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.cursor)
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.page_size)
    end

    if self.config_key ~= nil and self.config_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.config_key)
    end

    if self.surface_key ~= nil and self.surface_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.surface_key)
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CollectionPageRequest.decode(buf1: buffer)
    local var1 = CollectionPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.view = tbl1.View.fromNumber(var4) or var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_size = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.collection_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.cursor = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.config_key = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.surface_key = buffer.tostring(buf)
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
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

function CollectionPageRequest:jsonEncode()
    local result = {}

    if self.collection_id ~= nil and self.collection_id ~= "" then
        result.collectionId = self.collection_id
    end

    if self.view ~= nil and (self.view ~= nil and self.view ~= 0 or self.view ~= tbl1.View.fromNumber(0)) then
        result.view = if typeof(self.view) == "number" then self.view else tbl1.View.toNumber(self.view)
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        result.cursor = self.cursor
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        result.pageSize = self.page_size
    end

    if self.config_key ~= nil and self.config_key ~= "" then
        result.configKey = self.config_key
    end

    if self.surface_key ~= nil and self.surface_key ~= "" then
        result.surfaceKey = self.surface_key
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

    return result
end

function CollectionPageRequest:jsonDecode()
    local var1 = CollectionPageRequest.new()

    if self.collection_id ~= nil then
        var1.collection_id = self.collection_id
    end

    if self.collectionId ~= nil then
        var1.collection_id = self.collectionId
    end

    if self.view ~= nil then
        var1.view = if typeof(self.view) == "number" then tbl1.View.fromNumber(self.view) or self.view else tbl1.View.fromName(self.view) or self.view
    end

    if self.cursor ~= nil then
        var1.cursor = self.cursor
    end

    if self.page_size ~= nil then
        var1.page_size = self.page_size
    end

    if self.pageSize ~= nil then
        var1.page_size = self.pageSize
    end

    if self.config_key ~= nil then
        var1.config_key = self.config_key
    end

    if self.configKey ~= nil then
        var1.config_key = self.configKey
    end

    if self.surface_key ~= nil then
        var1.surface_key = self.surface_key
    end

    if self.surfaceKey ~= nil then
        var1.surface_key = self.surfaceKey
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

    return var1
end

CollectionPageRequest.descriptor = {
    name = "CollectionPageRequest",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.CollectionPageRequest"
}

tbl1.CollectionPageRequest = CollectionPageRequest

typeRegistry.default:register(tbl1.CollectionPageRequest)

local CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry = {}
CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.__index = CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry

function CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then "" else tbl6.value
    }, CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry = CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.CollectionPageRequest_CachedRobloxComponentToTemplateIdEntry)

local PageResponse = {}
PageResponse.__index = PageResponse

function PageResponse.new(tbl7)
    return (setmetatable({
        page_entries = (tbl7 == nil or tbl7.page_entries == nil) and {} or tbl7.page_entries,
        hydration_data = if tbl7 == nil or tbl7.hydration_data == nil then nil else tbl7.hydration_data,
        templates = (tbl7 == nil or tbl7.templates == nil) and {} or tbl7.templates,
        localized_literals = (tbl7 == nil or tbl7.localized_literals == nil) and {} or tbl7.localized_literals
    }, PageResponse))
end

function PageResponse:encode(): buffer
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

function PageResponse.decode(buf1: buffer)
    local var1 = PageResponse.new()
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

                local var5 = tbl1.PageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.PageResponse_LocalizedLiteralsEntry.decode(var4)

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

function PageResponse:jsonEncode()
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

function PageResponse:jsonDecode()
    local var1 = PageResponse.new()

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

PageResponse.descriptor = {
    name = "PageResponse",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.PageResponse"
}

tbl1.PageResponse = PageResponse

typeRegistry.default:register(tbl1.PageResponse)

local PageResponse_TemplatesEntry = {}
PageResponse_TemplatesEntry.__index = PageResponse_TemplatesEntry

function PageResponse_TemplatesEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then nil else tbl8.value
    }, PageResponse_TemplatesEntry))
end

function PageResponse_TemplatesEntry:encode(): buffer
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

function PageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = PageResponse_TemplatesEntry.new()
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

function PageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function PageResponse_TemplatesEntry:jsonDecode()
    local var1 = PageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

PageResponse_TemplatesEntry.descriptor = {
    name = "PageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.TemplatesEntry"
}

tbl1.PageResponse_TemplatesEntry = PageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.PageResponse_TemplatesEntry)

local PageResponse_LocalizedLiteralsEntry = {}
PageResponse_LocalizedLiteralsEntry.__index = PageResponse_LocalizedLiteralsEntry

function PageResponse_LocalizedLiteralsEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then "" else tbl9.value
    }, PageResponse_LocalizedLiteralsEntry))
end

function PageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function PageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = PageResponse_LocalizedLiteralsEntry.new()
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

function PageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function PageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = PageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

PageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "PageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.userlibrary.v1beta1.LocalizedLiteralsEntry"
}

tbl1.PageResponse_LocalizedLiteralsEntry = PageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.PageResponse_LocalizedLiteralsEntry)

tbl1.View = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "VIEW_INVALID"
        elseif num1 == 1 then
            return "VIEW_ALL"
        elseif num1 == 2 then
            return "VIEW_COLLECTIONS"
        elseif num1 == 3 then
            return "VIEW_GAMES"
        elseif num1 == 4 then
            return "VIEW_AVATARS"
        elseif num1 == 5 then
            return "VIEW_AVATAR_ITEMS"
        elseif num1 == 6 then
            return "VIEW_SONGS"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "VIEW_INVALID" then
            return 0
        elseif arg1 == "VIEW_ALL" then
            return 1
        elseif arg1 == "VIEW_COLLECTIONS" then
            return 2
        elseif arg1 == "VIEW_GAMES" then
            return 3
        elseif arg1 == "VIEW_AVATARS" then
            return 4
        elseif arg1 == "VIEW_AVATAR_ITEMS" then
            return 5
        elseif arg1 == "VIEW_SONGS" then
            return 6
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "VIEW_INVALID" then
            return "VIEW_INVALID"
        elseif str1 == "VIEW_ALL" then
            return "VIEW_ALL"
        elseif str1 == "VIEW_COLLECTIONS" then
            return "VIEW_COLLECTIONS"
        elseif str1 == "VIEW_GAMES" then
            return "VIEW_GAMES"
        elseif str1 == "VIEW_AVATARS" then
            return "VIEW_AVATARS"
        elseif str1 == "VIEW_AVATAR_ITEMS" then
            return "VIEW_AVATAR_ITEMS"
        elseif str1 == "VIEW_SONGS" then
            return "VIEW_SONGS"
        end

        return nil
    end
}

return {
    LibraryPageRequest = tbl1.LibraryPageRequest,
    CollectionPageRequest = tbl1.CollectionPageRequest,
    PageResponse = tbl1.PageResponse,
    View = tbl1.View
}

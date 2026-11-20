-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local StreamPageRequest = {}
StreamPageRequest.__index = StreamPageRequest

function StreamPageRequest.new(tbl3)
    return (setmetatable({
        cursor = if tbl3 == nil or tbl3.cursor == nil then "" else tbl3.cursor,
        max_rows = if tbl3 == nil or tbl3.max_rows == nil then 0 else tbl3.max_rows,
        notification_id = if tbl3 == nil or tbl3.notification_id == nil then nil else tbl3.notification_id,
        state = if tbl3 == nil or tbl3.state == nil then nil else tbl3.state,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities,
        cached_roblox_component_to_template_id = (tbl3 == nil or tbl3.cached_roblox_component_to_template_id == nil) and {}
            or tbl3.cached_roblox_component_to_template_id,
        client_attributes = (tbl3 == nil or tbl3.client_attributes == nil) and {} or tbl3.client_attributes
    }, StreamPageRequest))
end

function StreamPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.cursor ~= nil and self.cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.cursor)
    end

    if self.max_rows ~= nil and self.max_rows ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.max_rows)
    end

    if self.notification_id ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.notification_id)
    end

    if self.state ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.state)
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_attributes ~= nil and next(self.client_attributes) ~= nil then
        for value, value2 in self.client_attributes do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StreamPageRequest.decode(buf1: buffer)
    local var1 = StreamPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.max_rows = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.cursor = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.notification_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.state = buffer.tostring(buf)
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.StreamPageRequest_ClientAttributesEntry.decode(var4)

                var1.client_attributes[var5.key or ""] = var5.value or ""
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

function StreamPageRequest:jsonEncode()
    local result = {}

    if self.cursor ~= nil and self.cursor ~= "" then
        result.cursor = self.cursor
    end

    if self.max_rows ~= nil and self.max_rows ~= 0 then
        result.maxRows = self.max_rows
    end

    if self.notification_id ~= nil then
        result.notificationId = self.notification_id
    end

    if self.state ~= nil then
        result.state = self.state
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        local cachedRobloxComponentToTemplateId = ({})
        for value, value2 in self.cached_roblox_component_to_template_id do
            cachedRobloxComponentToTemplateId[value] = value2
        end
        result.cachedRobloxComponentToTemplateId = cachedRobloxComponentToTemplateId
    end

    if self.client_attributes ~= nil and next(self.client_attributes) ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.client_attributes do
            clientAttributes[value] = value2
        end
        result.clientAttributes = clientAttributes
    end

    return result
end

function StreamPageRequest:jsonDecode()
    local var1 = StreamPageRequest.new()

    if self.cursor ~= nil then
        var1.cursor = self.cursor
    end

    if self.max_rows ~= nil then
        var1.max_rows = self.max_rows
    end

    if self.maxRows ~= nil then
        var1.max_rows = self.maxRows
    end

    if self.notification_id ~= nil then
        var1.notification_id = self.notification_id
    end

    if self.notificationId ~= nil then
        var1.notification_id = self.notificationId
    end

    if self.state ~= nil then
        var1.state = self.state
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
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

    if self.client_attributes ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.client_attributes do
            clientAttributes[value] = value2
        end

        var1.client_attributes = clientAttributes
    end

    if self.clientAttributes ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.clientAttributes do
            clientAttributes[value] = value2
        end

        var1.client_attributes = clientAttributes
    end

    return var1
end

StreamPageRequest.descriptor = {
    name = "StreamPageRequest",
    fullName = "roblox.apppageplatform.notifications.v1beta1.StreamPageRequest"
}

tbl1.StreamPageRequest = StreamPageRequest

typeRegistry.default:register(tbl1.StreamPageRequest)

local StreamPageRequest_CachedRobloxComponentToTemplateIdEntry = {}
StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.__index = StreamPageRequest_CachedRobloxComponentToTemplateIdEntry

function StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, StreamPageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function StreamPageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function StreamPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function StreamPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

StreamPageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "StreamPageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.notifications.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.StreamPageRequest_CachedRobloxComponentToTemplateIdEntry = StreamPageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.StreamPageRequest_CachedRobloxComponentToTemplateIdEntry)

local StreamPageRequest_ClientAttributesEntry = {}
StreamPageRequest_ClientAttributesEntry.__index = StreamPageRequest_ClientAttributesEntry

function StreamPageRequest_ClientAttributesEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then "" else tbl5.value
    }, StreamPageRequest_ClientAttributesEntry))
end

function StreamPageRequest_ClientAttributesEntry:encode(): buffer
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

function StreamPageRequest_ClientAttributesEntry.decode(buf1: buffer)
    local var1 = StreamPageRequest_ClientAttributesEntry.new()
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

function StreamPageRequest_ClientAttributesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function StreamPageRequest_ClientAttributesEntry:jsonDecode()
    local var1 = StreamPageRequest_ClientAttributesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

StreamPageRequest_ClientAttributesEntry.descriptor = {
    name = "StreamPageRequest_ClientAttributesEntry",
    fullName = "roblox.apppageplatform.notifications.v1beta1.ClientAttributesEntry"
}

tbl1.StreamPageRequest_ClientAttributesEntry = StreamPageRequest_ClientAttributesEntry

typeRegistry.default:register(tbl1.StreamPageRequest_ClientAttributesEntry)

local StreamPageResponse = {}
StreamPageResponse.__index = StreamPageResponse

function StreamPageResponse.new(tbl6)
    return (setmetatable({
        page_entries = (tbl6 == nil or tbl6.page_entries == nil) and {} or tbl6.page_entries,
        hydration_data = if tbl6 == nil or tbl6.hydration_data == nil then nil else tbl6.hydration_data,
        templates = (tbl6 == nil or tbl6.templates == nil) and {} or tbl6.templates,
        localized_literals = (tbl6 == nil or tbl6.localized_literals == nil) and {} or tbl6.localized_literals,
        next_cursor = if tbl6 == nil or tbl6.next_cursor == nil then "" else tbl6.next_cursor
    }, StreamPageResponse))
end

function StreamPageResponse:encode(): buffer
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

    if self.next_cursor ~= nil and self.next_cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.next_cursor)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StreamPageResponse.decode(buf1: buffer)
    local var1 = StreamPageResponse.new()
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

                local var5 = tbl1.StreamPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.StreamPageResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.next_cursor = buffer.tostring(buf)
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

function StreamPageResponse:jsonEncode()
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

    if self.next_cursor ~= nil and self.next_cursor ~= "" then
        result.nextCursor = self.next_cursor
    end

    return result
end

function StreamPageResponse:jsonDecode()
    local var1 = StreamPageResponse.new()

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

    if self.next_cursor ~= nil then
        var1.next_cursor = self.next_cursor
    end

    if self.nextCursor ~= nil then
        var1.next_cursor = self.nextCursor
    end

    return var1
end

StreamPageResponse.descriptor = {
    name = "StreamPageResponse",
    fullName = "roblox.apppageplatform.notifications.v1beta1.StreamPageResponse"
}

tbl1.StreamPageResponse = StreamPageResponse

typeRegistry.default:register(tbl1.StreamPageResponse)

local StreamPageResponse_TemplatesEntry = {}
StreamPageResponse_TemplatesEntry.__index = StreamPageResponse_TemplatesEntry

function StreamPageResponse_TemplatesEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then nil else tbl7.value
    }, StreamPageResponse_TemplatesEntry))
end

function StreamPageResponse_TemplatesEntry:encode(): buffer
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

function StreamPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = StreamPageResponse_TemplatesEntry.new()
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

function StreamPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function StreamPageResponse_TemplatesEntry:jsonDecode()
    local var1 = StreamPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

StreamPageResponse_TemplatesEntry.descriptor = {
    name = "StreamPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.notifications.v1beta1.TemplatesEntry"
}

tbl1.StreamPageResponse_TemplatesEntry = StreamPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.StreamPageResponse_TemplatesEntry)

local StreamPageResponse_LocalizedLiteralsEntry = {}
StreamPageResponse_LocalizedLiteralsEntry.__index = StreamPageResponse_LocalizedLiteralsEntry

function StreamPageResponse_LocalizedLiteralsEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then "" else tbl8.value
    }, StreamPageResponse_LocalizedLiteralsEntry))
end

function StreamPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function StreamPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = StreamPageResponse_LocalizedLiteralsEntry.new()
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

function StreamPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function StreamPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = StreamPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

StreamPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "StreamPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.notifications.v1beta1.LocalizedLiteralsEntry"
}

tbl1.StreamPageResponse_LocalizedLiteralsEntry = StreamPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.StreamPageResponse_LocalizedLiteralsEntry)

return {
    StreamPageRequest = tbl1.StreamPageRequest,
    StreamPageResponse = tbl1.StreamPageResponse
}

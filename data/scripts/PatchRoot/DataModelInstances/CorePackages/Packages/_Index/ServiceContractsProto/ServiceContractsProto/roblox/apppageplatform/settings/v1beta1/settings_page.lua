-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local struct = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.struct)

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local config_driven_form_data = require(script.Parent.Parent.Parent.shared.v1beta1.config_driven_form_data)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local SettingsPageRequest = {}
SettingsPageRequest.__index = SettingsPageRequest

function SettingsPageRequest.new(tbl3)
    return (setmetatable({
        session_id = if tbl3 == nil or tbl3.session_id == nil then "" else tbl3.session_id,
        cached_roblox_component_to_template_id = (tbl3 == nil or tbl3.cached_roblox_component_to_template_id == nil) and {}
            or tbl3.cached_roblox_component_to_template_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }, SettingsPageRequest))
end

function SettingsPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.session_id ~= nil and self.session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.session_id)
    end

    if self.cached_roblox_component_to_template_id ~= nil and next(self.cached_roblox_component_to_template_id) ~= nil then
        for value, value2 in self.cached_roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SettingsPageRequest.decode(buf1: buffer)
    local var1 = SettingsPageRequest.new()
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

                local var5 = tbl1.SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(var4)

                var1.cached_roblox_component_to_template_id[var5.key or ""] = var5.value or ""
            elseif var2 == 3 then
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

function SettingsPageRequest:jsonEncode()
    local result = {}

    if self.session_id ~= nil and self.session_id ~= "" then
        result.sessionId = self.session_id
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

function SettingsPageRequest:jsonDecode()
    local var1 = SettingsPageRequest.new()

    if self.session_id ~= nil then
        var1.session_id = self.session_id
    end

    if self.sessionId ~= nil then
        var1.session_id = self.sessionId
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

SettingsPageRequest.descriptor = {
    name = "SettingsPageRequest",
    fullName = "roblox.apppageplatform.settings.v1beta1.SettingsPageRequest"
}

tbl1.SettingsPageRequest = SettingsPageRequest

typeRegistry.default:register(tbl1.SettingsPageRequest)

local SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry = {}
SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.__index = SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry

function SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry))
end

function SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry:encode(): buffer
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

function SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.new()
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

function SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry.descriptor = {
    name = "SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.settings.v1beta1.CachedRobloxComponentToTemplateIdEntry"
}

tbl1.SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry = SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.SettingsPageRequest_CachedRobloxComponentToTemplateIdEntry)

local SettingsPageResponse = {}
SettingsPageResponse.__index = SettingsPageResponse

function SettingsPageResponse.new(tbl5)
    return (setmetatable({
        page_entries = (tbl5 == nil or tbl5.page_entries == nil) and {} or tbl5.page_entries,
        hydration_data = if tbl5 == nil or tbl5.hydration_data == nil then nil else tbl5.hydration_data,
        templates = (tbl5 == nil or tbl5.templates == nil) and {} or tbl5.templates,
        localized_literals = (tbl5 == nil or tbl5.localized_literals == nil) and {} or tbl5.localized_literals
    }, SettingsPageResponse))
end

function SettingsPageResponse:encode(): buffer
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

function SettingsPageResponse.decode(buf1: buffer)
    local var1 = SettingsPageResponse.new()
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

                local var5 = tbl1.SettingsPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.SettingsPageResponse_LocalizedLiteralsEntry.decode(var4)

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

function SettingsPageResponse:jsonEncode()
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

function SettingsPageResponse:jsonDecode()
    local var1 = SettingsPageResponse.new()

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

SettingsPageResponse.descriptor = {
    name = "SettingsPageResponse",
    fullName = "roblox.apppageplatform.settings.v1beta1.SettingsPageResponse"
}

tbl1.SettingsPageResponse = SettingsPageResponse

typeRegistry.default:register(tbl1.SettingsPageResponse)

local SettingsPageResponse_TemplatesEntry = {}
SettingsPageResponse_TemplatesEntry.__index = SettingsPageResponse_TemplatesEntry

function SettingsPageResponse_TemplatesEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then nil else tbl6.value
    }, SettingsPageResponse_TemplatesEntry))
end

function SettingsPageResponse_TemplatesEntry:encode(): buffer
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

function SettingsPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = SettingsPageResponse_TemplatesEntry.new()
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

function SettingsPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function SettingsPageResponse_TemplatesEntry:jsonDecode()
    local var1 = SettingsPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

SettingsPageResponse_TemplatesEntry.descriptor = {
    name = "SettingsPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.settings.v1beta1.TemplatesEntry"
}

tbl1.SettingsPageResponse_TemplatesEntry = SettingsPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.SettingsPageResponse_TemplatesEntry)

local SettingsPageResponse_LocalizedLiteralsEntry = {}
SettingsPageResponse_LocalizedLiteralsEntry.__index = SettingsPageResponse_LocalizedLiteralsEntry

function SettingsPageResponse_LocalizedLiteralsEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then "" else tbl7.value
    }, SettingsPageResponse_LocalizedLiteralsEntry))
end

function SettingsPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function SettingsPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = SettingsPageResponse_LocalizedLiteralsEntry.new()
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

function SettingsPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function SettingsPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = SettingsPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

SettingsPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "SettingsPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.settings.v1beta1.LocalizedLiteralsEntry"
}

tbl1.SettingsPageResponse_LocalizedLiteralsEntry = SettingsPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.SettingsPageResponse_LocalizedLiteralsEntry)

local FormAction = {}
FormAction.__index = FormAction

function FormAction.new(tbl8)
    return (setmetatable({
        name = if tbl8 == nil or tbl8.name == nil then "" else tbl8.name,
        parameters = if tbl8 == nil or tbl8.parameters == nil then nil else tbl8.parameters
    }, FormAction))
end

function FormAction:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.parameters ~= nil then
        local buf = self.parameters:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FormAction.decode(buf1: buffer)
    local var1 = FormAction.new()
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
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.parameters = struct.Struct.decode(var4)
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

function FormAction:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.parameters ~= nil then
        result.parameters = self.parameters:jsonEncode()
    end

    return result
end

function FormAction:jsonDecode()
    local var1 = FormAction.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.parameters ~= nil then
        var1.parameters = struct.Struct.jsonDecode(self.parameters)
    end

    return var1
end

FormAction.descriptor = {
    name = "FormAction",
    fullName = "roblox.apppageplatform.settings.v1beta1.FormAction"
}

tbl1.FormAction = FormAction

typeRegistry.default:register(tbl1.FormAction)

local SaveSettingsFormRequest = {}
SaveSettingsFormRequest.__index = SaveSettingsFormRequest

function SaveSettingsFormRequest.new(tbl9)
    return (setmetatable(
        {
            operation = if tbl9 == nil or tbl9.operation == nil then nil else tbl9.operation
        },
        SaveSettingsFormRequest
    ))
end

function SaveSettingsFormRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.operation ~= nil then
        if self.operation.type == "diff" then
            local buf = self.operation.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.operation.type == "action" then
            local buf = self.operation.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SaveSettingsFormRequest.decode(buf1: buffer)
    local var1 = SaveSettingsFormRequest.new()
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
                var1.operation = {
                    type = "diff",
                    value = struct.Struct.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.operation = {
                    type = "action",
                    value = tbl1.FormAction.decode(var4)
                }
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

function SaveSettingsFormRequest:jsonEncode()
    local result = {}

    if self.operation ~= nil then
        if self.operation.type == "diff" then
            result.diff = self.operation.value:jsonEncode()
            return result
        end

        if self.operation.type == "action" then
            result.action = self.operation.value:jsonEncode()
        end
    end

    return result
end

function SaveSettingsFormRequest.jsonDecode(tbl9)
    local var1 = SaveSettingsFormRequest.new()

    if tbl9.diff ~= nil then
        var1.operation = {
            type = "diff",
            value = struct.Struct.jsonDecode(tbl9.diff)
        }
    end
    if tbl9.action ~= nil then
        var1.operation = {
            type = "action",
            value = tbl1.FormAction.jsonDecode(tbl9.action)
        }
    end
    return var1
end

SaveSettingsFormRequest.descriptor = {
    name = "SaveSettingsFormRequest",
    fullName = "roblox.apppageplatform.settings.v1beta1.SaveSettingsFormRequest"
}

tbl1.SaveSettingsFormRequest = SaveSettingsFormRequest

typeRegistry.default:register(tbl1.SaveSettingsFormRequest)

local FormWriteError = {}
FormWriteError.__index = FormWriteError

function FormWriteError.new(tbl10)
    return (setmetatable({
        name = if tbl10 == nil or tbl10.name == nil then "" else tbl10.name,
        status = if tbl10 == nil or tbl10.status == nil then 0 else tbl10.status,
        message = if tbl10 == nil or tbl10.message == nil then "" else tbl10.message
    }, FormWriteError))
end

function FormWriteError:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.status ~= nil and self.status ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.status)
    end

    if self.message ~= nil and self.message ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.message)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FormWriteError.decode(buf1: buffer)
    local var1 = FormWriteError.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.status = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.message = buffer.tostring(buf)
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

function FormWriteError:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.status ~= nil and self.status ~= 0 then
        result.status = self.status
    end

    if self.message ~= nil and self.message ~= "" then
        result.message = self.message
    end

    return result
end

function FormWriteError:jsonDecode()
    local var1 = FormWriteError.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.status ~= nil then
        var1.status = self.status
    end

    if self.message ~= nil then
        var1.message = self.message
    end

    return var1
end

FormWriteError.descriptor = {
    name = "FormWriteError",
    fullName = "roblox.apppageplatform.settings.v1beta1.FormWriteError"
}

tbl1.FormWriteError = FormWriteError

typeRegistry.default:register(tbl1.FormWriteError)

local SaveSettingsFormResponse = {}
SaveSettingsFormResponse.__index = SaveSettingsFormResponse

function SaveSettingsFormResponse.new(tbl11)
    return (setmetatable({
        refreshed_data = if tbl11 == nil or tbl11.refreshed_data == nil then nil else tbl11.refreshed_data,
        committed_groups = (tbl11 == nil or tbl11.committed_groups == nil) and {} or tbl11.committed_groups,
        write_errors = (tbl11 == nil or tbl11.write_errors == nil) and {} or tbl11.write_errors
    }, SaveSettingsFormResponse))
end

function SaveSettingsFormResponse:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.refreshed_data ~= nil then
        local buf = self.refreshed_data:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.committed_groups ~= nil and #self.committed_groups > 0 then
        for _, committedGroup in self.committed_groups do
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, committedGroup)
        end
    end

    if self.write_errors ~= nil and #self.write_errors > 0 then
        for _, writeError in self.write_errors do
            local buf = writeError:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SaveSettingsFormResponse.decode(buf1: buffer)
    local var1 = SaveSettingsFormResponse.new()
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
                var1.refreshed_data = config_driven_form_data.ConfigDrivenFormInputData.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.committed_groups, buffer.tostring(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.write_errors, tbl1.FormWriteError.decode(var4))
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

function SaveSettingsFormResponse:jsonEncode()
    local result = {}

    if self.refreshed_data ~= nil then
        result.refreshedData = self.refreshed_data:jsonEncode()
    end

    if self.committed_groups ~= nil and #self.committed_groups > 0 then
        local committedGroups = {}
        for _, committedGroup in self.committed_groups do
            table.insert(committedGroups, committedGroup)
        end
        result.committedGroups = committedGroups
    end

    if self.write_errors ~= nil and #self.write_errors > 0 then
        local writeErrors = {}
        for _, writeError in self.write_errors do
            table.insert(writeErrors, writeError:jsonEncode())
        end
        result.writeErrors = writeErrors
    end

    return result
end

function SaveSettingsFormResponse:jsonDecode()
    local var1 = SaveSettingsFormResponse.new()

    if self.refreshed_data ~= nil then
        var1.refreshed_data = config_driven_form_data.ConfigDrivenFormInputData.jsonDecode(self.refreshed_data)
    end

    if self.refreshedData ~= nil then
        var1.refreshed_data = config_driven_form_data.ConfigDrivenFormInputData.jsonDecode(self.refreshedData)
    end

    if self.committed_groups ~= nil then
        local committedGroups = {}
        for _, committedGroup in self.committed_groups do
            table.insert(committedGroups, committedGroup)
        end

        var1.committed_groups = committedGroups
    end

    if self.committedGroups ~= nil then
        local committedGroups = {}
        for _, committedGroup in self.committedGroups do
            table.insert(committedGroups, committedGroup)
        end

        var1.committed_groups = committedGroups
    end

    if self.write_errors ~= nil then
        local writeErrors = {}
        for _, writeError in self.write_errors do
            table.insert(writeErrors, tbl1.FormWriteError.jsonDecode(writeError))
        end

        var1.write_errors = writeErrors
    end

    if self.writeErrors ~= nil then
        local writeErrors = {}
        for _, writeError in self.writeErrors do
            table.insert(writeErrors, tbl1.FormWriteError.jsonDecode(writeError))
        end

        var1.write_errors = writeErrors
    end

    return var1
end

SaveSettingsFormResponse.descriptor = {
    name = "SaveSettingsFormResponse",
    fullName = "roblox.apppageplatform.settings.v1beta1.SaveSettingsFormResponse"
}

tbl1.SaveSettingsFormResponse = SaveSettingsFormResponse

typeRegistry.default:register(tbl1.SaveSettingsFormResponse)

return {
    SettingsPageRequest = tbl1.SettingsPageRequest,
    SettingsPageResponse = tbl1.SettingsPageResponse,
    FormAction = tbl1.FormAction,
    SaveSettingsFormRequest = tbl1.SaveSettingsFormRequest,
    FormWriteError = tbl1.FormWriteError,
    SaveSettingsFormResponse = tbl1.SaveSettingsFormResponse
}

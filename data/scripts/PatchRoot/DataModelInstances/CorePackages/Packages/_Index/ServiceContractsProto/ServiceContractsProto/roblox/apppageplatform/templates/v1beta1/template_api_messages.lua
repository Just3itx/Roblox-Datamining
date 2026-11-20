-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local display_location = require(script.Parent.Parent.Parent.shared.v1beta1.display_location)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local DisplayLocationTemplateMapping = {}
DisplayLocationTemplateMapping.__index = DisplayLocationTemplateMapping

function DisplayLocationTemplateMapping.new(tbl3)
    local tbl4 = {
        display_location = if tbl3 == nil or tbl3.display_location == nil then assert(display_location.DisplayLocation.fromNumber(0), "Enum has no 0 default") else tbl3.display_location,
        roblox_component_to_template_id = (tbl3 == nil or tbl3.roblox_component_to_template_id == nil) and {} or tbl3.roblox_component_to_template_id
    }
    return (setmetatable(tbl4, DisplayLocationTemplateMapping))
end

function DisplayLocationTemplateMapping:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.display_location ~= nil
        and (self.display_location ~= nil and self.display_location ~= 0
            or self.display_location ~= display_location.DisplayLocation.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, display_location.DisplayLocation.toNumber(self.display_location))
    end

    if self.roblox_component_to_template_id ~= nil and next(self.roblox_component_to_template_id) ~= nil then
        for value, value2 in self.roblox_component_to_template_id do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function DisplayLocationTemplateMapping.decode(buf1: buffer)
    local var1 = DisplayLocationTemplateMapping.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.display_location = display_location.DisplayLocation.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.decode(var4)

                var1.roblox_component_to_template_id[var5.key or ""] = var5.value or ""
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

function DisplayLocationTemplateMapping:jsonEncode()
    local result = {}

    if self.display_location ~= nil
        and (self.display_location ~= nil and self.display_location ~= 0
            or self.display_location ~= display_location.DisplayLocation.fromNumber(0))
    then
        result.displayLocation = if typeof(self.display_location) == "number" then self.display_location else display_location.DisplayLocation.toNumber(self.display_location)
    end

    if self.roblox_component_to_template_id ~= nil and next(self.roblox_component_to_template_id) ~= nil then
        local robloxComponentToTemplateId = ({})
        for value, value2 in self.roblox_component_to_template_id do
            robloxComponentToTemplateId[value] = value2
        end
        result.robloxComponentToTemplateId = robloxComponentToTemplateId
    end

    return result
end

function DisplayLocationTemplateMapping:jsonDecode()
    local var1 = DisplayLocationTemplateMapping.new()

    if self.display_location ~= nil then
        var1.display_location = if typeof(self.display_location) == "number" then display_location.DisplayLocation.fromNumber(self.display_location) or self.display_location else display_location.DisplayLocation.fromName(self.display_location) or self.display_location
    end

    if self.displayLocation ~= nil then
        var1.display_location = if typeof(self.displayLocation) == "number" then display_location.DisplayLocation.fromNumber(self.displayLocation) or self.displayLocation else display_location.DisplayLocation.fromName(self.displayLocation) or self.displayLocation
    end

    if self.roblox_component_to_template_id ~= nil then
        local robloxComponentToTemplateId = ({})
        for value, value2 in self.roblox_component_to_template_id do
            robloxComponentToTemplateId[value] = value2
        end

        var1.roblox_component_to_template_id = robloxComponentToTemplateId
    end

    if self.robloxComponentToTemplateId ~= nil then
        local robloxComponentToTemplateId = ({})
        for value, value2 in self.robloxComponentToTemplateId do
            robloxComponentToTemplateId[value] = value2
        end

        var1.roblox_component_to_template_id = robloxComponentToTemplateId
    end

    return var1
end

DisplayLocationTemplateMapping.descriptor = {
    name = "DisplayLocationTemplateMapping",
    fullName = "roblox.apppageplatform.templates.v1beta1.DisplayLocationTemplateMapping"
}

tbl1.DisplayLocationTemplateMapping = DisplayLocationTemplateMapping

typeRegistry.default:register(tbl1.DisplayLocationTemplateMapping)

local DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry = {}
DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.__index = DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry

function DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry))
end

function DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry:encode(): buffer
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

function DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.decode(buf1: buffer)
    local var1 = DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.new()
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

function DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry:jsonDecode()
    local var1 = DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry.descriptor = {
    name = "DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry",
    fullName = "roblox.apppageplatform.templates.v1beta1.RobloxComponentToTemplateIdEntry"
}

tbl1.DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry = DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry

typeRegistry.default:register(tbl1.DisplayLocationTemplateMapping_RobloxComponentToTemplateIdEntry)

local GetTemplatesRequest = {}
GetTemplatesRequest.__index = GetTemplatesRequest

function GetTemplatesRequest.new(tbl5)
    return (setmetatable({
        display_locations = (tbl5 == nil or tbl5.display_locations == nil) and {} or tbl5.display_locations,
        client_capabilities = if tbl5 == nil or tbl5.client_capabilities == nil then nil else tbl5.client_capabilities,
        cached_component_mappings = (tbl5 == nil or tbl5.cached_component_mappings == nil) and {} or tbl5.cached_component_mappings,
        locale = if tbl5 == nil or tbl5.locale == nil then "" else tbl5.locale
    }, GetTemplatesRequest))
end

function GetTemplatesRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.display_locations ~= nil and #self.display_locations > 0 then
        for _, displayLocation in self.display_locations do
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, display_location.DisplayLocation.toNumber(displayLocation))
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.cached_component_mappings ~= nil and #self.cached_component_mappings > 0 then
        for _, cachedComponentMapping in self.cached_component_mappings do
            local buf = cachedComponentMapping:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.locale ~= nil and self.locale ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.locale)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetTemplatesRequest.decode(buf1: buffer)
    local var1 = GetTemplatesRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                table.insert(var1.display_locations, display_location.DisplayLocation.fromNumber(var4) or var4)
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.cached_component_mappings, tbl1.DisplayLocationTemplateMapping.decode(var4))
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.locale = buffer.tostring(buf)
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

function GetTemplatesRequest:jsonEncode()
    local result = {}

    if self.display_locations ~= nil and #self.display_locations > 0 then
        local displayLocations = {}
        for _, displayLocation in self.display_locations do
            if typeof(displayLocation) ~= "number" then
                displayLocation = display_location.DisplayLocation.toNumber(displayLocation)
            end

            table.insert(displayLocations, displayLocation)
        end

        result.displayLocations = displayLocations
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    if self.cached_component_mappings ~= nil and #self.cached_component_mappings > 0 then
        local cachedComponentMappings = {}
        for _, cachedComponentMapping in self.cached_component_mappings do
            table.insert(cachedComponentMappings, cachedComponentMapping:jsonEncode())
        end
        result.cachedComponentMappings = cachedComponentMappings
    end

    if self.locale ~= nil and self.locale ~= "" then
        result.locale = self.locale
    end

    return result
end

function GetTemplatesRequest:jsonDecode()
    local var1 = GetTemplatesRequest.new()

    if self.display_locations ~= nil then
        local displayLocations = {}
        for _, displayLocation in self.display_locations do
            table.insert(
                displayLocations,
                if typeof(displayLocation) == "number" then display_location.DisplayLocation.fromNumber(displayLocation) or displayLocation else display_location.DisplayLocation.fromName(displayLocation) or displayLocation
            )
        end

        var1.display_locations = displayLocations
    end

    if self.displayLocations ~= nil then
        local displayLocations = {}
        for _, displayLocation in self.displayLocations do
            table.insert(
                displayLocations,
                if typeof(displayLocation) == "number" then display_location.DisplayLocation.fromNumber(displayLocation) or displayLocation else display_location.DisplayLocation.fromName(displayLocation) or displayLocation
            )
        end

        var1.display_locations = displayLocations
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    if self.cached_component_mappings ~= nil then
        local cachedComponentMappings = {}
        for _, cachedComponentMapping in self.cached_component_mappings do
            table.insert(cachedComponentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(cachedComponentMapping))
        end

        var1.cached_component_mappings = cachedComponentMappings
    end

    if self.cachedComponentMappings ~= nil then
        local cachedComponentMappings = {}
        for _, cachedComponentMapping in self.cachedComponentMappings do
            table.insert(cachedComponentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(cachedComponentMapping))
        end

        var1.cached_component_mappings = cachedComponentMappings
    end

    if self.locale ~= nil then
        var1.locale = self.locale
    end

    return var1
end

GetTemplatesRequest.descriptor = {
    name = "GetTemplatesRequest",
    fullName = "roblox.apppageplatform.templates.v1beta1.GetTemplatesRequest"
}

tbl1.GetTemplatesRequest = GetTemplatesRequest

typeRegistry.default:register(tbl1.GetTemplatesRequest)

local GetTemplatesResponse = {}
GetTemplatesResponse.__index = GetTemplatesResponse

function GetTemplatesResponse.new(tbl6)
    return (setmetatable({
        templates = (tbl6 == nil or tbl6.templates == nil) and {} or tbl6.templates,
        component_mappings = (tbl6 == nil or tbl6.component_mappings == nil) and {} or tbl6.component_mappings,
        valid_cached_component_mappings = (tbl6 == nil or tbl6.valid_cached_component_mappings == nil) and {} or tbl6.valid_cached_component_mappings,
        localized_literals = (tbl6 == nil or tbl6.localized_literals == nil) and {} or tbl6.localized_literals
    }, GetTemplatesResponse))
end

function GetTemplatesResponse:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.templates ~= nil and next(self.templates) ~= nil then
        for value, value2 in self.templates do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.component_mappings ~= nil and #self.component_mappings > 0 then
        for _, componentMapping in self.component_mappings do
            local buf = componentMapping:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.valid_cached_component_mappings ~= nil and #self.valid_cached_component_mappings > 0 then
        for _, validCachedComponentMapping in self.valid_cached_component_mappings do
            local buf = validCachedComponentMapping:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
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

function GetTemplatesResponse.decode(buf1: buffer)
    local var1 = GetTemplatesResponse.new()
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

                local var5 = tbl1.GetTemplatesResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.component_mappings, tbl1.DisplayLocationTemplateMapping.decode(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.valid_cached_component_mappings, tbl1.DisplayLocationTemplateMapping.decode(var4))
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetTemplatesResponse_LocalizedLiteralsEntry.decode(var4)

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

function GetTemplatesResponse:jsonEncode()
    local result = {}

    if self.templates ~= nil and next(self.templates) ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = value2:jsonEncode()
        end
        result.templates = templates
    end

    if self.component_mappings ~= nil and #self.component_mappings > 0 then
        local componentMappings = {}
        for _, componentMapping in self.component_mappings do
            table.insert(componentMappings, componentMapping:jsonEncode())
        end
        result.componentMappings = componentMappings
    end

    if self.valid_cached_component_mappings ~= nil and #self.valid_cached_component_mappings > 0 then
        local validCachedComponentMappings = {}
        for _, validCachedComponentMapping in self.valid_cached_component_mappings do
            table.insert(validCachedComponentMappings, validCachedComponentMapping:jsonEncode())
        end
        result.validCachedComponentMappings = validCachedComponentMappings
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

function GetTemplatesResponse:jsonDecode()
    local var1 = GetTemplatesResponse.new()

    if self.templates ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = template_entry.TemplateEntry.jsonDecode(value2)
        end

        var1.templates = templates
    end

    if self.component_mappings ~= nil then
        local componentMappings = {}
        for _, componentMapping in self.component_mappings do
            table.insert(componentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(componentMapping))
        end

        var1.component_mappings = componentMappings
    end

    if self.componentMappings ~= nil then
        local componentMappings = {}
        for _, componentMapping in self.componentMappings do
            table.insert(componentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(componentMapping))
        end

        var1.component_mappings = componentMappings
    end

    if self.valid_cached_component_mappings ~= nil then
        local validCachedComponentMappings = {}
        for _, validCachedComponentMapping in self.valid_cached_component_mappings do
            table.insert(validCachedComponentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(validCachedComponentMapping))
        end

        var1.valid_cached_component_mappings = validCachedComponentMappings
    end

    if self.validCachedComponentMappings ~= nil then
        local validCachedComponentMappings = {}
        for _, validCachedComponentMapping in self.validCachedComponentMappings do
            table.insert(validCachedComponentMappings, tbl1.DisplayLocationTemplateMapping.jsonDecode(validCachedComponentMapping))
        end

        var1.valid_cached_component_mappings = validCachedComponentMappings
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

GetTemplatesResponse.descriptor = {
    name = "GetTemplatesResponse",
    fullName = "roblox.apppageplatform.templates.v1beta1.GetTemplatesResponse"
}

tbl1.GetTemplatesResponse = GetTemplatesResponse

typeRegistry.default:register(tbl1.GetTemplatesResponse)

local GetTemplatesResponse_TemplatesEntry = {}
GetTemplatesResponse_TemplatesEntry.__index = GetTemplatesResponse_TemplatesEntry

function GetTemplatesResponse_TemplatesEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then nil else tbl7.value
    }, GetTemplatesResponse_TemplatesEntry))
end

function GetTemplatesResponse_TemplatesEntry:encode(): buffer
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

function GetTemplatesResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GetTemplatesResponse_TemplatesEntry.new()
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

function GetTemplatesResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetTemplatesResponse_TemplatesEntry:jsonDecode()
    local var1 = GetTemplatesResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GetTemplatesResponse_TemplatesEntry.descriptor = {
    name = "GetTemplatesResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.templates.v1beta1.TemplatesEntry"
}

tbl1.GetTemplatesResponse_TemplatesEntry = GetTemplatesResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GetTemplatesResponse_TemplatesEntry)

local GetTemplatesResponse_LocalizedLiteralsEntry = {}
GetTemplatesResponse_LocalizedLiteralsEntry.__index = GetTemplatesResponse_LocalizedLiteralsEntry

function GetTemplatesResponse_LocalizedLiteralsEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then "" else tbl8.value
    }, GetTemplatesResponse_LocalizedLiteralsEntry))
end

function GetTemplatesResponse_LocalizedLiteralsEntry:encode(): buffer
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

function GetTemplatesResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GetTemplatesResponse_LocalizedLiteralsEntry.new()
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

function GetTemplatesResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetTemplatesResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GetTemplatesResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetTemplatesResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GetTemplatesResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.templates.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GetTemplatesResponse_LocalizedLiteralsEntry = GetTemplatesResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GetTemplatesResponse_LocalizedLiteralsEntry)

return {
    DisplayLocationTemplateMapping = tbl1.DisplayLocationTemplateMapping,
    GetTemplatesRequest = tbl1.GetTemplatesRequest,
    GetTemplatesResponse = tbl1.GetTemplatesResponse
}

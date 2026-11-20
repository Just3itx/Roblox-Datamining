-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)
local page_entry = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local BadgeDetailsPageRequest = {}
BadgeDetailsPageRequest.__index = BadgeDetailsPageRequest

function BadgeDetailsPageRequest.new(tbl3)
    local tbl4 = {
        badge_id = if tbl3 == nil or tbl3.badge_id == nil then 0 else tbl3.badge_id,
        user_id = if tbl3 == nil or tbl3.user_id == nil then 0 else tbl3.user_id,
        page_entry_format = if tbl3 == nil or tbl3.page_entry_format == nil then assert(page_entry_content.PageEntryFormat.fromNumber(0), "Enum has no 0 default") else tbl3.page_entry_format,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }
    return (setmetatable(tbl4, BadgeDetailsPageRequest))
end

function BadgeDetailsPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.badge_id ~= nil and self.badge_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.badge_id)
    end

    if self.user_id ~= nil and self.user_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.user_id)
    end

    if self.page_entry_format ~= nil
        and (self.page_entry_format ~= nil and self.page_entry_format ~= 0
            or self.page_entry_format ~= page_entry_content.PageEntryFormat.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, page_entry_content.PageEntryFormat.toNumber(self.page_entry_format))
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsPageRequest.decode(buf1: buffer)
    local var1 = BadgeDetailsPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.badge_id = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.user_id = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_entry_format = page_entry_content.PageEntryFormat.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 4 then
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

function BadgeDetailsPageRequest:jsonEncode()
    local result = {}

    if self.badge_id ~= nil and self.badge_id ~= 0 then
        result.badgeId = self.badge_id
    end

    if self.user_id ~= nil and self.user_id ~= 0 then
        result.userId = self.user_id
    end

    if self.page_entry_format ~= nil
        and (self.page_entry_format ~= nil and self.page_entry_format ~= 0
            or self.page_entry_format ~= page_entry_content.PageEntryFormat.fromNumber(0))
    then
        result.pageEntryFormat = if typeof(self.page_entry_format) == "number" then self.page_entry_format else page_entry_content.PageEntryFormat.toNumber(self.page_entry_format)
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    return result
end

function BadgeDetailsPageRequest:jsonDecode()
    local var1 = BadgeDetailsPageRequest.new()

    if self.badge_id ~= nil then
        var1.badge_id = self.badge_id
    end

    if self.badgeId ~= nil then
        var1.badge_id = self.badgeId
    end

    if self.user_id ~= nil then
        var1.user_id = self.user_id
    end

    if self.userId ~= nil then
        var1.user_id = self.userId
    end

    if self.page_entry_format ~= nil then
        var1.page_entry_format = if typeof(self.page_entry_format) == "number" then page_entry_content.PageEntryFormat.fromNumber(self.page_entry_format) or self.page_entry_format else page_entry_content.PageEntryFormat.fromName(self.page_entry_format) or self.page_entry_format
    end

    if self.pageEntryFormat ~= nil then
        var1.page_entry_format = if typeof(self.pageEntryFormat) == "number" then page_entry_content.PageEntryFormat.fromNumber(self.pageEntryFormat) or self.pageEntryFormat else page_entry_content.PageEntryFormat.fromName(self.pageEntryFormat) or self.pageEntryFormat
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    return var1
end

BadgeDetailsPageRequest.descriptor = {
    name = "BadgeDetailsPageRequest",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeDetailsPageRequest"
}

tbl1.BadgeDetailsPageRequest = BadgeDetailsPageRequest

typeRegistry.default:register(tbl1.BadgeDetailsPageRequest)

local BadgeDetailsPageResponse = {}
BadgeDetailsPageResponse.__index = BadgeDetailsPageResponse

function BadgeDetailsPageResponse.new(tbl4)
    return (setmetatable({
        page_entries = (tbl4 == nil or tbl4.page_entries == nil) and {} or tbl4.page_entries,
        hydration_data = if tbl4 == nil or tbl4.hydration_data == nil then nil else tbl4.hydration_data,
        templates = (tbl4 == nil or tbl4.templates == nil) and {} or tbl4.templates
    }, BadgeDetailsPageResponse))
end

function BadgeDetailsPageResponse:encode(): buffer
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

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsPageResponse.decode(buf1: buffer)
    local var1 = BadgeDetailsPageResponse.new()
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
                table.insert(var1.page_entries, tbl1.BadgeDetailsPageEntry.decode(var4))
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.hydration_data = hydration_content.HydrationContent.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.BadgeDetailsPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
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

function BadgeDetailsPageResponse:jsonEncode()
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

    return result
end

function BadgeDetailsPageResponse:jsonDecode()
    local var1 = BadgeDetailsPageResponse.new()

    if self.page_entries ~= nil then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, tbl1.BadgeDetailsPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.pageEntries ~= nil then
        local pageEntries = {}
        for _, value in self.pageEntries do
            table.insert(pageEntries, tbl1.BadgeDetailsPageEntry.jsonDecode(value))
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

    return var1
end

BadgeDetailsPageResponse.descriptor = {
    name = "BadgeDetailsPageResponse",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeDetailsPageResponse"
}

tbl1.BadgeDetailsPageResponse = BadgeDetailsPageResponse

typeRegistry.default:register(tbl1.BadgeDetailsPageResponse)

local BadgeDetailsPageResponse_TemplatesEntry = {}
BadgeDetailsPageResponse_TemplatesEntry.__index = BadgeDetailsPageResponse_TemplatesEntry

function BadgeDetailsPageResponse_TemplatesEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then nil else tbl5.value
    }, BadgeDetailsPageResponse_TemplatesEntry))
end

function BadgeDetailsPageResponse_TemplatesEntry:encode(): buffer
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

function BadgeDetailsPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = BadgeDetailsPageResponse_TemplatesEntry.new()
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

function BadgeDetailsPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function BadgeDetailsPageResponse_TemplatesEntry:jsonDecode()
    local var1 = BadgeDetailsPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

BadgeDetailsPageResponse_TemplatesEntry.descriptor = {
    name = "BadgeDetailsPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.TemplatesEntry"
}

tbl1.BadgeDetailsPageResponse_TemplatesEntry = BadgeDetailsPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.BadgeDetailsPageResponse_TemplatesEntry)

local BadgeDetailsPageV2Response = {}
BadgeDetailsPageV2Response.__index = BadgeDetailsPageV2Response

function BadgeDetailsPageV2Response.new(tbl6)
    return (setmetatable({
        page_entries = (tbl6 == nil or tbl6.page_entries == nil) and {} or tbl6.page_entries,
        hydration_data = if tbl6 == nil or tbl6.hydration_data == nil then nil else tbl6.hydration_data,
        templates = (tbl6 == nil or tbl6.templates == nil) and {} or tbl6.templates
    }, BadgeDetailsPageV2Response))
end

function BadgeDetailsPageV2Response:encode(): buffer
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

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsPageV2Response.decode(buf1: buffer)
    local var1 = BadgeDetailsPageV2Response.new()
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

                local var5 = tbl1.BadgeDetailsPageV2Response_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
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

function BadgeDetailsPageV2Response:jsonEncode()
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

    return result
end

function BadgeDetailsPageV2Response:jsonDecode()
    local var1 = BadgeDetailsPageV2Response.new()

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

    return var1
end

BadgeDetailsPageV2Response.descriptor = {
    name = "BadgeDetailsPageV2Response",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeDetailsPageV2Response"
}

tbl1.BadgeDetailsPageV2Response = BadgeDetailsPageV2Response

typeRegistry.default:register(tbl1.BadgeDetailsPageV2Response)

local BadgeDetailsPageV2Response_TemplatesEntry = {}
BadgeDetailsPageV2Response_TemplatesEntry.__index = BadgeDetailsPageV2Response_TemplatesEntry

function BadgeDetailsPageV2Response_TemplatesEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then nil else tbl7.value
    }, BadgeDetailsPageV2Response_TemplatesEntry))
end

function BadgeDetailsPageV2Response_TemplatesEntry:encode(): buffer
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

function BadgeDetailsPageV2Response_TemplatesEntry.decode(buf1: buffer)
    local var1 = BadgeDetailsPageV2Response_TemplatesEntry.new()
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

function BadgeDetailsPageV2Response_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function BadgeDetailsPageV2Response_TemplatesEntry:jsonDecode()
    local var1 = BadgeDetailsPageV2Response_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

BadgeDetailsPageV2Response_TemplatesEntry.descriptor = {
    name = "BadgeDetailsPageV2Response_TemplatesEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.TemplatesEntry"
}

tbl1.BadgeDetailsPageV2Response_TemplatesEntry = BadgeDetailsPageV2Response_TemplatesEntry

typeRegistry.default:register(tbl1.BadgeDetailsPageV2Response_TemplatesEntry)

local BadgeDetailsPageEntry = {}
BadgeDetailsPageEntry.__index = BadgeDetailsPageEntry

function BadgeDetailsPageEntry.new(tbl8)
    return (setmetatable({
        page_entry = if tbl8 == nil or tbl8.page_entry == nil then nil else tbl8.page_entry,
        kind = if tbl8 == nil or tbl8.kind == nil then nil else tbl8.kind
    }, BadgeDetailsPageEntry))
end

function BadgeDetailsPageEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.page_entry ~= nil then
        local buf = self.page_entry:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil and self.kind.type == "badge_details" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsPageEntry.decode(buf1: buffer)
    local var1 = BadgeDetailsPageEntry.new()
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
                var1.page_entry = page_entry.PageEntry.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "badge_details",
                    value = tbl1.BadgeDetailsContent.decode(var4)
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

function BadgeDetailsPageEntry:jsonEncode()
    local result = {}

    if self.page_entry ~= nil then
        result.pageEntry = self.page_entry:jsonEncode()
    end

    if self.kind ~= nil and self.kind.type == "badge_details" then
        result.badgeDetails = self.kind.value:jsonEncode()
    end

    return result
end

function BadgeDetailsPageEntry:jsonDecode()
    local var1 = BadgeDetailsPageEntry.new()

    if self.page_entry ~= nil then
        var1.page_entry = page_entry.PageEntry.jsonDecode(self.page_entry)
    end

    if self.pageEntry ~= nil then
        var1.page_entry = page_entry.PageEntry.jsonDecode(self.pageEntry)
    end

    if self.badge_details ~= nil then
        var1.kind = {
            type = "badge_details",
            value = tbl1.BadgeDetailsContent.jsonDecode(self.badge_details)
        }
    end
    if self.badgeDetails ~= nil then
        var1.kind = {
            type = "badge_details",
            value = tbl1.BadgeDetailsContent.jsonDecode(self.badgeDetails)
        }
    end
    return var1
end

BadgeDetailsPageEntry.descriptor = {
    name = "BadgeDetailsPageEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeDetailsPageEntry"
}

tbl1.BadgeDetailsPageEntry = BadgeDetailsPageEntry

typeRegistry.default:register(tbl1.BadgeDetailsPageEntry)

local BadgeDetailsContent = {}
BadgeDetailsContent.__index = BadgeDetailsContent

function BadgeDetailsContent.new(tbl9)
    return (setmetatable({
        badge_id = if tbl9 == nil or tbl9.badge_id == nil then "" else tbl9.badge_id,
        universe_id = if tbl9 == nil or tbl9.universe_id == nil then "" else tbl9.universe_id,
        localized_literals = if tbl9 == nil or tbl9.localized_literals == nil then nil else tbl9.localized_literals,
        creator_key = if tbl9 == nil or tbl9.creator_key == nil then "" else tbl9.creator_key
    }, BadgeDetailsContent))
end

function BadgeDetailsContent:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.badge_id ~= nil and self.badge_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.badge_id)
    end

    if self.universe_id ~= nil and self.universe_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.universe_id)
    end

    if self.localized_literals ~= nil then
        local buf = self.localized_literals:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.creator_key ~= nil and self.creator_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_key)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsContent.decode(buf1: buffer)
    local var1 = BadgeDetailsContent.new()
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
                var1.badge_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.universe_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.localized_literals = tbl1.BadgeDetailsContent_LocalizedLiterals.decode(var4)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_key = buffer.tostring(buf)
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

function BadgeDetailsContent:jsonEncode()
    local result = {}

    if self.badge_id ~= nil and self.badge_id ~= "" then
        result.badgeId = self.badge_id
    end

    if self.universe_id ~= nil and self.universe_id ~= "" then
        result.universeId = self.universe_id
    end

    if self.localized_literals ~= nil then
        result.localizedLiterals = self.localized_literals:jsonEncode()
    end

    if self.creator_key ~= nil and self.creator_key ~= "" then
        result.creatorKey = self.creator_key
    end

    return result
end

function BadgeDetailsContent:jsonDecode()
    local var1 = BadgeDetailsContent.new()

    if self.badge_id ~= nil then
        var1.badge_id = self.badge_id
    end

    if self.badgeId ~= nil then
        var1.badge_id = self.badgeId
    end

    if self.universe_id ~= nil then
        var1.universe_id = self.universe_id
    end

    if self.universeId ~= nil then
        var1.universe_id = self.universeId
    end

    if self.localized_literals ~= nil then
        var1.localized_literals = tbl1.BadgeDetailsContent_LocalizedLiterals.jsonDecode(self.localized_literals)
    end

    if self.localizedLiterals ~= nil then
        var1.localized_literals = tbl1.BadgeDetailsContent_LocalizedLiterals.jsonDecode(self.localizedLiterals)
    end

    if self.creator_key ~= nil then
        var1.creator_key = self.creator_key
    end

    if self.creatorKey ~= nil then
        var1.creator_key = self.creatorKey
    end

    return var1
end

BadgeDetailsContent.descriptor = {
    name = "BadgeDetailsContent",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeDetailsContent"
}

tbl1.BadgeDetailsContent = BadgeDetailsContent

typeRegistry.default:register(tbl1.BadgeDetailsContent)

local BadgeDetailsContent_LocalizedLiterals = {}
BadgeDetailsContent_LocalizedLiterals.__index = BadgeDetailsContent_LocalizedLiterals

function BadgeDetailsContent_LocalizedLiterals.new(tbl10)
    return (setmetatable({
        info_table = if tbl10 == nil or tbl10.info_table == nil then nil else tbl10.info_table,
        action_module = if tbl10 == nil or tbl10.action_module == nil then nil else tbl10.action_module,
        overflow_menu = if tbl10 == nil or tbl10.overflow_menu == nil then nil else tbl10.overflow_menu
    }, BadgeDetailsContent_LocalizedLiterals))
end

function BadgeDetailsContent_LocalizedLiterals:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.info_table ~= nil then
        local buf = self.info_table:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.action_module ~= nil then
        local buf = self.action_module:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.overflow_menu ~= nil then
        local buf = self.overflow_menu:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsContent_LocalizedLiterals.decode(buf1: buffer)
    local var1 = BadgeDetailsContent_LocalizedLiterals.new()
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
                var1.info_table = tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.action_module = tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.overflow_menu = tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu.decode(var4)
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

function BadgeDetailsContent_LocalizedLiterals:jsonEncode()
    local result = {}

    if self.info_table ~= nil then
        result.infoTable = self.info_table:jsonEncode()
    end

    if self.action_module ~= nil then
        result.actionModule = self.action_module:jsonEncode()
    end

    if self.overflow_menu ~= nil then
        result.overflowMenu = self.overflow_menu:jsonEncode()
    end

    return result
end

function BadgeDetailsContent_LocalizedLiterals:jsonDecode()
    local var1 = BadgeDetailsContent_LocalizedLiterals.new()

    if self.info_table ~= nil then
        var1.info_table = tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable.jsonDecode(self.info_table)
    end

    if self.infoTable ~= nil then
        var1.info_table = tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable.jsonDecode(self.infoTable)
    end

    if self.action_module ~= nil then
        var1.action_module = tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule.jsonDecode(self.action_module)
    end

    if self.actionModule ~= nil then
        var1.action_module = tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule.jsonDecode(self.actionModule)
    end

    if self.overflow_menu ~= nil then
        var1.overflow_menu = tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu.jsonDecode(self.overflow_menu)
    end

    if self.overflowMenu ~= nil then
        var1.overflow_menu = tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu.jsonDecode(self.overflowMenu)
    end

    return var1
end

BadgeDetailsContent_LocalizedLiterals.descriptor = {
    name = "BadgeDetailsContent_LocalizedLiterals",
    fullName = "roblox.apppageplatform.badges.v1beta1.LocalizedLiterals"
}

tbl1.BadgeDetailsContent_LocalizedLiterals = BadgeDetailsContent_LocalizedLiterals

typeRegistry.default:register(tbl1.BadgeDetailsContent_LocalizedLiterals)

local BadgeDetailsContent_LocalizedLiterals_InfoTable = {}
BadgeDetailsContent_LocalizedLiterals_InfoTable.__index = BadgeDetailsContent_LocalizedLiterals_InfoTable

function BadgeDetailsContent_LocalizedLiterals_InfoTable.new(tbl11)
    return (setmetatable({
        type_label = if tbl11 == nil or tbl11.type_label == nil then "" else tbl11.type_label,
        earned_label = if tbl11 == nil or tbl11.earned_label == nil then "" else tbl11.earned_label,
        updated_label = if tbl11 == nil or tbl11.updated_label == nil then "" else tbl11.updated_label,
        experience_label = if tbl11 == nil or tbl11.experience_label == nil then "" else tbl11.experience_label,
        rarity_label = if tbl11 == nil or tbl11.rarity_label == nil then "" else tbl11.rarity_label,
        won_yesterday_label = if tbl11 == nil or tbl11.won_yesterday_label == nil then "" else tbl11.won_yesterday_label,
        won_ever_label = if tbl11 == nil or tbl11.won_ever_label == nil then "" else tbl11.won_ever_label
    }, BadgeDetailsContent_LocalizedLiterals_InfoTable))
end

function BadgeDetailsContent_LocalizedLiterals_InfoTable:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.type_label ~= nil and self.type_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type_label)
    end

    if self.earned_label ~= nil and self.earned_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.earned_label)
    end

    if self.updated_label ~= nil and self.updated_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.updated_label)
    end

    if self.experience_label ~= nil and self.experience_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.experience_label)
    end

    if self.rarity_label ~= nil and self.rarity_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.rarity_label)
    end

    if self.won_yesterday_label ~= nil and self.won_yesterday_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.won_yesterday_label)
    end

    if self.won_ever_label ~= nil and self.won_ever_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.won_ever_label)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsContent_LocalizedLiterals_InfoTable.decode(buf1: buffer)
    local var1 = BadgeDetailsContent_LocalizedLiterals_InfoTable.new()
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
                var1.type_label = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.earned_label = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.updated_label = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.experience_label = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.rarity_label = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.won_yesterday_label = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.won_ever_label = buffer.tostring(buf)
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

function BadgeDetailsContent_LocalizedLiterals_InfoTable:jsonEncode()
    local result = {}

    if self.type_label ~= nil and self.type_label ~= "" then
        result.typeLabel = self.type_label
    end

    if self.earned_label ~= nil and self.earned_label ~= "" then
        result.earnedLabel = self.earned_label
    end

    if self.updated_label ~= nil and self.updated_label ~= "" then
        result.updatedLabel = self.updated_label
    end

    if self.experience_label ~= nil and self.experience_label ~= "" then
        result.experienceLabel = self.experience_label
    end

    if self.rarity_label ~= nil and self.rarity_label ~= "" then
        result.rarityLabel = self.rarity_label
    end

    if self.won_yesterday_label ~= nil and self.won_yesterday_label ~= "" then
        result.wonYesterdayLabel = self.won_yesterday_label
    end

    if self.won_ever_label ~= nil and self.won_ever_label ~= "" then
        result.wonEverLabel = self.won_ever_label
    end

    return result
end

function BadgeDetailsContent_LocalizedLiterals_InfoTable:jsonDecode()
    local var1 = BadgeDetailsContent_LocalizedLiterals_InfoTable.new()

    if self.type_label ~= nil then
        var1.type_label = self.type_label
    end

    if self.typeLabel ~= nil then
        var1.type_label = self.typeLabel
    end

    if self.earned_label ~= nil then
        var1.earned_label = self.earned_label
    end

    if self.earnedLabel ~= nil then
        var1.earned_label = self.earnedLabel
    end

    if self.updated_label ~= nil then
        var1.updated_label = self.updated_label
    end

    if self.updatedLabel ~= nil then
        var1.updated_label = self.updatedLabel
    end

    if self.experience_label ~= nil then
        var1.experience_label = self.experience_label
    end

    if self.experienceLabel ~= nil then
        var1.experience_label = self.experienceLabel
    end

    if self.rarity_label ~= nil then
        var1.rarity_label = self.rarity_label
    end

    if self.rarityLabel ~= nil then
        var1.rarity_label = self.rarityLabel
    end

    if self.won_yesterday_label ~= nil then
        var1.won_yesterday_label = self.won_yesterday_label
    end

    if self.wonYesterdayLabel ~= nil then
        var1.won_yesterday_label = self.wonYesterdayLabel
    end

    if self.won_ever_label ~= nil then
        var1.won_ever_label = self.won_ever_label
    end

    if self.wonEverLabel ~= nil then
        var1.won_ever_label = self.wonEverLabel
    end

    return var1
end

BadgeDetailsContent_LocalizedLiterals_InfoTable.descriptor = {
    name = "BadgeDetailsContent_LocalizedLiterals_InfoTable",
    fullName = "roblox.apppageplatform.badges.v1beta1.InfoTable"
}

tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable = BadgeDetailsContent_LocalizedLiterals_InfoTable

typeRegistry.default:register(tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable)

local BadgeDetailsContent_LocalizedLiterals_ActionModule = {}
BadgeDetailsContent_LocalizedLiterals_ActionModule.__index = BadgeDetailsContent_LocalizedLiterals_ActionModule

function BadgeDetailsContent_LocalizedLiterals_ActionModule.new(tbl12)
    return (setmetatable({
        share = if tbl12 == nil or tbl12.share == nil then "" else tbl12.share,
        report = if tbl12 == nil or tbl12.report == nil then "" else tbl12.report
    }, BadgeDetailsContent_LocalizedLiterals_ActionModule))
end

function BadgeDetailsContent_LocalizedLiterals_ActionModule:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.share ~= nil and self.share ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.share)
    end

    if self.report ~= nil and self.report ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.report)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsContent_LocalizedLiterals_ActionModule.decode(buf1: buffer)
    local var1 = BadgeDetailsContent_LocalizedLiterals_ActionModule.new()
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
                var1.share = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.report = buffer.tostring(buf)
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

function BadgeDetailsContent_LocalizedLiterals_ActionModule:jsonEncode()
    local result = {}

    if self.share ~= nil and self.share ~= "" then
        result.share = self.share
    end

    if self.report ~= nil and self.report ~= "" then
        result.report = self.report
    end

    return result
end

function BadgeDetailsContent_LocalizedLiterals_ActionModule:jsonDecode()
    local var1 = BadgeDetailsContent_LocalizedLiterals_ActionModule.new()

    if self.share ~= nil then
        var1.share = self.share
    end

    if self.report ~= nil then
        var1.report = self.report
    end

    return var1
end

BadgeDetailsContent_LocalizedLiterals_ActionModule.descriptor = {
    name = "BadgeDetailsContent_LocalizedLiterals_ActionModule",
    fullName = "roblox.apppageplatform.badges.v1beta1.ActionModule"
}

tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule = BadgeDetailsContent_LocalizedLiterals_ActionModule

typeRegistry.default:register(tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule)

local BadgeDetailsContent_LocalizedLiterals_OverflowMenu = {}
BadgeDetailsContent_LocalizedLiterals_OverflowMenu.__index = BadgeDetailsContent_LocalizedLiterals_OverflowMenu

function BadgeDetailsContent_LocalizedLiterals_OverflowMenu.new(tbl13)
    return (setmetatable({
        report = if tbl13 == nil or tbl13.report == nil then "" else tbl13.report,
        remove = if tbl13 == nil or tbl13.remove == nil then "" else tbl13.remove
    }, BadgeDetailsContent_LocalizedLiterals_OverflowMenu))
end

function BadgeDetailsContent_LocalizedLiterals_OverflowMenu:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.report ~= nil and self.report ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.report)
    end

    if self.remove ~= nil and self.remove ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.remove)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgeDetailsContent_LocalizedLiterals_OverflowMenu.decode(buf1: buffer)
    local var1 = BadgeDetailsContent_LocalizedLiterals_OverflowMenu.new()
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
                var1.report = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.remove = buffer.tostring(buf)
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

function BadgeDetailsContent_LocalizedLiterals_OverflowMenu:jsonEncode()
    local result = {}

    if self.report ~= nil and self.report ~= "" then
        result.report = self.report
    end

    if self.remove ~= nil and self.remove ~= "" then
        result.remove = self.remove
    end

    return result
end

function BadgeDetailsContent_LocalizedLiterals_OverflowMenu:jsonDecode()
    local var1 = BadgeDetailsContent_LocalizedLiterals_OverflowMenu.new()

    if self.report ~= nil then
        var1.report = self.report
    end

    if self.remove ~= nil then
        var1.remove = self.remove
    end

    return var1
end

BadgeDetailsContent_LocalizedLiterals_OverflowMenu.descriptor = {
    name = "BadgeDetailsContent_LocalizedLiterals_OverflowMenu",
    fullName = "roblox.apppageplatform.badges.v1beta1.OverflowMenu"
}

tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu = BadgeDetailsContent_LocalizedLiterals_OverflowMenu

typeRegistry.default:register(tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu)

return {
    BadgeDetailsPageRequest = tbl1.BadgeDetailsPageRequest,
    BadgeDetailsPageResponse = tbl1.BadgeDetailsPageResponse,
    BadgeDetailsPageV2Response = tbl1.BadgeDetailsPageV2Response,
    BadgeDetailsPageEntry = tbl1.BadgeDetailsPageEntry,
    BadgeDetailsContent = tbl1.BadgeDetailsContent,
    BadgeDetailsContent_LocalizedLiterals = tbl1.BadgeDetailsContent_LocalizedLiterals,
    BadgeDetailsContent_LocalizedLiterals_InfoTable = tbl1.BadgeDetailsContent_LocalizedLiterals_InfoTable,
    BadgeDetailsContent_LocalizedLiterals_ActionModule = tbl1.BadgeDetailsContent_LocalizedLiterals_ActionModule,
    BadgeDetailsContent_LocalizedLiterals_OverflowMenu = tbl1.BadgeDetailsContent_LocalizedLiterals_OverflowMenu
}

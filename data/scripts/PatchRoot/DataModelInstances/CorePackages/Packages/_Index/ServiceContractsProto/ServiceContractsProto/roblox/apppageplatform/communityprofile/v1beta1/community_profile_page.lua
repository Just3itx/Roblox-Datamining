-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local CommunityProfilePageRequest = {}
CommunityProfilePageRequest.__index = CommunityProfilePageRequest

function CommunityProfilePageRequest.new(tbl3)
    return (setmetatable({
        community_id = if tbl3 == nil or tbl3.community_id == nil then "" else tbl3.community_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }, CommunityProfilePageRequest))
end

function CommunityProfilePageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.community_id ~= nil and self.community_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.community_id)
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CommunityProfilePageRequest.decode(buf1: buffer)
    local var1 = CommunityProfilePageRequest.new()
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
                var1.community_id = buffer.tostring(buf)
            elseif var2 == 2 then
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

function CommunityProfilePageRequest:jsonEncode()
    local result = {}

    if self.community_id ~= nil and self.community_id ~= "" then
        result.communityId = self.community_id
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    return result
end

function CommunityProfilePageRequest:jsonDecode()
    local var1 = CommunityProfilePageRequest.new()

    if self.community_id ~= nil then
        var1.community_id = self.community_id
    end

    if self.communityId ~= nil then
        var1.community_id = self.communityId
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    return var1
end

CommunityProfilePageRequest.descriptor = {
    name = "CommunityProfilePageRequest",
    fullName = "roblox.apppageplatform.communityprofile.v1beta1.CommunityProfilePageRequest"
}

tbl1.CommunityProfilePageRequest = CommunityProfilePageRequest

typeRegistry.default:register(tbl1.CommunityProfilePageRequest)

local CommunityProfilePageResponse = {}
CommunityProfilePageResponse.__index = CommunityProfilePageResponse

function CommunityProfilePageResponse.new(tbl4)
    return (setmetatable({
        page_entries = (tbl4 == nil or tbl4.page_entries == nil) and {} or tbl4.page_entries,
        hydration_data = if tbl4 == nil or tbl4.hydration_data == nil then nil else tbl4.hydration_data,
        templates = (tbl4 == nil or tbl4.templates == nil) and {} or tbl4.templates,
        localized_literals = (tbl4 == nil or tbl4.localized_literals == nil) and {} or tbl4.localized_literals
    }, CommunityProfilePageResponse))
end

function CommunityProfilePageResponse:encode(): buffer
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

function CommunityProfilePageResponse.decode(buf1: buffer)
    local var1 = CommunityProfilePageResponse.new()
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

                local var5 = tbl1.CommunityProfilePageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.CommunityProfilePageResponse_LocalizedLiteralsEntry.decode(var4)

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

function CommunityProfilePageResponse:jsonEncode()
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

function CommunityProfilePageResponse:jsonDecode()
    local var1 = CommunityProfilePageResponse.new()

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

CommunityProfilePageResponse.descriptor = {
    name = "CommunityProfilePageResponse",
    fullName = "roblox.apppageplatform.communityprofile.v1beta1.CommunityProfilePageResponse"
}

tbl1.CommunityProfilePageResponse = CommunityProfilePageResponse

typeRegistry.default:register(tbl1.CommunityProfilePageResponse)

local CommunityProfilePageResponse_TemplatesEntry = {}
CommunityProfilePageResponse_TemplatesEntry.__index = CommunityProfilePageResponse_TemplatesEntry

function CommunityProfilePageResponse_TemplatesEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then nil else tbl5.value
    }, CommunityProfilePageResponse_TemplatesEntry))
end

function CommunityProfilePageResponse_TemplatesEntry:encode(): buffer
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

function CommunityProfilePageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = CommunityProfilePageResponse_TemplatesEntry.new()
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

function CommunityProfilePageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function CommunityProfilePageResponse_TemplatesEntry:jsonDecode()
    local var1 = CommunityProfilePageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

CommunityProfilePageResponse_TemplatesEntry.descriptor = {
    name = "CommunityProfilePageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.communityprofile.v1beta1.TemplatesEntry"
}

tbl1.CommunityProfilePageResponse_TemplatesEntry = CommunityProfilePageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.CommunityProfilePageResponse_TemplatesEntry)

local CommunityProfilePageResponse_LocalizedLiteralsEntry = {}
CommunityProfilePageResponse_LocalizedLiteralsEntry.__index = CommunityProfilePageResponse_LocalizedLiteralsEntry

function CommunityProfilePageResponse_LocalizedLiteralsEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then "" else tbl6.value
    }, CommunityProfilePageResponse_LocalizedLiteralsEntry))
end

function CommunityProfilePageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function CommunityProfilePageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = CommunityProfilePageResponse_LocalizedLiteralsEntry.new()
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

function CommunityProfilePageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function CommunityProfilePageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = CommunityProfilePageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

CommunityProfilePageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "CommunityProfilePageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.communityprofile.v1beta1.LocalizedLiteralsEntry"
}

tbl1.CommunityProfilePageResponse_LocalizedLiteralsEntry = CommunityProfilePageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.CommunityProfilePageResponse_LocalizedLiteralsEntry)

return {
    CommunityProfilePageRequest = tbl1.CommunityProfilePageRequest,
    CommunityProfilePageResponse = tbl1.CommunityProfilePageResponse
}

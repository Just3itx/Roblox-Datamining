-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local MarketplaceCatalogPageRequest = {}
MarketplaceCatalogPageRequest.__index = MarketplaceCatalogPageRequest

function MarketplaceCatalogPageRequest.new(tbl3)
    return (setmetatable({
        request_id = if tbl3 == nil or tbl3.request_id == nil then "" else tbl3.request_id,
        context = if tbl3 == nil or tbl3.context == nil then "" else tbl3.context,
        screen_size = if tbl3 == nil or tbl3.screen_size == nil then "" else tbl3.screen_size,
        pagination = if tbl3 == nil or tbl3.pagination == nil then nil else tbl3.pagination
    }, MarketplaceCatalogPageRequest))
end

function MarketplaceCatalogPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.request_id ~= nil and self.request_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.request_id)
    end

    if self.context ~= nil and self.context ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.context)
    end

    if self.screen_size ~= nil and self.screen_size ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.screen_size)
    end

    if self.pagination ~= nil then
        local buf = self.pagination:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogPageRequest.decode(buf1: buffer)
    local var1 = MarketplaceCatalogPageRequest.new()
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
                var1.request_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.context = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.screen_size = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.pagination = tbl1.RequestPagination.decode(var4)
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

function MarketplaceCatalogPageRequest:jsonEncode()
    local result = {}

    if self.request_id ~= nil and self.request_id ~= "" then
        result.requestId = self.request_id
    end

    if self.context ~= nil and self.context ~= "" then
        result.context = self.context
    end

    if self.screen_size ~= nil and self.screen_size ~= "" then
        result.screenSize = self.screen_size
    end

    if self.pagination ~= nil then
        result.pagination = self.pagination:jsonEncode()
    end

    return result
end

function MarketplaceCatalogPageRequest:jsonDecode()
    local var1 = MarketplaceCatalogPageRequest.new()

    if self.request_id ~= nil then
        var1.request_id = self.request_id
    end

    if self.requestId ~= nil then
        var1.request_id = self.requestId
    end

    if self.context ~= nil then
        var1.context = self.context
    end

    if self.screen_size ~= nil then
        var1.screen_size = self.screen_size
    end

    if self.screenSize ~= nil then
        var1.screen_size = self.screenSize
    end

    if self.pagination ~= nil then
        var1.pagination = tbl1.RequestPagination.jsonDecode(self.pagination)
    end

    return var1
end

MarketplaceCatalogPageRequest.descriptor = {
    name = "MarketplaceCatalogPageRequest",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.MarketplaceCatalogPageRequest"
}

tbl1.MarketplaceCatalogPageRequest = MarketplaceCatalogPageRequest

typeRegistry.default:register(tbl1.MarketplaceCatalogPageRequest)

local RequestPagination = {}
RequestPagination.__index = RequestPagination

function RequestPagination.new(tbl4)
    return (setmetatable({
        cursor = if tbl4 == nil or tbl4.cursor == nil then nil else tbl4.cursor,
        page_size = if tbl4 == nil or tbl4.page_size == nil then nil else tbl4.page_size,
        direction = if tbl4 == nil or tbl4.direction == nil then nil else tbl4.direction
    }, RequestPagination))
end

function RequestPagination:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.cursor ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.cursor)
    end

    if self.page_size ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.page_size)
    end

    if self.direction ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)

        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.PaginationDirection.toNumber(self.direction))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function RequestPagination.decode(buf1: buffer)
    local var1 = RequestPagination.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_size = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.direction = tbl1.PaginationDirection.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.cursor = buffer.tostring(buf)
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

function RequestPagination:jsonEncode()
    local result = {}

    if self.cursor ~= nil then
        result.cursor = self.cursor
    end

    if self.page_size ~= nil then
        result.pageSize = self.page_size
    end

    if self.direction ~= nil then
        result.direction = if typeof(self.direction) == "number" then self.direction else tbl1.PaginationDirection.toNumber(self.direction)
    end

    return result
end

function RequestPagination:jsonDecode()
    local var1 = RequestPagination.new()

    if self.cursor ~= nil then
        var1.cursor = self.cursor
    end

    if self.page_size ~= nil then
        var1.page_size = self.page_size
    end

    if self.pageSize ~= nil then
        var1.page_size = self.pageSize
    end

    if self.direction ~= nil then
        var1.direction = if typeof(self.direction) == "number" then tbl1.PaginationDirection.fromNumber(self.direction) or self.direction else tbl1.PaginationDirection.fromName(self.direction) or self.direction
    end

    return var1
end

RequestPagination.descriptor = {
    name = "RequestPagination",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.RequestPagination"
}

tbl1.RequestPagination = RequestPagination

typeRegistry.default:register(tbl1.RequestPagination)

local MarketplaceCatalogPageResponse = {}
MarketplaceCatalogPageResponse.__index = MarketplaceCatalogPageResponse

function MarketplaceCatalogPageResponse.new(tbl5)
    return (setmetatable({
        page_entries = (tbl5 == nil or tbl5.page_entries == nil) and {} or tbl5.page_entries,
        hydration_data = if tbl5 == nil or tbl5.hydration_data == nil then nil else tbl5.hydration_data,
        templates = (tbl5 == nil or tbl5.templates == nil) and {} or tbl5.templates,
        localized_literals = (tbl5 == nil or tbl5.localized_literals == nil) and {} or tbl5.localized_literals,
        pagination = if tbl5 == nil or tbl5.pagination == nil then nil else tbl5.pagination
    }, MarketplaceCatalogPageResponse))
end

function MarketplaceCatalogPageResponse:encode(): buffer
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

    if self.pagination ~= nil then
        local buf = self.pagination:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function MarketplaceCatalogPageResponse.decode(buf1: buffer)
    local var1 = MarketplaceCatalogPageResponse.new()
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

                local var5 = tbl1.MarketplaceCatalogPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.pagination = tbl1.Pagination.decode(var4)
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

function MarketplaceCatalogPageResponse:jsonEncode()
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

    if self.pagination ~= nil then
        result.pagination = self.pagination:jsonEncode()
    end

    return result
end

function MarketplaceCatalogPageResponse:jsonDecode()
    local var1 = MarketplaceCatalogPageResponse.new()

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

    if self.pagination ~= nil then
        var1.pagination = tbl1.Pagination.jsonDecode(self.pagination)
    end

    return var1
end

MarketplaceCatalogPageResponse.descriptor = {
    name = "MarketplaceCatalogPageResponse",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.MarketplaceCatalogPageResponse"
}

tbl1.MarketplaceCatalogPageResponse = MarketplaceCatalogPageResponse

typeRegistry.default:register(tbl1.MarketplaceCatalogPageResponse)

local MarketplaceCatalogPageResponse_TemplatesEntry = {}
MarketplaceCatalogPageResponse_TemplatesEntry.__index = MarketplaceCatalogPageResponse_TemplatesEntry

function MarketplaceCatalogPageResponse_TemplatesEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then nil else tbl6.value
    }, MarketplaceCatalogPageResponse_TemplatesEntry))
end

function MarketplaceCatalogPageResponse_TemplatesEntry:encode(): buffer
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

function MarketplaceCatalogPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = MarketplaceCatalogPageResponse_TemplatesEntry.new()
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

function MarketplaceCatalogPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function MarketplaceCatalogPageResponse_TemplatesEntry:jsonDecode()
    local var1 = MarketplaceCatalogPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

MarketplaceCatalogPageResponse_TemplatesEntry.descriptor = {
    name = "MarketplaceCatalogPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.TemplatesEntry"
}

tbl1.MarketplaceCatalogPageResponse_TemplatesEntry = MarketplaceCatalogPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.MarketplaceCatalogPageResponse_TemplatesEntry)

local MarketplaceCatalogPageResponse_LocalizedLiteralsEntry = {}
MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.__index = MarketplaceCatalogPageResponse_LocalizedLiteralsEntry

function MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then "" else tbl7.value
    }, MarketplaceCatalogPageResponse_LocalizedLiteralsEntry))
end

function MarketplaceCatalogPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.new()
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

function MarketplaceCatalogPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function MarketplaceCatalogPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

MarketplaceCatalogPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "MarketplaceCatalogPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.LocalizedLiteralsEntry"
}

tbl1.MarketplaceCatalogPageResponse_LocalizedLiteralsEntry = MarketplaceCatalogPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.MarketplaceCatalogPageResponse_LocalizedLiteralsEntry)

local Pagination = {}
Pagination.__index = Pagination

function Pagination.new(tbl8)
    return (setmetatable({ next_cursor = if tbl8 == nil or tbl8.next_cursor == nil then nil else tbl8.next_cursor }, Pagination))
end

function Pagination:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.next_cursor ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.next_cursor)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Pagination.decode(buf1: buffer)
    local var1 = Pagination.new()
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

function Pagination:jsonEncode()
    local result = {}

    if self.next_cursor ~= nil then
        result.nextCursor = self.next_cursor
    end

    return result
end

function Pagination:jsonDecode()
    local var1 = Pagination.new()

    if self.next_cursor ~= nil then
        var1.next_cursor = self.next_cursor
    end

    if self.nextCursor ~= nil then
        var1.next_cursor = self.nextCursor
    end

    return var1
end

Pagination.descriptor = {
    name = "Pagination",
    fullName = "roblox.apppageplatform.marketplacecatalog.v1beta1.Pagination"
}

tbl1.Pagination = Pagination

typeRegistry.default:register(tbl1.Pagination)

tbl1.PaginationDirection = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "PAGINATION_DIRECTION_INVALID" elseif num1 == 1 then "PAGINATION_DIRECTION_FORWARD" elseif num1 == 2 then "PAGINATION_DIRECTION_BACKWARD" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "PAGINATION_DIRECTION_INVALID" then 0 elseif arg1 == "PAGINATION_DIRECTION_FORWARD" then 1 elseif arg1 == "PAGINATION_DIRECTION_BACKWARD" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "PAGINATION_DIRECTION_INVALID" then "PAGINATION_DIRECTION_INVALID" elseif str1 == "PAGINATION_DIRECTION_FORWARD" then "PAGINATION_DIRECTION_FORWARD" elseif str1 == "PAGINATION_DIRECTION_BACKWARD" then "PAGINATION_DIRECTION_BACKWARD" else nil
    end
}

return {
    MarketplaceCatalogPageRequest = tbl1.MarketplaceCatalogPageRequest,
    RequestPagination = tbl1.RequestPagination,
    MarketplaceCatalogPageResponse = tbl1.MarketplaceCatalogPageResponse,
    Pagination = tbl1.Pagination,
    PaginationDirection = tbl1.PaginationDirection
}

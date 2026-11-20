-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local GetSearchResultsPageRequest = {}
GetSearchResultsPageRequest.__index = GetSearchResultsPageRequest

function GetSearchResultsPageRequest.new(tbl3)
    local tbl4 = {
        search_query = if tbl3 == nil or tbl3.search_query == nil then "" else tbl3.search_query,
        session_id = if tbl3 == nil or tbl3.session_id == nil then "" else tbl3.session_id,
        vertical_type = if tbl3 == nil or tbl3.vertical_type == nil then assert(tbl1.SearchResultsPageVerticalType.fromNumber(0), "Enum has no 0 default") else tbl3.vertical_type,
        global_session_id = if tbl3 == nil or tbl3.global_session_id == nil then "" else tbl3.global_session_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities,
        guided_search_context = if tbl3 == nil or tbl3.guided_search_context == nil then nil else tbl3.guided_search_context
    }
    return (setmetatable(tbl4, GetSearchResultsPageRequest))
end

function GetSearchResultsPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.search_query ~= nil and self.search_query ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.search_query)
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.session_id)
    end

    if self.vertical_type ~= nil
        and (self.vertical_type ~= nil and self.vertical_type ~= 0
            or self.vertical_type ~= tbl1.SearchResultsPageVerticalType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.SearchResultsPageVerticalType.toNumber(self.vertical_type))
    end

    if self.global_session_id ~= nil and self.global_session_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.global_session_id)
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.guided_search_context ~= nil then
        local buf = self.guided_search_context:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetSearchResultsPageRequest.decode(buf1: buffer)
    local var1 = GetSearchResultsPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.vertical_type = tbl1.SearchResultsPageVerticalType.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.search_query = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.session_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.global_session_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.guided_search_context = tbl1.GuidedSearchContext.decode(var4)
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

function GetSearchResultsPageRequest:jsonEncode()
    local result = {}

    if self.search_query ~= nil and self.search_query ~= "" then
        result.searchQuery = self.search_query
    end

    if self.session_id ~= nil and self.session_id ~= "" then
        result.sessionId = self.session_id
    end

    if self.vertical_type ~= nil
        and (self.vertical_type ~= nil and self.vertical_type ~= 0
            or self.vertical_type ~= tbl1.SearchResultsPageVerticalType.fromNumber(0))
    then
        result.verticalType = if typeof(self.vertical_type) == "number" then self.vertical_type else tbl1.SearchResultsPageVerticalType.toNumber(self.vertical_type)
    end

    if self.global_session_id ~= nil and self.global_session_id ~= "" then
        result.globalSessionId = self.global_session_id
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    if self.guided_search_context ~= nil then
        result.guidedSearchContext = self.guided_search_context:jsonEncode()
    end

    return result
end

function GetSearchResultsPageRequest:jsonDecode()
    local var1 = GetSearchResultsPageRequest.new()

    if self.search_query ~= nil then
        var1.search_query = self.search_query
    end

    if self.searchQuery ~= nil then
        var1.search_query = self.searchQuery
    end

    if self.session_id ~= nil then
        var1.session_id = self.session_id
    end

    if self.sessionId ~= nil then
        var1.session_id = self.sessionId
    end

    if self.vertical_type ~= nil then
        var1.vertical_type = if typeof(self.vertical_type) == "number" then tbl1.SearchResultsPageVerticalType.fromNumber(self.vertical_type) or self.vertical_type else tbl1.SearchResultsPageVerticalType.fromName(self.vertical_type) or self.vertical_type
    end

    if self.verticalType ~= nil then
        var1.vertical_type = if typeof(self.verticalType) == "number" then tbl1.SearchResultsPageVerticalType.fromNumber(self.verticalType) or self.verticalType else tbl1.SearchResultsPageVerticalType.fromName(self.verticalType) or self.verticalType
    end

    if self.global_session_id ~= nil then
        var1.global_session_id = self.global_session_id
    end

    if self.globalSessionId ~= nil then
        var1.global_session_id = self.globalSessionId
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    if self.guided_search_context ~= nil then
        var1.guided_search_context = tbl1.GuidedSearchContext.jsonDecode(self.guided_search_context)
    end

    if self.guidedSearchContext ~= nil then
        var1.guided_search_context = tbl1.GuidedSearchContext.jsonDecode(self.guidedSearchContext)
    end

    return var1
end

GetSearchResultsPageRequest.descriptor = {
    name = "GetSearchResultsPageRequest",
    fullName = "roblox.apppageplatform.search.v1beta1.GetSearchResultsPageRequest"
}

tbl1.GetSearchResultsPageRequest = GetSearchResultsPageRequest

typeRegistry.default:register(tbl1.GetSearchResultsPageRequest)

local GuidedSearchContext = {}
GuidedSearchContext.__index = GuidedSearchContext

function GuidedSearchContext.new(tbl4)
    return (setmetatable({
        selected_option = if tbl4 == nil or tbl4.selected_option == nil then "" else tbl4.selected_option,
        suggestions = (tbl4 == nil or tbl4.suggestions == nil) and {} or tbl4.suggestions
    }, GuidedSearchContext))
end

function GuidedSearchContext:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.selected_option ~= nil and self.selected_option ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.selected_option)
    end

    if self.suggestions ~= nil and #self.suggestions > 0 then
        for _, suggestion in self.suggestions do
            local buf = suggestion:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GuidedSearchContext.decode(buf1: buffer)
    local var1 = GuidedSearchContext.new()
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
                var1.selected_option = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.suggestions, tbl1.GuidedSearchSuggestion.decode(var4))
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

function GuidedSearchContext:jsonEncode()
    local result = {}

    if self.selected_option ~= nil and self.selected_option ~= "" then
        result.selectedOption = self.selected_option
    end

    if self.suggestions ~= nil and #self.suggestions > 0 then
        local suggestions = {}
        for _, suggestion in self.suggestions do
            table.insert(suggestions, suggestion:jsonEncode())
        end
        result.suggestions = suggestions
    end

    return result
end

function GuidedSearchContext:jsonDecode()
    local var1 = GuidedSearchContext.new()

    if self.selected_option ~= nil then
        var1.selected_option = self.selected_option
    end

    if self.selectedOption ~= nil then
        var1.selected_option = self.selectedOption
    end

    if self.suggestions ~= nil then
        local suggestions = {}
        for _, suggestion in self.suggestions do
            table.insert(suggestions, tbl1.GuidedSearchSuggestion.jsonDecode(suggestion))
        end

        var1.suggestions = suggestions
    end

    return var1
end

GuidedSearchContext.descriptor = {
    name = "GuidedSearchContext",
    fullName = "roblox.apppageplatform.search.v1beta1.GuidedSearchContext"
}

tbl1.GuidedSearchContext = GuidedSearchContext

typeRegistry.default:register(tbl1.GuidedSearchContext)

local GuidedSearchSuggestion = {}
GuidedSearchSuggestion.__index = GuidedSearchSuggestion

function GuidedSearchSuggestion.new(tbl5)
    return (setmetatable({
        id = if tbl5 == nil or tbl5.id == nil then "" else tbl5.id,
        query = if tbl5 == nil or tbl5.query == nil then "" else tbl5.query
    }, GuidedSearchSuggestion))
end

function GuidedSearchSuggestion:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.query ~= nil and self.query ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.query)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GuidedSearchSuggestion.decode(buf1: buffer)
    local var1 = GuidedSearchSuggestion.new()
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
                var1.query = buffer.tostring(buf)
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

function GuidedSearchSuggestion:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.query ~= nil and self.query ~= "" then
        result.query = self.query
    end

    return result
end

function GuidedSearchSuggestion:jsonDecode()
    local var1 = GuidedSearchSuggestion.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.query ~= nil then
        var1.query = self.query
    end

    return var1
end

GuidedSearchSuggestion.descriptor = {
    name = "GuidedSearchSuggestion",
    fullName = "roblox.apppageplatform.search.v1beta1.GuidedSearchSuggestion"
}

tbl1.GuidedSearchSuggestion = GuidedSearchSuggestion

typeRegistry.default:register(tbl1.GuidedSearchSuggestion)

local GetSearchResultsPageResponse = {}
GetSearchResultsPageResponse.__index = GetSearchResultsPageResponse

function GetSearchResultsPageResponse.new(tbl6)
    return (setmetatable({
        page_entries = (tbl6 == nil or tbl6.page_entries == nil) and {} or tbl6.page_entries,
        hydration_data = if tbl6 == nil or tbl6.hydration_data == nil then nil else tbl6.hydration_data,
        templates = (tbl6 == nil or tbl6.templates == nil) and {} or tbl6.templates,
        localized_literals = (tbl6 == nil or tbl6.localized_literals == nil) and {} or tbl6.localized_literals
    }, GetSearchResultsPageResponse))
end

function GetSearchResultsPageResponse:encode(): buffer
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

function GetSearchResultsPageResponse.decode(buf1: buffer)
    local var1 = GetSearchResultsPageResponse.new()
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

                local var5 = tbl1.GetSearchResultsPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetSearchResultsPageResponse_LocalizedLiteralsEntry.decode(var4)

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

function GetSearchResultsPageResponse:jsonEncode()
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

function GetSearchResultsPageResponse:jsonDecode()
    local var1 = GetSearchResultsPageResponse.new()

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

GetSearchResultsPageResponse.descriptor = {
    name = "GetSearchResultsPageResponse",
    fullName = "roblox.apppageplatform.search.v1beta1.GetSearchResultsPageResponse"
}

tbl1.GetSearchResultsPageResponse = GetSearchResultsPageResponse

typeRegistry.default:register(tbl1.GetSearchResultsPageResponse)

local GetSearchResultsPageResponse_TemplatesEntry = {}
GetSearchResultsPageResponse_TemplatesEntry.__index = GetSearchResultsPageResponse_TemplatesEntry

function GetSearchResultsPageResponse_TemplatesEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then nil else tbl7.value
    }, GetSearchResultsPageResponse_TemplatesEntry))
end

function GetSearchResultsPageResponse_TemplatesEntry:encode(): buffer
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

function GetSearchResultsPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GetSearchResultsPageResponse_TemplatesEntry.new()
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

function GetSearchResultsPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetSearchResultsPageResponse_TemplatesEntry:jsonDecode()
    local var1 = GetSearchResultsPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GetSearchResultsPageResponse_TemplatesEntry.descriptor = {
    name = "GetSearchResultsPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.search.v1beta1.TemplatesEntry"
}

tbl1.GetSearchResultsPageResponse_TemplatesEntry = GetSearchResultsPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GetSearchResultsPageResponse_TemplatesEntry)

local GetSearchResultsPageResponse_LocalizedLiteralsEntry = {}
GetSearchResultsPageResponse_LocalizedLiteralsEntry.__index = GetSearchResultsPageResponse_LocalizedLiteralsEntry

function GetSearchResultsPageResponse_LocalizedLiteralsEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then "" else tbl8.value
    }, GetSearchResultsPageResponse_LocalizedLiteralsEntry))
end

function GetSearchResultsPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function GetSearchResultsPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GetSearchResultsPageResponse_LocalizedLiteralsEntry.new()
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

function GetSearchResultsPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetSearchResultsPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GetSearchResultsPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetSearchResultsPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GetSearchResultsPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.search.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GetSearchResultsPageResponse_LocalizedLiteralsEntry = GetSearchResultsPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GetSearchResultsPageResponse_LocalizedLiteralsEntry)

tbl1.SearchResultsPageVerticalType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_INVALID"
        elseif num1 == 1 then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_BLENDED"
        elseif num1 == 2 then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_GAME"
        elseif num1 == 3 then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_USER"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_INVALID" then
            return 0
        elseif arg1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_BLENDED" then
            return 1
        elseif arg1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_GAME" then
            return 2
        elseif arg1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_USER" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_INVALID" then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_INVALID"
        elseif str1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_BLENDED" then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_BLENDED"
        elseif str1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_GAME" then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_GAME"
        elseif str1 == "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_USER" then
            return "SEARCH_RESULTS_PAGE_VERTICAL_TYPE_USER"
        end

        return nil
    end
}

return {
    GetSearchResultsPageRequest = tbl1.GetSearchResultsPageRequest,
    GuidedSearchContext = tbl1.GuidedSearchContext,
    GuidedSearchSuggestion = tbl1.GuidedSearchSuggestion,
    GetSearchResultsPageResponse = tbl1.GetSearchResultsPageResponse,
    SearchResultsPageVerticalType = tbl1.SearchResultsPageVerticalType
}

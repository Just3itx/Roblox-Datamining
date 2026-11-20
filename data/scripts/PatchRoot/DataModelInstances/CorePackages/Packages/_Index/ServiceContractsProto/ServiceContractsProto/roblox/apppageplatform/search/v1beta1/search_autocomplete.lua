-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local GetSearchAutocompleteRequest = {}
GetSearchAutocompleteRequest.__index = GetSearchAutocompleteRequest

function GetSearchAutocompleteRequest.new(tbl3)
    return (setmetatable({ prefix = if tbl3 == nil or tbl3.prefix == nil then "" else tbl3.prefix }, GetSearchAutocompleteRequest))
end

function GetSearchAutocompleteRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.prefix ~= nil and self.prefix ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.prefix)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetSearchAutocompleteRequest.decode(buf1: buffer)
    local var1 = GetSearchAutocompleteRequest.new()
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
                var1.prefix = buffer.tostring(buf)
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

function GetSearchAutocompleteRequest:jsonEncode()
    local result = {}

    if self.prefix ~= nil and self.prefix ~= "" then
        result.prefix = self.prefix
    end

    return result
end

function GetSearchAutocompleteRequest:jsonDecode()
    local var1 = GetSearchAutocompleteRequest.new()

    if self.prefix ~= nil then
        var1.prefix = self.prefix
    end

    return var1
end

GetSearchAutocompleteRequest.descriptor = {
    name = "GetSearchAutocompleteRequest",
    fullName = "roblox.apppageplatform.search.v1beta1.GetSearchAutocompleteRequest"
}

tbl1.GetSearchAutocompleteRequest = GetSearchAutocompleteRequest

typeRegistry.default:register(tbl1.GetSearchAutocompleteRequest)

local GetSearchAutocompleteResponse = {}
GetSearchAutocompleteResponse.__index = GetSearchAutocompleteResponse

function GetSearchAutocompleteResponse.new(tbl4)
    return (setmetatable({
        page_entries = (tbl4 == nil or tbl4.page_entries == nil) and {} or tbl4.page_entries,
        hydration_data = if tbl4 == nil or tbl4.hydration_data == nil then nil else tbl4.hydration_data
    }, GetSearchAutocompleteResponse))
end

function GetSearchAutocompleteResponse:encode(): buffer
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

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetSearchAutocompleteResponse.decode(buf1: buffer)
    local var1 = GetSearchAutocompleteResponse.new()
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

function GetSearchAutocompleteResponse:jsonEncode()
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

    return result
end

function GetSearchAutocompleteResponse:jsonDecode()
    local var1 = GetSearchAutocompleteResponse.new()

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

    return var1
end

GetSearchAutocompleteResponse.descriptor = {
    name = "GetSearchAutocompleteResponse",
    fullName = "roblox.apppageplatform.search.v1beta1.GetSearchAutocompleteResponse"
}

tbl1.GetSearchAutocompleteResponse = GetSearchAutocompleteResponse

typeRegistry.default:register(tbl1.GetSearchAutocompleteResponse)

return {
    GetSearchAutocompleteRequest = tbl1.GetSearchAutocompleteRequest,
    GetSearchAutocompleteResponse = tbl1.GetSearchAutocompleteResponse
}

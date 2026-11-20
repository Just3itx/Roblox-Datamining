-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local GameItemDetailsPageRequest = {}
GameItemDetailsPageRequest.__index = GameItemDetailsPageRequest

function GameItemDetailsPageRequest.new(tbl3)
    local tbl4 = {
        item_id = if tbl3 == nil or tbl3.item_id == nil then "" else tbl3.item_id,
        item_type = if tbl3 == nil or tbl3.item_type == nil then assert(tbl1.GameItemType.fromNumber(0), "Enum has no 0 default") else tbl3.item_type,
        universe_id = if tbl3 == nil or tbl3.universe_id == nil then 0 else tbl3.universe_id,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }
    return (setmetatable(tbl4, GameItemDetailsPageRequest))
end

function GameItemDetailsPageRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.item_id ~= nil and self.item_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.item_id)
    end

    if self.item_type ~= nil
        and (self.item_type ~= nil and self.item_type ~= 0 or self.item_type ~= tbl1.GameItemType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.GameItemType.toNumber(self.item_type))
    end

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.universe_id)
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

function GameItemDetailsPageRequest.decode(buf1: buffer)
    local var1 = GameItemDetailsPageRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.item_type = tbl1.GameItemType.fromNumber(var4) or var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.universe_id = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.item_id = buffer.tostring(buf)
            elseif var2 == 4 then
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

function GameItemDetailsPageRequest:jsonEncode()
    local result = {}

    if self.item_id ~= nil and self.item_id ~= "" then
        result.itemId = self.item_id
    end

    if self.item_type ~= nil
        and (self.item_type ~= nil and self.item_type ~= 0 or self.item_type ~= tbl1.GameItemType.fromNumber(0))
    then
        result.itemType = if typeof(self.item_type) == "number" then self.item_type else tbl1.GameItemType.toNumber(self.item_type)
    end

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        result.universeId = self.universe_id
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    return result
end

function GameItemDetailsPageRequest:jsonDecode()
    local var1 = GameItemDetailsPageRequest.new()

    if self.item_id ~= nil then
        var1.item_id = self.item_id
    end

    if self.itemId ~= nil then
        var1.item_id = self.itemId
    end

    if self.item_type ~= nil then
        var1.item_type = if typeof(self.item_type) == "number" then tbl1.GameItemType.fromNumber(self.item_type) or self.item_type else tbl1.GameItemType.fromName(self.item_type) or self.item_type
    end

    if self.itemType ~= nil then
        var1.item_type = if typeof(self.itemType) == "number" then tbl1.GameItemType.fromNumber(self.itemType) or self.itemType else tbl1.GameItemType.fromName(self.itemType) or self.itemType
    end

    if self.universe_id ~= nil then
        var1.universe_id = self.universe_id
    end

    if self.universeId ~= nil then
        var1.universe_id = self.universeId
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    return var1
end

GameItemDetailsPageRequest.descriptor = {
    name = "GameItemDetailsPageRequest",
    fullName = "roblox.apppageplatform.devstore.v1beta1.GameItemDetailsPageRequest"
}

tbl1.GameItemDetailsPageRequest = GameItemDetailsPageRequest

typeRegistry.default:register(tbl1.GameItemDetailsPageRequest)

local GameItemDetailsPageResponse = {}
GameItemDetailsPageResponse.__index = GameItemDetailsPageResponse

function GameItemDetailsPageResponse.new(tbl4)
    return (setmetatable({
        page_entries = (tbl4 == nil or tbl4.page_entries == nil) and {} or tbl4.page_entries,
        hydration_data = if tbl4 == nil or tbl4.hydration_data == nil then nil else tbl4.hydration_data,
        templates = (tbl4 == nil or tbl4.templates == nil) and {} or tbl4.templates,
        localized_literals = (tbl4 == nil or tbl4.localized_literals == nil) and {} or tbl4.localized_literals
    }, GameItemDetailsPageResponse))
end

function GameItemDetailsPageResponse:encode(): buffer
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

function GameItemDetailsPageResponse.decode(buf1: buffer)
    local var1 = GameItemDetailsPageResponse.new()
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

                local var5 = tbl1.GameItemDetailsPageResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GameItemDetailsPageResponse_LocalizedLiteralsEntry.decode(var4)

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

function GameItemDetailsPageResponse:jsonEncode()
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

function GameItemDetailsPageResponse:jsonDecode()
    local var1 = GameItemDetailsPageResponse.new()

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

GameItemDetailsPageResponse.descriptor = {
    name = "GameItemDetailsPageResponse",
    fullName = "roblox.apppageplatform.devstore.v1beta1.GameItemDetailsPageResponse"
}

tbl1.GameItemDetailsPageResponse = GameItemDetailsPageResponse

typeRegistry.default:register(tbl1.GameItemDetailsPageResponse)

local GameItemDetailsPageResponse_TemplatesEntry = {}
GameItemDetailsPageResponse_TemplatesEntry.__index = GameItemDetailsPageResponse_TemplatesEntry

function GameItemDetailsPageResponse_TemplatesEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then nil else tbl5.value
    }, GameItemDetailsPageResponse_TemplatesEntry))
end

function GameItemDetailsPageResponse_TemplatesEntry:encode(): buffer
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

function GameItemDetailsPageResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GameItemDetailsPageResponse_TemplatesEntry.new()
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

function GameItemDetailsPageResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GameItemDetailsPageResponse_TemplatesEntry:jsonDecode()
    local var1 = GameItemDetailsPageResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GameItemDetailsPageResponse_TemplatesEntry.descriptor = {
    name = "GameItemDetailsPageResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.devstore.v1beta1.TemplatesEntry"
}

tbl1.GameItemDetailsPageResponse_TemplatesEntry = GameItemDetailsPageResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GameItemDetailsPageResponse_TemplatesEntry)

local GameItemDetailsPageResponse_LocalizedLiteralsEntry = {}
GameItemDetailsPageResponse_LocalizedLiteralsEntry.__index = GameItemDetailsPageResponse_LocalizedLiteralsEntry

function GameItemDetailsPageResponse_LocalizedLiteralsEntry.new(tbl6)
    return (setmetatable({
        key = if tbl6 == nil or tbl6.key == nil then "" else tbl6.key,
        value = if tbl6 == nil or tbl6.value == nil then "" else tbl6.value
    }, GameItemDetailsPageResponse_LocalizedLiteralsEntry))
end

function GameItemDetailsPageResponse_LocalizedLiteralsEntry:encode(): buffer
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

function GameItemDetailsPageResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GameItemDetailsPageResponse_LocalizedLiteralsEntry.new()
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

function GameItemDetailsPageResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GameItemDetailsPageResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GameItemDetailsPageResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GameItemDetailsPageResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GameItemDetailsPageResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.devstore.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GameItemDetailsPageResponse_LocalizedLiteralsEntry = GameItemDetailsPageResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GameItemDetailsPageResponse_LocalizedLiteralsEntry)

tbl1.GameItemType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "GAME_ITEM_TYPE_INVALID"
        elseif num1 == 1 then
            return "GAME_ITEM_TYPE_GAME_PASS"
        elseif num1 == 2 then
            return "GAME_ITEM_TYPE_DEVELOPER_PRODUCT"
        elseif num1 == 3 then
            return "GAME_ITEM_TYPE_SUBSCRIPTION"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "GAME_ITEM_TYPE_INVALID" then
            return 0
        elseif arg1 == "GAME_ITEM_TYPE_GAME_PASS" then
            return 1
        elseif arg1 == "GAME_ITEM_TYPE_DEVELOPER_PRODUCT" then
            return 2
        elseif arg1 == "GAME_ITEM_TYPE_SUBSCRIPTION" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "GAME_ITEM_TYPE_INVALID" then
            return "GAME_ITEM_TYPE_INVALID"
        elseif str1 == "GAME_ITEM_TYPE_GAME_PASS" then
            return "GAME_ITEM_TYPE_GAME_PASS"
        elseif str1 == "GAME_ITEM_TYPE_DEVELOPER_PRODUCT" then
            return "GAME_ITEM_TYPE_DEVELOPER_PRODUCT"
        elseif str1 == "GAME_ITEM_TYPE_SUBSCRIPTION" then
            return "GAME_ITEM_TYPE_SUBSCRIPTION"
        end

        return nil
    end
}

return {
    GameItemDetailsPageRequest = tbl1.GameItemDetailsPageRequest,
    GameItemDetailsPageResponse = tbl1.GameItemDetailsPageResponse,
    GameItemType = tbl1.GameItemType
}

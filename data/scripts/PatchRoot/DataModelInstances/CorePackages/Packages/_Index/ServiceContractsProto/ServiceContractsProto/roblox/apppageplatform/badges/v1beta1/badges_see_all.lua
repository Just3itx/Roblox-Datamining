-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)
local page_entry = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local BadgesSeeAllRequest = {}
BadgesSeeAllRequest.__index = BadgesSeeAllRequest

function BadgesSeeAllRequest.new(tbl3)
    local tbl4 = {
        universe_id = if tbl3 == nil or tbl3.universe_id == nil then 0 else tbl3.universe_id,
        user_id = if tbl3 == nil or tbl3.user_id == nil then 0 else tbl3.user_id,
        page_size = if tbl3 == nil or tbl3.page_size == nil then 0 else tbl3.page_size,
        cursor = if tbl3 == nil or tbl3.cursor == nil then "" else tbl3.cursor,
        page_entry_format = if tbl3 == nil or tbl3.page_entry_format == nil then assert(page_entry_content.PageEntryFormat.fromNumber(0), "Enum has no 0 default") else tbl3.page_entry_format,
        client_capabilities = if tbl3 == nil or tbl3.client_capabilities == nil then nil else tbl3.client_capabilities
    }
    return (setmetatable(tbl4, BadgesSeeAllRequest))
end

function BadgesSeeAllRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.universe_id)
    end

    if self.user_id ~= nil and self.user_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.user_id)
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.page_size)
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.cursor)
    end

    if self.page_entry_format ~= nil
        and (self.page_entry_format ~= nil and self.page_entry_format ~= 0
            or self.page_entry_format ~= page_entry_content.PageEntryFormat.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, page_entry_content.PageEntryFormat.toNumber(self.page_entry_format))
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesSeeAllRequest.decode(buf1: buffer)
    local var1 = BadgesSeeAllRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.universe_id = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.user_id = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_size = var4
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_entry_format = page_entry_content.PageEntryFormat.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.cursor = buffer.tostring(buf)
            elseif var2 == 6 then
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

function BadgesSeeAllRequest:jsonEncode()
    local result = {}

    if self.universe_id ~= nil and self.universe_id ~= 0 then
        result.universeId = self.universe_id
    end

    if self.user_id ~= nil and self.user_id ~= 0 then
        result.userId = self.user_id
    end

    if self.page_size ~= nil and self.page_size ~= 0 then
        result.pageSize = self.page_size
    end

    if self.cursor ~= nil and self.cursor ~= "" then
        result.cursor = self.cursor
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

function BadgesSeeAllRequest:jsonDecode()
    local var1 = BadgesSeeAllRequest.new()

    if self.universe_id ~= nil then
        var1.universe_id = self.universe_id
    end

    if self.universeId ~= nil then
        var1.universe_id = self.universeId
    end

    if self.user_id ~= nil then
        var1.user_id = self.user_id
    end

    if self.userId ~= nil then
        var1.user_id = self.userId
    end

    if self.page_size ~= nil then
        var1.page_size = self.page_size
    end

    if self.pageSize ~= nil then
        var1.page_size = self.pageSize
    end

    if self.cursor ~= nil then
        var1.cursor = self.cursor
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

BadgesSeeAllRequest.descriptor = {
    name = "BadgesSeeAllRequest",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgesSeeAllRequest"
}

tbl1.BadgesSeeAllRequest = BadgesSeeAllRequest

typeRegistry.default:register(tbl1.BadgesSeeAllRequest)

local Pagination = {}
Pagination.__index = Pagination

function Pagination.new(tbl4)
    return (setmetatable({
        page_size = if tbl4 == nil or tbl4.page_size == nil then 0 else tbl4.page_size,
        next_cursor = if tbl4 == nil or tbl4.next_cursor == nil then "" else tbl4.next_cursor,
        prev_cursor = if tbl4 == nil or tbl4.prev_cursor == nil then "" else tbl4.prev_cursor,
        total = if tbl4 == nil or tbl4.total == nil then 0 else tbl4.total
    }, Pagination))
end

function Pagination:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.page_size ~= nil and self.page_size ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.page_size)
    end

    if self.next_cursor ~= nil and self.next_cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.next_cursor)
    end

    if self.prev_cursor ~= nil and self.prev_cursor ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.prev_cursor)
    end

    if self.total ~= nil and self.total ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total)
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
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.page_size = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.next_cursor = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.prev_cursor = buffer.tostring(buf)
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

    if self.page_size ~= nil and self.page_size ~= 0 then
        result.pageSize = self.page_size
    end

    if self.next_cursor ~= nil and self.next_cursor ~= "" then
        result.nextCursor = self.next_cursor
    end

    if self.prev_cursor ~= nil and self.prev_cursor ~= "" then
        result.prevCursor = self.prev_cursor
    end

    if self.total ~= nil and self.total ~= 0 then
        result.total = self.total
    end

    return result
end

function Pagination:jsonDecode()
    local var1 = Pagination.new()

    if self.page_size ~= nil then
        var1.page_size = self.page_size
    end

    if self.pageSize ~= nil then
        var1.page_size = self.pageSize
    end

    if self.next_cursor ~= nil then
        var1.next_cursor = self.next_cursor
    end

    if self.nextCursor ~= nil then
        var1.next_cursor = self.nextCursor
    end

    if self.prev_cursor ~= nil then
        var1.prev_cursor = self.prev_cursor
    end

    if self.prevCursor ~= nil then
        var1.prev_cursor = self.prevCursor
    end

    if self.total ~= nil then
        var1.total = self.total
    end

    return var1
end

Pagination.descriptor = {
    name = "Pagination",
    fullName = "roblox.apppageplatform.badges.v1beta1.Pagination"
}

tbl1.Pagination = Pagination

typeRegistry.default:register(tbl1.Pagination)

local BadgesGridPageEntry = {}
BadgesGridPageEntry.__index = BadgesGridPageEntry

function BadgesGridPageEntry.new(tbl5)
    return (setmetatable({
        section_title = if tbl5 == nil or tbl5.section_title == nil then "" else tbl5.section_title,
        badges = (tbl5 == nil or tbl5.badges == nil) and {} or tbl5.badges,
        collection_id = if tbl5 == nil or tbl5.collection_id == nil then "" else tbl5.collection_id,
        collection_position = if tbl5 == nil or tbl5.collection_position == nil then "" else tbl5.collection_position,
        universe_id = if tbl5 == nil or tbl5.universe_id == nil then "" else tbl5.universe_id
    }, BadgesGridPageEntry))
end

function BadgesGridPageEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.section_title ~= nil and self.section_title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.section_title)
    end

    if self.badges ~= nil and #self.badges > 0 then
        for _, value in self.badges do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.collection_id ~= nil and self.collection_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.collection_id)
    end

    if self.collection_position ~= nil and self.collection_position ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.collection_position)
    end

    if self.universe_id ~= nil and self.universe_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.universe_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesGridPageEntry.decode(buf1: buffer)
    local var1 = BadgesGridPageEntry.new()
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
                var1.section_title = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.badges, tbl1.BadgesGridPageEntry_BadgeInputData.decode(var4))
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.collection_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.collection_position = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.universe_id = buffer.tostring(buf)
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

function BadgesGridPageEntry:jsonEncode()
    local result = {}

    if self.section_title ~= nil and self.section_title ~= "" then
        result.sectionTitle = self.section_title
    end

    if self.badges ~= nil and #self.badges > 0 then
        local badges = {}
        for _, value in self.badges do
            table.insert(badges, value:jsonEncode())
        end
        result.badges = badges
    end

    if self.collection_id ~= nil and self.collection_id ~= "" then
        result.collectionId = self.collection_id
    end

    if self.collection_position ~= nil and self.collection_position ~= "" then
        result.collectionPosition = self.collection_position
    end

    if self.universe_id ~= nil and self.universe_id ~= "" then
        result.universeId = self.universe_id
    end

    return result
end

function BadgesGridPageEntry:jsonDecode()
    local var1 = BadgesGridPageEntry.new()

    if self.section_title ~= nil then
        var1.section_title = self.section_title
    end

    if self.sectionTitle ~= nil then
        var1.section_title = self.sectionTitle
    end

    if self.badges ~= nil then
        local badges = {}
        for _, value in self.badges do
            table.insert(badges, tbl1.BadgesGridPageEntry_BadgeInputData.jsonDecode(value))
        end

        var1.badges = badges
    end

    if self.collection_id ~= nil then
        var1.collection_id = self.collection_id
    end

    if self.collectionId ~= nil then
        var1.collection_id = self.collectionId
    end

    if self.collection_position ~= nil then
        var1.collection_position = self.collection_position
    end

    if self.collectionPosition ~= nil then
        var1.collection_position = self.collectionPosition
    end

    if self.universe_id ~= nil then
        var1.universe_id = self.universe_id
    end

    if self.universeId ~= nil then
        var1.universe_id = self.universeId
    end

    return var1
end

BadgesGridPageEntry.descriptor = {
    name = "BadgesGridPageEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgesGridPageEntry"
}

tbl1.BadgesGridPageEntry = BadgesGridPageEntry

typeRegistry.default:register(tbl1.BadgesGridPageEntry)

local BadgesGridPageEntry_BadgeInputData = {}
BadgesGridPageEntry_BadgeInputData.__index = BadgesGridPageEntry_BadgeInputData

function BadgesGridPageEntry_BadgeInputData.new(tbl6)
    return (setmetatable(
        {
            badge_id = if tbl6 == nil or tbl6.badge_id == nil then "" else tbl6.badge_id
        },
        BadgesGridPageEntry_BadgeInputData
    ))
end

function BadgesGridPageEntry_BadgeInputData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.badge_id ~= nil and self.badge_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.badge_id)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesGridPageEntry_BadgeInputData.decode(buf1: buffer)
    local var1 = BadgesGridPageEntry_BadgeInputData.new()
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

function BadgesGridPageEntry_BadgeInputData:jsonEncode()
    local result = {}

    if self.badge_id ~= nil and self.badge_id ~= "" then
        result.badgeId = self.badge_id
    end

    return result
end

function BadgesGridPageEntry_BadgeInputData:jsonDecode()
    local var1 = BadgesGridPageEntry_BadgeInputData.new()

    if self.badge_id ~= nil then
        var1.badge_id = self.badge_id
    end

    if self.badgeId ~= nil then
        var1.badge_id = self.badgeId
    end

    return var1
end

BadgesGridPageEntry_BadgeInputData.descriptor = {
    name = "BadgesGridPageEntry_BadgeInputData",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgeInputData"
}

tbl1.BadgesGridPageEntry_BadgeInputData = BadgesGridPageEntry_BadgeInputData

typeRegistry.default:register(tbl1.BadgesGridPageEntry_BadgeInputData)

local BadgesSeeAllPageEntry = {}
BadgesSeeAllPageEntry.__index = BadgesSeeAllPageEntry

function BadgesSeeAllPageEntry.new(tbl7)
    return (setmetatable({
        page_entry = if tbl7 == nil or tbl7.page_entry == nil then nil else tbl7.page_entry,
        kind = if tbl7 == nil or tbl7.kind == nil then nil else tbl7.kind
    }, BadgesSeeAllPageEntry))
end

function BadgesSeeAllPageEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.page_entry ~= nil then
        local buf = self.page_entry:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil and self.kind.type == "badges_grid" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesSeeAllPageEntry.decode(buf1: buffer)
    local var1 = BadgesSeeAllPageEntry.new()
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
                    type = "badges_grid",
                    value = tbl1.BadgesGridPageEntry.decode(var4)
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

function BadgesSeeAllPageEntry:jsonEncode()
    local result = {}

    if self.page_entry ~= nil then
        result.pageEntry = self.page_entry:jsonEncode()
    end

    if self.kind ~= nil and self.kind.type == "badges_grid" then
        result.badgesGrid = self.kind.value:jsonEncode()
    end

    return result
end

function BadgesSeeAllPageEntry:jsonDecode()
    local var1 = BadgesSeeAllPageEntry.new()

    if self.page_entry ~= nil then
        var1.page_entry = page_entry.PageEntry.jsonDecode(self.page_entry)
    end

    if self.pageEntry ~= nil then
        var1.page_entry = page_entry.PageEntry.jsonDecode(self.pageEntry)
    end

    if self.badges_grid ~= nil then
        var1.kind = {
            type = "badges_grid",
            value = tbl1.BadgesGridPageEntry.jsonDecode(self.badges_grid)
        }
    end
    if self.badgesGrid ~= nil then
        var1.kind = {
            type = "badges_grid",
            value = tbl1.BadgesGridPageEntry.jsonDecode(self.badgesGrid)
        }
    end
    return var1
end

BadgesSeeAllPageEntry.descriptor = {
    name = "BadgesSeeAllPageEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgesSeeAllPageEntry"
}

tbl1.BadgesSeeAllPageEntry = BadgesSeeAllPageEntry

typeRegistry.default:register(tbl1.BadgesSeeAllPageEntry)

local BadgesSeeAllResponse = {}
BadgesSeeAllResponse.__index = BadgesSeeAllResponse

function BadgesSeeAllResponse.new(tbl8)
    return (setmetatable({
        page_entries = (tbl8 == nil or tbl8.page_entries == nil) and {} or tbl8.page_entries,
        hydration_data = if tbl8 == nil or tbl8.hydration_data == nil then nil else tbl8.hydration_data,
        templates = (tbl8 == nil or tbl8.templates == nil) and {} or tbl8.templates,
        pagination = if tbl8 == nil or tbl8.pagination == nil then nil else tbl8.pagination
    }, BadgesSeeAllResponse))
end

function BadgesSeeAllResponse:encode(): buffer
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

    if self.pagination ~= nil then
        local buf = self.pagination:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesSeeAllResponse.decode(buf1: buffer)
    local var1 = BadgesSeeAllResponse.new()
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
                table.insert(var1.page_entries, tbl1.BadgesSeeAllPageEntry.decode(var4))
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.hydration_data = hydration_content.HydrationContent.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.BadgesSeeAllResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
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

function BadgesSeeAllResponse:jsonEncode()
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

    if self.pagination ~= nil then
        result.pagination = self.pagination:jsonEncode()
    end

    return result
end

function BadgesSeeAllResponse:jsonDecode()
    local var1 = BadgesSeeAllResponse.new()

    if self.page_entries ~= nil then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, tbl1.BadgesSeeAllPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.pageEntries ~= nil then
        local pageEntries = {}
        for _, value in self.pageEntries do
            table.insert(pageEntries, tbl1.BadgesSeeAllPageEntry.jsonDecode(value))
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

    if self.pagination ~= nil then
        var1.pagination = tbl1.Pagination.jsonDecode(self.pagination)
    end

    return var1
end

BadgesSeeAllResponse.descriptor = {
    name = "BadgesSeeAllResponse",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgesSeeAllResponse"
}

tbl1.BadgesSeeAllResponse = BadgesSeeAllResponse

typeRegistry.default:register(tbl1.BadgesSeeAllResponse)

local BadgesSeeAllResponse_TemplatesEntry = {}
BadgesSeeAllResponse_TemplatesEntry.__index = BadgesSeeAllResponse_TemplatesEntry

function BadgesSeeAllResponse_TemplatesEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then nil else tbl9.value
    }, BadgesSeeAllResponse_TemplatesEntry))
end

function BadgesSeeAllResponse_TemplatesEntry:encode(): buffer
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

function BadgesSeeAllResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = BadgesSeeAllResponse_TemplatesEntry.new()
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

function BadgesSeeAllResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function BadgesSeeAllResponse_TemplatesEntry:jsonDecode()
    local var1 = BadgesSeeAllResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

BadgesSeeAllResponse_TemplatesEntry.descriptor = {
    name = "BadgesSeeAllResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.TemplatesEntry"
}

tbl1.BadgesSeeAllResponse_TemplatesEntry = BadgesSeeAllResponse_TemplatesEntry

typeRegistry.default:register(tbl1.BadgesSeeAllResponse_TemplatesEntry)

local BadgesSeeAllV2Response = {}
BadgesSeeAllV2Response.__index = BadgesSeeAllV2Response

function BadgesSeeAllV2Response.new(tbl10)
    return (setmetatable({
        page_entries = (tbl10 == nil or tbl10.page_entries == nil) and {} or tbl10.page_entries,
        hydration_data = if tbl10 == nil or tbl10.hydration_data == nil then nil else tbl10.hydration_data,
        templates = (tbl10 == nil or tbl10.templates == nil) and {} or tbl10.templates,
        pagination = if tbl10 == nil or tbl10.pagination == nil then nil else tbl10.pagination
    }, BadgesSeeAllV2Response))
end

function BadgesSeeAllV2Response:encode(): buffer
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

    if self.pagination ~= nil then
        local buf = self.pagination:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BadgesSeeAllV2Response.decode(buf1: buffer)
    local var1 = BadgesSeeAllV2Response.new()
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

                local var5 = tbl1.BadgesSeeAllV2Response_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
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

function BadgesSeeAllV2Response:jsonEncode()
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

    if self.pagination ~= nil then
        result.pagination = self.pagination:jsonEncode()
    end

    return result
end

function BadgesSeeAllV2Response:jsonDecode()
    local var1 = BadgesSeeAllV2Response.new()

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

    if self.pagination ~= nil then
        var1.pagination = tbl1.Pagination.jsonDecode(self.pagination)
    end

    return var1
end

BadgesSeeAllV2Response.descriptor = {
    name = "BadgesSeeAllV2Response",
    fullName = "roblox.apppageplatform.badges.v1beta1.BadgesSeeAllV2Response"
}

tbl1.BadgesSeeAllV2Response = BadgesSeeAllV2Response

typeRegistry.default:register(tbl1.BadgesSeeAllV2Response)

local BadgesSeeAllV2Response_TemplatesEntry = {}
BadgesSeeAllV2Response_TemplatesEntry.__index = BadgesSeeAllV2Response_TemplatesEntry

function BadgesSeeAllV2Response_TemplatesEntry.new(tbl11)
    return (setmetatable({
        key = if tbl11 == nil or tbl11.key == nil then "" else tbl11.key,
        value = if tbl11 == nil or tbl11.value == nil then nil else tbl11.value
    }, BadgesSeeAllV2Response_TemplatesEntry))
end

function BadgesSeeAllV2Response_TemplatesEntry:encode(): buffer
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

function BadgesSeeAllV2Response_TemplatesEntry.decode(buf1: buffer)
    local var1 = BadgesSeeAllV2Response_TemplatesEntry.new()
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

function BadgesSeeAllV2Response_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function BadgesSeeAllV2Response_TemplatesEntry:jsonDecode()
    local var1 = BadgesSeeAllV2Response_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

BadgesSeeAllV2Response_TemplatesEntry.descriptor = {
    name = "BadgesSeeAllV2Response_TemplatesEntry",
    fullName = "roblox.apppageplatform.badges.v1beta1.TemplatesEntry"
}

tbl1.BadgesSeeAllV2Response_TemplatesEntry = BadgesSeeAllV2Response_TemplatesEntry

typeRegistry.default:register(tbl1.BadgesSeeAllV2Response_TemplatesEntry)

return {
    BadgesSeeAllRequest = tbl1.BadgesSeeAllRequest,
    Pagination = tbl1.Pagination,
    BadgesGridPageEntry = tbl1.BadgesGridPageEntry,
    BadgesGridPageEntry_BadgeInputData = tbl1.BadgesGridPageEntry_BadgeInputData,
    BadgesSeeAllPageEntry = tbl1.BadgesSeeAllPageEntry,
    BadgesSeeAllResponse = tbl1.BadgesSeeAllResponse,
    BadgesSeeAllV2Response = tbl1.BadgesSeeAllV2Response
}

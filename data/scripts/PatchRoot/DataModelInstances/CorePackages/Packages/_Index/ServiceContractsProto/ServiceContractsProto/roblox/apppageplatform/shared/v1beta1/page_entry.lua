-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local surfacing = require(script.Parent.surfacing)

local PageEntry = {}
PageEntry.__index = PageEntry

function PageEntry.new(tbl3)
    return (setmetatable({
        roblox_component = if tbl3 == nil or tbl3.roblox_component == nil then "" else tbl3.roblox_component,
        identifier = if tbl3 == nil or tbl3.identifier == nil then "" else tbl3.identifier,
        title = if tbl3 == nil or tbl3.title == nil then "" else tbl3.title,
        category = if tbl3 == nil or tbl3.category == nil then "" else tbl3.category,
        surfacing = if tbl3 == nil or tbl3.surfacing == nil then nil else tbl3.surfacing
    }, PageEntry))
end

function PageEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.roblox_component ~= nil and self.roblox_component ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.roblox_component)
    end

    if self.identifier ~= nil and self.identifier ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.identifier)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.category ~= nil and self.category ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.category)
    end

    if self.surfacing ~= nil then
        local buf = self.surfacing:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PageEntry.decode(buf1: buffer)
    local var1 = PageEntry.new()
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
                var1.roblox_component = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.identifier = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.category = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.surfacing = surfacing.Surfacing.decode(var4)
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

function PageEntry:jsonEncode()
    local result = {}

    if self.roblox_component ~= nil and self.roblox_component ~= "" then
        result.robloxComponent = self.roblox_component
    end

    if self.identifier ~= nil and self.identifier ~= "" then
        result.identifier = self.identifier
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    if self.category ~= nil and self.category ~= "" then
        result.category = self.category
    end

    if self.surfacing ~= nil then
        result.surfacing = self.surfacing:jsonEncode()
    end

    return result
end

function PageEntry:jsonDecode()
    local var1 = PageEntry.new()

    if self.roblox_component ~= nil then
        var1.roblox_component = self.roblox_component
    end

    if self.robloxComponent ~= nil then
        var1.roblox_component = self.robloxComponent
    end

    if self.identifier ~= nil then
        var1.identifier = self.identifier
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.category ~= nil then
        var1.category = self.category
    end

    if self.surfacing ~= nil then
        var1.surfacing = surfacing.Surfacing.jsonDecode(self.surfacing)
    end

    return var1
end

PageEntry.descriptor = {
    name = "PageEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.PageEntry"
}

tbl1.PageEntry = PageEntry

typeRegistry.default:register(tbl1.PageEntry)

return {
    PageEntry = tbl1.PageEntry
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local ui_component_schema = require(script.Parent.ui_component_schema)

local TemplateEntry = {}
TemplateEntry.__index = TemplateEntry

function TemplateEntry.new(tbl3)
    return (setmetatable({
        template = if tbl3 == nil or tbl3.template == nil then nil else tbl3.template,
        roblox_component = if tbl3 == nil or tbl3.roblox_component == nil then "" else tbl3.roblox_component
    }, TemplateEntry))
end

function TemplateEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.template ~= nil then
        local buf = self.template:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.roblox_component ~= nil and self.roblox_component ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.roblox_component)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TemplateEntry.decode(buf1: buffer)
    local var1 = TemplateEntry.new()
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
                var1.template = ui_component_schema.UiComponentSchema.decode(var4)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.roblox_component = buffer.tostring(buf)
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

function TemplateEntry:jsonEncode()
    local result = {}

    if self.template ~= nil then
        result.template = self.template:jsonEncode()
    end

    if self.roblox_component ~= nil and self.roblox_component ~= "" then
        result.robloxComponent = self.roblox_component
    end

    return result
end

function TemplateEntry:jsonDecode()
    local var1 = TemplateEntry.new()

    if self.template ~= nil then
        var1.template = ui_component_schema.UiComponentSchema.jsonDecode(self.template)
    end

    if self.roblox_component ~= nil then
        var1.roblox_component = self.roblox_component
    end

    if self.robloxComponent ~= nil then
        var1.roblox_component = self.robloxComponent
    end

    return var1
end

TemplateEntry.descriptor = {
    name = "TemplateEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.TemplateEntry"
}

tbl1.TemplateEntry = TemplateEntry

typeRegistry.default:register(tbl1.TemplateEntry)

return {
    TemplateEntry = tbl1.TemplateEntry
}

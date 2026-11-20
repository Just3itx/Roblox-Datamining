-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local Struct = {}
Struct.__index = Struct

function Struct.new(tbl3)
    return (setmetatable({ fields = (tbl3 == nil or tbl3.fields == nil) and {} or tbl3.fields }, Struct))
end

function Struct:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.fields ~= nil and next(self.fields) ~= nil then
        for k, field in self.fields do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local buf = field:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Struct.decode(buf1: buffer)
    local var1 = Struct.new()
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

                local var5 = tbl1.Struct_FieldsEntry.decode(var4)

                local value = tbl1.Value.new()

                var1.fields[var5.key or ""] = var5.value or value
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

function Struct:jsonEncode()
    local result = ({})

    for k, field in self.fields do
        result[k] = tbl1.Value.jsonEncode(field)
    end

    return result
end

function Struct.jsonDecode(tbl3)
    local fields = ({})

    for value, value2 in tbl3 do
        fields[value] = tbl1.Value.jsonDecode(value2)
    end

    return Struct.new({ fields = fields })
end

Struct.descriptor = { name = "Struct", fullName = "google.protobuf.Struct" }

tbl1.Struct = Struct

typeRegistry.default:register(tbl1.Struct)

local Struct_FieldsEntry = {}
Struct_FieldsEntry.__index = Struct_FieldsEntry

function Struct_FieldsEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then nil else tbl4.value
    }, Struct_FieldsEntry))
end

function Struct_FieldsEntry:encode(): buffer
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

function Struct_FieldsEntry.decode(buf1: buffer)
    local var1 = Struct_FieldsEntry.new()
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
                var1.value = tbl1.Value.decode(var4)
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

function Struct_FieldsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function Struct_FieldsEntry:jsonDecode()
    local var1 = Struct_FieldsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = tbl1.Value.jsonDecode(self.value)
    end

    return var1
end

Struct_FieldsEntry.descriptor = {
    name = "Struct_FieldsEntry",
    fullName = "google.protobuf.FieldsEntry"
}

tbl1.Struct_FieldsEntry = Struct_FieldsEntry

typeRegistry.default:register(tbl1.Struct_FieldsEntry)

local tbl4 = {}
tbl4.__index = tbl4

function tbl4.new(tbl5)
    return (setmetatable({ kind = if tbl5 == nil or tbl5.kind == nil then nil else tbl5.kind }, tbl4))
end

function tbl4:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "null_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.NullValue.toNumber(self.kind.value))
        elseif self.kind.type == "number_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i64)
            buffer2, num1 = proto.writeDouble(var1, var2, self.kind.value)
        elseif self.kind.type == "string_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "bool_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, if self.kind.value then 1 else 0)
        elseif self.kind.type == "struct_value" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "list_value" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function tbl4.decode(buf1: buffer)
    local var1 = tbl4.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "null_value",
                    value = tbl1.NullValue.fromNumber(var4) or var4
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.kind = {
                    type = "bool_value",
                    value = var4 ~= 0
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "string_value",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "struct_value",
                    value = tbl1.Struct.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "list_value",
                    value = tbl1.ListValue.decode(var4)
                }
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 ~= proto.wireTypes.i64 then
            error("Unsupported wire type: " .. var3)
        elseif var2 == 2 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.kind = { type = "number_value", value = var4 }
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function tbl4:jsonEncode()
    local kind = self.kind

    if kind == nil or kind.type == "null_value" then
        return nil
    elseif kind.type == "number_value" or kind.type == "string_value" or kind.type == "bool_value" then
        return kind.value
    elseif kind.type == "list_value" then
        return tbl1.ListValue.jsonEncode(kind.value)
    elseif kind.type == "struct_value" then
        return tbl1.Struct.jsonEncode(kind.value)
    end
    return kind.type
end

function tbl4.jsonDecode(value)
    if value == nil then
        return tbl4.new({ kind = { type = "null_value", value = "NULL_VALUE" } })
    end

    if typeof(value) == "number" then
        return tbl4.new({ kind = { type = "number_value", value = value } })
    end

    if typeof(value) == "string" then
        return tbl4.new({ kind = { type = "string_value", value = value } })
    end

    if typeof(value) == "boolean" then
        return tbl4.new({ kind = { type = "bool_value", value = value } })
    end

    if typeof(value) ~= "table" then
        error(`Unknown input type: {typeof(value)}`)

        return
    end

    local num1 = 0
    for _ in value do
        num1 += 1
        if #value < num1 then
            break
        end
    end

    if num1 == #value then
        return tbl4.new({ kind = { type = "list_value", value = tbl1.ListValue.jsonDecode(value) } })
    end
    return tbl4.new({ kind = { type = "struct_value", value = tbl1.Struct.jsonDecode(value) } })
end
tbl4.descriptor = { name = "Value", fullName = "google.protobuf.Value" }

tbl1.Value = tbl4

typeRegistry.default:register(tbl1.Value)

local ListValue = {}
ListValue.__index = ListValue

function ListValue.new(tbl6)
    return (setmetatable({ values = (tbl6 == nil or tbl6.values == nil) and {} or tbl6.values }, ListValue))
end

function ListValue:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.values ~= nil and #self.values > 0 then
        for _, value in self.values do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ListValue.decode(buf1: buffer)
    local var1 = ListValue.new()
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
                table.insert(var1.values, tbl1.Value.decode(var4))
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

function ListValue:jsonEncode()
    local result = {}

    for _, value in self.values do
        table.insert(result, tbl1.Value.jsonEncode(value))
    end

    return result
end

function ListValue.jsonDecode(arg1)
    local values = {}

    for _, value in arg1 do
        table.insert(values, tbl1.Value.jsonDecode(value))
    end

    return ListValue.new({ values = values })
end

ListValue.descriptor = { name = "ListValue", fullName = "google.protobuf.ListValue" }

tbl1.ListValue = ListValue

typeRegistry.default:register(tbl1.ListValue)

tbl1.NullValue = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "NULL_VALUE" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "NULL_VALUE" then 0 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "NULL_VALUE" then "NULL_VALUE" else nil
    end
}

return {
    Struct = tbl1.Struct,
    Value = tbl1.Value,
    ListValue = tbl1.ListValue,
    NullValue = tbl1.NullValue
}

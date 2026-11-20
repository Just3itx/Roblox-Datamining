-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local PropCondition = {}
PropCondition.__index = PropCondition

function PropCondition.new(tbl3)
    return (setmetatable({ kind = if tbl3 == nil or tbl3.kind == nil then nil else tbl3.kind }, PropCondition))
end

function PropCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "comparison" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "is_null" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "is_not_null" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "and_condition" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "or_condition" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "is_empty" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "is_not_empty" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "contains" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PropCondition.decode(buf1: buffer)
    local var1 = PropCondition.new()
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
                var1.kind = {
                    type = "comparison",
                    value = tbl1.ComparisonCondition.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "is_null",
                    value = tbl1.IsNullCondition.decode(var4)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "is_not_null",
                    value = tbl1.IsNotNullCondition.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "and_condition",
                    value = tbl1.AndCondition.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "or_condition",
                    value = tbl1.OrCondition.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "is_empty",
                    value = tbl1.IsEmptyCondition.decode(var4)
                }
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "is_not_empty",
                    value = tbl1.IsNotEmptyCondition.decode(var4)
                }
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "contains",
                    value = tbl1.ContainsCondition.decode(var4)
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

function PropCondition:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "comparison" then
            result.comparison = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "is_null" then
            result.isNull = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "is_not_null" then
            result.isNotNull = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "and_condition" then
            result.andCondition = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "or_condition" then
            result.orCondition = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "is_empty" then
            result.isEmpty = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "is_not_empty" then
            result.isNotEmpty = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "contains" then
            result.contains = self.kind.value:jsonEncode()
        end
    end

    return result
end

function PropCondition.jsonDecode(tbl3)
    local var1 = PropCondition.new()

    if tbl3.comparison ~= nil then
        var1.kind = {
            type = "comparison",
            value = tbl1.ComparisonCondition.jsonDecode(tbl3.comparison)
        }
    end
    if tbl3.is_null ~= nil then
        var1.kind = {
            type = "is_null",
            value = tbl1.IsNullCondition.jsonDecode(tbl3.is_null)
        }
    end
    if tbl3.isNull ~= nil then
        var1.kind = {
            type = "is_null",
            value = tbl1.IsNullCondition.jsonDecode(tbl3.isNull)
        }
    end
    if tbl3.is_not_null ~= nil then
        var1.kind = {
            type = "is_not_null",
            value = tbl1.IsNotNullCondition.jsonDecode(tbl3.is_not_null)
        }
    end
    if tbl3.isNotNull ~= nil then
        var1.kind = {
            type = "is_not_null",
            value = tbl1.IsNotNullCondition.jsonDecode(tbl3.isNotNull)
        }
    end
    if tbl3.and_condition ~= nil then
        var1.kind = {
            type = "and_condition",
            value = tbl1.AndCondition.jsonDecode(tbl3.and_condition)
        }
    end
    if tbl3.andCondition ~= nil then
        var1.kind = {
            type = "and_condition",
            value = tbl1.AndCondition.jsonDecode(tbl3.andCondition)
        }
    end
    if tbl3.or_condition ~= nil then
        var1.kind = {
            type = "or_condition",
            value = tbl1.OrCondition.jsonDecode(tbl3.or_condition)
        }
    end
    if tbl3.orCondition ~= nil then
        var1.kind = {
            type = "or_condition",
            value = tbl1.OrCondition.jsonDecode(tbl3.orCondition)
        }
    end
    if tbl3.is_empty ~= nil then
        var1.kind = {
            type = "is_empty",
            value = tbl1.IsEmptyCondition.jsonDecode(tbl3.is_empty)
        }
    end
    if tbl3.isEmpty ~= nil then
        var1.kind = {
            type = "is_empty",
            value = tbl1.IsEmptyCondition.jsonDecode(tbl3.isEmpty)
        }
    end
    if tbl3.is_not_empty ~= nil then
        var1.kind = {
            type = "is_not_empty",
            value = tbl1.IsNotEmptyCondition.jsonDecode(tbl3.is_not_empty)
        }
    end
    if tbl3.isNotEmpty ~= nil then
        var1.kind = {
            type = "is_not_empty",
            value = tbl1.IsNotEmptyCondition.jsonDecode(tbl3.isNotEmpty)
        }
    end
    if tbl3.contains ~= nil then
        var1.kind = {
            type = "contains",
            value = tbl1.ContainsCondition.jsonDecode(tbl3.contains)
        }
    end
    return var1
end

PropCondition.descriptor = {
    name = "PropCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.PropCondition"
}

tbl1.PropCondition = PropCondition

typeRegistry.default:register(tbl1.PropCondition)

local ComparisonCondition = {}
ComparisonCondition.__index = ComparisonCondition

function ComparisonCondition.new(tbl4)
    local tbl5 = {
        field = if tbl4 == nil or tbl4.field == nil then "" else tbl4.field,
        op = if tbl4 == nil or tbl4.op == nil then assert(tbl1.ComparisonCondition_Op.fromNumber(0), "Enum has no 0 default") else tbl4.op,
        kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind
    }
    return (setmetatable(tbl5, ComparisonCondition))
end

function ComparisonCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    if self.op ~= nil and (self.op ~= nil and self.op ~= 0 or self.op ~= tbl1.ComparisonCondition_Op.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ComparisonCondition_Op.toNumber(self.op))
    end

    if self.kind ~= nil then
        if self.kind.type == "string_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "bool_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, if self.kind.value then 1 else 0)
        elseif self.kind.type == "int32_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "int64_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "float_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.i32)
            buffer2, num1 = proto.writeFloat(var1, var2, self.kind.value)
        elseif self.kind.type == "double_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.i64)
            buffer2, num1 = proto.writeDouble(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ComparisonCondition.decode(buf1: buffer)
    local var1 = ComparisonCondition.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.op = tbl1.ComparisonCondition_Op.fromNumber(var4) or var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.kind = {
                    type = "bool_value",
                    value = var4 ~= 0
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = { type = "int32_value", value = var4 }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.kind = { type = "int64_value", value = var4 }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.field = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "string_value",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 9 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path_value",
                    value = buffer.tostring(buf)
                }
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 7 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.kind = { type = "float_value", value = var4 }
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 ~= proto.wireTypes.i64 then
            error("Unsupported wire type: " .. var3)
        elseif var2 == 8 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.kind = { type = "double_value", value = var4 }
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function ComparisonCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    if self.op ~= nil and (self.op ~= nil and self.op ~= 0 or self.op ~= tbl1.ComparisonCondition_Op.fromNumber(0)) then
        result.op = if typeof(self.op) == "number" then self.op else tbl1.ComparisonCondition_Op.toNumber(self.op)
    end

    if self.kind ~= nil then
        if self.kind.type == "string_value" then
            result.stringValue = self.kind.value
            return result
        elseif self.kind.type == "bool_value" then
            result.boolValue = self.kind.value
            return result
        elseif self.kind.type == "int32_value" then
            result.int32Value = self.kind.value
            return result
        elseif self.kind.type == "int64_value" then
            result.int64Value = self.kind.value
            return result
        elseif self.kind.type == "float_value" then
            result.floatValue = proto.json.serializeNumber(self.kind.value)
            return result
        elseif self.kind.type == "double_value" then
            result.doubleValue = proto.json.serializeNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path_value" then
            result.bindingPathValue = self.kind.value
        end
    end

    return result
end

function ComparisonCondition:jsonDecode()
    local var1 = ComparisonCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    if self.op ~= nil then
        var1.op = if typeof(self.op) == "number" then tbl1.ComparisonCondition_Op.fromNumber(self.op) or self.op else tbl1.ComparisonCondition_Op.fromName(self.op) or self.op
    end

    if self.string_value ~= nil then
        var1.kind = {
            type = "string_value",
            value = self.string_value
        }
    end
    if self.stringValue ~= nil then
        var1.kind = {
            type = "string_value",
            value = self.stringValue
        }
    end
    if self.bool_value ~= nil then
        var1.kind = {
            type = "bool_value",
            value = self.bool_value
        }
    end
    if self.boolValue ~= nil then
        var1.kind = {
            type = "bool_value",
            value = self.boolValue
        }
    end
    if self.int32_value ~= nil then
        var1.kind = {
            type = "int32_value",
            value = self.int32_value
        }
    end
    if self.int32Value ~= nil then
        var1.kind = {
            type = "int32_value",
            value = self.int32Value
        }
    end
    if self.int64_value ~= nil then
        var1.kind = {
            type = "int64_value",
            value = self.int64_value
        }
    end
    if self.int64Value ~= nil then
        var1.kind = {
            type = "int64_value",
            value = self.int64Value
        }
    end
    if self.float_value ~= nil then
        var1.kind = {
            type = "float_value",
            value = proto.json.deserializeNumber(self.float_value)
        }
    end
    if self.floatValue ~= nil then
        var1.kind = {
            type = "float_value",
            value = proto.json.deserializeNumber(self.floatValue)
        }
    end
    if self.double_value ~= nil then
        var1.kind = {
            type = "double_value",
            value = proto.json.deserializeNumber(self.double_value)
        }
    end
    if self.doubleValue ~= nil then
        var1.kind = {
            type = "double_value",
            value = proto.json.deserializeNumber(self.doubleValue)
        }
    end
    if self.binding_path_value ~= nil then
        var1.kind = {
            type = "binding_path_value",
            value = self.binding_path_value
        }
    end
    if self.bindingPathValue ~= nil then
        var1.kind = {
            type = "binding_path_value",
            value = self.bindingPathValue
        }
    end
    return var1
end

ComparisonCondition.descriptor = {
    name = "ComparisonCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.ComparisonCondition"
}

tbl1.ComparisonCondition = ComparisonCondition

typeRegistry.default:register(tbl1.ComparisonCondition)

tbl1.ComparisonCondition_Op = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "OP_INVALID"
        elseif num1 == 1 then
            return "OP_LT"
        elseif num1 == 2 then
            return "OP_LTE"
        elseif num1 == 3 then
            return "OP_GT"
        elseif num1 == 4 then
            return "OP_GTE"
        elseif num1 == 5 then
            return "OP_E"
        elseif num1 == 6 then
            return "OP_NE"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "OP_INVALID" then
            return 0
        elseif arg1 == "OP_LT" then
            return 1
        elseif arg1 == "OP_LTE" then
            return 2
        elseif arg1 == "OP_GT" then
            return 3
        elseif arg1 == "OP_GTE" then
            return 4
        elseif arg1 == "OP_E" then
            return 5
        elseif arg1 == "OP_NE" then
            return 6
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "OP_INVALID" then
            return "OP_INVALID"
        elseif str1 == "OP_LT" then
            return "OP_LT"
        elseif str1 == "OP_LTE" then
            return "OP_LTE"
        elseif str1 == "OP_GT" then
            return "OP_GT"
        elseif str1 == "OP_GTE" then
            return "OP_GTE"
        elseif str1 == "OP_E" then
            return "OP_E"
        elseif str1 == "OP_NE" then
            return "OP_NE"
        end

        return nil
    end
}

local IsNullCondition = {}
IsNullCondition.__index = IsNullCondition

function IsNullCondition.new(tbl5)
    return (setmetatable({ field = if tbl5 == nil or tbl5.field == nil then "" else tbl5.field }, IsNullCondition))
end

function IsNullCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IsNullCondition.decode(buf1: buffer)
    local var1 = IsNullCondition.new()
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
                var1.field = buffer.tostring(buf)
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

function IsNullCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    return result
end

function IsNullCondition:jsonDecode()
    local var1 = IsNullCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    return var1
end

IsNullCondition.descriptor = {
    name = "IsNullCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.IsNullCondition"
}

tbl1.IsNullCondition = IsNullCondition

typeRegistry.default:register(tbl1.IsNullCondition)

local IsNotNullCondition = {}
IsNotNullCondition.__index = IsNotNullCondition

function IsNotNullCondition.new(tbl6)
    return (setmetatable({ field = if tbl6 == nil or tbl6.field == nil then "" else tbl6.field }, IsNotNullCondition))
end

function IsNotNullCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IsNotNullCondition.decode(buf1: buffer)
    local var1 = IsNotNullCondition.new()
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
                var1.field = buffer.tostring(buf)
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

function IsNotNullCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    return result
end

function IsNotNullCondition:jsonDecode()
    local var1 = IsNotNullCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    return var1
end

IsNotNullCondition.descriptor = {
    name = "IsNotNullCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.IsNotNullCondition"
}

tbl1.IsNotNullCondition = IsNotNullCondition

typeRegistry.default:register(tbl1.IsNotNullCondition)

local IsEmptyCondition = {}
IsEmptyCondition.__index = IsEmptyCondition

function IsEmptyCondition.new(tbl7)
    return (setmetatable({ field = if tbl7 == nil or tbl7.field == nil then "" else tbl7.field }, IsEmptyCondition))
end

function IsEmptyCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IsEmptyCondition.decode(buf1: buffer)
    local var1 = IsEmptyCondition.new()
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
                var1.field = buffer.tostring(buf)
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

function IsEmptyCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    return result
end

function IsEmptyCondition:jsonDecode()
    local var1 = IsEmptyCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    return var1
end

IsEmptyCondition.descriptor = {
    name = "IsEmptyCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.IsEmptyCondition"
}

tbl1.IsEmptyCondition = IsEmptyCondition

typeRegistry.default:register(tbl1.IsEmptyCondition)

local IsNotEmptyCondition = {}
IsNotEmptyCondition.__index = IsNotEmptyCondition

function IsNotEmptyCondition.new(tbl8)
    return (setmetatable({ field = if tbl8 == nil or tbl8.field == nil then "" else tbl8.field }, IsNotEmptyCondition))
end

function IsNotEmptyCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IsNotEmptyCondition.decode(buf1: buffer)
    local var1 = IsNotEmptyCondition.new()
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
                var1.field = buffer.tostring(buf)
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

function IsNotEmptyCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    return result
end

function IsNotEmptyCondition:jsonDecode()
    local var1 = IsNotEmptyCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    return var1
end

IsNotEmptyCondition.descriptor = {
    name = "IsNotEmptyCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.IsNotEmptyCondition"
}

tbl1.IsNotEmptyCondition = IsNotEmptyCondition

typeRegistry.default:register(tbl1.IsNotEmptyCondition)

local ContainsCondition = {}
ContainsCondition.__index = ContainsCondition

function ContainsCondition.new(tbl9)
    return (setmetatable({
        field = if tbl9 == nil or tbl9.field == nil then "" else tbl9.field,
        kind = if tbl9 == nil or tbl9.kind == nil then nil else tbl9.kind
    }, ContainsCondition))
end

function ContainsCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field ~= nil and self.field ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field)
    end

    if self.kind ~= nil then
        if self.kind.type == "string_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path_value" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ContainsCondition.decode(buf1: buffer)
    local var1 = ContainsCondition.new()
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
                var1.field = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "string_value",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path_value",
                    value = buffer.tostring(buf)
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

function ContainsCondition:jsonEncode()
    local result = {}

    if self.field ~= nil and self.field ~= "" then
        result.field = self.field
    end

    if self.kind ~= nil then
        if self.kind.type == "string_value" then
            result.stringValue = self.kind.value
            return result
        end

        if self.kind.type == "binding_path_value" then
            result.bindingPathValue = self.kind.value
        end
    end

    return result
end

function ContainsCondition:jsonDecode()
    local var1 = ContainsCondition.new()

    if self.field ~= nil then
        var1.field = self.field
    end

    if self.string_value ~= nil then
        var1.kind = {
            type = "string_value",
            value = self.string_value
        }
    end
    if self.stringValue ~= nil then
        var1.kind = {
            type = "string_value",
            value = self.stringValue
        }
    end
    if self.binding_path_value ~= nil then
        var1.kind = {
            type = "binding_path_value",
            value = self.binding_path_value
        }
    end
    if self.bindingPathValue ~= nil then
        var1.kind = {
            type = "binding_path_value",
            value = self.bindingPathValue
        }
    end
    return var1
end

ContainsCondition.descriptor = {
    name = "ContainsCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.ContainsCondition"
}

tbl1.ContainsCondition = ContainsCondition

typeRegistry.default:register(tbl1.ContainsCondition)

local AndCondition = {}
AndCondition.__index = AndCondition

function AndCondition.new(tbl10)
    return (setmetatable({ conditions = (tbl10 == nil or tbl10.conditions == nil) and {} or tbl10.conditions }, AndCondition))
end

function AndCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.conditions ~= nil and #self.conditions > 0 then
        for _, condition in self.conditions do
            local buf = condition:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AndCondition.decode(buf1: buffer)
    local var1 = AndCondition.new()
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
                table.insert(var1.conditions, tbl1.PropCondition.decode(var4))
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

function AndCondition:jsonEncode()
    local result = {}

    if self.conditions ~= nil and #self.conditions > 0 then
        local conditions = {}
        for _, condition in self.conditions do
            table.insert(conditions, condition:jsonEncode())
        end
        result.conditions = conditions
    end

    return result
end

function AndCondition:jsonDecode()
    local var1 = AndCondition.new()

    if self.conditions ~= nil then
        local conditions = {}
        for _, condition in self.conditions do
            table.insert(conditions, tbl1.PropCondition.jsonDecode(condition))
        end

        var1.conditions = conditions
    end

    return var1
end

AndCondition.descriptor = {
    name = "AndCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.AndCondition"
}

tbl1.AndCondition = AndCondition

typeRegistry.default:register(tbl1.AndCondition)

local OrCondition = {}
OrCondition.__index = OrCondition

function OrCondition.new(tbl11)
    return (setmetatable({ conditions = (tbl11 == nil or tbl11.conditions == nil) and {} or tbl11.conditions }, OrCondition))
end

function OrCondition:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.conditions ~= nil and #self.conditions > 0 then
        for _, condition in self.conditions do
            local buf = condition:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function OrCondition.decode(buf1: buffer)
    local var1 = OrCondition.new()
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
                table.insert(var1.conditions, tbl1.PropCondition.decode(var4))
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

function OrCondition:jsonEncode()
    local result = {}

    if self.conditions ~= nil and #self.conditions > 0 then
        local conditions = {}
        for _, condition in self.conditions do
            table.insert(conditions, condition:jsonEncode())
        end
        result.conditions = conditions
    end

    return result
end

function OrCondition:jsonDecode()
    local var1 = OrCondition.new()

    if self.conditions ~= nil then
        local conditions = {}
        for _, condition in self.conditions do
            table.insert(conditions, tbl1.PropCondition.jsonDecode(condition))
        end

        var1.conditions = conditions
    end

    return var1
end

OrCondition.descriptor = {
    name = "OrCondition",
    fullName = "roblox.apppageplatform.shared.v1beta1.OrCondition"
}

tbl1.OrCondition = OrCondition

typeRegistry.default:register(tbl1.OrCondition)

return {
    PropCondition = tbl1.PropCondition,
    ComparisonCondition = tbl1.ComparisonCondition,
    ComparisonCondition_Op = tbl1.ComparisonCondition_Op,
    IsNullCondition = tbl1.IsNullCondition,
    IsNotNullCondition = tbl1.IsNotNullCondition,
    IsEmptyCondition = tbl1.IsEmptyCondition,
    IsNotEmptyCondition = tbl1.IsNotEmptyCondition,
    ContainsCondition = tbl1.ContainsCondition,
    AndCondition = tbl1.AndCondition,
    OrCondition = tbl1.OrCondition
}

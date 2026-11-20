-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local prop_condition = require(script.Parent.prop_condition)

local AnalyticsDataField = {}
AnalyticsDataField.__index = AnalyticsDataField

function AnalyticsDataField.new(tbl3)
    return (setmetatable({ kind = if tbl3 == nil or tbl3.kind == nil then nil else tbl3.kind }, AnalyticsDataField))
end

function AnalyticsDataField:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AnalyticsDataField.decode(buf1: buffer)
    local var1 = AnalyticsDataField.new()
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
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.AnalyticsDataField_ConditionalOptions.decode(var4)
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

function AnalyticsDataField:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function AnalyticsDataField.jsonDecode(tbl3)
    local var1 = AnalyticsDataField.new()

    if tbl3.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl3.binding_path
        }
    end
    if tbl3.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl3.bindingPath
        }
    end
    if tbl3.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl3.literal
        }
    end
    if tbl3.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.AnalyticsDataField_ConditionalOptions.jsonDecode(tbl3.conditional)
        }
    end

    return var1
end

AnalyticsDataField.descriptor = {
    name = "AnalyticsDataField",
    fullName = "roblox.apppageplatform.shared.v1beta1.AnalyticsDataField"
}

tbl1.AnalyticsDataField = AnalyticsDataField

typeRegistry.default:register(tbl1.AnalyticsDataField)

local AnalyticsDataField_ConditionalOption = {}
AnalyticsDataField_ConditionalOption.__index = AnalyticsDataField_ConditionalOption

function AnalyticsDataField_ConditionalOption.new(tbl4)
    return (setmetatable({
        condition = if tbl4 == nil or tbl4.condition == nil then nil else tbl4.condition,
        kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind
    }, AnalyticsDataField_ConditionalOption))
end

function AnalyticsDataField_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AnalyticsDataField_ConditionalOption.decode(buf1: buffer)
    local var1 = AnalyticsDataField_ConditionalOption.new()
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
                var1.condition = prop_condition.PropCondition.decode(var4)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
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

function AnalyticsDataField_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function AnalyticsDataField_ConditionalOption:jsonDecode()
    local var1 = AnalyticsDataField_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = self.binding_path
        }
    end
    if self.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = self.bindingPath
        }
    end
    return var1
end

AnalyticsDataField_ConditionalOption.descriptor = {
    name = "AnalyticsDataField_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.AnalyticsDataField_ConditionalOption = AnalyticsDataField_ConditionalOption

typeRegistry.default:register(tbl1.AnalyticsDataField_ConditionalOption)

local AnalyticsDataField_ConditionalOptions = {}
AnalyticsDataField_ConditionalOptions.__index = AnalyticsDataField_ConditionalOptions

function AnalyticsDataField_ConditionalOptions.new(tbl5)
    return (setmetatable(
        {
            options = (tbl5 == nil or tbl5.options == nil) and {} or tbl5.options
        },
        AnalyticsDataField_ConditionalOptions
    ))
end

function AnalyticsDataField_ConditionalOptions:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.options ~= nil and #self.options > 0 then
        for _, option in self.options do
            local buf = option:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AnalyticsDataField_ConditionalOptions.decode(buf1: buffer)
    local var1 = AnalyticsDataField_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.AnalyticsDataField_ConditionalOption.decode(var4))
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

function AnalyticsDataField_ConditionalOptions:jsonEncode()
    local result = {}

    if self.options ~= nil and #self.options > 0 then
        local options = {}
        for _, option in self.options do
            table.insert(options, option:jsonEncode())
        end
        result.options = options
    end

    return result
end

function AnalyticsDataField_ConditionalOptions:jsonDecode()
    local var1 = AnalyticsDataField_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.AnalyticsDataField_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

AnalyticsDataField_ConditionalOptions.descriptor = {
    name = "AnalyticsDataField_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.AnalyticsDataField_ConditionalOptions = AnalyticsDataField_ConditionalOptions

typeRegistry.default:register(tbl1.AnalyticsDataField_ConditionalOptions)

return {
    AnalyticsDataField = tbl1.AnalyticsDataField,
    AnalyticsDataField_ConditionalOption = tbl1.AnalyticsDataField_ConditionalOption,
    AnalyticsDataField_ConditionalOptions = tbl1.AnalyticsDataField_ConditionalOptions
}

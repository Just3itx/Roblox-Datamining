-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local prop_condition = require(script.Parent.prop_condition)

local AutomaticSizeProp = {}
AutomaticSizeProp.__index = AutomaticSizeProp

function AutomaticSizeProp.new(tbl3)
    return (setmetatable({ kind = if tbl3 == nil or tbl3.kind == nil then nil else tbl3.kind }, AutomaticSizeProp))
end

function AutomaticSizeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.AutomaticSize.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function AutomaticSizeProp.decode(buf1: buffer)
    local var1 = AutomaticSizeProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.AutomaticSize.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.AutomaticSizeProp_ConditionalOptions.decode(var4)
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

function AutomaticSizeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.AutomaticSize.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function AutomaticSizeProp.jsonDecode(tbl3)
    local var1 = AutomaticSizeProp.new()

    if tbl3.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl3.literal) == "number" then tbl1.AutomaticSize.fromNumber(tbl3.literal) or tbl3.literal else tbl1.AutomaticSize.fromName(tbl3.literal) or tbl3.literal
        }
    end

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
    if tbl3.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.AutomaticSizeProp_ConditionalOptions.jsonDecode(tbl3.conditional)
        }
    end

    return var1
end

AutomaticSizeProp.descriptor = {
    name = "AutomaticSizeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.AutomaticSizeProp"
}

tbl1.AutomaticSizeProp = AutomaticSizeProp

typeRegistry.default:register(tbl1.AutomaticSizeProp)

local AutomaticSizeProp_ConditionalOption = {}
AutomaticSizeProp_ConditionalOption.__index = AutomaticSizeProp_ConditionalOption

function AutomaticSizeProp_ConditionalOption.new(tbl4)
    return (setmetatable({
        condition = if tbl4 == nil or tbl4.condition == nil then nil else tbl4.condition,
        kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind
    }, AutomaticSizeProp_ConditionalOption))
end

function AutomaticSizeProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.AutomaticSize.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AutomaticSizeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = AutomaticSizeProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.AutomaticSize.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function AutomaticSizeProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.AutomaticSize.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function AutomaticSizeProp_ConditionalOption:jsonDecode()
    local var1 = AutomaticSizeProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.AutomaticSize.fromNumber(self.literal) or self.literal else tbl1.AutomaticSize.fromName(self.literal) or self.literal
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

AutomaticSizeProp_ConditionalOption.descriptor = {
    name = "AutomaticSizeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.AutomaticSizeProp_ConditionalOption = AutomaticSizeProp_ConditionalOption

typeRegistry.default:register(tbl1.AutomaticSizeProp_ConditionalOption)

local AutomaticSizeProp_ConditionalOptions = {}
AutomaticSizeProp_ConditionalOptions.__index = AutomaticSizeProp_ConditionalOptions

function AutomaticSizeProp_ConditionalOptions.new(tbl5)
    return (setmetatable(
        {
            options = (tbl5 == nil or tbl5.options == nil) and {} or tbl5.options
        },
        AutomaticSizeProp_ConditionalOptions
    ))
end

function AutomaticSizeProp_ConditionalOptions:encode(): buffer
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

function AutomaticSizeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = AutomaticSizeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.AutomaticSizeProp_ConditionalOption.decode(var4))
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

function AutomaticSizeProp_ConditionalOptions:jsonEncode()
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

function AutomaticSizeProp_ConditionalOptions:jsonDecode()
    local var1 = AutomaticSizeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.AutomaticSizeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

AutomaticSizeProp_ConditionalOptions.descriptor = {
    name = "AutomaticSizeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.AutomaticSizeProp_ConditionalOptions = AutomaticSizeProp_ConditionalOptions

typeRegistry.default:register(tbl1.AutomaticSizeProp_ConditionalOptions)

local TextTruncateProp = {}
TextTruncateProp.__index = TextTruncateProp

function TextTruncateProp.new(tbl6)
    return (setmetatable({ kind = if tbl6 == nil or tbl6.kind == nil then nil else tbl6.kind }, TextTruncateProp))
end

function TextTruncateProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextTruncate.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function TextTruncateProp.decode(buf1: buffer)
    local var1 = TextTruncateProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextTruncate.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.TextTruncateProp_ConditionalOptions.decode(var4)
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

function TextTruncateProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextTruncate.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function TextTruncateProp.jsonDecode(tbl6)
    local var1 = TextTruncateProp.new()

    if tbl6.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl6.literal) == "number" then tbl1.TextTruncate.fromNumber(tbl6.literal) or tbl6.literal else tbl1.TextTruncate.fromName(tbl6.literal) or tbl6.literal
        }
    end

    if tbl6.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl6.binding_path
        }
    end
    if tbl6.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl6.bindingPath
        }
    end
    if tbl6.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.TextTruncateProp_ConditionalOptions.jsonDecode(tbl6.conditional)
        }
    end

    return var1
end

TextTruncateProp.descriptor = {
    name = "TextTruncateProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.TextTruncateProp"
}

tbl1.TextTruncateProp = TextTruncateProp

typeRegistry.default:register(tbl1.TextTruncateProp)

local TextTruncateProp_ConditionalOption = {}
TextTruncateProp_ConditionalOption.__index = TextTruncateProp_ConditionalOption

function TextTruncateProp_ConditionalOption.new(tbl7)
    return (setmetatable({
        condition = if tbl7 == nil or tbl7.condition == nil then nil else tbl7.condition,
        kind = if tbl7 == nil or tbl7.kind == nil then nil else tbl7.kind
    }, TextTruncateProp_ConditionalOption))
end

function TextTruncateProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextTruncate.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TextTruncateProp_ConditionalOption.decode(buf1: buffer)
    local var1 = TextTruncateProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextTruncate.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function TextTruncateProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextTruncate.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function TextTruncateProp_ConditionalOption:jsonDecode()
    local var1 = TextTruncateProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.TextTruncate.fromNumber(self.literal) or self.literal else tbl1.TextTruncate.fromName(self.literal) or self.literal
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

TextTruncateProp_ConditionalOption.descriptor = {
    name = "TextTruncateProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.TextTruncateProp_ConditionalOption = TextTruncateProp_ConditionalOption

typeRegistry.default:register(tbl1.TextTruncateProp_ConditionalOption)

local TextTruncateProp_ConditionalOptions = {}
TextTruncateProp_ConditionalOptions.__index = TextTruncateProp_ConditionalOptions

function TextTruncateProp_ConditionalOptions.new(tbl8)
    return (setmetatable(
        {
            options = (tbl8 == nil or tbl8.options == nil) and {} or tbl8.options
        },
        TextTruncateProp_ConditionalOptions
    ))
end

function TextTruncateProp_ConditionalOptions:encode(): buffer
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

function TextTruncateProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = TextTruncateProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.TextTruncateProp_ConditionalOption.decode(var4))
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

function TextTruncateProp_ConditionalOptions:jsonEncode()
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

function TextTruncateProp_ConditionalOptions:jsonDecode()
    local var1 = TextTruncateProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.TextTruncateProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

TextTruncateProp_ConditionalOptions.descriptor = {
    name = "TextTruncateProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.TextTruncateProp_ConditionalOptions = TextTruncateProp_ConditionalOptions

typeRegistry.default:register(tbl1.TextTruncateProp_ConditionalOptions)

local TextXAlignmentProp = {}
TextXAlignmentProp.__index = TextXAlignmentProp

function TextXAlignmentProp.new(tbl9)
    return (setmetatable({ kind = if tbl9 == nil or tbl9.kind == nil then nil else tbl9.kind }, TextXAlignmentProp))
end

function TextXAlignmentProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextXAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function TextXAlignmentProp.decode(buf1: buffer)
    local var1 = TextXAlignmentProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextXAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.TextXAlignmentProp_ConditionalOptions.decode(var4)
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

function TextXAlignmentProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextXAlignment.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function TextXAlignmentProp.jsonDecode(tbl9)
    local var1 = TextXAlignmentProp.new()

    if tbl9.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl9.literal) == "number" then tbl1.TextXAlignment.fromNumber(tbl9.literal) or tbl9.literal else tbl1.TextXAlignment.fromName(tbl9.literal) or tbl9.literal
        }
    end

    if tbl9.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl9.binding_path
        }
    end
    if tbl9.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl9.bindingPath
        }
    end
    if tbl9.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.TextXAlignmentProp_ConditionalOptions.jsonDecode(tbl9.conditional)
        }
    end

    return var1
end

TextXAlignmentProp.descriptor = {
    name = "TextXAlignmentProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.TextXAlignmentProp"
}

tbl1.TextXAlignmentProp = TextXAlignmentProp

typeRegistry.default:register(tbl1.TextXAlignmentProp)

local TextXAlignmentProp_ConditionalOption = {}
TextXAlignmentProp_ConditionalOption.__index = TextXAlignmentProp_ConditionalOption

function TextXAlignmentProp_ConditionalOption.new(tbl10)
    return (setmetatable({
        condition = if tbl10 == nil or tbl10.condition == nil then nil else tbl10.condition,
        kind = if tbl10 == nil or tbl10.kind == nil then nil else tbl10.kind
    }, TextXAlignmentProp_ConditionalOption))
end

function TextXAlignmentProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextXAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TextXAlignmentProp_ConditionalOption.decode(buf1: buffer)
    local var1 = TextXAlignmentProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextXAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function TextXAlignmentProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextXAlignment.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function TextXAlignmentProp_ConditionalOption:jsonDecode()
    local var1 = TextXAlignmentProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.TextXAlignment.fromNumber(self.literal) or self.literal else tbl1.TextXAlignment.fromName(self.literal) or self.literal
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

TextXAlignmentProp_ConditionalOption.descriptor = {
    name = "TextXAlignmentProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.TextXAlignmentProp_ConditionalOption = TextXAlignmentProp_ConditionalOption

typeRegistry.default:register(tbl1.TextXAlignmentProp_ConditionalOption)

local TextXAlignmentProp_ConditionalOptions = {}
TextXAlignmentProp_ConditionalOptions.__index = TextXAlignmentProp_ConditionalOptions

function TextXAlignmentProp_ConditionalOptions.new(tbl11)
    return (setmetatable(
        {
            options = (tbl11 == nil or tbl11.options == nil) and {} or tbl11.options
        },
        TextXAlignmentProp_ConditionalOptions
    ))
end

function TextXAlignmentProp_ConditionalOptions:encode(): buffer
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

function TextXAlignmentProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = TextXAlignmentProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.TextXAlignmentProp_ConditionalOption.decode(var4))
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

function TextXAlignmentProp_ConditionalOptions:jsonEncode()
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

function TextXAlignmentProp_ConditionalOptions:jsonDecode()
    local var1 = TextXAlignmentProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.TextXAlignmentProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

TextXAlignmentProp_ConditionalOptions.descriptor = {
    name = "TextXAlignmentProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.TextXAlignmentProp_ConditionalOptions = TextXAlignmentProp_ConditionalOptions

typeRegistry.default:register(tbl1.TextXAlignmentProp_ConditionalOptions)

local TextYAlignmentProp = {}
TextYAlignmentProp.__index = TextYAlignmentProp

function TextYAlignmentProp.new(tbl12)
    return (setmetatable({ kind = if tbl12 == nil or tbl12.kind == nil then nil else tbl12.kind }, TextYAlignmentProp))
end

function TextYAlignmentProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextYAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function TextYAlignmentProp.decode(buf1: buffer)
    local var1 = TextYAlignmentProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextYAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.TextYAlignmentProp_ConditionalOptions.decode(var4)
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

function TextYAlignmentProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextYAlignment.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function TextYAlignmentProp.jsonDecode(tbl12)
    local var1 = TextYAlignmentProp.new()

    if tbl12.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl12.literal) == "number" then tbl1.TextYAlignment.fromNumber(tbl12.literal) or tbl12.literal else tbl1.TextYAlignment.fromName(tbl12.literal) or tbl12.literal
        }
    end

    if tbl12.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl12.binding_path
        }
    end
    if tbl12.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl12.bindingPath
        }
    end
    if tbl12.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.TextYAlignmentProp_ConditionalOptions.jsonDecode(tbl12.conditional)
        }
    end

    return var1
end

TextYAlignmentProp.descriptor = {
    name = "TextYAlignmentProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.TextYAlignmentProp"
}

tbl1.TextYAlignmentProp = TextYAlignmentProp

typeRegistry.default:register(tbl1.TextYAlignmentProp)

local TextYAlignmentProp_ConditionalOption = {}
TextYAlignmentProp_ConditionalOption.__index = TextYAlignmentProp_ConditionalOption

function TextYAlignmentProp_ConditionalOption.new(tbl13)
    return (setmetatable({
        condition = if tbl13 == nil or tbl13.condition == nil then nil else tbl13.condition,
        kind = if tbl13 == nil or tbl13.kind == nil then nil else tbl13.kind
    }, TextYAlignmentProp_ConditionalOption))
end

function TextYAlignmentProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.TextYAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TextYAlignmentProp_ConditionalOption.decode(buf1: buffer)
    local var1 = TextYAlignmentProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.TextYAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function TextYAlignmentProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.TextYAlignment.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function TextYAlignmentProp_ConditionalOption:jsonDecode()
    local var1 = TextYAlignmentProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.TextYAlignment.fromNumber(self.literal) or self.literal else tbl1.TextYAlignment.fromName(self.literal) or self.literal
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

TextYAlignmentProp_ConditionalOption.descriptor = {
    name = "TextYAlignmentProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.TextYAlignmentProp_ConditionalOption = TextYAlignmentProp_ConditionalOption

typeRegistry.default:register(tbl1.TextYAlignmentProp_ConditionalOption)

local TextYAlignmentProp_ConditionalOptions = {}
TextYAlignmentProp_ConditionalOptions.__index = TextYAlignmentProp_ConditionalOptions

function TextYAlignmentProp_ConditionalOptions.new(tbl14)
    return (setmetatable(
        {
            options = (tbl14 == nil or tbl14.options == nil) and {} or tbl14.options
        },
        TextYAlignmentProp_ConditionalOptions
    ))
end

function TextYAlignmentProp_ConditionalOptions:encode(): buffer
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

function TextYAlignmentProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = TextYAlignmentProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.TextYAlignmentProp_ConditionalOption.decode(var4))
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

function TextYAlignmentProp_ConditionalOptions:jsonEncode()
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

function TextYAlignmentProp_ConditionalOptions:jsonDecode()
    local var1 = TextYAlignmentProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.TextYAlignmentProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

TextYAlignmentProp_ConditionalOptions.descriptor = {
    name = "TextYAlignmentProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.TextYAlignmentProp_ConditionalOptions = TextYAlignmentProp_ConditionalOptions

typeRegistry.default:register(tbl1.TextYAlignmentProp_ConditionalOptions)

local UIFlexModeProp = {}
UIFlexModeProp.__index = UIFlexModeProp

function UIFlexModeProp.new(tbl15)
    return (setmetatable({ kind = if tbl15 == nil or tbl15.kind == nil then nil else tbl15.kind }, UIFlexModeProp))
end

function UIFlexModeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.UIFlexMode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function UIFlexModeProp.decode(buf1: buffer)
    local var1 = UIFlexModeProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.UIFlexMode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UIFlexModeProp_ConditionalOptions.decode(var4)
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

function UIFlexModeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.UIFlexMode.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function UIFlexModeProp.jsonDecode(tbl15)
    local var1 = UIFlexModeProp.new()

    if tbl15.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl15.literal) == "number" then tbl1.UIFlexMode.fromNumber(tbl15.literal) or tbl15.literal else tbl1.UIFlexMode.fromName(tbl15.literal) or tbl15.literal
        }
    end

    if tbl15.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl15.binding_path
        }
    end
    if tbl15.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl15.bindingPath
        }
    end
    if tbl15.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UIFlexModeProp_ConditionalOptions.jsonDecode(tbl15.conditional)
        }
    end

    return var1
end

UIFlexModeProp.descriptor = {
    name = "UIFlexModeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.UIFlexModeProp"
}

tbl1.UIFlexModeProp = UIFlexModeProp

typeRegistry.default:register(tbl1.UIFlexModeProp)

local UIFlexModeProp_ConditionalOption = {}
UIFlexModeProp_ConditionalOption.__index = UIFlexModeProp_ConditionalOption

function UIFlexModeProp_ConditionalOption.new(tbl16)
    return (setmetatable({
        condition = if tbl16 == nil or tbl16.condition == nil then nil else tbl16.condition,
        kind = if tbl16 == nil or tbl16.kind == nil then nil else tbl16.kind
    }, UIFlexModeProp_ConditionalOption))
end

function UIFlexModeProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.UIFlexMode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UIFlexModeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = UIFlexModeProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.UIFlexMode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function UIFlexModeProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.UIFlexMode.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UIFlexModeProp_ConditionalOption:jsonDecode()
    local var1 = UIFlexModeProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.UIFlexMode.fromNumber(self.literal) or self.literal else tbl1.UIFlexMode.fromName(self.literal) or self.literal
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

UIFlexModeProp_ConditionalOption.descriptor = {
    name = "UIFlexModeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UIFlexModeProp_ConditionalOption = UIFlexModeProp_ConditionalOption

typeRegistry.default:register(tbl1.UIFlexModeProp_ConditionalOption)

local UIFlexModeProp_ConditionalOptions = {}
UIFlexModeProp_ConditionalOptions.__index = UIFlexModeProp_ConditionalOptions

function UIFlexModeProp_ConditionalOptions.new(tbl17)
    return (setmetatable(
        {
            options = (tbl17 == nil or tbl17.options == nil) and {} or tbl17.options
        },
        UIFlexModeProp_ConditionalOptions
    ))
end

function UIFlexModeProp_ConditionalOptions:encode(): buffer
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

function UIFlexModeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = UIFlexModeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UIFlexModeProp_ConditionalOption.decode(var4))
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

function UIFlexModeProp_ConditionalOptions:jsonEncode()
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

function UIFlexModeProp_ConditionalOptions:jsonDecode()
    local var1 = UIFlexModeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UIFlexModeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UIFlexModeProp_ConditionalOptions.descriptor = {
    name = "UIFlexModeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UIFlexModeProp_ConditionalOptions = UIFlexModeProp_ConditionalOptions

typeRegistry.default:register(tbl1.UIFlexModeProp_ConditionalOptions)

local ScaleTypeProp = {}
ScaleTypeProp.__index = ScaleTypeProp

function ScaleTypeProp.new(tbl18)
    return (setmetatable({ kind = if tbl18 == nil or tbl18.kind == nil then nil else tbl18.kind }, ScaleTypeProp))
end

function ScaleTypeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ScaleType.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function ScaleTypeProp.decode(buf1: buffer)
    local var1 = ScaleTypeProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ScaleType.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ScaleTypeProp_ConditionalOptions.decode(var4)
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

function ScaleTypeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ScaleType.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ScaleTypeProp.jsonDecode(tbl18)
    local var1 = ScaleTypeProp.new()

    if tbl18.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl18.literal) == "number" then tbl1.ScaleType.fromNumber(tbl18.literal) or tbl18.literal else tbl1.ScaleType.fromName(tbl18.literal) or tbl18.literal
        }
    end

    if tbl18.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl18.binding_path
        }
    end
    if tbl18.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl18.bindingPath
        }
    end
    if tbl18.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ScaleTypeProp_ConditionalOptions.jsonDecode(tbl18.conditional)
        }
    end

    return var1
end

ScaleTypeProp.descriptor = {
    name = "ScaleTypeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ScaleTypeProp"
}

tbl1.ScaleTypeProp = ScaleTypeProp

typeRegistry.default:register(tbl1.ScaleTypeProp)

local ScaleTypeProp_ConditionalOption = {}
ScaleTypeProp_ConditionalOption.__index = ScaleTypeProp_ConditionalOption

function ScaleTypeProp_ConditionalOption.new(tbl19)
    return (setmetatable({
        condition = if tbl19 == nil or tbl19.condition == nil then nil else tbl19.condition,
        kind = if tbl19 == nil or tbl19.kind == nil then nil else tbl19.kind
    }, ScaleTypeProp_ConditionalOption))
end

function ScaleTypeProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ScaleType.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ScaleTypeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ScaleTypeProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ScaleType.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function ScaleTypeProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ScaleType.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ScaleTypeProp_ConditionalOption:jsonDecode()
    local var1 = ScaleTypeProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.ScaleType.fromNumber(self.literal) or self.literal else tbl1.ScaleType.fromName(self.literal) or self.literal
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

ScaleTypeProp_ConditionalOption.descriptor = {
    name = "ScaleTypeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ScaleTypeProp_ConditionalOption = ScaleTypeProp_ConditionalOption

typeRegistry.default:register(tbl1.ScaleTypeProp_ConditionalOption)

local ScaleTypeProp_ConditionalOptions = {}
ScaleTypeProp_ConditionalOptions.__index = ScaleTypeProp_ConditionalOptions

function ScaleTypeProp_ConditionalOptions.new(tbl20)
    return (setmetatable(
        {
            options = (tbl20 == nil or tbl20.options == nil) and {} or tbl20.options
        },
        ScaleTypeProp_ConditionalOptions
    ))
end

function ScaleTypeProp_ConditionalOptions:encode(): buffer
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

function ScaleTypeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ScaleTypeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ScaleTypeProp_ConditionalOption.decode(var4))
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

function ScaleTypeProp_ConditionalOptions:jsonEncode()
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

function ScaleTypeProp_ConditionalOptions:jsonDecode()
    local var1 = ScaleTypeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ScaleTypeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ScaleTypeProp_ConditionalOptions.descriptor = {
    name = "ScaleTypeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ScaleTypeProp_ConditionalOptions = ScaleTypeProp_ConditionalOptions

typeRegistry.default:register(tbl1.ScaleTypeProp_ConditionalOptions)

local ResamplerModeProp = {}
ResamplerModeProp.__index = ResamplerModeProp

function ResamplerModeProp.new(tbl21)
    return (setmetatable({ kind = if tbl21 == nil or tbl21.kind == nil then nil else tbl21.kind }, ResamplerModeProp))
end

function ResamplerModeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ResamplerMode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function ResamplerModeProp.decode(buf1: buffer)
    local var1 = ResamplerModeProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ResamplerMode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ResamplerModeProp_ConditionalOptions.decode(var4)
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

function ResamplerModeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ResamplerMode.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ResamplerModeProp.jsonDecode(tbl21)
    local var1 = ResamplerModeProp.new()

    if tbl21.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl21.literal) == "number" then tbl1.ResamplerMode.fromNumber(tbl21.literal) or tbl21.literal else tbl1.ResamplerMode.fromName(tbl21.literal) or tbl21.literal
        }
    end

    if tbl21.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl21.binding_path
        }
    end
    if tbl21.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl21.bindingPath
        }
    end
    if tbl21.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ResamplerModeProp_ConditionalOptions.jsonDecode(tbl21.conditional)
        }
    end

    return var1
end

ResamplerModeProp.descriptor = {
    name = "ResamplerModeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ResamplerModeProp"
}

tbl1.ResamplerModeProp = ResamplerModeProp

typeRegistry.default:register(tbl1.ResamplerModeProp)

local ResamplerModeProp_ConditionalOption = {}
ResamplerModeProp_ConditionalOption.__index = ResamplerModeProp_ConditionalOption

function ResamplerModeProp_ConditionalOption.new(tbl22)
    return (setmetatable({
        condition = if tbl22 == nil or tbl22.condition == nil then nil else tbl22.condition,
        kind = if tbl22 == nil or tbl22.kind == nil then nil else tbl22.kind
    }, ResamplerModeProp_ConditionalOption))
end

function ResamplerModeProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ResamplerMode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ResamplerModeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ResamplerModeProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ResamplerMode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function ResamplerModeProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ResamplerMode.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ResamplerModeProp_ConditionalOption:jsonDecode()
    local var1 = ResamplerModeProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.ResamplerMode.fromNumber(self.literal) or self.literal else tbl1.ResamplerMode.fromName(self.literal) or self.literal
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

ResamplerModeProp_ConditionalOption.descriptor = {
    name = "ResamplerModeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ResamplerModeProp_ConditionalOption = ResamplerModeProp_ConditionalOption

typeRegistry.default:register(tbl1.ResamplerModeProp_ConditionalOption)

local ResamplerModeProp_ConditionalOptions = {}
ResamplerModeProp_ConditionalOptions.__index = ResamplerModeProp_ConditionalOptions

function ResamplerModeProp_ConditionalOptions.new(tbl23)
    return (setmetatable(
        {
            options = (tbl23 == nil or tbl23.options == nil) and {} or tbl23.options
        },
        ResamplerModeProp_ConditionalOptions
    ))
end

function ResamplerModeProp_ConditionalOptions:encode(): buffer
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

function ResamplerModeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ResamplerModeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ResamplerModeProp_ConditionalOption.decode(var4))
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

function ResamplerModeProp_ConditionalOptions:jsonEncode()
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

function ResamplerModeProp_ConditionalOptions:jsonDecode()
    local var1 = ResamplerModeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ResamplerModeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ResamplerModeProp_ConditionalOptions.descriptor = {
    name = "ResamplerModeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ResamplerModeProp_ConditionalOptions = ResamplerModeProp_ConditionalOptions

typeRegistry.default:register(tbl1.ResamplerModeProp_ConditionalOptions)

local SizeConstraintProp = {}
SizeConstraintProp.__index = SizeConstraintProp

function SizeConstraintProp.new(tbl24)
    return (setmetatable({ kind = if tbl24 == nil or tbl24.kind == nil then nil else tbl24.kind }, SizeConstraintProp))
end

function SizeConstraintProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.SizeConstraint.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function SizeConstraintProp.decode(buf1: buffer)
    local var1 = SizeConstraintProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.SizeConstraint.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.SizeConstraintProp_ConditionalOptions.decode(var4)
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

function SizeConstraintProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.SizeConstraint.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function SizeConstraintProp.jsonDecode(tbl24)
    local var1 = SizeConstraintProp.new()

    if tbl24.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl24.literal) == "number" then tbl1.SizeConstraint.fromNumber(tbl24.literal) or tbl24.literal else tbl1.SizeConstraint.fromName(tbl24.literal) or tbl24.literal
        }
    end

    if tbl24.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl24.binding_path
        }
    end
    if tbl24.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl24.bindingPath
        }
    end
    if tbl24.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.SizeConstraintProp_ConditionalOptions.jsonDecode(tbl24.conditional)
        }
    end

    return var1
end

SizeConstraintProp.descriptor = {
    name = "SizeConstraintProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.SizeConstraintProp"
}

tbl1.SizeConstraintProp = SizeConstraintProp

typeRegistry.default:register(tbl1.SizeConstraintProp)

local SizeConstraintProp_ConditionalOption = {}
SizeConstraintProp_ConditionalOption.__index = SizeConstraintProp_ConditionalOption

function SizeConstraintProp_ConditionalOption.new(tbl25)
    return (setmetatable({
        condition = if tbl25 == nil or tbl25.condition == nil then nil else tbl25.condition,
        kind = if tbl25 == nil or tbl25.kind == nil then nil else tbl25.kind
    }, SizeConstraintProp_ConditionalOption))
end

function SizeConstraintProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.SizeConstraint.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SizeConstraintProp_ConditionalOption.decode(buf1: buffer)
    local var1 = SizeConstraintProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.SizeConstraint.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function SizeConstraintProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.SizeConstraint.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function SizeConstraintProp_ConditionalOption:jsonDecode()
    local var1 = SizeConstraintProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.SizeConstraint.fromNumber(self.literal) or self.literal else tbl1.SizeConstraint.fromName(self.literal) or self.literal
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

SizeConstraintProp_ConditionalOption.descriptor = {
    name = "SizeConstraintProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.SizeConstraintProp_ConditionalOption = SizeConstraintProp_ConditionalOption

typeRegistry.default:register(tbl1.SizeConstraintProp_ConditionalOption)

local SizeConstraintProp_ConditionalOptions = {}
SizeConstraintProp_ConditionalOptions.__index = SizeConstraintProp_ConditionalOptions

function SizeConstraintProp_ConditionalOptions.new(tbl26)
    return (setmetatable(
        {
            options = (tbl26 == nil or tbl26.options == nil) and {} or tbl26.options
        },
        SizeConstraintProp_ConditionalOptions
    ))
end

function SizeConstraintProp_ConditionalOptions:encode(): buffer
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

function SizeConstraintProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = SizeConstraintProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.SizeConstraintProp_ConditionalOption.decode(var4))
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

function SizeConstraintProp_ConditionalOptions:jsonEncode()
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

function SizeConstraintProp_ConditionalOptions:jsonDecode()
    local var1 = SizeConstraintProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.SizeConstraintProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

SizeConstraintProp_ConditionalOptions.descriptor = {
    name = "SizeConstraintProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.SizeConstraintProp_ConditionalOptions = SizeConstraintProp_ConditionalOptions

typeRegistry.default:register(tbl1.SizeConstraintProp_ConditionalOptions)

local HorizontalAlignmentProp = {}
HorizontalAlignmentProp.__index = HorizontalAlignmentProp

function HorizontalAlignmentProp.new(tbl27)
    return (setmetatable({ kind = if tbl27 == nil or tbl27.kind == nil then nil else tbl27.kind }, HorizontalAlignmentProp))
end

function HorizontalAlignmentProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.HorizontalAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function HorizontalAlignmentProp.decode(buf1: buffer)
    local var1 = HorizontalAlignmentProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.HorizontalAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.HorizontalAlignmentProp_ConditionalOptions.decode(var4)
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

function HorizontalAlignmentProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.HorizontalAlignment.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function HorizontalAlignmentProp.jsonDecode(tbl27)
    local var1 = HorizontalAlignmentProp.new()

    if tbl27.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl27.literal) == "number" then tbl1.HorizontalAlignment.fromNumber(tbl27.literal) or tbl27.literal else tbl1.HorizontalAlignment.fromName(tbl27.literal) or tbl27.literal
        }
    end

    if tbl27.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl27.binding_path
        }
    end
    if tbl27.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl27.bindingPath
        }
    end
    if tbl27.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.HorizontalAlignmentProp_ConditionalOptions.jsonDecode(tbl27.conditional)
        }
    end

    return var1
end

HorizontalAlignmentProp.descriptor = {
    name = "HorizontalAlignmentProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.HorizontalAlignmentProp"
}

tbl1.HorizontalAlignmentProp = HorizontalAlignmentProp

typeRegistry.default:register(tbl1.HorizontalAlignmentProp)

local HorizontalAlignmentProp_ConditionalOption = {}
HorizontalAlignmentProp_ConditionalOption.__index = HorizontalAlignmentProp_ConditionalOption

function HorizontalAlignmentProp_ConditionalOption.new(tbl28)
    return (setmetatable({
        condition = if tbl28 == nil or tbl28.condition == nil then nil else tbl28.condition,
        kind = if tbl28 == nil or tbl28.kind == nil then nil else tbl28.kind
    }, HorizontalAlignmentProp_ConditionalOption))
end

function HorizontalAlignmentProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.HorizontalAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HorizontalAlignmentProp_ConditionalOption.decode(buf1: buffer)
    local var1 = HorizontalAlignmentProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.HorizontalAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function HorizontalAlignmentProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.HorizontalAlignment.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function HorizontalAlignmentProp_ConditionalOption:jsonDecode()
    local var1 = HorizontalAlignmentProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.HorizontalAlignment.fromNumber(self.literal) or self.literal else tbl1.HorizontalAlignment.fromName(self.literal) or self.literal
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

HorizontalAlignmentProp_ConditionalOption.descriptor = {
    name = "HorizontalAlignmentProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.HorizontalAlignmentProp_ConditionalOption = HorizontalAlignmentProp_ConditionalOption

typeRegistry.default:register(tbl1.HorizontalAlignmentProp_ConditionalOption)

local HorizontalAlignmentProp_ConditionalOptions = {}
HorizontalAlignmentProp_ConditionalOptions.__index = HorizontalAlignmentProp_ConditionalOptions

function HorizontalAlignmentProp_ConditionalOptions.new(tbl29)
    return (setmetatable(
        {
            option = (tbl29 == nil or tbl29.option == nil) and {} or tbl29.option
        },
        HorizontalAlignmentProp_ConditionalOptions
    ))
end

function HorizontalAlignmentProp_ConditionalOptions:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.option ~= nil and #self.option > 0 then
        for _, value in self.option do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HorizontalAlignmentProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = HorizontalAlignmentProp_ConditionalOptions.new()
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
                table.insert(var1.option, tbl1.HorizontalAlignmentProp_ConditionalOption.decode(var4))
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

function HorizontalAlignmentProp_ConditionalOptions:jsonEncode()
    local result = {}

    if self.option ~= nil and #self.option > 0 then
        local option = {}
        for _, value in self.option do
            table.insert(option, value:jsonEncode())
        end
        result.option = option
    end

    return result
end

function HorizontalAlignmentProp_ConditionalOptions:jsonDecode()
    local var1 = HorizontalAlignmentProp_ConditionalOptions.new()

    if self.option ~= nil then
        local option = {}
        for _, value in self.option do
            table.insert(option, tbl1.HorizontalAlignmentProp_ConditionalOption.jsonDecode(value))
        end

        var1.option = option
    end

    return var1
end

HorizontalAlignmentProp_ConditionalOptions.descriptor = {
    name = "HorizontalAlignmentProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.HorizontalAlignmentProp_ConditionalOptions = HorizontalAlignmentProp_ConditionalOptions

typeRegistry.default:register(tbl1.HorizontalAlignmentProp_ConditionalOptions)

local SelectionBehaviorProp = {}
SelectionBehaviorProp.__index = SelectionBehaviorProp

function SelectionBehaviorProp.new(tbl30)
    return (setmetatable({ kind = if tbl30 == nil or tbl30.kind == nil then nil else tbl30.kind }, SelectionBehaviorProp))
end

function SelectionBehaviorProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.SelectionBehavior.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function SelectionBehaviorProp.decode(buf1: buffer)
    local var1 = SelectionBehaviorProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.SelectionBehavior.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.SelectionBehaviorProp_ConditionalOptions.decode(var4)
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

function SelectionBehaviorProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.SelectionBehavior.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function SelectionBehaviorProp.jsonDecode(tbl30)
    local var1 = SelectionBehaviorProp.new()

    if tbl30.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl30.literal) == "number" then tbl1.SelectionBehavior.fromNumber(tbl30.literal) or tbl30.literal else tbl1.SelectionBehavior.fromName(tbl30.literal) or tbl30.literal
        }
    end

    if tbl30.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl30.binding_path
        }
    end
    if tbl30.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl30.bindingPath
        }
    end
    if tbl30.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.SelectionBehaviorProp_ConditionalOptions.jsonDecode(tbl30.conditional)
        }
    end

    return var1
end

SelectionBehaviorProp.descriptor = {
    name = "SelectionBehaviorProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.SelectionBehaviorProp"
}

tbl1.SelectionBehaviorProp = SelectionBehaviorProp

typeRegistry.default:register(tbl1.SelectionBehaviorProp)

local SelectionBehaviorProp_ConditionalOption = {}
SelectionBehaviorProp_ConditionalOption.__index = SelectionBehaviorProp_ConditionalOption

function SelectionBehaviorProp_ConditionalOption.new(tbl31)
    return (setmetatable({
        condition = if tbl31 == nil or tbl31.condition == nil then nil else tbl31.condition,
        kind = if tbl31 == nil or tbl31.kind == nil then nil else tbl31.kind
    }, SelectionBehaviorProp_ConditionalOption))
end

function SelectionBehaviorProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.SelectionBehavior.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function SelectionBehaviorProp_ConditionalOption.decode(buf1: buffer)
    local var1 = SelectionBehaviorProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.SelectionBehavior.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function SelectionBehaviorProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.SelectionBehavior.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function SelectionBehaviorProp_ConditionalOption:jsonDecode()
    local var1 = SelectionBehaviorProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.SelectionBehavior.fromNumber(self.literal) or self.literal else tbl1.SelectionBehavior.fromName(self.literal) or self.literal
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

SelectionBehaviorProp_ConditionalOption.descriptor = {
    name = "SelectionBehaviorProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.SelectionBehaviorProp_ConditionalOption = SelectionBehaviorProp_ConditionalOption

typeRegistry.default:register(tbl1.SelectionBehaviorProp_ConditionalOption)

local SelectionBehaviorProp_ConditionalOptions = {}
SelectionBehaviorProp_ConditionalOptions.__index = SelectionBehaviorProp_ConditionalOptions

function SelectionBehaviorProp_ConditionalOptions.new(tbl32)
    return (setmetatable(
        {
            options = (tbl32 == nil or tbl32.options == nil) and {} or tbl32.options
        },
        SelectionBehaviorProp_ConditionalOptions
    ))
end

function SelectionBehaviorProp_ConditionalOptions:encode(): buffer
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

function SelectionBehaviorProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = SelectionBehaviorProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.SelectionBehaviorProp_ConditionalOption.decode(var4))
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

function SelectionBehaviorProp_ConditionalOptions:jsonEncode()
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

function SelectionBehaviorProp_ConditionalOptions:jsonDecode()
    local var1 = SelectionBehaviorProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.SelectionBehaviorProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

SelectionBehaviorProp_ConditionalOptions.descriptor = {
    name = "SelectionBehaviorProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.SelectionBehaviorProp_ConditionalOptions = SelectionBehaviorProp_ConditionalOptions

typeRegistry.default:register(tbl1.SelectionBehaviorProp_ConditionalOptions)

local KeyCodeProp = {}
KeyCodeProp.__index = KeyCodeProp

function KeyCodeProp.new(tbl33)
    return (setmetatable({ kind = if tbl33 == nil or tbl33.kind == nil then nil else tbl33.kind }, KeyCodeProp))
end

function KeyCodeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.KeyCode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function KeyCodeProp.decode(buf1: buffer)
    local var1 = KeyCodeProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.KeyCode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.KeyCodeProp_ConditionalOptions.decode(var4)
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

function KeyCodeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.KeyCode.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function KeyCodeProp.jsonDecode(tbl33)
    local var1 = KeyCodeProp.new()

    if tbl33.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl33.literal) == "number" then tbl1.KeyCode.fromNumber(tbl33.literal) or tbl33.literal else tbl1.KeyCode.fromName(tbl33.literal) or tbl33.literal
        }
    end

    if tbl33.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl33.binding_path
        }
    end
    if tbl33.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl33.bindingPath
        }
    end
    if tbl33.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.KeyCodeProp_ConditionalOptions.jsonDecode(tbl33.conditional)
        }
    end
    return var1
end

KeyCodeProp.descriptor = {
    name = "KeyCodeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.KeyCodeProp"
}

tbl1.KeyCodeProp = KeyCodeProp

typeRegistry.default:register(tbl1.KeyCodeProp)

local KeyCodeProp_ConditionalOption = {}
KeyCodeProp_ConditionalOption.__index = KeyCodeProp_ConditionalOption

function KeyCodeProp_ConditionalOption.new(tbl34)
    return (setmetatable({
        condition = if tbl34 == nil or tbl34.condition == nil then nil else tbl34.condition,
        kind = if tbl34 == nil or tbl34.kind == nil then nil else tbl34.kind
    }, KeyCodeProp_ConditionalOption))
end

function KeyCodeProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.KeyCode.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function KeyCodeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = KeyCodeProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.KeyCode.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function KeyCodeProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.KeyCode.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function KeyCodeProp_ConditionalOption:jsonDecode()
    local var1 = KeyCodeProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.KeyCode.fromNumber(self.literal) or self.literal else tbl1.KeyCode.fromName(self.literal) or self.literal
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

KeyCodeProp_ConditionalOption.descriptor = {
    name = "KeyCodeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.KeyCodeProp_ConditionalOption = KeyCodeProp_ConditionalOption

typeRegistry.default:register(tbl1.KeyCodeProp_ConditionalOption)

local KeyCodeProp_ConditionalOptions = {}
KeyCodeProp_ConditionalOptions.__index = KeyCodeProp_ConditionalOptions

function KeyCodeProp_ConditionalOptions.new(tbl35)
    return (setmetatable(
        {
            options = (tbl35 == nil or tbl35.options == nil) and {} or tbl35.options
        },
        KeyCodeProp_ConditionalOptions
    ))
end

function KeyCodeProp_ConditionalOptions:encode(): buffer
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

function KeyCodeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = KeyCodeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.KeyCodeProp_ConditionalOption.decode(var4))
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

function KeyCodeProp_ConditionalOptions:jsonEncode()
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

function KeyCodeProp_ConditionalOptions:jsonDecode()
    local var1 = KeyCodeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.KeyCodeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

KeyCodeProp_ConditionalOptions.descriptor = {
    name = "KeyCodeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.KeyCodeProp_ConditionalOptions = KeyCodeProp_ConditionalOptions

typeRegistry.default:register(tbl1.KeyCodeProp_ConditionalOptions)

local VerticalAlignmentProp = {}
VerticalAlignmentProp.__index = VerticalAlignmentProp

function VerticalAlignmentProp.new(tbl36)
    return (setmetatable({ kind = if tbl36 == nil or tbl36.kind == nil then nil else tbl36.kind }, VerticalAlignmentProp))
end

function VerticalAlignmentProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.VerticalAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
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

function VerticalAlignmentProp.decode(buf1: buffer)
    local var1 = VerticalAlignmentProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.VerticalAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.VerticalAlignmentProp_ConditionalOptions.decode(var4)
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

function VerticalAlignmentProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.VerticalAlignment.toNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function VerticalAlignmentProp.jsonDecode(tbl36)
    local var1 = VerticalAlignmentProp.new()

    if tbl36.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl36.literal) == "number" then tbl1.VerticalAlignment.fromNumber(tbl36.literal) or tbl36.literal else tbl1.VerticalAlignment.fromName(tbl36.literal) or tbl36.literal
        }
    end

    if tbl36.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl36.binding_path
        }
    end
    if tbl36.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl36.bindingPath
        }
    end
    if tbl36.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.VerticalAlignmentProp_ConditionalOptions.jsonDecode(tbl36.conditional)
        }
    end

    return var1
end

VerticalAlignmentProp.descriptor = {
    name = "VerticalAlignmentProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.VerticalAlignmentProp"
}

tbl1.VerticalAlignmentProp = VerticalAlignmentProp

typeRegistry.default:register(tbl1.VerticalAlignmentProp)

local VerticalAlignmentProp_ConditionalOption = {}
VerticalAlignmentProp_ConditionalOption.__index = VerticalAlignmentProp_ConditionalOption

function VerticalAlignmentProp_ConditionalOption.new(tbl37)
    return (setmetatable({
        condition = if tbl37 == nil or tbl37.condition == nil then nil else tbl37.condition,
        kind = if tbl37 == nil or tbl37.kind == nil then nil else tbl37.kind
    }, VerticalAlignmentProp_ConditionalOption))
end

function VerticalAlignmentProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.VerticalAlignment.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function VerticalAlignmentProp_ConditionalOption.decode(buf1: buffer)
    local var1 = VerticalAlignmentProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.VerticalAlignment.fromNumber(var4) or var4
                }
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.condition = prop_condition.PropCondition.decode(var4)
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

function VerticalAlignmentProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.VerticalAlignment.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function VerticalAlignmentProp_ConditionalOption:jsonDecode()
    local var1 = VerticalAlignmentProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.VerticalAlignment.fromNumber(self.literal) or self.literal else tbl1.VerticalAlignment.fromName(self.literal) or self.literal
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

VerticalAlignmentProp_ConditionalOption.descriptor = {
    name = "VerticalAlignmentProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.VerticalAlignmentProp_ConditionalOption = VerticalAlignmentProp_ConditionalOption

typeRegistry.default:register(tbl1.VerticalAlignmentProp_ConditionalOption)

local VerticalAlignmentProp_ConditionalOptions = {}
VerticalAlignmentProp_ConditionalOptions.__index = VerticalAlignmentProp_ConditionalOptions

function VerticalAlignmentProp_ConditionalOptions.new(tbl38)
    return (setmetatable(
        {
            option = (tbl38 == nil or tbl38.option == nil) and {} or tbl38.option
        },
        VerticalAlignmentProp_ConditionalOptions
    ))
end

function VerticalAlignmentProp_ConditionalOptions:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.option ~= nil and #self.option > 0 then
        for _, value in self.option do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function VerticalAlignmentProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = VerticalAlignmentProp_ConditionalOptions.new()
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
                table.insert(var1.option, tbl1.VerticalAlignmentProp_ConditionalOption.decode(var4))
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

function VerticalAlignmentProp_ConditionalOptions:jsonEncode()
    local result = {}

    if self.option ~= nil and #self.option > 0 then
        local option = {}
        for _, value in self.option do
            table.insert(option, value:jsonEncode())
        end
        result.option = option
    end

    return result
end

function VerticalAlignmentProp_ConditionalOptions:jsonDecode()
    local var1 = VerticalAlignmentProp_ConditionalOptions.new()

    if self.option ~= nil then
        local option = {}
        for _, value in self.option do
            table.insert(option, tbl1.VerticalAlignmentProp_ConditionalOption.jsonDecode(value))
        end

        var1.option = option
    end

    return var1
end

VerticalAlignmentProp_ConditionalOptions.descriptor = {
    name = "VerticalAlignmentProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.VerticalAlignmentProp_ConditionalOptions = VerticalAlignmentProp_ConditionalOptions

typeRegistry.default:register(tbl1.VerticalAlignmentProp_ConditionalOptions)

tbl1.AutomaticSize = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "AUTOMATIC_SIZE_INVALID"
        elseif num1 == 1 then
            return "AUTOMATIC_SIZE_NONE"
        elseif num1 == 2 then
            return "AUTOMATIC_SIZE_X"
        elseif num1 == 3 then
            return "AUTOMATIC_SIZE_Y"
        elseif num1 == 4 then
            return "AUTOMATIC_SIZE_XY"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "AUTOMATIC_SIZE_INVALID" then
            return 0
        elseif arg1 == "AUTOMATIC_SIZE_NONE" then
            return 1
        elseif arg1 == "AUTOMATIC_SIZE_X" then
            return 2
        elseif arg1 == "AUTOMATIC_SIZE_Y" then
            return 3
        elseif arg1 == "AUTOMATIC_SIZE_XY" then
            return 4
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "AUTOMATIC_SIZE_INVALID" then
            return "AUTOMATIC_SIZE_INVALID"
        elseif str1 == "AUTOMATIC_SIZE_NONE" then
            return "AUTOMATIC_SIZE_NONE"
        elseif str1 == "AUTOMATIC_SIZE_X" then
            return "AUTOMATIC_SIZE_X"
        elseif str1 == "AUTOMATIC_SIZE_Y" then
            return "AUTOMATIC_SIZE_Y"
        elseif str1 == "AUTOMATIC_SIZE_XY" then
            return "AUTOMATIC_SIZE_XY"
        end

        return nil
    end
}

tbl1.TextTruncate = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TEXT_TRUNCATE_INVALID"
        elseif num1 == 1 then
            return "TEXT_TRUNCATE_NONE"
        elseif num1 == 2 then
            return "TEXT_TRUNCATE_AT_END"
        elseif num1 == 3 then
            return "TEXT_TRUNCATE_SPLIT_WORD"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TEXT_TRUNCATE_INVALID" then
            return 0
        elseif arg1 == "TEXT_TRUNCATE_NONE" then
            return 1
        elseif arg1 == "TEXT_TRUNCATE_AT_END" then
            return 2
        elseif arg1 == "TEXT_TRUNCATE_SPLIT_WORD" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TEXT_TRUNCATE_INVALID" then
            return "TEXT_TRUNCATE_INVALID"
        elseif str1 == "TEXT_TRUNCATE_NONE" then
            return "TEXT_TRUNCATE_NONE"
        elseif str1 == "TEXT_TRUNCATE_AT_END" then
            return "TEXT_TRUNCATE_AT_END"
        elseif str1 == "TEXT_TRUNCATE_SPLIT_WORD" then
            return "TEXT_TRUNCATE_SPLIT_WORD"
        end

        return nil
    end
}

tbl1.TextXAlignment = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TEXT_X_ALIGNMENT_INVALID"
        elseif num1 == 1 then
            return "TEXT_X_ALIGNMENT_LEFT"
        elseif num1 == 2 then
            return "TEXT_X_ALIGNMENT_CENTER"
        elseif num1 == 3 then
            return "TEXT_X_ALIGNMENT_RIGHT"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TEXT_X_ALIGNMENT_INVALID" then
            return 0
        elseif arg1 == "TEXT_X_ALIGNMENT_LEFT" then
            return 1
        elseif arg1 == "TEXT_X_ALIGNMENT_CENTER" then
            return 2
        elseif arg1 == "TEXT_X_ALIGNMENT_RIGHT" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TEXT_X_ALIGNMENT_INVALID" then
            return "TEXT_X_ALIGNMENT_INVALID"
        elseif str1 == "TEXT_X_ALIGNMENT_LEFT" then
            return "TEXT_X_ALIGNMENT_LEFT"
        elseif str1 == "TEXT_X_ALIGNMENT_CENTER" then
            return "TEXT_X_ALIGNMENT_CENTER"
        elseif str1 == "TEXT_X_ALIGNMENT_RIGHT" then
            return "TEXT_X_ALIGNMENT_RIGHT"
        end

        return nil
    end
}

tbl1.TextYAlignment = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TEXT_Y_ALIGNMENT_INVALID"
        elseif num1 == 1 then
            return "TEXT_Y_ALIGNMENT_TOP"
        elseif num1 == 2 then
            return "TEXT_Y_ALIGNMENT_CENTER"
        elseif num1 == 3 then
            return "TEXT_Y_ALIGNMENT_BOTTOM"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TEXT_Y_ALIGNMENT_INVALID" then
            return 0
        elseif arg1 == "TEXT_Y_ALIGNMENT_TOP" then
            return 1
        elseif arg1 == "TEXT_Y_ALIGNMENT_CENTER" then
            return 2
        elseif arg1 == "TEXT_Y_ALIGNMENT_BOTTOM" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TEXT_Y_ALIGNMENT_INVALID" then
            return "TEXT_Y_ALIGNMENT_INVALID"
        elseif str1 == "TEXT_Y_ALIGNMENT_TOP" then
            return "TEXT_Y_ALIGNMENT_TOP"
        elseif str1 == "TEXT_Y_ALIGNMENT_CENTER" then
            return "TEXT_Y_ALIGNMENT_CENTER"
        elseif str1 == "TEXT_Y_ALIGNMENT_BOTTOM" then
            return "TEXT_Y_ALIGNMENT_BOTTOM"
        end

        return nil
    end
}

tbl1.UIFlexMode = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "UI_FLEX_MODE_INVALID"
        elseif num1 == 1 then
            return "UI_FLEX_MODE_NONE"
        elseif num1 == 2 then
            return "UI_FLEX_MODE_GROW"
        elseif num1 == 3 then
            return "UI_FLEX_MODE_SHRINK"
        elseif num1 == 4 then
            return "UI_FLEX_MODE_FILL"
        elseif num1 == 5 then
            return "UI_FLEX_MODE_CUSTOM"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "UI_FLEX_MODE_INVALID" then
            return 0
        elseif arg1 == "UI_FLEX_MODE_NONE" then
            return 1
        elseif arg1 == "UI_FLEX_MODE_GROW" then
            return 2
        elseif arg1 == "UI_FLEX_MODE_SHRINK" then
            return 3
        elseif arg1 == "UI_FLEX_MODE_FILL" then
            return 4
        elseif arg1 == "UI_FLEX_MODE_CUSTOM" then
            return 5
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "UI_FLEX_MODE_INVALID" then
            return "UI_FLEX_MODE_INVALID"
        elseif str1 == "UI_FLEX_MODE_NONE" then
            return "UI_FLEX_MODE_NONE"
        elseif str1 == "UI_FLEX_MODE_GROW" then
            return "UI_FLEX_MODE_GROW"
        elseif str1 == "UI_FLEX_MODE_SHRINK" then
            return "UI_FLEX_MODE_SHRINK"
        elseif str1 == "UI_FLEX_MODE_FILL" then
            return "UI_FLEX_MODE_FILL"
        elseif str1 == "UI_FLEX_MODE_CUSTOM" then
            return "UI_FLEX_MODE_CUSTOM"
        end

        return nil
    end
}

tbl1.ScaleType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "SCALE_TYPE_INVALID"
        elseif num1 == 1 then
            return "SCALE_TYPE_STRETCH"
        elseif num1 == 2 then
            return "SCALE_TYPE_SLICE"
        elseif num1 == 3 then
            return "SCALE_TYPE_TILE"
        elseif num1 == 4 then
            return "SCALE_TYPE_FIT"
        elseif num1 == 5 then
            return "SCALE_TYPE_CROP"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "SCALE_TYPE_INVALID" then
            return 0
        elseif arg1 == "SCALE_TYPE_STRETCH" then
            return 1
        elseif arg1 == "SCALE_TYPE_SLICE" then
            return 2
        elseif arg1 == "SCALE_TYPE_TILE" then
            return 3
        elseif arg1 == "SCALE_TYPE_FIT" then
            return 4
        elseif arg1 == "SCALE_TYPE_CROP" then
            return 5
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "SCALE_TYPE_INVALID" then
            return "SCALE_TYPE_INVALID"
        elseif str1 == "SCALE_TYPE_STRETCH" then
            return "SCALE_TYPE_STRETCH"
        elseif str1 == "SCALE_TYPE_SLICE" then
            return "SCALE_TYPE_SLICE"
        elseif str1 == "SCALE_TYPE_TILE" then
            return "SCALE_TYPE_TILE"
        elseif str1 == "SCALE_TYPE_FIT" then
            return "SCALE_TYPE_FIT"
        elseif str1 == "SCALE_TYPE_CROP" then
            return "SCALE_TYPE_CROP"
        end

        return nil
    end
}

tbl1.ResamplerMode = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "RESAMPLER_MODE_INVALID" elseif num1 == 1 then "RESAMPLER_MODE_DEFAULT" elseif num1 == 2 then "RESAMPLER_MODE_PIXELATED" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "RESAMPLER_MODE_INVALID" then 0 elseif arg1 == "RESAMPLER_MODE_DEFAULT" then 1 elseif arg1 == "RESAMPLER_MODE_PIXELATED" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "RESAMPLER_MODE_INVALID" then "RESAMPLER_MODE_INVALID" elseif str1 == "RESAMPLER_MODE_DEFAULT" then "RESAMPLER_MODE_DEFAULT" elseif str1 == "RESAMPLER_MODE_PIXELATED" then "RESAMPLER_MODE_PIXELATED" else nil
    end
}

tbl1.SizeConstraint = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "SIZE_CONSTRAINT_INVALID"
        elseif num1 == 1 then
            return "SIZE_CONSTRAINT_RELATIVE_XY"
        elseif num1 == 2 then
            return "SIZE_CONSTRAINT_RELATIVE_XX"
        elseif num1 == 3 then
            return "SIZE_CONSTRAINT_RELATIVE_YY"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "SIZE_CONSTRAINT_INVALID" then
            return 0
        elseif arg1 == "SIZE_CONSTRAINT_RELATIVE_XY" then
            return 1
        elseif arg1 == "SIZE_CONSTRAINT_RELATIVE_XX" then
            return 2
        elseif arg1 == "SIZE_CONSTRAINT_RELATIVE_YY" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "SIZE_CONSTRAINT_INVALID" then
            return "SIZE_CONSTRAINT_INVALID"
        elseif str1 == "SIZE_CONSTRAINT_RELATIVE_XY" then
            return "SIZE_CONSTRAINT_RELATIVE_XY"
        elseif str1 == "SIZE_CONSTRAINT_RELATIVE_XX" then
            return "SIZE_CONSTRAINT_RELATIVE_XX"
        elseif str1 == "SIZE_CONSTRAINT_RELATIVE_YY" then
            return "SIZE_CONSTRAINT_RELATIVE_YY"
        end

        return nil
    end
}

tbl1.HorizontalAlignment = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "HORIZONTAL_ALIGNMENT_INVALID"
        elseif num1 == 1 then
            return "HORIZONTAL_ALIGNMENT_LEFT"
        elseif num1 == 2 then
            return "HORIZONTAL_ALIGNMENT_CENTER"
        elseif num1 == 3 then
            return "HORIZONTAL_ALIGNMENT_RIGHT"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "HORIZONTAL_ALIGNMENT_INVALID" then
            return 0
        elseif arg1 == "HORIZONTAL_ALIGNMENT_LEFT" then
            return 1
        elseif arg1 == "HORIZONTAL_ALIGNMENT_CENTER" then
            return 2
        elseif arg1 == "HORIZONTAL_ALIGNMENT_RIGHT" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "HORIZONTAL_ALIGNMENT_INVALID" then
            return "HORIZONTAL_ALIGNMENT_INVALID"
        elseif str1 == "HORIZONTAL_ALIGNMENT_LEFT" then
            return "HORIZONTAL_ALIGNMENT_LEFT"
        elseif str1 == "HORIZONTAL_ALIGNMENT_CENTER" then
            return "HORIZONTAL_ALIGNMENT_CENTER"
        elseif str1 == "HORIZONTAL_ALIGNMENT_RIGHT" then
            return "HORIZONTAL_ALIGNMENT_RIGHT"
        end

        return nil
    end
}

tbl1.VerticalAlignment = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "VERTICAL_ALIGNMENT_INVALID"
        elseif num1 == 1 then
            return "VERTICAL_ALIGNMENT_TOP"
        elseif num1 == 2 then
            return "VERTICAL_ALIGNMENT_CENTER"
        elseif num1 == 3 then
            return "VERTICAL_ALIGNMENT_BOTTOM"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "VERTICAL_ALIGNMENT_INVALID" then
            return 0
        elseif arg1 == "VERTICAL_ALIGNMENT_TOP" then
            return 1
        elseif arg1 == "VERTICAL_ALIGNMENT_CENTER" then
            return 2
        elseif arg1 == "VERTICAL_ALIGNMENT_BOTTOM" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "VERTICAL_ALIGNMENT_INVALID" then
            return "VERTICAL_ALIGNMENT_INVALID"
        elseif str1 == "VERTICAL_ALIGNMENT_TOP" then
            return "VERTICAL_ALIGNMENT_TOP"
        elseif str1 == "VERTICAL_ALIGNMENT_CENTER" then
            return "VERTICAL_ALIGNMENT_CENTER"
        elseif str1 == "VERTICAL_ALIGNMENT_BOTTOM" then
            return "VERTICAL_ALIGNMENT_BOTTOM"
        end

        return nil
    end
}

tbl1.SelectionBehavior = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "SELECTION_BEHAVIOR_INVALID" elseif num1 == 1 then "SELECTION_BEHAVIOR_ESCAPE" elseif num1 == 2 then "SELECTION_BEHAVIOR_STOP" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "SELECTION_BEHAVIOR_INVALID" then 0 elseif arg1 == "SELECTION_BEHAVIOR_ESCAPE" then 1 elseif arg1 == "SELECTION_BEHAVIOR_STOP" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "SELECTION_BEHAVIOR_INVALID" then "SELECTION_BEHAVIOR_INVALID" elseif str1 == "SELECTION_BEHAVIOR_ESCAPE" then "SELECTION_BEHAVIOR_ESCAPE" elseif str1 == "SELECTION_BEHAVIOR_STOP" then "SELECTION_BEHAVIOR_STOP" else nil
    end
}

tbl1.KeyCode = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "KEY_CODE_INVALID"
        elseif num1 == 1 then
            return "KEY_CODE_BUTTON_A"
        elseif num1 == 2 then
            return "KEY_CODE_BUTTON_B"
        elseif num1 == 3 then
            return "KEY_CODE_BUTTON_X"
        elseif num1 == 4 then
            return "KEY_CODE_BUTTON_Y"
        elseif num1 == 5 then
            return "KEY_CODE_BUTTON_L1"
        elseif num1 == 6 then
            return "KEY_CODE_BUTTON_R1"
        elseif num1 == 7 then
            return "KEY_CODE_BUTTON_L2"
        elseif num1 == 8 then
            return "KEY_CODE_BUTTON_R2"
        elseif num1 == 9 then
            return "KEY_CODE_BUTTON_L3"
        elseif num1 == 10 then
            return "KEY_CODE_BUTTON_R3"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "KEY_CODE_INVALID" then
            return 0
        elseif arg1 == "KEY_CODE_BUTTON_A" then
            return 1
        elseif arg1 == "KEY_CODE_BUTTON_B" then
            return 2
        elseif arg1 == "KEY_CODE_BUTTON_X" then
            return 3
        elseif arg1 == "KEY_CODE_BUTTON_Y" then
            return 4
        elseif arg1 == "KEY_CODE_BUTTON_L1" then
            return 5
        elseif arg1 == "KEY_CODE_BUTTON_R1" then
            return 6
        elseif arg1 == "KEY_CODE_BUTTON_L2" then
            return 7
        elseif arg1 == "KEY_CODE_BUTTON_R2" then
            return 8
        elseif arg1 == "KEY_CODE_BUTTON_L3" then
            return 9
        elseif arg1 == "KEY_CODE_BUTTON_R3" then
            return 10
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "KEY_CODE_INVALID" then
            return "KEY_CODE_INVALID"
        elseif str1 == "KEY_CODE_BUTTON_A" then
            return "KEY_CODE_BUTTON_A"
        elseif str1 == "KEY_CODE_BUTTON_B" then
            return "KEY_CODE_BUTTON_B"
        elseif str1 == "KEY_CODE_BUTTON_X" then
            return "KEY_CODE_BUTTON_X"
        elseif str1 == "KEY_CODE_BUTTON_Y" then
            return "KEY_CODE_BUTTON_Y"
        elseif str1 == "KEY_CODE_BUTTON_L1" then
            return "KEY_CODE_BUTTON_L1"
        elseif str1 == "KEY_CODE_BUTTON_R1" then
            return "KEY_CODE_BUTTON_R1"
        elseif str1 == "KEY_CODE_BUTTON_L2" then
            return "KEY_CODE_BUTTON_L2"
        elseif str1 == "KEY_CODE_BUTTON_R2" then
            return "KEY_CODE_BUTTON_R2"
        elseif str1 == "KEY_CODE_BUTTON_L3" then
            return "KEY_CODE_BUTTON_L3"
        elseif str1 == "KEY_CODE_BUTTON_R3" then
            return "KEY_CODE_BUTTON_R3"
        end

        return nil
    end
}

return {
    AutomaticSizeProp = tbl1.AutomaticSizeProp,
    AutomaticSizeProp_ConditionalOption = tbl1.AutomaticSizeProp_ConditionalOption,
    AutomaticSizeProp_ConditionalOptions = tbl1.AutomaticSizeProp_ConditionalOptions,
    TextTruncateProp = tbl1.TextTruncateProp,
    TextTruncateProp_ConditionalOption = tbl1.TextTruncateProp_ConditionalOption,
    TextTruncateProp_ConditionalOptions = tbl1.TextTruncateProp_ConditionalOptions,
    TextXAlignmentProp = tbl1.TextXAlignmentProp,
    TextXAlignmentProp_ConditionalOption = tbl1.TextXAlignmentProp_ConditionalOption,
    TextXAlignmentProp_ConditionalOptions = tbl1.TextXAlignmentProp_ConditionalOptions,
    TextYAlignmentProp = tbl1.TextYAlignmentProp,
    TextYAlignmentProp_ConditionalOption = tbl1.TextYAlignmentProp_ConditionalOption,
    TextYAlignmentProp_ConditionalOptions = tbl1.TextYAlignmentProp_ConditionalOptions,
    UIFlexModeProp = tbl1.UIFlexModeProp,
    UIFlexModeProp_ConditionalOption = tbl1.UIFlexModeProp_ConditionalOption,
    UIFlexModeProp_ConditionalOptions = tbl1.UIFlexModeProp_ConditionalOptions,
    ScaleTypeProp = tbl1.ScaleTypeProp,
    ScaleTypeProp_ConditionalOption = tbl1.ScaleTypeProp_ConditionalOption,
    ScaleTypeProp_ConditionalOptions = tbl1.ScaleTypeProp_ConditionalOptions,
    ResamplerModeProp = tbl1.ResamplerModeProp,
    ResamplerModeProp_ConditionalOption = tbl1.ResamplerModeProp_ConditionalOption,
    ResamplerModeProp_ConditionalOptions = tbl1.ResamplerModeProp_ConditionalOptions,
    SizeConstraintProp = tbl1.SizeConstraintProp,
    SizeConstraintProp_ConditionalOption = tbl1.SizeConstraintProp_ConditionalOption,
    SizeConstraintProp_ConditionalOptions = tbl1.SizeConstraintProp_ConditionalOptions,
    HorizontalAlignmentProp = tbl1.HorizontalAlignmentProp,
    HorizontalAlignmentProp_ConditionalOption = tbl1.HorizontalAlignmentProp_ConditionalOption,
    HorizontalAlignmentProp_ConditionalOptions = tbl1.HorizontalAlignmentProp_ConditionalOptions,
    SelectionBehaviorProp = tbl1.SelectionBehaviorProp,
    SelectionBehaviorProp_ConditionalOption = tbl1.SelectionBehaviorProp_ConditionalOption,
    SelectionBehaviorProp_ConditionalOptions = tbl1.SelectionBehaviorProp_ConditionalOptions,
    KeyCodeProp = tbl1.KeyCodeProp,
    KeyCodeProp_ConditionalOption = tbl1.KeyCodeProp_ConditionalOption,
    KeyCodeProp_ConditionalOptions = tbl1.KeyCodeProp_ConditionalOptions,
    VerticalAlignmentProp = tbl1.VerticalAlignmentProp,
    VerticalAlignmentProp_ConditionalOption = tbl1.VerticalAlignmentProp_ConditionalOption,
    VerticalAlignmentProp_ConditionalOptions = tbl1.VerticalAlignmentProp_ConditionalOptions,
    AutomaticSize = tbl1.AutomaticSize,
    TextTruncate = tbl1.TextTruncate,
    TextXAlignment = tbl1.TextXAlignment,
    TextYAlignment = tbl1.TextYAlignment,
    UIFlexMode = tbl1.UIFlexMode,
    ScaleType = tbl1.ScaleType,
    ResamplerMode = tbl1.ResamplerMode,
    SizeConstraint = tbl1.SizeConstraint,
    HorizontalAlignment = tbl1.HorizontalAlignment,
    VerticalAlignment = tbl1.VerticalAlignment,
    SelectionBehavior = tbl1.SelectionBehavior,
    KeyCode = tbl1.KeyCode
}

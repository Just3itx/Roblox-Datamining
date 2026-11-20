-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local prop_condition = require(script.Parent.prop_condition)

local ImageBackground = {}
ImageBackground.__index = ImageBackground

function ImageBackground.new(tbl3)
    return (setmetatable(
        {
            resource_identifier = if tbl3 == nil or tbl3.resource_identifier == nil then "" else tbl3.resource_identifier
        },
        ImageBackground
    ))
end

function ImageBackground:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.resource_identifier ~= nil and self.resource_identifier ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.resource_identifier)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageBackground.decode(buf1: buffer)
    local var1 = ImageBackground.new()
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
                var1.resource_identifier = buffer.tostring(buf)
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

function ImageBackground:jsonEncode()
    local result = {}

    if self.resource_identifier ~= nil and self.resource_identifier ~= "" then
        result.resourceIdentifier = self.resource_identifier
    end

    return result
end

function ImageBackground:jsonDecode()
    local var1 = ImageBackground.new()

    if self.resource_identifier ~= nil then
        var1.resource_identifier = self.resource_identifier
    end

    if self.resourceIdentifier ~= nil then
        var1.resource_identifier = self.resourceIdentifier
    end

    return var1
end

ImageBackground.descriptor = {
    name = "ImageBackground",
    fullName = "roblox.apppageplatform.shared.v1beta1.ImageBackground"
}

tbl1.ImageBackground = ImageBackground

typeRegistry.default:register(tbl1.ImageBackground)

local BackgroundLayer = {}
BackgroundLayer.__index = BackgroundLayer

function BackgroundLayer.new(tbl4)
    return (setmetatable({ kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind }, BackgroundLayer))
end

function BackgroundLayer:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "image_background" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BackgroundLayer.decode(buf1: buffer)
    local var1 = BackgroundLayer.new()
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
                    type = "image_background",
                    value = tbl1.ImageBackground.decode(var4)
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

function BackgroundLayer:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "image_background" then
        result.imageBackground = self.kind.value:jsonEncode()
    end

    return result
end

function BackgroundLayer.jsonDecode(tbl4)
    local var1 = BackgroundLayer.new()

    if tbl4.image_background ~= nil then
        var1.kind = {
            type = "image_background",
            value = tbl1.ImageBackground.jsonDecode(tbl4.image_background)
        }
    end
    if tbl4.imageBackground ~= nil then
        var1.kind = {
            type = "image_background",
            value = tbl1.ImageBackground.jsonDecode(tbl4.imageBackground)
        }
    end
    return var1
end

BackgroundLayer.descriptor = {
    name = "BackgroundLayer",
    fullName = "roblox.apppageplatform.shared.v1beta1.BackgroundLayer"
}

tbl1.BackgroundLayer = BackgroundLayer

typeRegistry.default:register(tbl1.BackgroundLayer)

local ArrayOfBackgroundLayerProp = {}
ArrayOfBackgroundLayerProp.__index = ArrayOfBackgroundLayerProp

function ArrayOfBackgroundLayerProp.new(tbl5)
    return (setmetatable({ kind = if tbl5 == nil or tbl5.kind == nil then nil else tbl5.kind }, ArrayOfBackgroundLayerProp))
end

function ArrayOfBackgroundLayerProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
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

function ArrayOfBackgroundLayerProp.decode(buf1: buffer)
    local var1 = ArrayOfBackgroundLayerProp.new()
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
                    type = "literal",
                    value = tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.decode(var4)
                }
            elseif var2 == 2 then
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
                    value = tbl1.ArrayOfBackgroundLayerProp_ConditionalOptions.decode(var4)
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

function ArrayOfBackgroundLayerProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
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

function ArrayOfBackgroundLayerProp.jsonDecode(tbl5)
    local var1 = ArrayOfBackgroundLayerProp.new()

    if tbl5.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.jsonDecode(tbl5.literal)
        }
    end

    if tbl5.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl5.binding_path
        }
    end
    if tbl5.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl5.bindingPath
        }
    end
    if tbl5.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ArrayOfBackgroundLayerProp_ConditionalOptions.jsonDecode(tbl5.conditional)
        }
    end

    return var1
end

ArrayOfBackgroundLayerProp.descriptor = {
    name = "ArrayOfBackgroundLayerProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfBackgroundLayerProp"
}

tbl1.ArrayOfBackgroundLayerProp = ArrayOfBackgroundLayerProp

typeRegistry.default:register(tbl1.ArrayOfBackgroundLayerProp)

local ArrayOfBackgroundLayerProp_ConditionalOption = {}
ArrayOfBackgroundLayerProp_ConditionalOption.__index = ArrayOfBackgroundLayerProp_ConditionalOption

function ArrayOfBackgroundLayerProp_ConditionalOption.new(tbl6)
    return (setmetatable({
        condition = if tbl6 == nil or tbl6.condition == nil then nil else tbl6.condition,
        kind = if tbl6 == nil or tbl6.kind == nil then nil else tbl6.kind
    }, ArrayOfBackgroundLayerProp_ConditionalOption))
end

function ArrayOfBackgroundLayerProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfBackgroundLayerProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfBackgroundLayerProp_ConditionalOption.new()
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
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.decode(var4)
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

function ArrayOfBackgroundLayerProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ArrayOfBackgroundLayerProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfBackgroundLayerProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.jsonDecode(self.literal)
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

ArrayOfBackgroundLayerProp_ConditionalOption.descriptor = {
    name = "ArrayOfBackgroundLayerProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfBackgroundLayerProp_ConditionalOption = ArrayOfBackgroundLayerProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfBackgroundLayerProp_ConditionalOption)

local ArrayOfBackgroundLayerProp_ConditionalOptions = {}
ArrayOfBackgroundLayerProp_ConditionalOptions.__index = ArrayOfBackgroundLayerProp_ConditionalOptions

function ArrayOfBackgroundLayerProp_ConditionalOptions.new(tbl7)
    return (setmetatable(
        {
            options = (tbl7 == nil or tbl7.options == nil) and {} or tbl7.options
        },
        ArrayOfBackgroundLayerProp_ConditionalOptions
    ))
end

function ArrayOfBackgroundLayerProp_ConditionalOptions:encode(): buffer
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

function ArrayOfBackgroundLayerProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfBackgroundLayerProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfBackgroundLayerProp_ConditionalOption.decode(var4))
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

function ArrayOfBackgroundLayerProp_ConditionalOptions:jsonEncode()
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

function ArrayOfBackgroundLayerProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfBackgroundLayerProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfBackgroundLayerProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfBackgroundLayerProp_ConditionalOptions.descriptor = {
    name = "ArrayOfBackgroundLayerProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfBackgroundLayerProp_ConditionalOptions = ArrayOfBackgroundLayerProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfBackgroundLayerProp_ConditionalOptions)

local ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer = {}
ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.__index = ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer

function ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.new(tbl8)
    return (setmetatable(
        {
            array = (tbl8 == nil or tbl8.array == nil) and {} or tbl8.array
        },
        ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer
    ))
end

function ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.array ~= nil and #self.array > 0 then
        for _, value in self.array do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.decode(buf1: buffer)
    local var1 = ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.new()
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
                table.insert(var1.array, tbl1.BackgroundLayer.decode(var4))
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

function ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer:jsonEncode()
    local result = {}

    if self.array ~= nil and #self.array > 0 then
        local array = {}
        for _, value in self.array do
            table.insert(array, value:jsonEncode())
        end
        result.array = array
    end

    return result
end

function ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer:jsonDecode()
    local var1 = ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.new()

    if self.array ~= nil then
        local array = {}
        for _, value in self.array do
            table.insert(array, tbl1.BackgroundLayer.jsonDecode(value))
        end

        var1.array = array
    end

    return var1
end

ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer.descriptor = {
    name = "ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfBackgroundLayer"
}

tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer = ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer

typeRegistry.default:register(tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer)

return {
    ImageBackground = tbl1.ImageBackground,
    BackgroundLayer = tbl1.BackgroundLayer,
    ArrayOfBackgroundLayerProp = tbl1.ArrayOfBackgroundLayerProp,
    ArrayOfBackgroundLayerProp_ConditionalOption = tbl1.ArrayOfBackgroundLayerProp_ConditionalOption,
    ArrayOfBackgroundLayerProp_ConditionalOptions = tbl1.ArrayOfBackgroundLayerProp_ConditionalOptions,
    ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer = tbl1.ArrayOfBackgroundLayerProp_ArrayOfBackgroundLayer
}

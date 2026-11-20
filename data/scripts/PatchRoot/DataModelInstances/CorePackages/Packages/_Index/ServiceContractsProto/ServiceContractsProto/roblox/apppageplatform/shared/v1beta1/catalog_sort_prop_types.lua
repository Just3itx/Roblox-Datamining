-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local background_layer = require(script.Parent.background_layer)
local catalog_sort_data = require(script.Parent.catalog_sort_data)
local hydration_data_spec = require(script.Parent.hydration_data_spec)
local prop_condition = require(script.Parent.prop_condition)
local prop_types = require(script.Parent.prop_types)

local ItemFooter = {}
ItemFooter.__index = ItemFooter

function ItemFooter.new(tbl3)
    return (setmetatable({ content_type = if tbl3 == nil or tbl3.content_type == nil then nil else tbl3.content_type }, ItemFooter))
end

function ItemFooter:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.content_type ~= nil then
        local buf = self.content_type:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ItemFooter.decode(buf1: buffer)
    local var1 = ItemFooter.new()
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
                var1.content_type = prop_types.StringProp.decode(var4)
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

function ItemFooter:jsonEncode()
    local result = {}

    if self.content_type ~= nil then
        result.contentType = self.content_type:jsonEncode()
    end

    return result
end

function ItemFooter:jsonDecode()
    local var1 = ItemFooter.new()

    if self.content_type ~= nil then
        var1.content_type = prop_types.StringProp.jsonDecode(self.content_type)
    end

    if self.contentType ~= nil then
        var1.content_type = prop_types.StringProp.jsonDecode(self.contentType)
    end

    return var1
end

ItemFooter.descriptor = {
    name = "ItemFooter",
    fullName = "roblox.apppageplatform.shared.v1beta1.ItemFooter"
}

tbl1.ItemFooter = ItemFooter

typeRegistry.default:register(tbl1.ItemFooter)

local ArrayOfItemFooterProp = {}
ArrayOfItemFooterProp.__index = ArrayOfItemFooterProp

function ArrayOfItemFooterProp.new(tbl4)
    return (setmetatable({ kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind }, ArrayOfItemFooterProp))
end

function ArrayOfItemFooterProp:encode(): buffer
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
        elseif self.kind.type == "array_map" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfItemFooterProp.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp.new()
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
                    value = tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter.decode(var4)
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
                    value = tbl1.ArrayOfItemFooterProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "array_map",
                    value = tbl1.ArrayOfItemFooterProp_ArrayMap.decode(var4)
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

function ArrayOfItemFooterProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "array_map" then
            result.arrayMap = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ArrayOfItemFooterProp.jsonDecode(tbl4)
    local var1 = ArrayOfItemFooterProp.new()

    if tbl4.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter.jsonDecode(tbl4.literal)
        }
    end
    if tbl4.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl4.binding_path
        }
    end
    if tbl4.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl4.bindingPath
        }
    end
    if tbl4.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ArrayOfItemFooterProp_ConditionalOptions.jsonDecode(tbl4.conditional)
        }
    end

    if tbl4.array_map ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfItemFooterProp_ArrayMap.jsonDecode(tbl4.array_map)
        }
    end
    if tbl4.arrayMap ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfItemFooterProp_ArrayMap.jsonDecode(tbl4.arrayMap)
        }
    end
    return var1
end

ArrayOfItemFooterProp.descriptor = {
    name = "ArrayOfItemFooterProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfItemFooterProp"
}

tbl1.ArrayOfItemFooterProp = ArrayOfItemFooterProp

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp)

local ArrayOfItemFooterProp_ConditionalOption = {}
ArrayOfItemFooterProp_ConditionalOption.__index = ArrayOfItemFooterProp_ConditionalOption

function ArrayOfItemFooterProp_ConditionalOption.new(tbl5)
    return (setmetatable({
        condition = if tbl5 == nil or tbl5.condition == nil then nil else tbl5.condition,
        kind = if tbl5 == nil or tbl5.kind == nil then nil else tbl5.kind
    }, ArrayOfItemFooterProp_ConditionalOption))
end

function ArrayOfItemFooterProp_ConditionalOption:encode(): buffer
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

function ArrayOfItemFooterProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter.decode(var4)
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

function ArrayOfItemFooterProp_ConditionalOption:jsonEncode()
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

function ArrayOfItemFooterProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfItemFooterProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter.jsonDecode(self.literal)
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

ArrayOfItemFooterProp_ConditionalOption.descriptor = {
    name = "ArrayOfItemFooterProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfItemFooterProp_ConditionalOption = ArrayOfItemFooterProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp_ConditionalOption)

local ArrayOfItemFooterProp_ConditionalOptions = {}
ArrayOfItemFooterProp_ConditionalOptions.__index = ArrayOfItemFooterProp_ConditionalOptions

function ArrayOfItemFooterProp_ConditionalOptions.new(tbl6)
    return (setmetatable(
        {
            options = (tbl6 == nil or tbl6.options == nil) and {} or tbl6.options
        },
        ArrayOfItemFooterProp_ConditionalOptions
    ))
end

function ArrayOfItemFooterProp_ConditionalOptions:encode(): buffer
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

function ArrayOfItemFooterProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfItemFooterProp_ConditionalOption.decode(var4))
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

function ArrayOfItemFooterProp_ConditionalOptions:jsonEncode()
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

function ArrayOfItemFooterProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfItemFooterProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfItemFooterProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfItemFooterProp_ConditionalOptions.descriptor = {
    name = "ArrayOfItemFooterProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfItemFooterProp_ConditionalOptions = ArrayOfItemFooterProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp_ConditionalOptions)

local ArrayOfItemFooterProp_ArrayOfItemFooter = {}
ArrayOfItemFooterProp_ArrayOfItemFooter.__index = ArrayOfItemFooterProp_ArrayOfItemFooter

function ArrayOfItemFooterProp_ArrayOfItemFooter.new(tbl7)
    return (setmetatable(
        {
            array = (tbl7 == nil or tbl7.array == nil) and {} or tbl7.array
        },
        ArrayOfItemFooterProp_ArrayOfItemFooter
    ))
end

function ArrayOfItemFooterProp_ArrayOfItemFooter:encode(): buffer
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

function ArrayOfItemFooterProp_ArrayOfItemFooter.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp_ArrayOfItemFooter.new()
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
                table.insert(var1.array, tbl1.ItemFooter.decode(var4))
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

function ArrayOfItemFooterProp_ArrayOfItemFooter:jsonEncode()
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

function ArrayOfItemFooterProp_ArrayOfItemFooter:jsonDecode()
    local var1 = ArrayOfItemFooterProp_ArrayOfItemFooter.new()

    if self.array ~= nil then
        local array = {}
        for _, value in self.array do
            table.insert(array, tbl1.ItemFooter.jsonDecode(value))
        end

        var1.array = array
    end

    return var1
end

ArrayOfItemFooterProp_ArrayOfItemFooter.descriptor = {
    name = "ArrayOfItemFooterProp_ArrayOfItemFooter",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfItemFooter"
}

tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter = ArrayOfItemFooterProp_ArrayOfItemFooter

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter)

local ArrayOfItemFooterProp_ArrayMap = {}
ArrayOfItemFooterProp_ArrayMap.__index = ArrayOfItemFooterProp_ArrayMap

function ArrayOfItemFooterProp_ArrayMap.new(tbl8)
    return (setmetatable({
        kind = if tbl8 == nil or tbl8.kind == nil then nil else tbl8.kind,
        item_hydration_specs = (tbl8 == nil or tbl8.item_hydration_specs == nil) and {} or tbl8.item_hydration_specs,
        field_map = if tbl8 == nil or tbl8.field_map == nil then nil else tbl8.field_map
    }, ArrayOfItemFooterProp_ArrayMap))
end

function ArrayOfItemFooterProp_ArrayMap:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "literal" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.item_hydration_specs ~= nil and #self.item_hydration_specs > 0 then
        for _, itemHydrationSpec in self.item_hydration_specs do
            local buf = itemHydrationSpec:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.field_map ~= nil then
        local buf = self.field_map:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfItemFooterProp_ArrayMap.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp_ArrayMap.new()
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
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ArrayOfItemFooterProp_ArrayMap_LiteralItems.decode(var4)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.item_hydration_specs, hydration_data_spec.HydrationDataSpec.decode(var4))
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.field_map = tbl1.ItemFooter.decode(var4)
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

function ArrayOfItemFooterProp_ArrayMap:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        elseif self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
        end
    end

    if self.item_hydration_specs ~= nil and #self.item_hydration_specs > 0 then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.item_hydration_specs do
            table.insert(itemHydrationSpecs, itemHydrationSpec:jsonEncode())
        end
        result.itemHydrationSpecs = itemHydrationSpecs
    end

    if self.field_map ~= nil then
        result.fieldMap = self.field_map:jsonEncode()
    end

    return result
end

function ArrayOfItemFooterProp_ArrayMap:jsonDecode()
    local var1 = ArrayOfItemFooterProp_ArrayMap.new()

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
    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfItemFooterProp_ArrayMap_LiteralItems.jsonDecode(self.literal)
        }
    end

    if self.item_hydration_specs ~= nil then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.item_hydration_specs do
            table.insert(itemHydrationSpecs, hydration_data_spec.HydrationDataSpec.jsonDecode(itemHydrationSpec))
        end

        var1.item_hydration_specs = itemHydrationSpecs
    end

    if self.itemHydrationSpecs ~= nil then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.itemHydrationSpecs do
            table.insert(itemHydrationSpecs, hydration_data_spec.HydrationDataSpec.jsonDecode(itemHydrationSpec))
        end

        var1.item_hydration_specs = itemHydrationSpecs
    end

    if self.field_map ~= nil then
        var1.field_map = tbl1.ItemFooter.jsonDecode(self.field_map)
    end

    if self.fieldMap ~= nil then
        var1.field_map = tbl1.ItemFooter.jsonDecode(self.fieldMap)
    end

    return var1
end

ArrayOfItemFooterProp_ArrayMap.descriptor = {
    name = "ArrayOfItemFooterProp_ArrayMap",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayMap"
}

tbl1.ArrayOfItemFooterProp_ArrayMap = ArrayOfItemFooterProp_ArrayMap

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp_ArrayMap)

local ArrayOfItemFooterProp_ArrayMap_LiteralItems = {}
ArrayOfItemFooterProp_ArrayMap_LiteralItems.__index = ArrayOfItemFooterProp_ArrayMap_LiteralItems

function ArrayOfItemFooterProp_ArrayMap_LiteralItems.new(tbl9)
    return (setmetatable(
        {
            items = (tbl9 == nil or tbl9.items == nil) and {} or tbl9.items
        },
        ArrayOfItemFooterProp_ArrayMap_LiteralItems
    ))
end

function ArrayOfItemFooterProp_ArrayMap_LiteralItems:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.items ~= nil and #self.items > 0 then
        for _, item in self.items do
            local buf = item:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfItemFooterProp_ArrayMap_LiteralItems.decode(buf1: buffer)
    local var1 = ArrayOfItemFooterProp_ArrayMap_LiteralItems.new()
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
                table.insert(var1.items, catalog_sort_data.CatalogSortCardItemFooter.decode(var4))
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

function ArrayOfItemFooterProp_ArrayMap_LiteralItems:jsonEncode()
    local result = {}

    if self.items ~= nil and #self.items > 0 then
        local items = {}
        for _, item in self.items do
            table.insert(items, item:jsonEncode())
        end
        result.items = items
    end

    return result
end

function ArrayOfItemFooterProp_ArrayMap_LiteralItems:jsonDecode()
    local var1 = ArrayOfItemFooterProp_ArrayMap_LiteralItems.new()

    if self.items ~= nil then
        local items = {}
        for _, item in self.items do
            table.insert(items, catalog_sort_data.CatalogSortCardItemFooter.jsonDecode(item))
        end

        var1.items = items
    end

    return var1
end

ArrayOfItemFooterProp_ArrayMap_LiteralItems.descriptor = {
    name = "ArrayOfItemFooterProp_ArrayMap_LiteralItems",
    fullName = "roblox.apppageplatform.shared.v1beta1.LiteralItems"
}

tbl1.ArrayOfItemFooterProp_ArrayMap_LiteralItems = ArrayOfItemFooterProp_ArrayMap_LiteralItems

typeRegistry.default:register(tbl1.ArrayOfItemFooterProp_ArrayMap_LiteralItems)

local CardStyle = {}
CardStyle.__index = CardStyle

function CardStyle.new(tbl10)
    return (setmetatable({
        thumbnail_aspect_ratio = if tbl10 == nil or tbl10.thumbnail_aspect_ratio == nil then nil else tbl10.thumbnail_aspect_ratio,
        background_layers = if tbl10 == nil or tbl10.background_layers == nil then nil else tbl10.background_layers
    }, CardStyle))
end

function CardStyle:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.thumbnail_aspect_ratio ~= nil then
        local buf = self.thumbnail_aspect_ratio:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.background_layers ~= nil then
        local buf = self.background_layers:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CardStyle.decode(buf1: buffer)
    local var1 = CardStyle.new()
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
                var1.thumbnail_aspect_ratio = prop_types.StringProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.decode(var4)
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

function CardStyle:jsonEncode()
    local result = {}

    if self.thumbnail_aspect_ratio ~= nil then
        result.thumbnailAspectRatio = self.thumbnail_aspect_ratio:jsonEncode()
    end

    if self.background_layers ~= nil then
        result.backgroundLayers = self.background_layers:jsonEncode()
    end

    return result
end

function CardStyle:jsonDecode()
    local var1 = CardStyle.new()

    if self.thumbnail_aspect_ratio ~= nil then
        var1.thumbnail_aspect_ratio = prop_types.StringProp.jsonDecode(self.thumbnail_aspect_ratio)
    end

    if self.thumbnailAspectRatio ~= nil then
        var1.thumbnail_aspect_ratio = prop_types.StringProp.jsonDecode(self.thumbnailAspectRatio)
    end

    if self.background_layers ~= nil then
        var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.jsonDecode(self.background_layers)
    end

    if self.backgroundLayers ~= nil then
        var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.jsonDecode(self.backgroundLayers)
    end

    return var1
end

CardStyle.descriptor = {
    name = "CardStyle",
    fullName = "roblox.apppageplatform.shared.v1beta1.CardStyle"
}

tbl1.CardStyle = CardStyle

typeRegistry.default:register(tbl1.CardStyle)

local CardStyleProp = {}
CardStyleProp.__index = CardStyleProp

function CardStyleProp.new(tbl11)
    return (setmetatable({ kind = if tbl11 == nil or tbl11.kind == nil then nil else tbl11.kind }, CardStyleProp))
end

function CardStyleProp:encode(): buffer
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

function CardStyleProp.decode(buf1: buffer)
    local var1 = CardStyleProp.new()
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
                    value = tbl1.CardStyle.decode(var4)
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
                    value = tbl1.CardStyleProp_ConditionalOptions.decode(var4)
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

function CardStyleProp:jsonEncode()
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

function CardStyleProp.jsonDecode(tbl11)
    local var1 = CardStyleProp.new()

    if tbl11.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.CardStyle.jsonDecode(tbl11.literal)
        }
    end
    if tbl11.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl11.binding_path
        }
    end
    if tbl11.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl11.bindingPath
        }
    end
    if tbl11.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.CardStyleProp_ConditionalOptions.jsonDecode(tbl11.conditional)
        }
    end

    return var1
end

CardStyleProp.descriptor = {
    name = "CardStyleProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.CardStyleProp"
}

tbl1.CardStyleProp = CardStyleProp

typeRegistry.default:register(tbl1.CardStyleProp)

local CardStyleProp_ConditionalOption = {}
CardStyleProp_ConditionalOption.__index = CardStyleProp_ConditionalOption

function CardStyleProp_ConditionalOption.new(tbl12)
    return (setmetatable({
        condition = if tbl12 == nil or tbl12.condition == nil then nil else tbl12.condition,
        kind = if tbl12 == nil or tbl12.kind == nil then nil else tbl12.kind
    }, CardStyleProp_ConditionalOption))
end

function CardStyleProp_ConditionalOption:encode(): buffer
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

function CardStyleProp_ConditionalOption.decode(buf1: buffer)
    local var1 = CardStyleProp_ConditionalOption.new()
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
                    value = tbl1.CardStyle.decode(var4)
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

function CardStyleProp_ConditionalOption:jsonEncode()
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

function CardStyleProp_ConditionalOption:jsonDecode()
    local var1 = CardStyleProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.CardStyle.jsonDecode(self.literal)
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

CardStyleProp_ConditionalOption.descriptor = {
    name = "CardStyleProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.CardStyleProp_ConditionalOption = CardStyleProp_ConditionalOption

typeRegistry.default:register(tbl1.CardStyleProp_ConditionalOption)

local CardStyleProp_ConditionalOptions = {}
CardStyleProp_ConditionalOptions.__index = CardStyleProp_ConditionalOptions

function CardStyleProp_ConditionalOptions.new(tbl13)
    return (setmetatable(
        {
            options = (tbl13 == nil or tbl13.options == nil) and {} or tbl13.options
        },
        CardStyleProp_ConditionalOptions
    ))
end

function CardStyleProp_ConditionalOptions:encode(): buffer
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

function CardStyleProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = CardStyleProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.CardStyleProp_ConditionalOption.decode(var4))
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

function CardStyleProp_ConditionalOptions:jsonEncode()
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

function CardStyleProp_ConditionalOptions:jsonDecode()
    local var1 = CardStyleProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.CardStyleProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

CardStyleProp_ConditionalOptions.descriptor = {
    name = "CardStyleProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.CardStyleProp_ConditionalOptions = CardStyleProp_ConditionalOptions

typeRegistry.default:register(tbl1.CardStyleProp_ConditionalOptions)

local CatalogSortContent = {}
CatalogSortContent.__index = CatalogSortContent

function CatalogSortContent.new(tbl14)
    return (setmetatable({
        id = if tbl14 == nil or tbl14.id == nil then nil else tbl14.id,
        type = if tbl14 == nil or tbl14.type == nil then nil else tbl14.type
    }, CatalogSortContent))
end

function CatalogSortContent:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil then
        local buf = self.id:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.type ~= nil then
        local buf = self.type:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CatalogSortContent.decode(buf1: buffer)
    local var1 = CatalogSortContent.new()
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
                var1.id = prop_types.StringProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.type = prop_types.StringProp.decode(var4)
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

function CatalogSortContent:jsonEncode()
    local result = {}

    if self.id ~= nil then
        result.id = self.id:jsonEncode()
    end

    if self.type ~= nil then
        result.type = self.type:jsonEncode()
    end

    return result
end

function CatalogSortContent:jsonDecode()
    local var1 = CatalogSortContent.new()

    if self.id ~= nil then
        var1.id = prop_types.StringProp.jsonDecode(self.id)
    end

    if self.type ~= nil then
        var1.type = prop_types.StringProp.jsonDecode(self.type)
    end

    return var1
end

CatalogSortContent.descriptor = {
    name = "CatalogSortContent",
    fullName = "roblox.apppageplatform.shared.v1beta1.CatalogSortContent"
}

tbl1.CatalogSortContent = CatalogSortContent

typeRegistry.default:register(tbl1.CatalogSortContent)

local ArrayOfCatalogSortContentProp = {}
ArrayOfCatalogSortContentProp.__index = ArrayOfCatalogSortContentProp

function ArrayOfCatalogSortContentProp.new(tbl15)
    return (setmetatable({ kind = if tbl15 == nil or tbl15.kind == nil then nil else tbl15.kind }, ArrayOfCatalogSortContentProp))
end

function ArrayOfCatalogSortContentProp:encode(): buffer
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
        elseif self.kind.type == "array_map" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfCatalogSortContentProp.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp.new()
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
                    value = tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.decode(var4)
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
                    value = tbl1.ArrayOfCatalogSortContentProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "array_map",
                    value = tbl1.ArrayOfCatalogSortContentProp_ArrayMap.decode(var4)
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

function ArrayOfCatalogSortContentProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "array_map" then
            result.arrayMap = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ArrayOfCatalogSortContentProp.jsonDecode(tbl15)
    local var1 = ArrayOfCatalogSortContentProp.new()

    if tbl15.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.jsonDecode(tbl15.literal)
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
            value = tbl1.ArrayOfCatalogSortContentProp_ConditionalOptions.jsonDecode(tbl15.conditional)
        }
    end

    if tbl15.array_map ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfCatalogSortContentProp_ArrayMap.jsonDecode(tbl15.array_map)
        }
    end

    if tbl15.arrayMap ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfCatalogSortContentProp_ArrayMap.jsonDecode(tbl15.arrayMap)
        }
    end

    return var1
end

ArrayOfCatalogSortContentProp.descriptor = {
    name = "ArrayOfCatalogSortContentProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfCatalogSortContentProp"
}

tbl1.ArrayOfCatalogSortContentProp = ArrayOfCatalogSortContentProp

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp)

local ArrayOfCatalogSortContentProp_ConditionalOption = {}
ArrayOfCatalogSortContentProp_ConditionalOption.__index = ArrayOfCatalogSortContentProp_ConditionalOption

function ArrayOfCatalogSortContentProp_ConditionalOption.new(tbl16)
    return (setmetatable({
        condition = if tbl16 == nil or tbl16.condition == nil then nil else tbl16.condition,
        kind = if tbl16 == nil or tbl16.kind == nil then nil else tbl16.kind
    }, ArrayOfCatalogSortContentProp_ConditionalOption))
end

function ArrayOfCatalogSortContentProp_ConditionalOption:encode(): buffer
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

function ArrayOfCatalogSortContentProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.decode(var4)
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

function ArrayOfCatalogSortContentProp_ConditionalOption:jsonEncode()
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

function ArrayOfCatalogSortContentProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfCatalogSortContentProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.jsonDecode(self.literal)
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

ArrayOfCatalogSortContentProp_ConditionalOption.descriptor = {
    name = "ArrayOfCatalogSortContentProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfCatalogSortContentProp_ConditionalOption = ArrayOfCatalogSortContentProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp_ConditionalOption)

local ArrayOfCatalogSortContentProp_ConditionalOptions = {}
ArrayOfCatalogSortContentProp_ConditionalOptions.__index = ArrayOfCatalogSortContentProp_ConditionalOptions

function ArrayOfCatalogSortContentProp_ConditionalOptions.new(tbl17)
    return (setmetatable(
        {
            options = (tbl17 == nil or tbl17.options == nil) and {} or tbl17.options
        },
        ArrayOfCatalogSortContentProp_ConditionalOptions
    ))
end

function ArrayOfCatalogSortContentProp_ConditionalOptions:encode(): buffer
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

function ArrayOfCatalogSortContentProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfCatalogSortContentProp_ConditionalOption.decode(var4))
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

function ArrayOfCatalogSortContentProp_ConditionalOptions:jsonEncode()
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

function ArrayOfCatalogSortContentProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfCatalogSortContentProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfCatalogSortContentProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfCatalogSortContentProp_ConditionalOptions.descriptor = {
    name = "ArrayOfCatalogSortContentProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfCatalogSortContentProp_ConditionalOptions = ArrayOfCatalogSortContentProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp_ConditionalOptions)

local ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent = {}
ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.__index = ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent

function ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.new(tbl18)
    return (setmetatable(
        {
            array = (tbl18 == nil or tbl18.array == nil) and {} or tbl18.array
        },
        ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent
    ))
end

function ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent:encode(): buffer
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

function ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.new()
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
                table.insert(var1.array, tbl1.CatalogSortContent.decode(var4))
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

function ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent:jsonEncode()
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

function ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent:jsonDecode()
    local var1 = ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.new()

    if self.array ~= nil then
        local array = {}
        for _, value in self.array do
            table.insert(array, tbl1.CatalogSortContent.jsonDecode(value))
        end

        var1.array = array
    end

    return var1
end

ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent.descriptor = {
    name = "ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfCatalogSortContent"
}

tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent = ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent)

local ArrayOfCatalogSortContentProp_ArrayMap = {}
ArrayOfCatalogSortContentProp_ArrayMap.__index = ArrayOfCatalogSortContentProp_ArrayMap

function ArrayOfCatalogSortContentProp_ArrayMap.new(tbl19)
    return (setmetatable({
        kind = if tbl19 == nil or tbl19.kind == nil then nil else tbl19.kind,
        item_hydration_specs = (tbl19 == nil or tbl19.item_hydration_specs == nil) and {} or tbl19.item_hydration_specs,
        field_map = if tbl19 == nil or tbl19.field_map == nil then nil else tbl19.field_map
    }, ArrayOfCatalogSortContentProp_ArrayMap))
end

function ArrayOfCatalogSortContentProp_ArrayMap:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "literal" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.item_hydration_specs ~= nil and #self.item_hydration_specs > 0 then
        for _, itemHydrationSpec in self.item_hydration_specs do
            local buf = itemHydrationSpec:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.field_map ~= nil then
        local buf = self.field_map:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfCatalogSortContentProp_ArrayMap.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp_ArrayMap.new()
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
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = tbl1.ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.decode(var4)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.item_hydration_specs, hydration_data_spec.HydrationDataSpec.decode(var4))
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.field_map = tbl1.CatalogSortContent.decode(var4)
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

function ArrayOfCatalogSortContentProp_ArrayMap:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        elseif self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
        end
    end

    if self.item_hydration_specs ~= nil and #self.item_hydration_specs > 0 then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.item_hydration_specs do
            table.insert(itemHydrationSpecs, itemHydrationSpec:jsonEncode())
        end
        result.itemHydrationSpecs = itemHydrationSpecs
    end

    if self.field_map ~= nil then
        result.fieldMap = self.field_map:jsonEncode()
    end

    return result
end

function ArrayOfCatalogSortContentProp_ArrayMap:jsonDecode()
    local var1 = ArrayOfCatalogSortContentProp_ArrayMap.new()

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
    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.jsonDecode(self.literal)
        }
    end

    if self.item_hydration_specs ~= nil then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.item_hydration_specs do
            table.insert(itemHydrationSpecs, hydration_data_spec.HydrationDataSpec.jsonDecode(itemHydrationSpec))
        end

        var1.item_hydration_specs = itemHydrationSpecs
    end

    if self.itemHydrationSpecs ~= nil then
        local itemHydrationSpecs = {}
        for _, itemHydrationSpec in self.itemHydrationSpecs do
            table.insert(itemHydrationSpecs, hydration_data_spec.HydrationDataSpec.jsonDecode(itemHydrationSpec))
        end

        var1.item_hydration_specs = itemHydrationSpecs
    end

    if self.field_map ~= nil then
        var1.field_map = tbl1.CatalogSortContent.jsonDecode(self.field_map)
    end

    if self.fieldMap ~= nil then
        var1.field_map = tbl1.CatalogSortContent.jsonDecode(self.fieldMap)
    end

    return var1
end

ArrayOfCatalogSortContentProp_ArrayMap.descriptor = {
    name = "ArrayOfCatalogSortContentProp_ArrayMap",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayMap"
}

tbl1.ArrayOfCatalogSortContentProp_ArrayMap = ArrayOfCatalogSortContentProp_ArrayMap

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp_ArrayMap)

local ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems = {}
ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.__index = ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems

function ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.new(tbl20)
    return (setmetatable(
        {
            items = (tbl20 == nil or tbl20.items == nil) and {} or tbl20.items
        },
        ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems
    ))
end

function ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.items ~= nil and #self.items > 0 then
        for _, item in self.items do
            local buf = item:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.decode(buf1: buffer)
    local var1 = ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.new()
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
                table.insert(var1.items, catalog_sort_data.CatalogSortContentData.decode(var4))
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

function ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems:jsonEncode()
    local result = {}

    if self.items ~= nil and #self.items > 0 then
        local items = {}
        for _, item in self.items do
            table.insert(items, item:jsonEncode())
        end
        result.items = items
    end

    return result
end

function ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems:jsonDecode()
    local var1 = ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.new()

    if self.items ~= nil then
        local items = {}
        for _, item in self.items do
            table.insert(items, catalog_sort_data.CatalogSortContentData.jsonDecode(item))
        end

        var1.items = items
    end

    return var1
end

ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems.descriptor = {
    name = "ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems",
    fullName = "roblox.apppageplatform.shared.v1beta1.LiteralItems"
}

tbl1.ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems = ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems

typeRegistry.default:register(tbl1.ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems)

local WidgetStyle = {}
WidgetStyle.__index = WidgetStyle

function WidgetStyle.new(tbl21)
    return (setmetatable(
        {
            background_layers = if tbl21 == nil or tbl21.background_layers == nil then nil else tbl21.background_layers
        },
        WidgetStyle
    ))
end

function WidgetStyle:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.background_layers ~= nil then
        local buf = self.background_layers:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function WidgetStyle.decode(buf1: buffer)
    local var1 = WidgetStyle.new()
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
                var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.decode(var4)
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

function WidgetStyle:jsonEncode()
    local result = {}

    if self.background_layers ~= nil then
        result.backgroundLayers = self.background_layers:jsonEncode()
    end

    return result
end

function WidgetStyle:jsonDecode()
    local var1 = WidgetStyle.new()

    if self.background_layers ~= nil then
        var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.jsonDecode(self.background_layers)
    end

    if self.backgroundLayers ~= nil then
        var1.background_layers = background_layer.ArrayOfBackgroundLayerProp.jsonDecode(self.backgroundLayers)
    end

    return var1
end

WidgetStyle.descriptor = {
    name = "WidgetStyle",
    fullName = "roblox.apppageplatform.shared.v1beta1.WidgetStyle"
}

tbl1.WidgetStyle = WidgetStyle

typeRegistry.default:register(tbl1.WidgetStyle)

local WidgetStyleProp = {}
WidgetStyleProp.__index = WidgetStyleProp

function WidgetStyleProp.new(tbl22)
    return (setmetatable({ kind = if tbl22 == nil or tbl22.kind == nil then nil else tbl22.kind }, WidgetStyleProp))
end

function WidgetStyleProp:encode(): buffer
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

function WidgetStyleProp.decode(buf1: buffer)
    local var1 = WidgetStyleProp.new()
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
                    value = tbl1.WidgetStyle.decode(var4)
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
                    value = tbl1.WidgetStyleProp_ConditionalOptions.decode(var4)
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

function WidgetStyleProp:jsonEncode()
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

function WidgetStyleProp.jsonDecode(tbl22)
    local var1 = WidgetStyleProp.new()

    if tbl22.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.WidgetStyle.jsonDecode(tbl22.literal)
        }
    end
    if tbl22.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl22.binding_path
        }
    end
    if tbl22.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl22.bindingPath
        }
    end
    if tbl22.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.WidgetStyleProp_ConditionalOptions.jsonDecode(tbl22.conditional)
        }
    end

    return var1
end

WidgetStyleProp.descriptor = {
    name = "WidgetStyleProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.WidgetStyleProp"
}

tbl1.WidgetStyleProp = WidgetStyleProp

typeRegistry.default:register(tbl1.WidgetStyleProp)

local WidgetStyleProp_ConditionalOption = {}
WidgetStyleProp_ConditionalOption.__index = WidgetStyleProp_ConditionalOption

function WidgetStyleProp_ConditionalOption.new(tbl23)
    return (setmetatable({
        condition = if tbl23 == nil or tbl23.condition == nil then nil else tbl23.condition,
        kind = if tbl23 == nil or tbl23.kind == nil then nil else tbl23.kind
    }, WidgetStyleProp_ConditionalOption))
end

function WidgetStyleProp_ConditionalOption:encode(): buffer
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

function WidgetStyleProp_ConditionalOption.decode(buf1: buffer)
    local var1 = WidgetStyleProp_ConditionalOption.new()
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
                    value = tbl1.WidgetStyle.decode(var4)
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

function WidgetStyleProp_ConditionalOption:jsonEncode()
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

function WidgetStyleProp_ConditionalOption:jsonDecode()
    local var1 = WidgetStyleProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.WidgetStyle.jsonDecode(self.literal)
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

WidgetStyleProp_ConditionalOption.descriptor = {
    name = "WidgetStyleProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.WidgetStyleProp_ConditionalOption = WidgetStyleProp_ConditionalOption

typeRegistry.default:register(tbl1.WidgetStyleProp_ConditionalOption)

local WidgetStyleProp_ConditionalOptions = {}
WidgetStyleProp_ConditionalOptions.__index = WidgetStyleProp_ConditionalOptions

function WidgetStyleProp_ConditionalOptions.new(tbl24)
    return (setmetatable(
        {
            options = (tbl24 == nil or tbl24.options == nil) and {} or tbl24.options
        },
        WidgetStyleProp_ConditionalOptions
    ))
end

function WidgetStyleProp_ConditionalOptions:encode(): buffer
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

function WidgetStyleProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = WidgetStyleProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.WidgetStyleProp_ConditionalOption.decode(var4))
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

function WidgetStyleProp_ConditionalOptions:jsonEncode()
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

function WidgetStyleProp_ConditionalOptions:jsonDecode()
    local var1 = WidgetStyleProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.WidgetStyleProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

WidgetStyleProp_ConditionalOptions.descriptor = {
    name = "WidgetStyleProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.WidgetStyleProp_ConditionalOptions = WidgetStyleProp_ConditionalOptions

typeRegistry.default:register(tbl1.WidgetStyleProp_ConditionalOptions)

return {
    ItemFooter = tbl1.ItemFooter,
    ArrayOfItemFooterProp = tbl1.ArrayOfItemFooterProp,
    ArrayOfItemFooterProp_ConditionalOption = tbl1.ArrayOfItemFooterProp_ConditionalOption,
    ArrayOfItemFooterProp_ConditionalOptions = tbl1.ArrayOfItemFooterProp_ConditionalOptions,
    ArrayOfItemFooterProp_ArrayOfItemFooter = tbl1.ArrayOfItemFooterProp_ArrayOfItemFooter,
    ArrayOfItemFooterProp_ArrayMap = tbl1.ArrayOfItemFooterProp_ArrayMap,
    ArrayOfItemFooterProp_ArrayMap_LiteralItems = tbl1.ArrayOfItemFooterProp_ArrayMap_LiteralItems,
    CardStyle = tbl1.CardStyle,
    CardStyleProp = tbl1.CardStyleProp,
    CardStyleProp_ConditionalOption = tbl1.CardStyleProp_ConditionalOption,
    CardStyleProp_ConditionalOptions = tbl1.CardStyleProp_ConditionalOptions,
    CatalogSortContent = tbl1.CatalogSortContent,
    ArrayOfCatalogSortContentProp = tbl1.ArrayOfCatalogSortContentProp,
    ArrayOfCatalogSortContentProp_ConditionalOption = tbl1.ArrayOfCatalogSortContentProp_ConditionalOption,
    ArrayOfCatalogSortContentProp_ConditionalOptions = tbl1.ArrayOfCatalogSortContentProp_ConditionalOptions,
    ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent = tbl1.ArrayOfCatalogSortContentProp_ArrayOfCatalogSortContent,
    ArrayOfCatalogSortContentProp_ArrayMap = tbl1.ArrayOfCatalogSortContentProp_ArrayMap,
    ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems = tbl1.ArrayOfCatalogSortContentProp_ArrayMap_LiteralItems,
    WidgetStyle = tbl1.WidgetStyle,
    WidgetStyleProp = tbl1.WidgetStyleProp,
    WidgetStyleProp_ConditionalOption = tbl1.WidgetStyleProp_ConditionalOption,
    WidgetStyleProp_ConditionalOptions = tbl1.WidgetStyleProp_ConditionalOptions
}

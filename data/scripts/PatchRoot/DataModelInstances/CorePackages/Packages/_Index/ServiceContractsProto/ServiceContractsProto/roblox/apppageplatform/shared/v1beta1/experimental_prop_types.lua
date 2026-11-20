-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local prop_types = require(script.Parent.prop_types)
local prop_types_engine = require(script.Parent.prop_types_engine)

local ExperimentalProp = {}
ExperimentalProp.__index = ExperimentalProp

function ExperimentalProp.new(tbl3)
    return (setmetatable({
        prop_builder = if tbl3 == nil or tbl3.prop_builder == nil then nil else tbl3.prop_builder,
        oneof_prop = if tbl3 == nil or tbl3.oneof_prop == nil then nil else tbl3.oneof_prop
    }, ExperimentalProp))
end

function ExperimentalProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.prop_builder ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1000, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.prop_builder)
    end

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "string_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "int32_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "int64_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "float_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "double_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "bool_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "struct_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "array_of_struct_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "string_array_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "image_string_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "image_set_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "icon_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "icon_size_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "foundation_icon_config_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "color_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "color_style_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "gradient_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "typography_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 18, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "typography_font_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 19, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "udim_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 20, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "udim2_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 21, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "vector2_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 22, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "ui_scaled_float_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 23, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "ui_scaled_udim_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 24, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "ui_scaled_udim2_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 25, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "fill_behavior_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 26, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "input_size_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 27, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "automatic_size_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 28, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "text_truncate_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 29, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "text_x_alignment_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 30, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "text_y_alignment_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 31, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "ui_flex_mode_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 32, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "scale_type_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 33, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "resampler_mode_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 34, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "size_constraint_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 35, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "selection_behavior_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 36, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "key_code_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 37, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ExperimentalProp.decode(buf1: buffer)
    local var1 = ExperimentalProp.new()
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
                var1.oneof_prop = {
                    type = "string_prop",
                    value = prop_types.StringProp.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "int32_prop",
                    value = prop_types.Int32Prop.decode(var4)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "int64_prop",
                    value = prop_types.Int64Prop.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "float_prop",
                    value = prop_types.FloatProp.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "double_prop",
                    value = prop_types.DoubleProp.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "bool_prop",
                    value = prop_types.BoolProp.decode(var4)
                }
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "struct_prop",
                    value = prop_types.StructProp.decode(var4)
                }
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "array_of_struct_prop",
                    value = prop_types.ArrayOfStructProp.decode(var4)
                }
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "string_array_prop",
                    value = prop_types.StringArrayProp.decode(var4)
                }
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "image_string_prop",
                    value = prop_types.ImageStringProp.decode(var4)
                }
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "image_set_prop",
                    value = prop_types.ImageSetProp.decode(var4)
                }
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "icon_prop",
                    value = prop_types.IconProp.decode(var4)
                }
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "icon_size_prop",
                    value = prop_types.IconSizeProp.decode(var4)
                }
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "foundation_icon_config_prop",
                    value = prop_types.FoundationIconConfigProp.decode(var4)
                }
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "color_prop",
                    value = prop_types.ColorProp.decode(var4)
                }
            elseif var2 == 16 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "color_style_prop",
                    value = prop_types.ColorStyleProp.decode(var4)
                }
            elseif var2 == 17 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "gradient_prop",
                    value = prop_types.GradientProp.decode(var4)
                }
            elseif var2 == 18 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "typography_prop",
                    value = prop_types.TypographyProp.decode(var4)
                }
            elseif var2 == 19 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "typography_font_prop",
                    value = prop_types.TypographyFontProp.decode(var4)
                }
            elseif var2 == 20 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "udim_prop",
                    value = prop_types.UDimProp.decode(var4)
                }
            elseif var2 == 21 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "udim2_prop",
                    value = prop_types.UDim2Prop.decode(var4)
                }
            elseif var2 == 22 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "vector2_prop",
                    value = prop_types.Vector2Prop.decode(var4)
                }
            elseif var2 == 23 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "ui_scaled_float_prop",
                    value = prop_types.UiScaledFloatProp.decode(var4)
                }
            elseif var2 == 24 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "ui_scaled_udim_prop",
                    value = prop_types.UiScaledUDimProp.decode(var4)
                }
            elseif var2 == 25 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "ui_scaled_udim2_prop",
                    value = prop_types.UiScaledUDim2Prop.decode(var4)
                }
            elseif var2 == 26 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "fill_behavior_prop",
                    value = prop_types.FillBehaviorProp.decode(var4)
                }
            elseif var2 == 27 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "input_size_prop",
                    value = prop_types.InputSizeProp.decode(var4)
                }
            elseif var2 == 28 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "automatic_size_prop",
                    value = prop_types_engine.AutomaticSizeProp.decode(var4)
                }
            elseif var2 == 29 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "text_truncate_prop",
                    value = prop_types_engine.TextTruncateProp.decode(var4)
                }
            elseif var2 == 30 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "text_x_alignment_prop",
                    value = prop_types_engine.TextXAlignmentProp.decode(var4)
                }
            elseif var2 == 31 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "text_y_alignment_prop",
                    value = prop_types_engine.TextYAlignmentProp.decode(var4)
                }
            elseif var2 == 32 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "ui_flex_mode_prop",
                    value = prop_types_engine.UIFlexModeProp.decode(var4)
                }
            elseif var2 == 33 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "scale_type_prop",
                    value = prop_types_engine.ScaleTypeProp.decode(var4)
                }
            elseif var2 == 34 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "resampler_mode_prop",
                    value = prop_types_engine.ResamplerModeProp.decode(var4)
                }
            elseif var2 == 35 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "size_constraint_prop",
                    value = prop_types_engine.SizeConstraintProp.decode(var4)
                }
            elseif var2 == 36 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "selection_behavior_prop",
                    value = prop_types_engine.SelectionBehaviorProp.decode(var4)
                }
            elseif var2 == 37 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "key_code_prop",
                    value = prop_types_engine.KeyCodeProp.decode(var4)
                }
            elseif var2 == 1000 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.prop_builder = buffer.tostring(buf)
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

function ExperimentalProp:jsonEncode()
    local result = {}

    if self.prop_builder ~= nil then
        result.propBuilder = self.prop_builder
    end

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "string_prop" then
            result.stringProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "int32_prop" then
            result.int32Prop = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "int64_prop" then
            result.int64Prop = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "float_prop" then
            result.floatProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "double_prop" then
            result.doubleProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "bool_prop" then
            result.boolProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "struct_prop" then
            result.structProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "array_of_struct_prop" then
            result.arrayOfStructProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "string_array_prop" then
            result.stringArrayProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "image_string_prop" then
            result.imageStringProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "image_set_prop" then
            result.imageSetProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "icon_prop" then
            result.iconProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "icon_size_prop" then
            result.iconSizeProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "foundation_icon_config_prop" then
            result.foundationIconConfigProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "color_prop" then
            result.colorProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "color_style_prop" then
            result.colorStyleProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "gradient_prop" then
            result.gradientProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "typography_prop" then
            result.typographyProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "typography_font_prop" then
            result.typographyFontProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "udim_prop" then
            result.udimProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "udim2_prop" then
            result.udim2Prop = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "vector2_prop" then
            result.vector2Prop = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "ui_scaled_float_prop" then
            result.uiScaledFloatProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "ui_scaled_udim_prop" then
            result.uiScaledUdimProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "ui_scaled_udim2_prop" then
            result.uiScaledUdim2Prop = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "fill_behavior_prop" then
            result.fillBehaviorProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "input_size_prop" then
            result.inputSizeProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "automatic_size_prop" then
            result.automaticSizeProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "text_truncate_prop" then
            result.textTruncateProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "text_x_alignment_prop" then
            result.textXAlignmentProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "text_y_alignment_prop" then
            result.textYAlignmentProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "ui_flex_mode_prop" then
            result.uiFlexModeProp = self.oneof_prop.value:jsonEncode()
            return result
        end

        if self.oneof_prop.type == "scale_type_prop" then
            result.scaleTypeProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "resampler_mode_prop" then
            result.resamplerModeProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "size_constraint_prop" then
            result.sizeConstraintProp = self.oneof_prop.value:jsonEncode()
            return result
        elseif self.oneof_prop.type == "selection_behavior_prop" then
            result.selectionBehaviorProp = self.oneof_prop.value:jsonEncode()
            return result
        end

        if self.oneof_prop.type == "key_code_prop" then
            result.keyCodeProp = self.oneof_prop.value:jsonEncode()
        end
    end

    return result
end

function ExperimentalProp:jsonDecode()
    local var1 = ExperimentalProp.new()

    if self.prop_builder ~= nil then
        var1.prop_builder = self.prop_builder
    end

    if self.propBuilder ~= nil then
        var1.prop_builder = self.propBuilder
    end

    if self.string_prop ~= nil then
        var1.oneof_prop = {
            type = "string_prop",
            value = prop_types.StringProp.jsonDecode(self.string_prop)
        }
    end

    if self.stringProp ~= nil then
        var1.oneof_prop = {
            type = "string_prop",
            value = prop_types.StringProp.jsonDecode(self.stringProp)
        }
    end

    if self.int32_prop ~= nil then
        var1.oneof_prop = {
            type = "int32_prop",
            value = prop_types.Int32Prop.jsonDecode(self.int32_prop)
        }
    end

    if self.int32Prop ~= nil then
        var1.oneof_prop = {
            type = "int32_prop",
            value = prop_types.Int32Prop.jsonDecode(self.int32Prop)
        }
    end

    if self.int64_prop ~= nil then
        var1.oneof_prop = {
            type = "int64_prop",
            value = prop_types.Int64Prop.jsonDecode(self.int64_prop)
        }
    end

    if self.int64Prop ~= nil then
        var1.oneof_prop = {
            type = "int64_prop",
            value = prop_types.Int64Prop.jsonDecode(self.int64Prop)
        }
    end

    if self.float_prop ~= nil then
        var1.oneof_prop = {
            type = "float_prop",
            value = prop_types.FloatProp.jsonDecode(self.float_prop)
        }
    end

    if self.floatProp ~= nil then
        var1.oneof_prop = {
            type = "float_prop",
            value = prop_types.FloatProp.jsonDecode(self.floatProp)
        }
    end

    if self.double_prop ~= nil then
        var1.oneof_prop = {
            type = "double_prop",
            value = prop_types.DoubleProp.jsonDecode(self.double_prop)
        }
    end

    if self.doubleProp ~= nil then
        var1.oneof_prop = {
            type = "double_prop",
            value = prop_types.DoubleProp.jsonDecode(self.doubleProp)
        }
    end

    if self.bool_prop ~= nil then
        var1.oneof_prop = {
            type = "bool_prop",
            value = prop_types.BoolProp.jsonDecode(self.bool_prop)
        }
    end

    if self.boolProp ~= nil then
        var1.oneof_prop = {
            type = "bool_prop",
            value = prop_types.BoolProp.jsonDecode(self.boolProp)
        }
    end

    if self.struct_prop ~= nil then
        var1.oneof_prop = {
            type = "struct_prop",
            value = prop_types.StructProp.jsonDecode(self.struct_prop)
        }
    end

    if self.structProp ~= nil then
        var1.oneof_prop = {
            type = "struct_prop",
            value = prop_types.StructProp.jsonDecode(self.structProp)
        }
    end

    if self.array_of_struct_prop ~= nil then
        var1.oneof_prop = {
            type = "array_of_struct_prop",
            value = prop_types.ArrayOfStructProp.jsonDecode(self.array_of_struct_prop)
        }
    end

    if self.arrayOfStructProp ~= nil then
        var1.oneof_prop = {
            type = "array_of_struct_prop",
            value = prop_types.ArrayOfStructProp.jsonDecode(self.arrayOfStructProp)
        }
    end

    if self.string_array_prop ~= nil then
        var1.oneof_prop = {
            type = "string_array_prop",
            value = prop_types.StringArrayProp.jsonDecode(self.string_array_prop)
        }
    end

    if self.stringArrayProp ~= nil then
        var1.oneof_prop = {
            type = "string_array_prop",
            value = prop_types.StringArrayProp.jsonDecode(self.stringArrayProp)
        }
    end

    if self.image_string_prop ~= nil then
        var1.oneof_prop = {
            type = "image_string_prop",
            value = prop_types.ImageStringProp.jsonDecode(self.image_string_prop)
        }
    end

    if self.imageStringProp ~= nil then
        var1.oneof_prop = {
            type = "image_string_prop",
            value = prop_types.ImageStringProp.jsonDecode(self.imageStringProp)
        }
    end

    if self.image_set_prop ~= nil then
        var1.oneof_prop = {
            type = "image_set_prop",
            value = prop_types.ImageSetProp.jsonDecode(self.image_set_prop)
        }
    end

    if self.imageSetProp ~= nil then
        var1.oneof_prop = {
            type = "image_set_prop",
            value = prop_types.ImageSetProp.jsonDecode(self.imageSetProp)
        }
    end

    if self.icon_prop ~= nil then
        var1.oneof_prop = {
            type = "icon_prop",
            value = prop_types.IconProp.jsonDecode(self.icon_prop)
        }
    end

    if self.iconProp ~= nil then
        var1.oneof_prop = {
            type = "icon_prop",
            value = prop_types.IconProp.jsonDecode(self.iconProp)
        }
    end

    if self.icon_size_prop ~= nil then
        var1.oneof_prop = {
            type = "icon_size_prop",
            value = prop_types.IconSizeProp.jsonDecode(self.icon_size_prop)
        }
    end

    if self.iconSizeProp ~= nil then
        var1.oneof_prop = {
            type = "icon_size_prop",
            value = prop_types.IconSizeProp.jsonDecode(self.iconSizeProp)
        }
    end

    if self.foundation_icon_config_prop ~= nil then
        var1.oneof_prop = {
            type = "foundation_icon_config_prop",
            value = prop_types.FoundationIconConfigProp.jsonDecode(self.foundation_icon_config_prop)
        }
    end

    if self.foundationIconConfigProp ~= nil then
        var1.oneof_prop = {
            type = "foundation_icon_config_prop",
            value = prop_types.FoundationIconConfigProp.jsonDecode(self.foundationIconConfigProp)
        }
    end

    if self.color_prop ~= nil then
        var1.oneof_prop = {
            type = "color_prop",
            value = prop_types.ColorProp.jsonDecode(self.color_prop)
        }
    end

    if self.colorProp ~= nil then
        var1.oneof_prop = {
            type = "color_prop",
            value = prop_types.ColorProp.jsonDecode(self.colorProp)
        }
    end

    if self.color_style_prop ~= nil then
        var1.oneof_prop = {
            type = "color_style_prop",
            value = prop_types.ColorStyleProp.jsonDecode(self.color_style_prop)
        }
    end

    if self.colorStyleProp ~= nil then
        var1.oneof_prop = {
            type = "color_style_prop",
            value = prop_types.ColorStyleProp.jsonDecode(self.colorStyleProp)
        }
    end

    if self.gradient_prop ~= nil then
        var1.oneof_prop = {
            type = "gradient_prop",
            value = prop_types.GradientProp.jsonDecode(self.gradient_prop)
        }
    end

    if self.gradientProp ~= nil then
        var1.oneof_prop = {
            type = "gradient_prop",
            value = prop_types.GradientProp.jsonDecode(self.gradientProp)
        }
    end

    if self.typography_prop ~= nil then
        var1.oneof_prop = {
            type = "typography_prop",
            value = prop_types.TypographyProp.jsonDecode(self.typography_prop)
        }
    end

    if self.typographyProp ~= nil then
        var1.oneof_prop = {
            type = "typography_prop",
            value = prop_types.TypographyProp.jsonDecode(self.typographyProp)
        }
    end

    if self.typography_font_prop ~= nil then
        var1.oneof_prop = {
            type = "typography_font_prop",
            value = prop_types.TypographyFontProp.jsonDecode(self.typography_font_prop)
        }
    end

    if self.typographyFontProp ~= nil then
        var1.oneof_prop = {
            type = "typography_font_prop",
            value = prop_types.TypographyFontProp.jsonDecode(self.typographyFontProp)
        }
    end

    if self.udim_prop ~= nil then
        var1.oneof_prop = {
            type = "udim_prop",
            value = prop_types.UDimProp.jsonDecode(self.udim_prop)
        }
    end

    if self.udimProp ~= nil then
        var1.oneof_prop = {
            type = "udim_prop",
            value = prop_types.UDimProp.jsonDecode(self.udimProp)
        }
    end

    if self.udim2_prop ~= nil then
        var1.oneof_prop = {
            type = "udim2_prop",
            value = prop_types.UDim2Prop.jsonDecode(self.udim2_prop)
        }
    end

    if self.udim2Prop ~= nil then
        var1.oneof_prop = {
            type = "udim2_prop",
            value = prop_types.UDim2Prop.jsonDecode(self.udim2Prop)
        }
    end

    if self.vector2_prop ~= nil then
        var1.oneof_prop = {
            type = "vector2_prop",
            value = prop_types.Vector2Prop.jsonDecode(self.vector2_prop)
        }
    end

    if self.vector2Prop ~= nil then
        var1.oneof_prop = {
            type = "vector2_prop",
            value = prop_types.Vector2Prop.jsonDecode(self.vector2Prop)
        }
    end

    if self.ui_scaled_float_prop ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_float_prop",
            value = prop_types.UiScaledFloatProp.jsonDecode(self.ui_scaled_float_prop)
        }
    end

    if self.uiScaledFloatProp ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_float_prop",
            value = prop_types.UiScaledFloatProp.jsonDecode(self.uiScaledFloatProp)
        }
    end

    if self.ui_scaled_udim_prop ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_udim_prop",
            value = prop_types.UiScaledUDimProp.jsonDecode(self.ui_scaled_udim_prop)
        }
    end

    if self.uiScaledUdimProp ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_udim_prop",
            value = prop_types.UiScaledUDimProp.jsonDecode(self.uiScaledUdimProp)
        }
    end

    if self.ui_scaled_udim2_prop ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_udim2_prop",
            value = prop_types.UiScaledUDim2Prop.jsonDecode(self.ui_scaled_udim2_prop)
        }
    end

    if self.uiScaledUdim2Prop ~= nil then
        var1.oneof_prop = {
            type = "ui_scaled_udim2_prop",
            value = prop_types.UiScaledUDim2Prop.jsonDecode(self.uiScaledUdim2Prop)
        }
    end

    if self.fill_behavior_prop ~= nil then
        var1.oneof_prop = {
            type = "fill_behavior_prop",
            value = prop_types.FillBehaviorProp.jsonDecode(self.fill_behavior_prop)
        }
    end

    if self.fillBehaviorProp ~= nil then
        var1.oneof_prop = {
            type = "fill_behavior_prop",
            value = prop_types.FillBehaviorProp.jsonDecode(self.fillBehaviorProp)
        }
    end

    if self.input_size_prop ~= nil then
        var1.oneof_prop = {
            type = "input_size_prop",
            value = prop_types.InputSizeProp.jsonDecode(self.input_size_prop)
        }
    end

    if self.inputSizeProp ~= nil then
        var1.oneof_prop = {
            type = "input_size_prop",
            value = prop_types.InputSizeProp.jsonDecode(self.inputSizeProp)
        }
    end

    if self.automatic_size_prop ~= nil then
        var1.oneof_prop = {
            type = "automatic_size_prop",
            value = prop_types_engine.AutomaticSizeProp.jsonDecode(self.automatic_size_prop)
        }
    end

    if self.automaticSizeProp ~= nil then
        var1.oneof_prop = {
            type = "automatic_size_prop",
            value = prop_types_engine.AutomaticSizeProp.jsonDecode(self.automaticSizeProp)
        }
    end

    if self.text_truncate_prop ~= nil then
        var1.oneof_prop = {
            type = "text_truncate_prop",
            value = prop_types_engine.TextTruncateProp.jsonDecode(self.text_truncate_prop)
        }
    end

    if self.textTruncateProp ~= nil then
        var1.oneof_prop = {
            type = "text_truncate_prop",
            value = prop_types_engine.TextTruncateProp.jsonDecode(self.textTruncateProp)
        }
    end

    if self.text_x_alignment_prop ~= nil then
        var1.oneof_prop = {
            type = "text_x_alignment_prop",
            value = prop_types_engine.TextXAlignmentProp.jsonDecode(self.text_x_alignment_prop)
        }
    end

    if self.textXAlignmentProp ~= nil then
        var1.oneof_prop = {
            type = "text_x_alignment_prop",
            value = prop_types_engine.TextXAlignmentProp.jsonDecode(self.textXAlignmentProp)
        }
    end

    if self.text_y_alignment_prop ~= nil then
        var1.oneof_prop = {
            type = "text_y_alignment_prop",
            value = prop_types_engine.TextYAlignmentProp.jsonDecode(self.text_y_alignment_prop)
        }
    end

    if self.textYAlignmentProp ~= nil then
        var1.oneof_prop = {
            type = "text_y_alignment_prop",
            value = prop_types_engine.TextYAlignmentProp.jsonDecode(self.textYAlignmentProp)
        }
    end

    if self.ui_flex_mode_prop ~= nil then
        var1.oneof_prop = {
            type = "ui_flex_mode_prop",
            value = prop_types_engine.UIFlexModeProp.jsonDecode(self.ui_flex_mode_prop)
        }
    end

    if self.uiFlexModeProp ~= nil then
        var1.oneof_prop = {
            type = "ui_flex_mode_prop",
            value = prop_types_engine.UIFlexModeProp.jsonDecode(self.uiFlexModeProp)
        }
    end

    if self.scale_type_prop ~= nil then
        var1.oneof_prop = {
            type = "scale_type_prop",
            value = prop_types_engine.ScaleTypeProp.jsonDecode(self.scale_type_prop)
        }
    end

    if self.scaleTypeProp ~= nil then
        var1.oneof_prop = {
            type = "scale_type_prop",
            value = prop_types_engine.ScaleTypeProp.jsonDecode(self.scaleTypeProp)
        }
    end

    if self.resampler_mode_prop ~= nil then
        var1.oneof_prop = {
            type = "resampler_mode_prop",
            value = prop_types_engine.ResamplerModeProp.jsonDecode(self.resampler_mode_prop)
        }
    end

    if self.resamplerModeProp ~= nil then
        var1.oneof_prop = {
            type = "resampler_mode_prop",
            value = prop_types_engine.ResamplerModeProp.jsonDecode(self.resamplerModeProp)
        }
    end

    if self.size_constraint_prop ~= nil then
        var1.oneof_prop = {
            type = "size_constraint_prop",
            value = prop_types_engine.SizeConstraintProp.jsonDecode(self.size_constraint_prop)
        }
    end

    if self.sizeConstraintProp ~= nil then
        var1.oneof_prop = {
            type = "size_constraint_prop",
            value = prop_types_engine.SizeConstraintProp.jsonDecode(self.sizeConstraintProp)
        }
    end

    if self.selection_behavior_prop ~= nil then
        var1.oneof_prop = {
            type = "selection_behavior_prop",
            value = prop_types_engine.SelectionBehaviorProp.jsonDecode(self.selection_behavior_prop)
        }
    end

    if self.selectionBehaviorProp ~= nil then
        var1.oneof_prop = {
            type = "selection_behavior_prop",
            value = prop_types_engine.SelectionBehaviorProp.jsonDecode(self.selectionBehaviorProp)
        }
    end

    if self.key_code_prop ~= nil then
        var1.oneof_prop = {
            type = "key_code_prop",
            value = prop_types_engine.KeyCodeProp.jsonDecode(self.key_code_prop)
        }
    end

    if self.keyCodeProp ~= nil then
        var1.oneof_prop = {
            type = "key_code_prop",
            value = prop_types_engine.KeyCodeProp.jsonDecode(self.keyCodeProp)
        }
    end

    return var1
end

ExperimentalProp.descriptor = {
    name = "ExperimentalProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ExperimentalProp"
}

tbl1.ExperimentalProp = ExperimentalProp

typeRegistry.default:register(tbl1.ExperimentalProp)

return {
    ExperimentalProp = tbl1.ExperimentalProp
}

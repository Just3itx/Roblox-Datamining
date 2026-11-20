-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local struct = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.struct)
local hydration_data_spec = require(script.Parent.hydration_data_spec)
local prop_condition = require(script.Parent.prop_condition)

local TranslationRef = {}
TranslationRef.__index = TranslationRef

function TranslationRef.new(tbl3)
    return (setmetatable({
        namespace = if tbl3 == nil or tbl3.namespace == nil then "" else tbl3.namespace,
        key = if tbl3 == nil or tbl3.key == nil then "" else tbl3.key,
        map_key = if tbl3 == nil or tbl3.map_key == nil then "" else tbl3.map_key
    }, TranslationRef))
end

function TranslationRef:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.namespace ~= nil and self.namespace ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.namespace)
    end

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.map_key ~= nil and self.map_key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.map_key)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TranslationRef.decode(buf1: buffer)
    local var1 = TranslationRef.new()
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
                var1.namespace = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.map_key = buffer.tostring(buf)
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

function TranslationRef:jsonEncode()
    local result = {}

    if self.namespace ~= nil and self.namespace ~= "" then
        result.namespace = self.namespace
    end

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.map_key ~= nil and self.map_key ~= "" then
        result.mapKey = self.map_key
    end

    return result
end

function TranslationRef:jsonDecode()
    local var1 = TranslationRef.new()

    if self.namespace ~= nil then
        var1.namespace = self.namespace
    end

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.map_key ~= nil then
        var1.map_key = self.map_key
    end

    if self.mapKey ~= nil then
        var1.map_key = self.mapKey
    end

    return var1
end

TranslationRef.descriptor = {
    name = "TranslationRef",
    fullName = "roblox.apppageplatform.shared.v1beta1.TranslationRef"
}

tbl1.TranslationRef = TranslationRef

typeRegistry.default:register(tbl1.TranslationRef)

local StringFormat = {}
StringFormat.__index = StringFormat

function StringFormat.new(tbl4)
    return (setmetatable({
        str = if tbl4 == nil or tbl4.str == nil then "" else tbl4.str,
        args = (tbl4 == nil or tbl4.args == nil) and {} or tbl4.args,
        translation = if tbl4 == nil or tbl4.translation == nil then nil else tbl4.translation
    }, StringFormat))
end

function StringFormat:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.str ~= nil and self.str ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.str)
    end

    if self.args ~= nil and next(self.args) ~= nil then
        for k, arg in self.args do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local buf = arg:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.translation ~= nil then
        local buf = self.translation:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringFormat.decode(buf1: buffer)
    local var1 = StringFormat.new()
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
                var1.str = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.StringFormat_ArgsEntry.decode(var4)

                local stringFormatFormatArg = tbl1.StringFormat_FormatArg.new()

                var1.args[var5.key or ""] = var5.value or stringFormatFormatArg
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.translation = tbl1.TranslationRef.decode(var4)
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

function StringFormat:jsonEncode()
    local result = {}

    if self.str ~= nil and self.str ~= "" then
        result.str = self.str
    end

    if self.args ~= nil and next(self.args) ~= nil then
        local args = ({})
        for k, arg in self.args do
            args[k] = arg:jsonEncode()
        end
        result.args = args
    end

    if self.translation ~= nil then
        result.translation = self.translation:jsonEncode()
    end

    return result
end

function StringFormat:jsonDecode()
    local var1 = StringFormat.new()

    if self.str ~= nil then
        var1.str = self.str
    end

    if self.args ~= nil then
        local args = ({})
        for k, arg in self.args do
            args[k] = tbl1.StringFormat_FormatArg.jsonDecode(arg)
        end

        var1.args = args
    end

    if self.translation ~= nil then
        var1.translation = tbl1.TranslationRef.jsonDecode(self.translation)
    end

    return var1
end

StringFormat.descriptor = {
    name = "StringFormat",
    fullName = "roblox.apppageplatform.shared.v1beta1.StringFormat"
}

tbl1.StringFormat = StringFormat

typeRegistry.default:register(tbl1.StringFormat)

local StringFormat_FormatArg = {}
StringFormat_FormatArg.__index = StringFormat_FormatArg

function StringFormat_FormatArg.new(tbl5)
    return (setmetatable({
        kind = if tbl5 == nil or tbl5.kind == nil then nil else tbl5.kind,
        formatter = if tbl5 == nil or tbl5.formatter == nil then nil else tbl5.formatter
    }, StringFormat_FormatArg))
end

function StringFormat_FormatArg:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    if self.formatter ~= nil then
        local buf = self.formatter:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringFormat_FormatArg.decode(buf1: buffer)
    local var1 = StringFormat_FormatArg.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
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
                var1.formatter = tbl1.StringFormat_FormatArg_Formatter.decode(var4)
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

function StringFormat_FormatArg:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    if self.formatter ~= nil then
        result.formatter = self.formatter:jsonEncode()
    end

    return result
end

function StringFormat_FormatArg:jsonDecode()
    local var1 = StringFormat_FormatArg.new()

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
    if self.formatter ~= nil then
        var1.formatter = tbl1.StringFormat_FormatArg_Formatter.jsonDecode(self.formatter)
    end

    return var1
end

StringFormat_FormatArg.descriptor = {
    name = "StringFormat_FormatArg",
    fullName = "roblox.apppageplatform.shared.v1beta1.FormatArg"
}

tbl1.StringFormat_FormatArg = StringFormat_FormatArg

typeRegistry.default:register(tbl1.StringFormat_FormatArg)

local StringFormat_FormatArg_Formatter = {}
StringFormat_FormatArg_Formatter.__index = StringFormat_FormatArg_Formatter

function StringFormat_FormatArg_Formatter.new(tbl6)
    local tbl7 = {
        type = if tbl6 == nil or tbl6.type == nil then assert(tbl1.StringFormat_FormatArg_Formatter_Type.fromNumber(0), "Enum has no 0 default") else tbl6.type,
        config = if tbl6 == nil or tbl6.config == nil then nil else tbl6.config
    }
    return (setmetatable(tbl7, StringFormat_FormatArg_Formatter))
end

function StringFormat_FormatArg_Formatter:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.type ~= nil
        and (self.type ~= nil and self.type ~= 0 or self.type ~= tbl1.StringFormat_FormatArg_Formatter_Type.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.StringFormat_FormatArg_Formatter_Type.toNumber(self.type))
    end

    if self.config ~= nil and self.config.type == "date_config" then
        local buf = self.config.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringFormat_FormatArg_Formatter.decode(buf1: buffer)
    local var1 = StringFormat_FormatArg_Formatter.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.type = tbl1.StringFormat_FormatArg_Formatter_Type.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.config = {
                    type = "date_config",
                    value = tbl1.StringFormat_FormatArg_Formatter_DateConfig.decode(var4)
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

function StringFormat_FormatArg_Formatter:jsonEncode()
    local result = {}

    if self.type ~= nil
        and (self.type ~= nil and self.type ~= 0 or self.type ~= tbl1.StringFormat_FormatArg_Formatter_Type.fromNumber(0))
    then
        result.type = if typeof(self.type) == "number" then self.type else tbl1.StringFormat_FormatArg_Formatter_Type.toNumber(self.type)
    end

    if self.config ~= nil and self.config.type == "date_config" then
        result.dateConfig = self.config.value:jsonEncode()
    end

    return result
end

function StringFormat_FormatArg_Formatter:jsonDecode()
    local var1 = StringFormat_FormatArg_Formatter.new()

    if self.type ~= nil then
        var1.type = if typeof(self.type) == "number" then tbl1.StringFormat_FormatArg_Formatter_Type.fromNumber(self.type) or self.type else tbl1.StringFormat_FormatArg_Formatter_Type.fromName(self.type) or self.type
    end

    if self.date_config ~= nil then
        var1.config = {
            type = "date_config",
            value = tbl1.StringFormat_FormatArg_Formatter_DateConfig.jsonDecode(self.date_config)
        }
    end

    if self.dateConfig ~= nil then
        var1.config = {
            type = "date_config",
            value = tbl1.StringFormat_FormatArg_Formatter_DateConfig.jsonDecode(self.dateConfig)
        }
    end

    return var1
end

StringFormat_FormatArg_Formatter.descriptor = {
    name = "StringFormat_FormatArg_Formatter",
    fullName = "roblox.apppageplatform.shared.v1beta1.Formatter"
}

tbl1.StringFormat_FormatArg_Formatter = StringFormat_FormatArg_Formatter

typeRegistry.default:register(tbl1.StringFormat_FormatArg_Formatter)

local StringFormat_FormatArg_Formatter_DateConfig = {}
StringFormat_FormatArg_Formatter_DateConfig.__index = StringFormat_FormatArg_Formatter_DateConfig

function StringFormat_FormatArg_Formatter_DateConfig.new(tbl7)
    return (setmetatable(
        {
            pattern = if tbl7 == nil or tbl7.pattern == nil then "" else tbl7.pattern
        },
        StringFormat_FormatArg_Formatter_DateConfig
    ))
end

function StringFormat_FormatArg_Formatter_DateConfig:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.pattern ~= nil and self.pattern ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.pattern)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringFormat_FormatArg_Formatter_DateConfig.decode(buf1: buffer)
    local var1 = StringFormat_FormatArg_Formatter_DateConfig.new()
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
                var1.pattern = buffer.tostring(buf)
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

function StringFormat_FormatArg_Formatter_DateConfig:jsonEncode()
    local result = {}

    if self.pattern ~= nil and self.pattern ~= "" then
        result.pattern = self.pattern
    end

    return result
end

function StringFormat_FormatArg_Formatter_DateConfig:jsonDecode()
    local var1 = StringFormat_FormatArg_Formatter_DateConfig.new()

    if self.pattern ~= nil then
        var1.pattern = self.pattern
    end

    return var1
end

StringFormat_FormatArg_Formatter_DateConfig.descriptor = {
    name = "StringFormat_FormatArg_Formatter_DateConfig",
    fullName = "roblox.apppageplatform.shared.v1beta1.DateConfig"
}

tbl1.StringFormat_FormatArg_Formatter_DateConfig = StringFormat_FormatArg_Formatter_DateConfig

typeRegistry.default:register(tbl1.StringFormat_FormatArg_Formatter_DateConfig)

tbl1.StringFormat_FormatArg_Formatter_Type = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "TYPE_INVALID"
        elseif num1 == 1 then
            return "TYPE_NUMBER_ABBREVIATE"
        elseif num1 == 2 then
            return "TYPE_NUMBER_LOCALIZE"
        elseif num1 == 3 then
            return "TYPE_DATE_FORMAT"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "TYPE_INVALID" then
            return 0
        elseif arg1 == "TYPE_NUMBER_ABBREVIATE" then
            return 1
        elseif arg1 == "TYPE_NUMBER_LOCALIZE" then
            return 2
        elseif arg1 == "TYPE_DATE_FORMAT" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "TYPE_INVALID" then
            return "TYPE_INVALID"
        elseif str1 == "TYPE_NUMBER_ABBREVIATE" then
            return "TYPE_NUMBER_ABBREVIATE"
        elseif str1 == "TYPE_NUMBER_LOCALIZE" then
            return "TYPE_NUMBER_LOCALIZE"
        elseif str1 == "TYPE_DATE_FORMAT" then
            return "TYPE_DATE_FORMAT"
        end

        return nil
    end
}

local StringFormat_ArgsEntry = {}
StringFormat_ArgsEntry.__index = StringFormat_ArgsEntry

function StringFormat_ArgsEntry.new(tbl8)
    return (setmetatable({
        key = if tbl8 == nil or tbl8.key == nil then "" else tbl8.key,
        value = if tbl8 == nil or tbl8.value == nil then nil else tbl8.value
    }, StringFormat_ArgsEntry))
end

function StringFormat_ArgsEntry:encode(): buffer
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

function StringFormat_ArgsEntry.decode(buf1: buffer)
    local var1 = StringFormat_ArgsEntry.new()
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
                var1.value = tbl1.StringFormat_FormatArg.decode(var4)
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

function StringFormat_ArgsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function StringFormat_ArgsEntry:jsonDecode()
    local var1 = StringFormat_ArgsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = tbl1.StringFormat_FormatArg.jsonDecode(self.value)
    end

    return var1
end

StringFormat_ArgsEntry.descriptor = {
    name = "StringFormat_ArgsEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArgsEntry"
}

tbl1.StringFormat_ArgsEntry = StringFormat_ArgsEntry

typeRegistry.default:register(tbl1.StringFormat_ArgsEntry)

local StringProp = {}
StringProp.__index = StringProp

function StringProp.new(tbl9)
    return (setmetatable({ kind = if tbl9 == nil or tbl9.kind == nil then nil else tbl9.kind }, StringProp))
end

function StringProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringProp.decode(buf1: buffer)
    local var1 = StringProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.StringProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
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

function StringProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    return result
end

function StringProp.jsonDecode(tbl9)
    local var1 = StringProp.new()

    if tbl9.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl9.literal
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
    if tbl9.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl9.token
        }
    end
    if tbl9.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(tbl9.format)
        }
    end
    if tbl9.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.StringProp_ConditionalOptions.jsonDecode(tbl9.conditional)
        }
    end
    if tbl9.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(tbl9.translation)
        }
    end
    return var1
end

StringProp.descriptor = {
    name = "StringProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.StringProp"
}

tbl1.StringProp = StringProp

typeRegistry.default:register(tbl1.StringProp)

local StringProp_ConditionalOption = {}
StringProp_ConditionalOption.__index = StringProp_ConditionalOption

function StringProp_ConditionalOption.new(tbl10)
    return (setmetatable({
        condition = if tbl10 == nil or tbl10.condition == nil then nil else tbl10.condition,
        kind = if tbl10 == nil or tbl10.kind == nil then nil else tbl10.kind
    }, StringProp_ConditionalOption))
end

function StringProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringProp_ConditionalOption.decode(buf1: buffer)
    local var1 = StringProp_ConditionalOption.new()
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
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
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

function StringProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    return result
end

function StringProp_ConditionalOption:jsonDecode()
    local var1 = StringProp_ConditionalOption.new()

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
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    if self.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(self.format)
        }
    end
    if self.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(self.translation)
        }
    end
    return var1
end

StringProp_ConditionalOption.descriptor = {
    name = "StringProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.StringProp_ConditionalOption = StringProp_ConditionalOption

typeRegistry.default:register(tbl1.StringProp_ConditionalOption)

local StringProp_ConditionalOptions = {}
StringProp_ConditionalOptions.__index = StringProp_ConditionalOptions

function StringProp_ConditionalOptions.new(tbl11)
    return (setmetatable(
        {
            options = (tbl11 == nil or tbl11.options == nil) and {} or tbl11.options
        },
        StringProp_ConditionalOptions
    ))
end

function StringProp_ConditionalOptions:encode(): buffer
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

function StringProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = StringProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.StringProp_ConditionalOption.decode(var4))
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

function StringProp_ConditionalOptions:jsonEncode()
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

function StringProp_ConditionalOptions:jsonDecode()
    local var1 = StringProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.StringProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

StringProp_ConditionalOptions.descriptor = {
    name = "StringProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.StringProp_ConditionalOptions = StringProp_ConditionalOptions

typeRegistry.default:register(tbl1.StringProp_ConditionalOptions)

local FloatProp = {}
FloatProp.__index = FloatProp

function FloatProp.new(tbl12)
    return (setmetatable({ kind = if tbl12 == nil or tbl12.kind == nil then nil else tbl12.kind }, FloatProp))
end

function FloatProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i32)
            buffer2, num1 = proto.writeFloat(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FloatProp.decode(buf1: buffer)
    local var1 = FloatProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.FloatProp_ConditionalOptions.decode(var4)
                }
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function FloatProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = proto.json.serializeNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function FloatProp.jsonDecode(tbl12)
    local var1 = FloatProp.new()

    if tbl12.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = proto.json.deserializeNumber(tbl12.literal)
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
    if tbl12.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl12.token
        }
    end
    if tbl12.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.FloatProp_ConditionalOptions.jsonDecode(tbl12.conditional)
        }
    end
    return var1
end

FloatProp.descriptor = {
    name = "FloatProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.FloatProp"
}

tbl1.FloatProp = FloatProp

typeRegistry.default:register(tbl1.FloatProp)

local FloatProp_ConditionalOption = {}
FloatProp_ConditionalOption.__index = FloatProp_ConditionalOption

function FloatProp_ConditionalOption.new(tbl13)
    return (setmetatable({
        condition = if tbl13 == nil or tbl13.condition == nil then nil else tbl13.condition,
        kind = if tbl13 == nil or tbl13.kind == nil then nil else tbl13.kind
    }, FloatProp_ConditionalOption))
end

function FloatProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i32)
            buffer2, num1 = proto.writeFloat(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FloatProp_ConditionalOption.decode(buf1: buffer)
    local var1 = FloatProp_ConditionalOption.new()
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
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function FloatProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = proto.json.serializeNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "token" then
            result.token = self.kind.value
        end
    end

    return result
end

function FloatProp_ConditionalOption:jsonDecode()
    local var1 = FloatProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = proto.json.deserializeNumber(self.literal)
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
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

FloatProp_ConditionalOption.descriptor = {
    name = "FloatProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.FloatProp_ConditionalOption = FloatProp_ConditionalOption

typeRegistry.default:register(tbl1.FloatProp_ConditionalOption)

local FloatProp_ConditionalOptions = {}
FloatProp_ConditionalOptions.__index = FloatProp_ConditionalOptions

function FloatProp_ConditionalOptions.new(tbl14)
    return (setmetatable({ options = (tbl14 == nil or tbl14.options == nil) and {} or tbl14.options }, FloatProp_ConditionalOptions))
end

function FloatProp_ConditionalOptions:encode(): buffer
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

function FloatProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = FloatProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.FloatProp_ConditionalOption.decode(var4))
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

function FloatProp_ConditionalOptions:jsonEncode()
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

function FloatProp_ConditionalOptions:jsonDecode()
    local var1 = FloatProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.FloatProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

FloatProp_ConditionalOptions.descriptor = {
    name = "FloatProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.FloatProp_ConditionalOptions = FloatProp_ConditionalOptions

typeRegistry.default:register(tbl1.FloatProp_ConditionalOptions)

local ArrayOfFloatProp = {}
ArrayOfFloatProp.__index = ArrayOfFloatProp

function ArrayOfFloatProp.new(tbl15)
    return (setmetatable({ kind = if tbl15 == nil or tbl15.kind == nil then nil else tbl15.kind }, ArrayOfFloatProp))
end

function ArrayOfFloatProp:encode(): buffer
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

function ArrayOfFloatProp.decode(buf1: buffer)
    local var1 = ArrayOfFloatProp.new()
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
                    value = tbl1.ArrayOfFloatProp_ArrayOfFloats.decode(var4)
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
                    value = tbl1.ArrayOfFloatProp_ConditionalOptions.decode(var4)
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

function ArrayOfFloatProp:jsonEncode()
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

function ArrayOfFloatProp.jsonDecode(tbl15)
    local var1 = ArrayOfFloatProp.new()

    if tbl15.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfFloatProp_ArrayOfFloats.jsonDecode(tbl15.literal)
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
            value = tbl1.ArrayOfFloatProp_ConditionalOptions.jsonDecode(tbl15.conditional)
        }
    end

    return var1
end

ArrayOfFloatProp.descriptor = {
    name = "ArrayOfFloatProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfFloatProp"
}

tbl1.ArrayOfFloatProp = ArrayOfFloatProp

typeRegistry.default:register(tbl1.ArrayOfFloatProp)

local ArrayOfFloatProp_ConditionalOption = {}
ArrayOfFloatProp_ConditionalOption.__index = ArrayOfFloatProp_ConditionalOption

function ArrayOfFloatProp_ConditionalOption.new(tbl16)
    return (setmetatable({
        condition = if tbl16 == nil or tbl16.condition == nil then nil else tbl16.condition,
        kind = if tbl16 == nil or tbl16.kind == nil then nil else tbl16.kind
    }, ArrayOfFloatProp_ConditionalOption))
end

function ArrayOfFloatProp_ConditionalOption:encode(): buffer
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

function ArrayOfFloatProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfFloatProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfFloatProp_ArrayOfFloats.decode(var4)
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

function ArrayOfFloatProp_ConditionalOption:jsonEncode()
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

function ArrayOfFloatProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfFloatProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfFloatProp_ArrayOfFloats.jsonDecode(self.literal)
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

ArrayOfFloatProp_ConditionalOption.descriptor = {
    name = "ArrayOfFloatProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfFloatProp_ConditionalOption = ArrayOfFloatProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfFloatProp_ConditionalOption)

local ArrayOfFloatProp_ConditionalOptions = {}
ArrayOfFloatProp_ConditionalOptions.__index = ArrayOfFloatProp_ConditionalOptions

function ArrayOfFloatProp_ConditionalOptions.new(tbl17)
    return (setmetatable(
        {
            options = (tbl17 == nil or tbl17.options == nil) and {} or tbl17.options
        },
        ArrayOfFloatProp_ConditionalOptions
    ))
end

function ArrayOfFloatProp_ConditionalOptions:encode(): buffer
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

function ArrayOfFloatProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfFloatProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfFloatProp_ConditionalOption.decode(var4))
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

function ArrayOfFloatProp_ConditionalOptions:jsonEncode()
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

function ArrayOfFloatProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfFloatProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfFloatProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfFloatProp_ConditionalOptions.descriptor = {
    name = "ArrayOfFloatProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfFloatProp_ConditionalOptions = ArrayOfFloatProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfFloatProp_ConditionalOptions)

local ArrayOfFloatProp_ArrayOfFloats = {}
ArrayOfFloatProp_ArrayOfFloats.__index = ArrayOfFloatProp_ArrayOfFloats

function ArrayOfFloatProp_ArrayOfFloats.new(tbl18)
    return (setmetatable({ array = (tbl18 == nil or tbl18.array == nil) and {} or tbl18.array }, ArrayOfFloatProp_ArrayOfFloats))
end

function ArrayOfFloatProp_ArrayOfFloats:encode(): buffer
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

function ArrayOfFloatProp_ArrayOfFloats.decode(buf1: buffer)
    local var1 = ArrayOfFloatProp_ArrayOfFloats.new()
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
                table.insert(var1.array, tbl1.FloatProp.decode(var4))
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

function ArrayOfFloatProp_ArrayOfFloats:jsonEncode()
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

function ArrayOfFloatProp_ArrayOfFloats:jsonDecode()
    local var1 = ArrayOfFloatProp_ArrayOfFloats.new()

    if self.array ~= nil then
        local array = {}
        for _, value in self.array do
            table.insert(array, tbl1.FloatProp.jsonDecode(value))
        end

        var1.array = array
    end

    return var1
end

ArrayOfFloatProp_ArrayOfFloats.descriptor = {
    name = "ArrayOfFloatProp_ArrayOfFloats",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfFloats"
}

tbl1.ArrayOfFloatProp_ArrayOfFloats = ArrayOfFloatProp_ArrayOfFloats

typeRegistry.default:register(tbl1.ArrayOfFloatProp_ArrayOfFloats)

local DoubleProp = {}
DoubleProp.__index = DoubleProp

function DoubleProp.new(tbl19)
    return (setmetatable({ kind = if tbl19 == nil or tbl19.kind == nil then nil else tbl19.kind }, DoubleProp))
end

function DoubleProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.i64)
            buffer2, num1 = proto.writeDouble(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function DoubleProp.decode(buf1: buffer)
    local var1 = DoubleProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.DoubleProp_ConditionalOptions.decode(var4)
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
        elseif var2 == 1 then
            local var4
            var4, num1 = proto.readDouble(buf1, num1)
            var1.kind = { type = "literal", value = var4 }
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function DoubleProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = proto.json.serializeNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function DoubleProp.jsonDecode(tbl19)
    local var1 = DoubleProp.new()

    if tbl19.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = proto.json.deserializeNumber(tbl19.literal)
        }
    end
    if tbl19.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl19.binding_path
        }
    end
    if tbl19.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl19.bindingPath
        }
    end
    if tbl19.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl19.token
        }
    end
    if tbl19.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.DoubleProp_ConditionalOptions.jsonDecode(tbl19.conditional)
        }
    end
    return var1
end

DoubleProp.descriptor = {
    name = "DoubleProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.DoubleProp"
}

tbl1.DoubleProp = DoubleProp

typeRegistry.default:register(tbl1.DoubleProp)

local DoubleProp_ConditionalOption = {}
DoubleProp_ConditionalOption.__index = DoubleProp_ConditionalOption

function DoubleProp_ConditionalOption.new(tbl20)
    return (setmetatable({
        condition = if tbl20 == nil or tbl20.condition == nil then nil else tbl20.condition,
        kind = if tbl20 == nil or tbl20.kind == nil then nil else tbl20.kind
    }, DoubleProp_ConditionalOption))
end

function DoubleProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.i64)
            buffer2, num1 = proto.writeDouble(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function DoubleProp_ConditionalOption.decode(buf1: buffer)
    local var1 = DoubleProp_ConditionalOption.new()
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
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
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
            var1.kind = { type = "literal", value = var4 }
        else
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        end
    end

    return var1
end

function DoubleProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = proto.json.serializeNumber(self.kind.value)
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "token" then
            result.token = self.kind.value
        end
    end

    return result
end

function DoubleProp_ConditionalOption:jsonDecode()
    local var1 = DoubleProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = proto.json.deserializeNumber(self.literal)
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
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

DoubleProp_ConditionalOption.descriptor = {
    name = "DoubleProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.DoubleProp_ConditionalOption = DoubleProp_ConditionalOption

typeRegistry.default:register(tbl1.DoubleProp_ConditionalOption)

local DoubleProp_ConditionalOptions = {}
DoubleProp_ConditionalOptions.__index = DoubleProp_ConditionalOptions

function DoubleProp_ConditionalOptions.new(tbl21)
    return (setmetatable(
        {
            options = (tbl21 == nil or tbl21.options == nil) and {} or tbl21.options
        },
        DoubleProp_ConditionalOptions
    ))
end

function DoubleProp_ConditionalOptions:encode(): buffer
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

function DoubleProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = DoubleProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.DoubleProp_ConditionalOption.decode(var4))
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

function DoubleProp_ConditionalOptions:jsonEncode()
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

function DoubleProp_ConditionalOptions:jsonDecode()
    local var1 = DoubleProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.DoubleProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

DoubleProp_ConditionalOptions.descriptor = {
    name = "DoubleProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.DoubleProp_ConditionalOptions = DoubleProp_ConditionalOptions

typeRegistry.default:register(tbl1.DoubleProp_ConditionalOptions)

local Int32Prop = {}
Int32Prop.__index = Int32Prop

function Int32Prop.new(tbl22)
    return (setmetatable({ kind = if tbl22 == nil or tbl22.kind == nil then nil else tbl22.kind }, Int32Prop))
end

function Int32Prop:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Int32Prop.decode(buf1: buffer)
    local var1 = Int32Prop.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.Int32Prop_ConditionalOptions.decode(var4)
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

function Int32Prop:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function Int32Prop.jsonDecode(tbl22)
    local var1 = Int32Prop.new()

    if tbl22.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl22.literal
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
    if tbl22.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl22.token
        }
    end
    if tbl22.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.Int32Prop_ConditionalOptions.jsonDecode(tbl22.conditional)
        }
    end
    return var1
end

Int32Prop.descriptor = {
    name = "Int32Prop",
    fullName = "roblox.apppageplatform.shared.v1beta1.Int32Prop"
}

tbl1.Int32Prop = Int32Prop

typeRegistry.default:register(tbl1.Int32Prop)

local Int32Prop_ConditionalOption = {}
Int32Prop_ConditionalOption.__index = Int32Prop_ConditionalOption

function Int32Prop_ConditionalOption.new(tbl23)
    return (setmetatable({
        condition = if tbl23 == nil or tbl23.condition == nil then nil else tbl23.condition,
        kind = if tbl23 == nil or tbl23.kind == nil then nil else tbl23.kind
    }, Int32Prop_ConditionalOption))
end

function Int32Prop_ConditionalOption:encode(): buffer
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
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Int32Prop_ConditionalOption.decode(buf1: buffer)
    local var1 = Int32Prop_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
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
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
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

function Int32Prop_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "token" then
            result.token = self.kind.value
        end
    end

    return result
end

function Int32Prop_ConditionalOption:jsonDecode()
    local var1 = Int32Prop_ConditionalOption.new()

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
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

Int32Prop_ConditionalOption.descriptor = {
    name = "Int32Prop_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.Int32Prop_ConditionalOption = Int32Prop_ConditionalOption

typeRegistry.default:register(tbl1.Int32Prop_ConditionalOption)

local Int32Prop_ConditionalOptions = {}
Int32Prop_ConditionalOptions.__index = Int32Prop_ConditionalOptions

function Int32Prop_ConditionalOptions.new(tbl24)
    return (setmetatable({ options = (tbl24 == nil or tbl24.options == nil) and {} or tbl24.options }, Int32Prop_ConditionalOptions))
end

function Int32Prop_ConditionalOptions:encode(): buffer
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

function Int32Prop_ConditionalOptions.decode(buf1: buffer)
    local var1 = Int32Prop_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.Int32Prop_ConditionalOption.decode(var4))
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

function Int32Prop_ConditionalOptions:jsonEncode()
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

function Int32Prop_ConditionalOptions:jsonDecode()
    local var1 = Int32Prop_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.Int32Prop_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

Int32Prop_ConditionalOptions.descriptor = {
    name = "Int32Prop_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.Int32Prop_ConditionalOptions = Int32Prop_ConditionalOptions

typeRegistry.default:register(tbl1.Int32Prop_ConditionalOptions)

local Int64Prop = {}
Int64Prop.__index = Int64Prop

function Int64Prop.new(tbl25)
    return (setmetatable({ kind = if tbl25 == nil or tbl25.kind == nil then nil else tbl25.kind }, Int64Prop))
end

function Int64Prop:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Int64Prop.decode(buf1: buffer)
    local var1 = Int64Prop.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.Int64Prop_ConditionalOptions.decode(var4)
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

function Int64Prop:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function Int64Prop.jsonDecode(tbl25)
    local var1 = Int64Prop.new()

    if tbl25.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl25.literal
        }
    end
    if tbl25.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl25.binding_path
        }
    end
    if tbl25.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl25.bindingPath
        }
    end
    if tbl25.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl25.token
        }
    end
    if tbl25.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.Int64Prop_ConditionalOptions.jsonDecode(tbl25.conditional)
        }
    end
    return var1
end

Int64Prop.descriptor = {
    name = "Int64Prop",
    fullName = "roblox.apppageplatform.shared.v1beta1.Int64Prop"
}

tbl1.Int64Prop = Int64Prop

typeRegistry.default:register(tbl1.Int64Prop)

local Int64Prop_ConditionalOption = {}
Int64Prop_ConditionalOption.__index = Int64Prop_ConditionalOption

function Int64Prop_ConditionalOption.new(tbl26)
    return (setmetatable({
        condition = if tbl26 == nil or tbl26.condition == nil then nil else tbl26.condition,
        kind = if tbl26 == nil or tbl26.kind == nil then nil else tbl26.kind
    }, Int64Prop_ConditionalOption))
end

function Int64Prop_ConditionalOption:encode(): buffer
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
            buffer2, num1 = proto.writeVarInt(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Int64Prop_ConditionalOption.decode(buf1: buffer)
    local var1 = Int64Prop_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.kind = { type = "literal", value = var4 }
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
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
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

function Int64Prop_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        end

        if self.kind.type == "token" then
            result.token = self.kind.value
        end
    end

    return result
end

function Int64Prop_ConditionalOption:jsonDecode()
    local var1 = Int64Prop_ConditionalOption.new()

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
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

Int64Prop_ConditionalOption.descriptor = {
    name = "Int64Prop_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.Int64Prop_ConditionalOption = Int64Prop_ConditionalOption

typeRegistry.default:register(tbl1.Int64Prop_ConditionalOption)

local Int64Prop_ConditionalOptions = {}
Int64Prop_ConditionalOptions.__index = Int64Prop_ConditionalOptions

function Int64Prop_ConditionalOptions.new(tbl27)
    return (setmetatable({ options = (tbl27 == nil or tbl27.options == nil) and {} or tbl27.options }, Int64Prop_ConditionalOptions))
end

function Int64Prop_ConditionalOptions:encode(): buffer
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

function Int64Prop_ConditionalOptions.decode(buf1: buffer)
    local var1 = Int64Prop_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.Int64Prop_ConditionalOption.decode(var4))
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

function Int64Prop_ConditionalOptions:jsonEncode()
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

function Int64Prop_ConditionalOptions:jsonDecode()
    local var1 = Int64Prop_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.Int64Prop_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

Int64Prop_ConditionalOptions.descriptor = {
    name = "Int64Prop_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.Int64Prop_ConditionalOptions = Int64Prop_ConditionalOptions

typeRegistry.default:register(tbl1.Int64Prop_ConditionalOptions)

local BoolProp = {}
BoolProp.__index = BoolProp

function BoolProp.new(tbl28)
    return (setmetatable({ kind = if tbl28 == nil or tbl28.kind == nil then nil else tbl28.kind }, BoolProp))
end

function BoolProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, if self.kind.value then 1 else 0)
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

function BoolProp.decode(buf1: buffer)
    local var1 = BoolProp.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = var4 ~= 0
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
                    value = tbl1.BoolProp_ConditionalOptions.decode(var4)
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

function BoolProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
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

function BoolProp.jsonDecode(tbl28)
    local var1 = BoolProp.new()

    if tbl28.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl28.literal
        }
    end
    if tbl28.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl28.binding_path
        }
    end
    if tbl28.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl28.bindingPath
        }
    end
    if tbl28.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.BoolProp_ConditionalOptions.jsonDecode(tbl28.conditional)
        }
    end
    return var1
end

BoolProp.descriptor = {
    name = "BoolProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.BoolProp"
}

tbl1.BoolProp = BoolProp

typeRegistry.default:register(tbl1.BoolProp)

local BoolProp_ConditionalOption = {}
BoolProp_ConditionalOption.__index = BoolProp_ConditionalOption

function BoolProp_ConditionalOption.new(tbl29)
    return (setmetatable({
        condition = if tbl29 == nil or tbl29.condition == nil then nil else tbl29.condition,
        kind = if tbl29 == nil or tbl29.kind == nil then nil else tbl29.kind
    }, BoolProp_ConditionalOption))
end

function BoolProp_ConditionalOption:encode(): buffer
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
            buffer2, num1 = proto.writeVarInt(var1, var2, if self.kind.value then 1 else 0)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BoolProp_ConditionalOption.decode(buf1: buffer)
    local var1 = BoolProp_ConditionalOption.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.kind = {
                    type = "literal",
                    value = var4 ~= 0
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

function BoolProp_ConditionalOption:jsonEncode()
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

function BoolProp_ConditionalOption:jsonDecode()
    local var1 = BoolProp_ConditionalOption.new()

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

BoolProp_ConditionalOption.descriptor = {
    name = "BoolProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.BoolProp_ConditionalOption = BoolProp_ConditionalOption

typeRegistry.default:register(tbl1.BoolProp_ConditionalOption)

local BoolProp_ConditionalOptions = {}
BoolProp_ConditionalOptions.__index = BoolProp_ConditionalOptions

function BoolProp_ConditionalOptions.new(tbl30)
    return (setmetatable({ options = (tbl30 == nil or tbl30.options == nil) and {} or tbl30.options }, BoolProp_ConditionalOptions))
end

function BoolProp_ConditionalOptions:encode(): buffer
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

function BoolProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = BoolProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.BoolProp_ConditionalOption.decode(var4))
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

function BoolProp_ConditionalOptions:jsonEncode()
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

function BoolProp_ConditionalOptions:jsonDecode()
    local var1 = BoolProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.BoolProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

BoolProp_ConditionalOptions.descriptor = {
    name = "BoolProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.BoolProp_ConditionalOptions = BoolProp_ConditionalOptions

typeRegistry.default:register(tbl1.BoolProp_ConditionalOptions)

local StructProp = {}
StructProp.__index = StructProp

function StructProp.new(tbl31)
    return (setmetatable({ kind = if tbl31 == nil or tbl31.kind == nil then nil else tbl31.kind }, StructProp))
end

function StructProp:encode(): buffer
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

function StructProp.decode(buf1: buffer)
    local var1 = StructProp.new()
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
                    value = struct.Struct.decode(var4)
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
                    value = tbl1.StructProp_ConditionalOptions.decode(var4)
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

function StructProp:jsonEncode()
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

function StructProp.jsonDecode(tbl31)
    local var1 = StructProp.new()

    if tbl31.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = struct.Struct.jsonDecode(tbl31.literal)
        }
    end
    if tbl31.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl31.binding_path
        }
    end
    if tbl31.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl31.bindingPath
        }
    end
    if tbl31.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.StructProp_ConditionalOptions.jsonDecode(tbl31.conditional)
        }
    end
    return var1
end

StructProp.descriptor = {
    name = "StructProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.StructProp"
}

tbl1.StructProp = StructProp

typeRegistry.default:register(tbl1.StructProp)

local StructProp_ConditionalOption = {}
StructProp_ConditionalOption.__index = StructProp_ConditionalOption

function StructProp_ConditionalOption.new(tbl32)
    return (setmetatable({
        condition = if tbl32 == nil or tbl32.condition == nil then nil else tbl32.condition,
        kind = if tbl32 == nil or tbl32.kind == nil then nil else tbl32.kind
    }, StructProp_ConditionalOption))
end

function StructProp_ConditionalOption:encode(): buffer
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

function StructProp_ConditionalOption.decode(buf1: buffer)
    local var1 = StructProp_ConditionalOption.new()
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
                    value = struct.Struct.decode(var4)
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

function StructProp_ConditionalOption:jsonEncode()
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

function StructProp_ConditionalOption:jsonDecode()
    local var1 = StructProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = struct.Struct.jsonDecode(self.literal)
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

StructProp_ConditionalOption.descriptor = {
    name = "StructProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.StructProp_ConditionalOption = StructProp_ConditionalOption

typeRegistry.default:register(tbl1.StructProp_ConditionalOption)

local StructProp_ConditionalOptions = {}
StructProp_ConditionalOptions.__index = StructProp_ConditionalOptions

function StructProp_ConditionalOptions.new(tbl33)
    return (setmetatable(
        {
            options = (tbl33 == nil or tbl33.options == nil) and {} or tbl33.options
        },
        StructProp_ConditionalOptions
    ))
end

function StructProp_ConditionalOptions:encode(): buffer
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

function StructProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = StructProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.StructProp_ConditionalOption.decode(var4))
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

function StructProp_ConditionalOptions:jsonEncode()
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

function StructProp_ConditionalOptions:jsonDecode()
    local var1 = StructProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.StructProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

StructProp_ConditionalOptions.descriptor = {
    name = "StructProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.StructProp_ConditionalOptions = StructProp_ConditionalOptions

typeRegistry.default:register(tbl1.StructProp_ConditionalOptions)

local ImageStringProp = {}
ImageStringProp.__index = ImageStringProp

function ImageStringProp.new(tbl34)
    return (setmetatable({
        kind = if tbl34 == nil or tbl34.kind == nil then nil else tbl34.kind,
        alt = if tbl34 == nil or tbl34.alt == nil then nil else tbl34.alt
    }, ImageStringProp))
end

function ImageStringProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.alt ~= nil then
        local buf = self.alt:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageStringProp.decode(buf1: buffer)
    local var1 = ImageStringProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
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
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ImageStringProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
                }
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.alt = tbl1.StringFormat.decode(var4)
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

function ImageStringProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        elseif self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    if self.alt ~= nil then
        result.alt = self.alt:jsonEncode()
    end

    return result
end

function ImageStringProp:jsonDecode()
    local var1 = ImageStringProp.new()

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
    if self.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(self.format)
        }
    end
    if self.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ImageStringProp_ConditionalOptions.jsonDecode(self.conditional)
        }
    end

    if self.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(self.translation)
        }
    end
    if self.alt ~= nil then
        var1.alt = tbl1.StringFormat.jsonDecode(self.alt)
    end

    return var1
end

ImageStringProp.descriptor = {
    name = "ImageStringProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ImageStringProp"
}

tbl1.ImageStringProp = ImageStringProp

typeRegistry.default:register(tbl1.ImageStringProp)

local ImageStringProp_ConditionalOption = {}
ImageStringProp_ConditionalOption.__index = ImageStringProp_ConditionalOption

function ImageStringProp_ConditionalOption.new(tbl35)
    return (setmetatable({
        condition = if tbl35 == nil or tbl35.condition == nil then nil else tbl35.condition,
        kind = if tbl35 == nil or tbl35.kind == nil then nil else tbl35.kind
    }, ImageStringProp_ConditionalOption))
end

function ImageStringProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageStringProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ImageStringProp_ConditionalOption.new()
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
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
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

function ImageStringProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ImageStringProp_ConditionalOption:jsonDecode()
    local var1 = ImageStringProp_ConditionalOption.new()

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
    if self.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(self.format)
        }
    end
    if self.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(self.translation)
        }
    end
    return var1
end

ImageStringProp_ConditionalOption.descriptor = {
    name = "ImageStringProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ImageStringProp_ConditionalOption = ImageStringProp_ConditionalOption

typeRegistry.default:register(tbl1.ImageStringProp_ConditionalOption)

local ImageStringProp_ConditionalOptions = {}
ImageStringProp_ConditionalOptions.__index = ImageStringProp_ConditionalOptions

function ImageStringProp_ConditionalOptions.new(tbl36)
    return (setmetatable(
        {
            options = (tbl36 == nil or tbl36.options == nil) and {} or tbl36.options
        },
        ImageStringProp_ConditionalOptions
    ))
end

function ImageStringProp_ConditionalOptions:encode(): buffer
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

function ImageStringProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ImageStringProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ImageStringProp_ConditionalOption.decode(var4))
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

function ImageStringProp_ConditionalOptions:jsonEncode()
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

function ImageStringProp_ConditionalOptions:jsonDecode()
    local var1 = ImageStringProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ImageStringProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ImageStringProp_ConditionalOptions.descriptor = {
    name = "ImageStringProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ImageStringProp_ConditionalOptions = ImageStringProp_ConditionalOptions

typeRegistry.default:register(tbl1.ImageStringProp_ConditionalOptions)

local ImageSetProp = {}
ImageSetProp.__index = ImageSetProp

function ImageSetProp.new(tbl37)
    return (setmetatable({ kind = if tbl37 == nil or tbl37.kind == nil then nil else tbl37.kind }, ImageSetProp))
end

function ImageSetProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageSetProp.decode(buf1: buffer)
    local var1 = ImageSetProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
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
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ImageSetProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
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

function ImageSetProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ImageSetProp.jsonDecode(tbl37)
    local var1 = ImageSetProp.new()

    if tbl37.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl37.literal
        }
    end
    if tbl37.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl37.binding_path
        }
    end
    if tbl37.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl37.bindingPath
        }
    end
    if tbl37.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(tbl37.format)
        }
    end
    if tbl37.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ImageSetProp_ConditionalOptions.jsonDecode(tbl37.conditional)
        }
    end
    if tbl37.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(tbl37.translation)
        }
    end
    return var1
end

ImageSetProp.descriptor = {
    name = "ImageSetProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ImageSetProp"
}

tbl1.ImageSetProp = ImageSetProp

typeRegistry.default:register(tbl1.ImageSetProp)

local ImageSetProp_ConditionalOption = {}
ImageSetProp_ConditionalOption.__index = ImageSetProp_ConditionalOption

function ImageSetProp_ConditionalOption.new(tbl38)
    return (setmetatable({
        condition = if tbl38 == nil or tbl38.condition == nil then nil else tbl38.condition,
        kind = if tbl38 == nil or tbl38.kind == nil then nil else tbl38.kind
    }, ImageSetProp_ConditionalOption))
end

function ImageSetProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "format" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "translation" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ImageSetProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ImageSetProp_ConditionalOption.new()
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
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "format",
                    value = tbl1.StringFormat.decode(var4)
                }
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "translation",
                    value = tbl1.TranslationRef.decode(var4)
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

function ImageSetProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
            return result
        elseif self.kind.type == "format" then
            result.format = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "translation" then
            result.translation = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ImageSetProp_ConditionalOption:jsonDecode()
    local var1 = ImageSetProp_ConditionalOption.new()

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
    if self.format ~= nil then
        var1.kind = {
            type = "format",
            value = tbl1.StringFormat.jsonDecode(self.format)
        }
    end
    if self.translation ~= nil then
        var1.kind = {
            type = "translation",
            value = tbl1.TranslationRef.jsonDecode(self.translation)
        }
    end
    return var1
end

ImageSetProp_ConditionalOption.descriptor = {
    name = "ImageSetProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ImageSetProp_ConditionalOption = ImageSetProp_ConditionalOption

typeRegistry.default:register(tbl1.ImageSetProp_ConditionalOption)

local ImageSetProp_ConditionalOptions = {}
ImageSetProp_ConditionalOptions.__index = ImageSetProp_ConditionalOptions

function ImageSetProp_ConditionalOptions.new(tbl39)
    return (setmetatable(
        {
            options = (tbl39 == nil or tbl39.options == nil) and {} or tbl39.options
        },
        ImageSetProp_ConditionalOptions
    ))
end

function ImageSetProp_ConditionalOptions:encode(): buffer
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

function ImageSetProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ImageSetProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ImageSetProp_ConditionalOption.decode(var4))
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

function ImageSetProp_ConditionalOptions:jsonEncode()
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

function ImageSetProp_ConditionalOptions:jsonDecode()
    local var1 = ImageSetProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ImageSetProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ImageSetProp_ConditionalOptions.descriptor = {
    name = "ImageSetProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ImageSetProp_ConditionalOptions = ImageSetProp_ConditionalOptions

typeRegistry.default:register(tbl1.ImageSetProp_ConditionalOptions)

local ColorProp = {}
ColorProp.__index = ColorProp

function ColorProp.new(tbl40)
    return (setmetatable({ kind = if tbl40 == nil or tbl40.kind == nil then nil else tbl40.kind }, ColorProp))
end

function ColorProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ColorProp.decode(buf1: buffer)
    local var1 = ColorProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ColorProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function ColorProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ColorProp.jsonDecode(tbl40)
    local var1 = ColorProp.new()

    if tbl40.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl40.literal
        }
    end
    if tbl40.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl40.token
        }
    end
    if tbl40.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ColorProp_ConditionalOptions.jsonDecode(tbl40.conditional)
        }
    end
    if tbl40.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl40.binding_path
        }
    end
    if tbl40.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl40.bindingPath
        }
    end
    return var1
end

ColorProp.descriptor = {
    name = "ColorProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ColorProp"
}

tbl1.ColorProp = ColorProp

typeRegistry.default:register(tbl1.ColorProp)

local ColorProp_ConditionalOption = {}
ColorProp_ConditionalOption.__index = ColorProp_ConditionalOption

function ColorProp_ConditionalOption.new(tbl41)
    return (setmetatable({
        condition = if tbl41 == nil or tbl41.condition == nil then nil else tbl41.condition,
        kind = if tbl41 == nil or tbl41.kind == nil then nil else tbl41.kind
    }, ColorProp_ConditionalOption))
end

function ColorProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ColorProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ColorProp_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function ColorProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ColorProp_ConditionalOption:jsonDecode()
    local var1 = ColorProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

ColorProp_ConditionalOption.descriptor = {
    name = "ColorProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ColorProp_ConditionalOption = ColorProp_ConditionalOption

typeRegistry.default:register(tbl1.ColorProp_ConditionalOption)

local ColorProp_ConditionalOptions = {}
ColorProp_ConditionalOptions.__index = ColorProp_ConditionalOptions

function ColorProp_ConditionalOptions.new(tbl42)
    return (setmetatable({ options = (tbl42 == nil or tbl42.options == nil) and {} or tbl42.options }, ColorProp_ConditionalOptions))
end

function ColorProp_ConditionalOptions:encode(): buffer
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

function ColorProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ColorProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ColorProp_ConditionalOption.decode(var4))
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

function ColorProp_ConditionalOptions:jsonEncode()
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

function ColorProp_ConditionalOptions:jsonDecode()
    local var1 = ColorProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ColorProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ColorProp_ConditionalOptions.descriptor = {
    name = "ColorProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ColorProp_ConditionalOptions = ColorProp_ConditionalOptions

typeRegistry.default:register(tbl1.ColorProp_ConditionalOptions)

local TypographyProp = {}
TypographyProp.__index = TypographyProp

function TypographyProp.new(tbl43)
    return (setmetatable({ kind = if tbl43 == nil or tbl43.kind == nil then nil else tbl43.kind }, TypographyProp))
end

function TypographyProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TypographyProp.decode(buf1: buffer)
    local var1 = TypographyProp.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.TypographyProp_ConditionalOptions.decode(var4)
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

function TypographyProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function TypographyProp.jsonDecode(tbl43)
    local var1 = TypographyProp.new()

    if tbl43.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl43.token
        }
    end
    if tbl43.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.TypographyProp_ConditionalOptions.jsonDecode(tbl43.conditional)
        }
    end

    return var1
end

TypographyProp.descriptor = {
    name = "TypographyProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.TypographyProp"
}

tbl1.TypographyProp = TypographyProp

typeRegistry.default:register(tbl1.TypographyProp)

local TypographyProp_ConditionalOption = {}
TypographyProp_ConditionalOption.__index = TypographyProp_ConditionalOption

function TypographyProp_ConditionalOption.new(tbl44)
    return (setmetatable({
        condition = if tbl44 == nil or tbl44.condition == nil then nil else tbl44.condition,
        kind = if tbl44 == nil or tbl44.kind == nil then nil else tbl44.kind
    }, TypographyProp_ConditionalOption))
end

function TypographyProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil and self.kind.type == "token" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TypographyProp_ConditionalOption.decode(buf1: buffer)
    local var1 = TypographyProp_ConditionalOption.new()
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
                    type = "token",
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

function TypographyProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil and self.kind.type == "token" then
        result.token = self.kind.value
    end

    return result
end

function TypographyProp_ConditionalOption:jsonDecode()
    local var1 = TypographyProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

TypographyProp_ConditionalOption.descriptor = {
    name = "TypographyProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.TypographyProp_ConditionalOption = TypographyProp_ConditionalOption

typeRegistry.default:register(tbl1.TypographyProp_ConditionalOption)

local TypographyProp_ConditionalOptions = {}
TypographyProp_ConditionalOptions.__index = TypographyProp_ConditionalOptions

function TypographyProp_ConditionalOptions.new(tbl45)
    return (setmetatable(
        {
            options = (tbl45 == nil or tbl45.options == nil) and {} or tbl45.options
        },
        TypographyProp_ConditionalOptions
    ))
end

function TypographyProp_ConditionalOptions:encode(): buffer
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

function TypographyProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = TypographyProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.TypographyProp_ConditionalOption.decode(var4))
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

function TypographyProp_ConditionalOptions:jsonEncode()
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

function TypographyProp_ConditionalOptions:jsonDecode()
    local var1 = TypographyProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.TypographyProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

TypographyProp_ConditionalOptions.descriptor = {
    name = "TypographyProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.TypographyProp_ConditionalOptions = TypographyProp_ConditionalOptions

typeRegistry.default:register(tbl1.TypographyProp_ConditionalOptions)

local TypographyFontProp = {}
TypographyFontProp.__index = TypographyFontProp

function TypographyFontProp.new(tbl46)
    return (setmetatable({ kind = if tbl46 == nil or tbl46.kind == nil then nil else tbl46.kind }, TypographyFontProp))
end

function TypographyFontProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TypographyFontProp.decode(buf1: buffer)
    local var1 = TypographyFontProp.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.TypographyFontProp_ConditionalOptions.decode(var4)
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

function TypographyFontProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function TypographyFontProp.jsonDecode(tbl46)
    local var1 = TypographyFontProp.new()

    if tbl46.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl46.token
        }
    end
    if tbl46.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.TypographyFontProp_ConditionalOptions.jsonDecode(tbl46.conditional)
        }
    end

    return var1
end

TypographyFontProp.descriptor = {
    name = "TypographyFontProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.TypographyFontProp"
}

tbl1.TypographyFontProp = TypographyFontProp

typeRegistry.default:register(tbl1.TypographyFontProp)

local TypographyFontProp_ConditionalOption = {}
TypographyFontProp_ConditionalOption.__index = TypographyFontProp_ConditionalOption

function TypographyFontProp_ConditionalOption.new(tbl47)
    return (setmetatable({
        condition = if tbl47 == nil or tbl47.condition == nil then nil else tbl47.condition,
        kind = if tbl47 == nil or tbl47.kind == nil then nil else tbl47.kind
    }, TypographyFontProp_ConditionalOption))
end

function TypographyFontProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil and self.kind.type == "token" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function TypographyFontProp_ConditionalOption.decode(buf1: buffer)
    local var1 = TypographyFontProp_ConditionalOption.new()
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
                    type = "token",
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

function TypographyFontProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil and self.kind.type == "token" then
        result.token = self.kind.value
    end

    return result
end

function TypographyFontProp_ConditionalOption:jsonDecode()
    local var1 = TypographyFontProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

TypographyFontProp_ConditionalOption.descriptor = {
    name = "TypographyFontProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.TypographyFontProp_ConditionalOption = TypographyFontProp_ConditionalOption

typeRegistry.default:register(tbl1.TypographyFontProp_ConditionalOption)

local TypographyFontProp_ConditionalOptions = {}
TypographyFontProp_ConditionalOptions.__index = TypographyFontProp_ConditionalOptions

function TypographyFontProp_ConditionalOptions.new(tbl48)
    return (setmetatable(
        {
            options = (tbl48 == nil or tbl48.options == nil) and {} or tbl48.options
        },
        TypographyFontProp_ConditionalOptions
    ))
end

function TypographyFontProp_ConditionalOptions:encode(): buffer
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

function TypographyFontProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = TypographyFontProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.TypographyFontProp_ConditionalOption.decode(var4))
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

function TypographyFontProp_ConditionalOptions:jsonEncode()
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

function TypographyFontProp_ConditionalOptions:jsonDecode()
    local var1 = TypographyFontProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.TypographyFontProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

TypographyFontProp_ConditionalOptions.descriptor = {
    name = "TypographyFontProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.TypographyFontProp_ConditionalOptions = TypographyFontProp_ConditionalOptions

typeRegistry.default:register(tbl1.TypographyFontProp_ConditionalOptions)

local ColorStyleProp = {}
ColorStyleProp.__index = ColorStyleProp

function ColorStyleProp.new(tbl49)
    return (setmetatable({ kind = if tbl49 == nil or tbl49.kind == nil then nil else tbl49.kind }, ColorStyleProp))
end

function ColorStyleProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ColorStyleProp.decode(buf1: buffer)
    local var1 = ColorStyleProp.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.ColorStyleProp_ConditionalOptions.decode(var4)
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

function ColorStyleProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
        end
    end

    return result
end

function ColorStyleProp.jsonDecode(tbl49)
    local var1 = ColorStyleProp.new()

    if tbl49.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl49.token
        }
    end
    if tbl49.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ColorStyleProp_ConditionalOptions.jsonDecode(tbl49.conditional)
        }
    end

    return var1
end

ColorStyleProp.descriptor = {
    name = "ColorStyleProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ColorStyleProp"
}

tbl1.ColorStyleProp = ColorStyleProp

typeRegistry.default:register(tbl1.ColorStyleProp)

local ColorStyleProp_ConditionalOption = {}
ColorStyleProp_ConditionalOption.__index = ColorStyleProp_ConditionalOption

function ColorStyleProp_ConditionalOption.new(tbl50)
    return (setmetatable({
        condition = if tbl50 == nil or tbl50.condition == nil then nil else tbl50.condition,
        kind = if tbl50 == nil or tbl50.kind == nil then nil else tbl50.kind
    }, ColorStyleProp_ConditionalOption))
end

function ColorStyleProp_ConditionalOption:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.condition ~= nil then
        local buf = self.condition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.kind ~= nil and self.kind.type == "token" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ColorStyleProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ColorStyleProp_ConditionalOption.new()
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
                    type = "token",
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

function ColorStyleProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil and self.kind.type == "token" then
        result.token = self.kind.value
    end

    return result
end

function ColorStyleProp_ConditionalOption:jsonDecode()
    local var1 = ColorStyleProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
        }
    end
    return var1
end

ColorStyleProp_ConditionalOption.descriptor = {
    name = "ColorStyleProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ColorStyleProp_ConditionalOption = ColorStyleProp_ConditionalOption

typeRegistry.default:register(tbl1.ColorStyleProp_ConditionalOption)

local ColorStyleProp_ConditionalOptions = {}
ColorStyleProp_ConditionalOptions.__index = ColorStyleProp_ConditionalOptions

function ColorStyleProp_ConditionalOptions.new(tbl51)
    return (setmetatable(
        {
            options = (tbl51 == nil or tbl51.options == nil) and {} or tbl51.options
        },
        ColorStyleProp_ConditionalOptions
    ))
end

function ColorStyleProp_ConditionalOptions:encode(): buffer
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

function ColorStyleProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ColorStyleProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ColorStyleProp_ConditionalOption.decode(var4))
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

function ColorStyleProp_ConditionalOptions:jsonEncode()
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

function ColorStyleProp_ConditionalOptions:jsonDecode()
    local var1 = ColorStyleProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ColorStyleProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ColorStyleProp_ConditionalOptions.descriptor = {
    name = "ColorStyleProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ColorStyleProp_ConditionalOptions = ColorStyleProp_ConditionalOptions

typeRegistry.default:register(tbl1.ColorStyleProp_ConditionalOptions)

local FillBehaviorProp = {}
FillBehaviorProp.__index = FillBehaviorProp

function FillBehaviorProp.new(tbl52)
    return (setmetatable({ kind = if tbl52 == nil or tbl52.kind == nil then nil else tbl52.kind }, FillBehaviorProp))
end

function FillBehaviorProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
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

function FillBehaviorProp.decode(buf1: buffer)
    local var1 = FillBehaviorProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.FillBehaviorProp_ConditionalOptions.decode(var4)
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

function FillBehaviorProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function FillBehaviorProp.jsonDecode(tbl52)
    local var1 = FillBehaviorProp.new()

    if tbl52.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl52.literal
        }
    end
    if tbl52.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.FillBehaviorProp_ConditionalOptions.jsonDecode(tbl52.conditional)
        }
    end

    if tbl52.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl52.binding_path
        }
    end
    if tbl52.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl52.bindingPath
        }
    end
    return var1
end

FillBehaviorProp.descriptor = {
    name = "FillBehaviorProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.FillBehaviorProp"
}

tbl1.FillBehaviorProp = FillBehaviorProp

typeRegistry.default:register(tbl1.FillBehaviorProp)

local FillBehaviorProp_ConditionalOption = {}
FillBehaviorProp_ConditionalOption.__index = FillBehaviorProp_ConditionalOption

function FillBehaviorProp_ConditionalOption.new(tbl53)
    return (setmetatable({
        condition = if tbl53 == nil or tbl53.condition == nil then nil else tbl53.condition,
        kind = if tbl53 == nil or tbl53.kind == nil then nil else tbl53.kind
    }, FillBehaviorProp_ConditionalOption))
end

function FillBehaviorProp_ConditionalOption:encode(): buffer
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

function FillBehaviorProp_ConditionalOption.decode(buf1: buffer)
    local var1 = FillBehaviorProp_ConditionalOption.new()
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

function FillBehaviorProp_ConditionalOption:jsonEncode()
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

function FillBehaviorProp_ConditionalOption:jsonDecode()
    local var1 = FillBehaviorProp_ConditionalOption.new()

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

FillBehaviorProp_ConditionalOption.descriptor = {
    name = "FillBehaviorProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.FillBehaviorProp_ConditionalOption = FillBehaviorProp_ConditionalOption

typeRegistry.default:register(tbl1.FillBehaviorProp_ConditionalOption)

local FillBehaviorProp_ConditionalOptions = {}
FillBehaviorProp_ConditionalOptions.__index = FillBehaviorProp_ConditionalOptions

function FillBehaviorProp_ConditionalOptions.new(tbl54)
    return (setmetatable(
        {
            options = (tbl54 == nil or tbl54.options == nil) and {} or tbl54.options
        },
        FillBehaviorProp_ConditionalOptions
    ))
end

function FillBehaviorProp_ConditionalOptions:encode(): buffer
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

function FillBehaviorProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = FillBehaviorProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.FillBehaviorProp_ConditionalOption.decode(var4))
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

function FillBehaviorProp_ConditionalOptions:jsonEncode()
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

function FillBehaviorProp_ConditionalOptions:jsonDecode()
    local var1 = FillBehaviorProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.FillBehaviorProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

FillBehaviorProp_ConditionalOptions.descriptor = {
    name = "FillBehaviorProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.FillBehaviorProp_ConditionalOptions = FillBehaviorProp_ConditionalOptions

typeRegistry.default:register(tbl1.FillBehaviorProp_ConditionalOptions)

local InputSizeProp = {}
InputSizeProp.__index = InputSizeProp

function InputSizeProp.new(tbl55)
    return (setmetatable({ kind = if tbl55 == nil or tbl55.kind == nil then nil else tbl55.kind }, InputSizeProp))
end

function InputSizeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
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

function InputSizeProp.decode(buf1: buffer)
    local var1 = InputSizeProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.InputSizeProp_ConditionalOptions.decode(var4)
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

function InputSizeProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function InputSizeProp.jsonDecode(tbl55)
    local var1 = InputSizeProp.new()

    if tbl55.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl55.literal
        }
    end
    if tbl55.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.InputSizeProp_ConditionalOptions.jsonDecode(tbl55.conditional)
        }
    end

    if tbl55.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl55.binding_path
        }
    end
    if tbl55.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl55.bindingPath
        }
    end
    return var1
end

InputSizeProp.descriptor = {
    name = "InputSizeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.InputSizeProp"
}

tbl1.InputSizeProp = InputSizeProp

typeRegistry.default:register(tbl1.InputSizeProp)

local InputSizeProp_ConditionalOption = {}
InputSizeProp_ConditionalOption.__index = InputSizeProp_ConditionalOption

function InputSizeProp_ConditionalOption.new(tbl56)
    return (setmetatable({
        condition = if tbl56 == nil or tbl56.condition == nil then nil else tbl56.condition,
        kind = if tbl56 == nil or tbl56.kind == nil then nil else tbl56.kind
    }, InputSizeProp_ConditionalOption))
end

function InputSizeProp_ConditionalOption:encode(): buffer
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

function InputSizeProp_ConditionalOption.decode(buf1: buffer)
    local var1 = InputSizeProp_ConditionalOption.new()
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

function InputSizeProp_ConditionalOption:jsonEncode()
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

function InputSizeProp_ConditionalOption:jsonDecode()
    local var1 = InputSizeProp_ConditionalOption.new()

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

InputSizeProp_ConditionalOption.descriptor = {
    name = "InputSizeProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.InputSizeProp_ConditionalOption = InputSizeProp_ConditionalOption

typeRegistry.default:register(tbl1.InputSizeProp_ConditionalOption)

local InputSizeProp_ConditionalOptions = {}
InputSizeProp_ConditionalOptions.__index = InputSizeProp_ConditionalOptions

function InputSizeProp_ConditionalOptions.new(tbl57)
    return (setmetatable(
        {
            options = (tbl57 == nil or tbl57.options == nil) and {} or tbl57.options
        },
        InputSizeProp_ConditionalOptions
    ))
end

function InputSizeProp_ConditionalOptions:encode(): buffer
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

function InputSizeProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = InputSizeProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.InputSizeProp_ConditionalOption.decode(var4))
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

function InputSizeProp_ConditionalOptions:jsonEncode()
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

function InputSizeProp_ConditionalOptions:jsonDecode()
    local var1 = InputSizeProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.InputSizeProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

InputSizeProp_ConditionalOptions.descriptor = {
    name = "InputSizeProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.InputSizeProp_ConditionalOptions = InputSizeProp_ConditionalOptions

typeRegistry.default:register(tbl1.InputSizeProp_ConditionalOptions)

local UDimProp = {}
UDimProp.__index = UDimProp

function UDimProp.new(tbl58)
    return (setmetatable({ kind = if tbl58 == nil or tbl58.kind == nil then nil else tbl58.kind }, UDimProp))
end

function UDimProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UDimProp.decode(buf1: buffer)
    local var1 = UDimProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UDimProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function UDimProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UDimProp.jsonDecode(tbl58)
    local var1 = UDimProp.new()

    if tbl58.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl58.literal
        }
    end
    if tbl58.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl58.token
        }
    end
    if tbl58.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UDimProp_ConditionalOptions.jsonDecode(tbl58.conditional)
        }
    end
    if tbl58.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl58.binding_path
        }
    end
    if tbl58.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl58.bindingPath
        }
    end
    return var1
end

UDimProp.descriptor = {
    name = "UDimProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.UDimProp"
}

tbl1.UDimProp = UDimProp

typeRegistry.default:register(tbl1.UDimProp)

local UDimProp_ConditionalOption = {}
UDimProp_ConditionalOption.__index = UDimProp_ConditionalOption

function UDimProp_ConditionalOption.new(tbl59)
    return (setmetatable({
        condition = if tbl59 == nil or tbl59.condition == nil then nil else tbl59.condition,
        kind = if tbl59 == nil or tbl59.kind == nil then nil else tbl59.kind
    }, UDimProp_ConditionalOption))
end

function UDimProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UDimProp_ConditionalOption.decode(buf1: buffer)
    local var1 = UDimProp_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function UDimProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UDimProp_ConditionalOption:jsonDecode()
    local var1 = UDimProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

UDimProp_ConditionalOption.descriptor = {
    name = "UDimProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UDimProp_ConditionalOption = UDimProp_ConditionalOption

typeRegistry.default:register(tbl1.UDimProp_ConditionalOption)

local UDimProp_ConditionalOptions = {}
UDimProp_ConditionalOptions.__index = UDimProp_ConditionalOptions

function UDimProp_ConditionalOptions.new(tbl60)
    return (setmetatable({ options = (tbl60 == nil or tbl60.options == nil) and {} or tbl60.options }, UDimProp_ConditionalOptions))
end

function UDimProp_ConditionalOptions:encode(): buffer
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

function UDimProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = UDimProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UDimProp_ConditionalOption.decode(var4))
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

function UDimProp_ConditionalOptions:jsonEncode()
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

function UDimProp_ConditionalOptions:jsonDecode()
    local var1 = UDimProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UDimProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UDimProp_ConditionalOptions.descriptor = {
    name = "UDimProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UDimProp_ConditionalOptions = UDimProp_ConditionalOptions

typeRegistry.default:register(tbl1.UDimProp_ConditionalOptions)

local UDim2Prop = {}
UDim2Prop.__index = UDim2Prop

function UDim2Prop.new(tbl61)
    return (setmetatable({ kind = if tbl61 == nil or tbl61.kind == nil then nil else tbl61.kind }, UDim2Prop))
end

function UDim2Prop:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UDim2Prop.decode(buf1: buffer)
    local var1 = UDim2Prop.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UDim2Prop_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function UDim2Prop:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UDim2Prop.jsonDecode(tbl61)
    local var1 = UDim2Prop.new()

    if tbl61.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl61.literal
        }
    end
    if tbl61.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl61.token
        }
    end
    if tbl61.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UDim2Prop_ConditionalOptions.jsonDecode(tbl61.conditional)
        }
    end
    if tbl61.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl61.binding_path
        }
    end
    if tbl61.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl61.bindingPath
        }
    end
    return var1
end

UDim2Prop.descriptor = {
    name = "UDim2Prop",
    fullName = "roblox.apppageplatform.shared.v1beta1.UDim2Prop"
}

tbl1.UDim2Prop = UDim2Prop

typeRegistry.default:register(tbl1.UDim2Prop)

local UDim2Prop_ConditionalOption = {}
UDim2Prop_ConditionalOption.__index = UDim2Prop_ConditionalOption

function UDim2Prop_ConditionalOption.new(tbl62)
    return (setmetatable({
        condition = if tbl62 == nil or tbl62.condition == nil then nil else tbl62.condition,
        kind = if tbl62 == nil or tbl62.kind == nil then nil else tbl62.kind
    }, UDim2Prop_ConditionalOption))
end

function UDim2Prop_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UDim2Prop_ConditionalOption.decode(buf1: buffer)
    local var1 = UDim2Prop_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function UDim2Prop_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UDim2Prop_ConditionalOption:jsonDecode()
    local var1 = UDim2Prop_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

UDim2Prop_ConditionalOption.descriptor = {
    name = "UDim2Prop_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UDim2Prop_ConditionalOption = UDim2Prop_ConditionalOption

typeRegistry.default:register(tbl1.UDim2Prop_ConditionalOption)

local UDim2Prop_ConditionalOptions = {}
UDim2Prop_ConditionalOptions.__index = UDim2Prop_ConditionalOptions

function UDim2Prop_ConditionalOptions.new(tbl63)
    return (setmetatable({ options = (tbl63 == nil or tbl63.options == nil) and {} or tbl63.options }, UDim2Prop_ConditionalOptions))
end

function UDim2Prop_ConditionalOptions:encode(): buffer
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

function UDim2Prop_ConditionalOptions.decode(buf1: buffer)
    local var1 = UDim2Prop_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UDim2Prop_ConditionalOption.decode(var4))
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

function UDim2Prop_ConditionalOptions:jsonEncode()
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

function UDim2Prop_ConditionalOptions:jsonDecode()
    local var1 = UDim2Prop_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UDim2Prop_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UDim2Prop_ConditionalOptions.descriptor = {
    name = "UDim2Prop_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UDim2Prop_ConditionalOptions = UDim2Prop_ConditionalOptions

typeRegistry.default:register(tbl1.UDim2Prop_ConditionalOptions)

local Vector2Prop = {}
Vector2Prop.__index = Vector2Prop

function Vector2Prop.new(tbl64)
    return (setmetatable({ kind = if tbl64 == nil or tbl64.kind == nil then nil else tbl64.kind }, Vector2Prop))
end

function Vector2Prop:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Vector2Prop.decode(buf1: buffer)
    local var1 = Vector2Prop.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.Vector2Prop_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function Vector2Prop:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function Vector2Prop.jsonDecode(tbl64)
    local var1 = Vector2Prop.new()

    if tbl64.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl64.literal
        }
    end
    if tbl64.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl64.token
        }
    end
    if tbl64.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.Vector2Prop_ConditionalOptions.jsonDecode(tbl64.conditional)
        }
    end
    if tbl64.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl64.binding_path
        }
    end
    if tbl64.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl64.bindingPath
        }
    end
    return var1
end

Vector2Prop.descriptor = {
    name = "Vector2Prop",
    fullName = "roblox.apppageplatform.shared.v1beta1.Vector2Prop"
}

tbl1.Vector2Prop = Vector2Prop

typeRegistry.default:register(tbl1.Vector2Prop)

local Vector2Prop_ConditionalOption = {}
Vector2Prop_ConditionalOption.__index = Vector2Prop_ConditionalOption

function Vector2Prop_ConditionalOption.new(tbl65)
    return (setmetatable({
        condition = if tbl65 == nil or tbl65.condition == nil then nil else tbl65.condition,
        kind = if tbl65 == nil or tbl65.kind == nil then nil else tbl65.kind
    }, Vector2Prop_ConditionalOption))
end

function Vector2Prop_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Vector2Prop_ConditionalOption.decode(buf1: buffer)
    local var1 = Vector2Prop_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function Vector2Prop_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function Vector2Prop_ConditionalOption:jsonDecode()
    local var1 = Vector2Prop_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

Vector2Prop_ConditionalOption.descriptor = {
    name = "Vector2Prop_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.Vector2Prop_ConditionalOption = Vector2Prop_ConditionalOption

typeRegistry.default:register(tbl1.Vector2Prop_ConditionalOption)

local Vector2Prop_ConditionalOptions = {}
Vector2Prop_ConditionalOptions.__index = Vector2Prop_ConditionalOptions

function Vector2Prop_ConditionalOptions.new(tbl66)
    return (setmetatable(
        {
            options = (tbl66 == nil or tbl66.options == nil) and {} or tbl66.options
        },
        Vector2Prop_ConditionalOptions
    ))
end

function Vector2Prop_ConditionalOptions:encode(): buffer
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

function Vector2Prop_ConditionalOptions.decode(buf1: buffer)
    local var1 = Vector2Prop_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.Vector2Prop_ConditionalOption.decode(var4))
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

function Vector2Prop_ConditionalOptions:jsonEncode()
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

function Vector2Prop_ConditionalOptions:jsonDecode()
    local var1 = Vector2Prop_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.Vector2Prop_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

Vector2Prop_ConditionalOptions.descriptor = {
    name = "Vector2Prop_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.Vector2Prop_ConditionalOptions = Vector2Prop_ConditionalOptions

typeRegistry.default:register(tbl1.Vector2Prop_ConditionalOptions)

local IconProp = {}
IconProp.__index = IconProp

function IconProp.new(tbl67)
    return (setmetatable({ kind = if tbl67 == nil or tbl67.kind == nil then nil else tbl67.kind }, IconProp))
end

function IconProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
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

function IconProp.decode(buf1: buffer)
    local var1 = IconProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
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
                    value = tbl1.IconProp_ConditionalOptions.decode(var4)
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

function IconProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
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

function IconProp.jsonDecode(tbl67)
    local var1 = IconProp.new()

    if tbl67.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl67.literal
        }
    end
    if tbl67.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl67.binding_path
        }
    end
    if tbl67.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl67.bindingPath
        }
    end
    if tbl67.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.IconProp_ConditionalOptions.jsonDecode(tbl67.conditional)
        }
    end
    return var1
end

IconProp.descriptor = {
    name = "IconProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.IconProp"
}

tbl1.IconProp = IconProp

typeRegistry.default:register(tbl1.IconProp)

local IconProp_ConditionalOption = {}
IconProp_ConditionalOption.__index = IconProp_ConditionalOption

function IconProp_ConditionalOption.new(tbl68)
    return (setmetatable({
        condition = if tbl68 == nil or tbl68.condition == nil then nil else tbl68.condition,
        kind = if tbl68 == nil or tbl68.kind == nil then nil else tbl68.kind
    }, IconProp_ConditionalOption))
end

function IconProp_ConditionalOption:encode(): buffer
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

function IconProp_ConditionalOption.decode(buf1: buffer)
    local var1 = IconProp_ConditionalOption.new()
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

function IconProp_ConditionalOption:jsonEncode()
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

function IconProp_ConditionalOption:jsonDecode()
    local var1 = IconProp_ConditionalOption.new()

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

IconProp_ConditionalOption.descriptor = {
    name = "IconProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.IconProp_ConditionalOption = IconProp_ConditionalOption

typeRegistry.default:register(tbl1.IconProp_ConditionalOption)

local IconProp_ConditionalOptions = {}
IconProp_ConditionalOptions.__index = IconProp_ConditionalOptions

function IconProp_ConditionalOptions.new(tbl69)
    return (setmetatable({ options = (tbl69 == nil or tbl69.options == nil) and {} or tbl69.options }, IconProp_ConditionalOptions))
end

function IconProp_ConditionalOptions:encode(): buffer
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

function IconProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = IconProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.IconProp_ConditionalOption.decode(var4))
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

function IconProp_ConditionalOptions:jsonEncode()
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

function IconProp_ConditionalOptions:jsonDecode()
    local var1 = IconProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.IconProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

IconProp_ConditionalOptions.descriptor = {
    name = "IconProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.IconProp_ConditionalOptions = IconProp_ConditionalOptions

typeRegistry.default:register(tbl1.IconProp_ConditionalOptions)

local FoundationIconConfigProp = {}
FoundationIconConfigProp.__index = FoundationIconConfigProp

function FoundationIconConfigProp.new(tbl70)
    return (setmetatable({ kind = if tbl70 == nil or tbl70.kind == nil then nil else tbl70.kind }, FoundationIconConfigProp))
end

function FoundationIconConfigProp:encode(): buffer
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

function FoundationIconConfigProp.decode(buf1: buffer)
    local var1 = FoundationIconConfigProp.new()
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
                    value = tbl1.FoundationIconConfigProp_FoundationIconConfig.decode(var4)
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
                    value = tbl1.FoundationIconConfigProp_ConditionalOptions.decode(var4)
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

function FoundationIconConfigProp:jsonEncode()
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

function FoundationIconConfigProp.jsonDecode(tbl70)
    local var1 = FoundationIconConfigProp.new()

    if tbl70.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.FoundationIconConfigProp_FoundationIconConfig.jsonDecode(tbl70.literal)
        }
    end

    if tbl70.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl70.binding_path
        }
    end
    if tbl70.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl70.bindingPath
        }
    end
    if tbl70.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.FoundationIconConfigProp_ConditionalOptions.jsonDecode(tbl70.conditional)
        }
    end

    return var1
end

FoundationIconConfigProp.descriptor = {
    name = "FoundationIconConfigProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.FoundationIconConfigProp"
}

tbl1.FoundationIconConfigProp = FoundationIconConfigProp

typeRegistry.default:register(tbl1.FoundationIconConfigProp)

local FoundationIconConfigProp_ConditionalOption = {}
FoundationIconConfigProp_ConditionalOption.__index = FoundationIconConfigProp_ConditionalOption

function FoundationIconConfigProp_ConditionalOption.new(tbl71)
    return (setmetatable({
        condition = if tbl71 == nil or tbl71.condition == nil then nil else tbl71.condition,
        kind = if tbl71 == nil or tbl71.kind == nil then nil else tbl71.kind
    }, FoundationIconConfigProp_ConditionalOption))
end

function FoundationIconConfigProp_ConditionalOption:encode(): buffer
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

function FoundationIconConfigProp_ConditionalOption.decode(buf1: buffer)
    local var1 = FoundationIconConfigProp_ConditionalOption.new()
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
                    value = tbl1.FoundationIconConfigProp_FoundationIconConfig.decode(var4)
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

function FoundationIconConfigProp_ConditionalOption:jsonEncode()
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

function FoundationIconConfigProp_ConditionalOption:jsonDecode()
    local var1 = FoundationIconConfigProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.FoundationIconConfigProp_FoundationIconConfig.jsonDecode(self.literal)
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

FoundationIconConfigProp_ConditionalOption.descriptor = {
    name = "FoundationIconConfigProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.FoundationIconConfigProp_ConditionalOption = FoundationIconConfigProp_ConditionalOption

typeRegistry.default:register(tbl1.FoundationIconConfigProp_ConditionalOption)

local FoundationIconConfigProp_ConditionalOptions = {}
FoundationIconConfigProp_ConditionalOptions.__index = FoundationIconConfigProp_ConditionalOptions

function FoundationIconConfigProp_ConditionalOptions.new(tbl72)
    return (setmetatable(
        {
            options = (tbl72 == nil or tbl72.options == nil) and {} or tbl72.options
        },
        FoundationIconConfigProp_ConditionalOptions
    ))
end

function FoundationIconConfigProp_ConditionalOptions:encode(): buffer
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

function FoundationIconConfigProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = FoundationIconConfigProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.FoundationIconConfigProp_ConditionalOption.decode(var4))
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

function FoundationIconConfigProp_ConditionalOptions:jsonEncode()
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

function FoundationIconConfigProp_ConditionalOptions:jsonDecode()
    local var1 = FoundationIconConfigProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.FoundationIconConfigProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

FoundationIconConfigProp_ConditionalOptions.descriptor = {
    name = "FoundationIconConfigProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.FoundationIconConfigProp_ConditionalOptions = FoundationIconConfigProp_ConditionalOptions

typeRegistry.default:register(tbl1.FoundationIconConfigProp_ConditionalOptions)

local FoundationIconConfigProp_FoundationIconConfig = {}
FoundationIconConfigProp_FoundationIconConfig.__index = FoundationIconConfigProp_FoundationIconConfig

function FoundationIconConfigProp_FoundationIconConfig.new(tbl73)
    return (setmetatable({
        name = if tbl73 == nil or tbl73.name == nil then nil else tbl73.name,
        variant = if tbl73 == nil or tbl73.variant == nil then nil else tbl73.variant
    }, FoundationIconConfigProp_FoundationIconConfig))
end

function FoundationIconConfigProp_FoundationIconConfig:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil then
        local buf = self.name:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.variant ~= nil then
        local buf = self.variant:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FoundationIconConfigProp_FoundationIconConfig.decode(buf1: buffer)
    local var1 = FoundationIconConfigProp_FoundationIconConfig.new()
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
                var1.name = tbl1.StringProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.variant = tbl1.StringProp.decode(var4)
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

function FoundationIconConfigProp_FoundationIconConfig:jsonEncode()
    local result = {}

    if self.name ~= nil then
        result.name = self.name:jsonEncode()
    end

    if self.variant ~= nil then
        result.variant = self.variant:jsonEncode()
    end

    return result
end

function FoundationIconConfigProp_FoundationIconConfig:jsonDecode()
    local var1 = FoundationIconConfigProp_FoundationIconConfig.new()

    if self.name ~= nil then
        var1.name = tbl1.StringProp.jsonDecode(self.name)
    end

    if self.variant ~= nil then
        var1.variant = tbl1.StringProp.jsonDecode(self.variant)
    end

    return var1
end

FoundationIconConfigProp_FoundationIconConfig.descriptor = {
    name = "FoundationIconConfigProp_FoundationIconConfig",
    fullName = "roblox.apppageplatform.shared.v1beta1.FoundationIconConfig"
}

tbl1.FoundationIconConfigProp_FoundationIconConfig = FoundationIconConfigProp_FoundationIconConfig

typeRegistry.default:register(tbl1.FoundationIconConfigProp_FoundationIconConfig)

local IconSizeProp = {}
IconSizeProp.__index = IconSizeProp

function IconSizeProp.new(tbl74)
    return (setmetatable({ oneof_prop = if tbl74 == nil or tbl74.oneof_prop == nil then nil else tbl74.oneof_prop }, IconSizeProp))
end

function IconSizeProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "string_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "int32_prop" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IconSizeProp.decode(buf1: buffer)
    local var1 = IconSizeProp.new()
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
                    value = tbl1.StringProp.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "int32_prop",
                    value = tbl1.Int32Prop.decode(var4)
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

function IconSizeProp:jsonEncode()
    local result = {}

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "string_prop" then
            result.stringProp = self.oneof_prop.value:jsonEncode()
            return result
        end

        if self.oneof_prop.type == "int32_prop" then
            result.int32Prop = self.oneof_prop.value:jsonEncode()
        end
    end

    return result
end

function IconSizeProp.jsonDecode(tbl74)
    local var1 = IconSizeProp.new()

    if tbl74.string_prop ~= nil then
        var1.oneof_prop = {
            type = "string_prop",
            value = tbl1.StringProp.jsonDecode(tbl74.string_prop)
        }
    end
    if tbl74.stringProp ~= nil then
        var1.oneof_prop = {
            type = "string_prop",
            value = tbl1.StringProp.jsonDecode(tbl74.stringProp)
        }
    end
    if tbl74.int32_prop ~= nil then
        var1.oneof_prop = {
            type = "int32_prop",
            value = tbl1.Int32Prop.jsonDecode(tbl74.int32_prop)
        }
    end
    if tbl74.int32Prop ~= nil then
        var1.oneof_prop = {
            type = "int32_prop",
            value = tbl1.Int32Prop.jsonDecode(tbl74.int32Prop)
        }
    end
    return var1
end

IconSizeProp.descriptor = {
    name = "IconSizeProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.IconSizeProp"
}

tbl1.IconSizeProp = IconSizeProp

typeRegistry.default:register(tbl1.IconSizeProp)

local GradientProp = {}
GradientProp.__index = GradientProp

function GradientProp.new(tbl75)
    return (setmetatable({ kind = if tbl75 == nil or tbl75.kind == nil then nil else tbl75.kind }, GradientProp))
end

function GradientProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "conditional" then
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

function GradientProp.decode(buf1: buffer)
    local var1 = GradientProp.new()
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
                    value = tbl1.GradientProp_GradientData.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.GradientProp_ConditionalOptions.decode(var4)
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

function GradientProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value:jsonEncode()
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function GradientProp.jsonDecode(tbl75)
    local var1 = GradientProp.new()

    if tbl75.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.GradientProp_GradientData.jsonDecode(tbl75.literal)
        }
    end
    if tbl75.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.GradientProp_ConditionalOptions.jsonDecode(tbl75.conditional)
        }
    end
    if tbl75.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl75.binding_path
        }
    end
    if tbl75.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl75.bindingPath
        }
    end
    return var1
end

GradientProp.descriptor = {
    name = "GradientProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.GradientProp"
}

tbl1.GradientProp = GradientProp

typeRegistry.default:register(tbl1.GradientProp)

local GradientProp_ConditionalOption = {}
GradientProp_ConditionalOption.__index = GradientProp_ConditionalOption

function GradientProp_ConditionalOption.new(tbl76)
    return (setmetatable({
        condition = if tbl76 == nil or tbl76.condition == nil then nil else tbl76.condition,
        kind = if tbl76 == nil or tbl76.kind == nil then nil else tbl76.kind
    }, GradientProp_ConditionalOption))
end

function GradientProp_ConditionalOption:encode(): buffer
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

function GradientProp_ConditionalOption.decode(buf1: buffer)
    local var1 = GradientProp_ConditionalOption.new()
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
                    value = tbl1.GradientProp_GradientData.decode(var4)
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

function GradientProp_ConditionalOption:jsonEncode()
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

function GradientProp_ConditionalOption:jsonDecode()
    local var1 = GradientProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.GradientProp_GradientData.jsonDecode(self.literal)
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

GradientProp_ConditionalOption.descriptor = {
    name = "GradientProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.GradientProp_ConditionalOption = GradientProp_ConditionalOption

typeRegistry.default:register(tbl1.GradientProp_ConditionalOption)

local GradientProp_ConditionalOptions = {}
GradientProp_ConditionalOptions.__index = GradientProp_ConditionalOptions

function GradientProp_ConditionalOptions.new(tbl77)
    return (setmetatable(
        {
            options = (tbl77 == nil or tbl77.options == nil) and {} or tbl77.options
        },
        GradientProp_ConditionalOptions
    ))
end

function GradientProp_ConditionalOptions:encode(): buffer
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

function GradientProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = GradientProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.GradientProp_ConditionalOption.decode(var4))
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

function GradientProp_ConditionalOptions:jsonEncode()
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

function GradientProp_ConditionalOptions:jsonDecode()
    local var1 = GradientProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.GradientProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

GradientProp_ConditionalOptions.descriptor = {
    name = "GradientProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.GradientProp_ConditionalOptions = GradientProp_ConditionalOptions

typeRegistry.default:register(tbl1.GradientProp_ConditionalOptions)

local GradientProp_GradientData = {}
GradientProp_GradientData.__index = GradientProp_GradientData

function GradientProp_GradientData.new(tbl78)
    return (setmetatable({
        start_color = if tbl78 == nil or tbl78.start_color == nil then "" else tbl78.start_color,
        end_color = if tbl78 == nil or tbl78.end_color == nil then "" else tbl78.end_color,
        start_opacity = if tbl78 == nil or tbl78.start_opacity == nil then 0 else tbl78.start_opacity,
        end_opacity = if tbl78 == nil or tbl78.end_opacity == nil then 0 else tbl78.end_opacity,
        degree = if tbl78 == nil or tbl78.degree == nil then 0 else tbl78.degree,
        midpoint_percent = if tbl78 == nil or tbl78.midpoint_percent == nil then 0 else tbl78.midpoint_percent
    }, GradientProp_GradientData))
end

function GradientProp_GradientData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.start_color ~= nil and self.start_color ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.start_color)
    end

    if self.end_color ~= nil and self.end_color ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.end_color)
    end

    if self.start_opacity ~= nil and self.start_opacity ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.start_opacity)
    end

    if self.end_opacity ~= nil and self.end_opacity ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.end_opacity)
    end

    if self.degree ~= nil and self.degree ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.degree)
    end

    if self.midpoint_percent ~= nil and self.midpoint_percent ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.i32)
        buffer2, num1 = proto.writeFloat(var1, var2, self.midpoint_percent)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GradientProp_GradientData.decode(buf1: buffer)
    local var1 = GradientProp_GradientData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.degree = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.start_color = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.end_color = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.start_opacity = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.end_opacity = var4
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readFloat(buf1, num1)
                var1.midpoint_percent = var4
            else
                local _
                _, num1 = proto.readFixed32(buf1, num1)
            end
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function GradientProp_GradientData:jsonEncode()
    local result = {}

    if self.start_color ~= nil and self.start_color ~= "" then
        result.startColor = self.start_color
    end

    if self.end_color ~= nil and self.end_color ~= "" then
        result.endColor = self.end_color
    end

    if self.start_opacity ~= nil and self.start_opacity ~= 0 then
        result.startOpacity = proto.json.serializeNumber(self.start_opacity)
    end

    if self.end_opacity ~= nil and self.end_opacity ~= 0 then
        result.endOpacity = proto.json.serializeNumber(self.end_opacity)
    end

    if self.degree ~= nil and self.degree ~= 0 then
        result.degree = self.degree
    end

    if self.midpoint_percent ~= nil and self.midpoint_percent ~= 0 then
        result.midpointPercent = proto.json.serializeNumber(self.midpoint_percent)
    end

    return result
end

function GradientProp_GradientData:jsonDecode()
    local var1 = GradientProp_GradientData.new()

    if self.start_color ~= nil then
        var1.start_color = self.start_color
    end

    if self.startColor ~= nil then
        var1.start_color = self.startColor
    end

    if self.end_color ~= nil then
        var1.end_color = self.end_color
    end

    if self.endColor ~= nil then
        var1.end_color = self.endColor
    end

    if self.start_opacity ~= nil then
        var1.start_opacity = proto.json.deserializeNumber(self.start_opacity)
    end

    if self.startOpacity ~= nil then
        var1.start_opacity = proto.json.deserializeNumber(self.startOpacity)
    end

    if self.end_opacity ~= nil then
        var1.end_opacity = proto.json.deserializeNumber(self.end_opacity)
    end

    if self.endOpacity ~= nil then
        var1.end_opacity = proto.json.deserializeNumber(self.endOpacity)
    end

    if self.degree ~= nil then
        var1.degree = self.degree
    end

    if self.midpoint_percent ~= nil then
        var1.midpoint_percent = proto.json.deserializeNumber(self.midpoint_percent)
    end

    if self.midpointPercent ~= nil then
        var1.midpoint_percent = proto.json.deserializeNumber(self.midpointPercent)
    end

    return var1
end

GradientProp_GradientData.descriptor = {
    name = "GradientProp_GradientData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GradientData"
}

tbl1.GradientProp_GradientData = GradientProp_GradientData

typeRegistry.default:register(tbl1.GradientProp_GradientData)

local ArrayOfStructProp = {}
ArrayOfStructProp.__index = ArrayOfStructProp

function ArrayOfStructProp.new(tbl79)
    return (setmetatable({ kind = if tbl79 == nil or tbl79.kind == nil then nil else tbl79.kind }, ArrayOfStructProp))
end

function ArrayOfStructProp:encode(): buffer
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

function ArrayOfStructProp.decode(buf1: buffer)
    local var1 = ArrayOfStructProp.new()
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
                    value = tbl1.ArrayOfStructProp_ArrayOfStructs.decode(var4)
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
                    value = tbl1.ArrayOfStructProp_ConditionalOptions.decode(var4)
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

function ArrayOfStructProp:jsonEncode()
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

function ArrayOfStructProp.jsonDecode(tbl79)
    local var1 = ArrayOfStructProp.new()

    if tbl79.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfStructProp_ArrayOfStructs.jsonDecode(tbl79.literal)
        }
    end
    if tbl79.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl79.binding_path
        }
    end
    if tbl79.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl79.bindingPath
        }
    end
    if tbl79.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ArrayOfStructProp_ConditionalOptions.jsonDecode(tbl79.conditional)
        }
    end

    return var1
end

ArrayOfStructProp.descriptor = {
    name = "ArrayOfStructProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfStructProp"
}

tbl1.ArrayOfStructProp = ArrayOfStructProp

typeRegistry.default:register(tbl1.ArrayOfStructProp)

local ArrayOfStructProp_ConditionalOption = {}
ArrayOfStructProp_ConditionalOption.__index = ArrayOfStructProp_ConditionalOption

function ArrayOfStructProp_ConditionalOption.new(tbl80)
    return (setmetatable({
        condition = if tbl80 == nil or tbl80.condition == nil then nil else tbl80.condition,
        kind = if tbl80 == nil or tbl80.kind == nil then nil else tbl80.kind
    }, ArrayOfStructProp_ConditionalOption))
end

function ArrayOfStructProp_ConditionalOption:encode(): buffer
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

function ArrayOfStructProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfStructProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfStructProp_ArrayOfStructs.decode(var4)
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

function ArrayOfStructProp_ConditionalOption:jsonEncode()
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

function ArrayOfStructProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfStructProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfStructProp_ArrayOfStructs.jsonDecode(self.literal)
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

ArrayOfStructProp_ConditionalOption.descriptor = {
    name = "ArrayOfStructProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfStructProp_ConditionalOption = ArrayOfStructProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfStructProp_ConditionalOption)

local ArrayOfStructProp_ConditionalOptions = {}
ArrayOfStructProp_ConditionalOptions.__index = ArrayOfStructProp_ConditionalOptions

function ArrayOfStructProp_ConditionalOptions.new(tbl81)
    return (setmetatable(
        {
            options = (tbl81 == nil or tbl81.options == nil) and {} or tbl81.options
        },
        ArrayOfStructProp_ConditionalOptions
    ))
end

function ArrayOfStructProp_ConditionalOptions:encode(): buffer
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

function ArrayOfStructProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfStructProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfStructProp_ConditionalOption.decode(var4))
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

function ArrayOfStructProp_ConditionalOptions:jsonEncode()
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

function ArrayOfStructProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfStructProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfStructProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfStructProp_ConditionalOptions.descriptor = {
    name = "ArrayOfStructProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfStructProp_ConditionalOptions = ArrayOfStructProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfStructProp_ConditionalOptions)

local ArrayOfStructProp_ArrayOfStructs = {}
ArrayOfStructProp_ArrayOfStructs.__index = ArrayOfStructProp_ArrayOfStructs

function ArrayOfStructProp_ArrayOfStructs.new(tbl82)
    return (setmetatable({ entry = (tbl82 == nil or tbl82.entry == nil) and {} or tbl82.entry }, ArrayOfStructProp_ArrayOfStructs))
end

function ArrayOfStructProp_ArrayOfStructs:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.entry ~= nil and #self.entry > 0 then
        for _, value in self.entry do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ArrayOfStructProp_ArrayOfStructs.decode(buf1: buffer)
    local var1 = ArrayOfStructProp_ArrayOfStructs.new()
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
                table.insert(var1.entry, struct.Struct.decode(var4))
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

function ArrayOfStructProp_ArrayOfStructs:jsonEncode()
    local result = {}

    if self.entry ~= nil and #self.entry > 0 then
        local entry = {}
        for _, value in self.entry do
            table.insert(entry, value:jsonEncode())
        end
        result.entry = entry
    end

    return result
end

function ArrayOfStructProp_ArrayOfStructs:jsonDecode()
    local var1 = ArrayOfStructProp_ArrayOfStructs.new()

    if self.entry ~= nil then
        local entry = {}
        for _, value in self.entry do
            table.insert(entry, struct.Struct.jsonDecode(value))
        end

        var1.entry = entry
    end

    return var1
end

ArrayOfStructProp_ArrayOfStructs.descriptor = {
    name = "ArrayOfStructProp_ArrayOfStructs",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfStructs"
}

tbl1.ArrayOfStructProp_ArrayOfStructs = ArrayOfStructProp_ArrayOfStructs

typeRegistry.default:register(tbl1.ArrayOfStructProp_ArrayOfStructs)

local PymkItemData = {}
PymkItemData.__index = PymkItemData

function PymkItemData.new(tbl83)
    return (setmetatable({
        item_id = if tbl83 == nil or tbl83.item_id == nil then "" else tbl83.item_id,
        has_pending_friend_request = not (tbl83 == nil or tbl83.has_pending_friend_request == nil) and tbl83.has_pending_friend_request,
        is_seed_user_friend = not (tbl83 == nil or tbl83.is_seed_user_friend == nil) and tbl83.is_seed_user_friend
    }, PymkItemData))
end

function PymkItemData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.item_id ~= nil and self.item_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.item_id)
    end

    if self.has_pending_friend_request then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.has_pending_friend_request then 1 else 0)
    end

    if self.is_seed_user_friend then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_seed_user_friend then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PymkItemData.decode(buf1: buffer)
    local var1 = PymkItemData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.has_pending_friend_request = var4 ~= 0
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_seed_user_friend = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.item_id = buffer.tostring(buf)
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

function PymkItemData:jsonEncode()
    local result = {}

    if self.item_id ~= nil and self.item_id ~= "" then
        result.itemId = self.item_id
    end

    if self.has_pending_friend_request then
        result.hasPendingFriendRequest = self.has_pending_friend_request
    end

    if self.is_seed_user_friend then
        result.isSeedUserFriend = self.is_seed_user_friend
    end

    return result
end

function PymkItemData:jsonDecode()
    local var1 = PymkItemData.new()

    if self.item_id ~= nil then
        var1.item_id = self.item_id
    end

    if self.itemId ~= nil then
        var1.item_id = self.itemId
    end

    if self.has_pending_friend_request ~= nil then
        var1.has_pending_friend_request = self.has_pending_friend_request
    end

    if self.hasPendingFriendRequest ~= nil then
        var1.has_pending_friend_request = self.hasPendingFriendRequest
    end

    if self.is_seed_user_friend ~= nil then
        var1.is_seed_user_friend = self.is_seed_user_friend
    end

    if self.isSeedUserFriend ~= nil then
        var1.is_seed_user_friend = self.isSeedUserFriend
    end

    return var1
end

PymkItemData.descriptor = {
    name = "PymkItemData",
    fullName = "roblox.apppageplatform.shared.v1beta1.PymkItemData"
}

tbl1.PymkItemData = PymkItemData

typeRegistry.default:register(tbl1.PymkItemData)

local ArrayOfPymkItemDataProp = {}
ArrayOfPymkItemDataProp.__index = ArrayOfPymkItemDataProp

function ArrayOfPymkItemDataProp.new(tbl84)
    return (setmetatable({ kind = if tbl84 == nil or tbl84.kind == nil then nil else tbl84.kind }, ArrayOfPymkItemDataProp))
end

function ArrayOfPymkItemDataProp:encode(): buffer
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

function ArrayOfPymkItemDataProp.decode(buf1: buffer)
    local var1 = ArrayOfPymkItemDataProp.new()
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
                    value = tbl1.ArrayOfPymkItemDataProp_PymkItems.decode(var4)
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
                    value = tbl1.ArrayOfPymkItemDataProp_ConditionalOptions.decode(var4)
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

function ArrayOfPymkItemDataProp:jsonEncode()
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

function ArrayOfPymkItemDataProp.jsonDecode(tbl84)
    local var1 = ArrayOfPymkItemDataProp.new()

    if tbl84.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfPymkItemDataProp_PymkItems.jsonDecode(tbl84.literal)
        }
    end
    if tbl84.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl84.binding_path
        }
    end
    if tbl84.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl84.bindingPath
        }
    end
    if tbl84.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ArrayOfPymkItemDataProp_ConditionalOptions.jsonDecode(tbl84.conditional)
        }
    end

    return var1
end

ArrayOfPymkItemDataProp.descriptor = {
    name = "ArrayOfPymkItemDataProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfPymkItemDataProp"
}

tbl1.ArrayOfPymkItemDataProp = ArrayOfPymkItemDataProp

typeRegistry.default:register(tbl1.ArrayOfPymkItemDataProp)

local ArrayOfPymkItemDataProp_ConditionalOption = {}
ArrayOfPymkItemDataProp_ConditionalOption.__index = ArrayOfPymkItemDataProp_ConditionalOption

function ArrayOfPymkItemDataProp_ConditionalOption.new(tbl85)
    return (setmetatable({
        condition = if tbl85 == nil or tbl85.condition == nil then nil else tbl85.condition,
        kind = if tbl85 == nil or tbl85.kind == nil then nil else tbl85.kind
    }, ArrayOfPymkItemDataProp_ConditionalOption))
end

function ArrayOfPymkItemDataProp_ConditionalOption:encode(): buffer
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

function ArrayOfPymkItemDataProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfPymkItemDataProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfPymkItemDataProp_PymkItems.decode(var4)
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

function ArrayOfPymkItemDataProp_ConditionalOption:jsonEncode()
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

function ArrayOfPymkItemDataProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfPymkItemDataProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfPymkItemDataProp_PymkItems.jsonDecode(self.literal)
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

ArrayOfPymkItemDataProp_ConditionalOption.descriptor = {
    name = "ArrayOfPymkItemDataProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfPymkItemDataProp_ConditionalOption = ArrayOfPymkItemDataProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfPymkItemDataProp_ConditionalOption)

local ArrayOfPymkItemDataProp_ConditionalOptions = {}
ArrayOfPymkItemDataProp_ConditionalOptions.__index = ArrayOfPymkItemDataProp_ConditionalOptions

function ArrayOfPymkItemDataProp_ConditionalOptions.new(tbl86)
    return (setmetatable(
        {
            options = (tbl86 == nil or tbl86.options == nil) and {} or tbl86.options
        },
        ArrayOfPymkItemDataProp_ConditionalOptions
    ))
end

function ArrayOfPymkItemDataProp_ConditionalOptions:encode(): buffer
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

function ArrayOfPymkItemDataProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfPymkItemDataProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfPymkItemDataProp_ConditionalOption.decode(var4))
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

function ArrayOfPymkItemDataProp_ConditionalOptions:jsonEncode()
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

function ArrayOfPymkItemDataProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfPymkItemDataProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfPymkItemDataProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfPymkItemDataProp_ConditionalOptions.descriptor = {
    name = "ArrayOfPymkItemDataProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfPymkItemDataProp_ConditionalOptions = ArrayOfPymkItemDataProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfPymkItemDataProp_ConditionalOptions)

local ArrayOfPymkItemDataProp_PymkItems = {}
ArrayOfPymkItemDataProp_PymkItems.__index = ArrayOfPymkItemDataProp_PymkItems

function ArrayOfPymkItemDataProp_PymkItems.new(tbl87)
    return (setmetatable({ items = (tbl87 == nil or tbl87.items == nil) and {} or tbl87.items }, ArrayOfPymkItemDataProp_PymkItems))
end

function ArrayOfPymkItemDataProp_PymkItems:encode(): buffer
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

function ArrayOfPymkItemDataProp_PymkItems.decode(buf1: buffer)
    local var1 = ArrayOfPymkItemDataProp_PymkItems.new()
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
                table.insert(var1.items, tbl1.PymkItemData.decode(var4))
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

function ArrayOfPymkItemDataProp_PymkItems:jsonEncode()
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

function ArrayOfPymkItemDataProp_PymkItems:jsonDecode()
    local var1 = ArrayOfPymkItemDataProp_PymkItems.new()

    if self.items ~= nil then
        local items = {}
        for _, item in self.items do
            table.insert(items, tbl1.PymkItemData.jsonDecode(item))
        end

        var1.items = items
    end

    return var1
end

ArrayOfPymkItemDataProp_PymkItems.descriptor = {
    name = "ArrayOfPymkItemDataProp_PymkItems",
    fullName = "roblox.apppageplatform.shared.v1beta1.PymkItems"
}

tbl1.ArrayOfPymkItemDataProp_PymkItems = ArrayOfPymkItemDataProp_PymkItems

typeRegistry.default:register(tbl1.ArrayOfPymkItemDataProp_PymkItems)

local UiScaledFloatProp = {}
UiScaledFloatProp.__index = UiScaledFloatProp

function UiScaledFloatProp.new(tbl88)
    return (setmetatable({ kind = if tbl88 == nil or tbl88.kind == nil then nil else tbl88.kind }, UiScaledFloatProp))
end

function UiScaledFloatProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledFloatProp.decode(buf1: buffer)
    local var1 = UiScaledFloatProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UiScaledFloatProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function UiScaledFloatProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledFloatProp.jsonDecode(tbl88)
    local var1 = UiScaledFloatProp.new()

    if tbl88.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl88.literal
        }
    end
    if tbl88.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl88.token
        }
    end
    if tbl88.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UiScaledFloatProp_ConditionalOptions.jsonDecode(tbl88.conditional)
        }
    end

    if tbl88.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl88.binding_path
        }
    end
    if tbl88.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl88.bindingPath
        }
    end
    return var1
end

UiScaledFloatProp.descriptor = {
    name = "UiScaledFloatProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.UiScaledFloatProp"
}

tbl1.UiScaledFloatProp = UiScaledFloatProp

typeRegistry.default:register(tbl1.UiScaledFloatProp)

local UiScaledFloatProp_ConditionalOption = {}
UiScaledFloatProp_ConditionalOption.__index = UiScaledFloatProp_ConditionalOption

function UiScaledFloatProp_ConditionalOption.new(tbl89)
    return (setmetatable({
        condition = if tbl89 == nil or tbl89.condition == nil then nil else tbl89.condition,
        kind = if tbl89 == nil or tbl89.kind == nil then nil else tbl89.kind
    }, UiScaledFloatProp_ConditionalOption))
end

function UiScaledFloatProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledFloatProp_ConditionalOption.decode(buf1: buffer)
    local var1 = UiScaledFloatProp_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function UiScaledFloatProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledFloatProp_ConditionalOption:jsonDecode()
    local var1 = UiScaledFloatProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

UiScaledFloatProp_ConditionalOption.descriptor = {
    name = "UiScaledFloatProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UiScaledFloatProp_ConditionalOption = UiScaledFloatProp_ConditionalOption

typeRegistry.default:register(tbl1.UiScaledFloatProp_ConditionalOption)

local UiScaledFloatProp_ConditionalOptions = {}
UiScaledFloatProp_ConditionalOptions.__index = UiScaledFloatProp_ConditionalOptions

function UiScaledFloatProp_ConditionalOptions.new(tbl90)
    return (setmetatable(
        {
            options = (tbl90 == nil or tbl90.options == nil) and {} or tbl90.options
        },
        UiScaledFloatProp_ConditionalOptions
    ))
end

function UiScaledFloatProp_ConditionalOptions:encode(): buffer
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

function UiScaledFloatProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = UiScaledFloatProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UiScaledFloatProp_ConditionalOption.decode(var4))
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

function UiScaledFloatProp_ConditionalOptions:jsonEncode()
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

function UiScaledFloatProp_ConditionalOptions:jsonDecode()
    local var1 = UiScaledFloatProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UiScaledFloatProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UiScaledFloatProp_ConditionalOptions.descriptor = {
    name = "UiScaledFloatProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UiScaledFloatProp_ConditionalOptions = UiScaledFloatProp_ConditionalOptions

typeRegistry.default:register(tbl1.UiScaledFloatProp_ConditionalOptions)

local UiScaledUDimProp = {}
UiScaledUDimProp.__index = UiScaledUDimProp

function UiScaledUDimProp.new(tbl91)
    return (setmetatable({ kind = if tbl91 == nil or tbl91.kind == nil then nil else tbl91.kind }, UiScaledUDimProp))
end

function UiScaledUDimProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledUDimProp.decode(buf1: buffer)
    local var1 = UiScaledUDimProp.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UiScaledUDimProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function UiScaledUDimProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledUDimProp.jsonDecode(tbl91)
    local var1 = UiScaledUDimProp.new()

    if tbl91.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl91.literal
        }
    end
    if tbl91.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl91.token
        }
    end
    if tbl91.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UiScaledUDimProp_ConditionalOptions.jsonDecode(tbl91.conditional)
        }
    end

    if tbl91.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl91.binding_path
        }
    end
    if tbl91.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl91.bindingPath
        }
    end
    return var1
end

UiScaledUDimProp.descriptor = {
    name = "UiScaledUDimProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.UiScaledUDimProp"
}

tbl1.UiScaledUDimProp = UiScaledUDimProp

typeRegistry.default:register(tbl1.UiScaledUDimProp)

local UiScaledUDimProp_ConditionalOption = {}
UiScaledUDimProp_ConditionalOption.__index = UiScaledUDimProp_ConditionalOption

function UiScaledUDimProp_ConditionalOption.new(tbl92)
    return (setmetatable({
        condition = if tbl92 == nil or tbl92.condition == nil then nil else tbl92.condition,
        kind = if tbl92 == nil or tbl92.kind == nil then nil else tbl92.kind
    }, UiScaledUDimProp_ConditionalOption))
end

function UiScaledUDimProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledUDimProp_ConditionalOption.decode(buf1: buffer)
    local var1 = UiScaledUDimProp_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function UiScaledUDimProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledUDimProp_ConditionalOption:jsonDecode()
    local var1 = UiScaledUDimProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

UiScaledUDimProp_ConditionalOption.descriptor = {
    name = "UiScaledUDimProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UiScaledUDimProp_ConditionalOption = UiScaledUDimProp_ConditionalOption

typeRegistry.default:register(tbl1.UiScaledUDimProp_ConditionalOption)

local UiScaledUDimProp_ConditionalOptions = {}
UiScaledUDimProp_ConditionalOptions.__index = UiScaledUDimProp_ConditionalOptions

function UiScaledUDimProp_ConditionalOptions.new(tbl93)
    return (setmetatable(
        {
            options = (tbl93 == nil or tbl93.options == nil) and {} or tbl93.options
        },
        UiScaledUDimProp_ConditionalOptions
    ))
end

function UiScaledUDimProp_ConditionalOptions:encode(): buffer
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

function UiScaledUDimProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = UiScaledUDimProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UiScaledUDimProp_ConditionalOption.decode(var4))
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

function UiScaledUDimProp_ConditionalOptions:jsonEncode()
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

function UiScaledUDimProp_ConditionalOptions:jsonDecode()
    local var1 = UiScaledUDimProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UiScaledUDimProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UiScaledUDimProp_ConditionalOptions.descriptor = {
    name = "UiScaledUDimProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UiScaledUDimProp_ConditionalOptions = UiScaledUDimProp_ConditionalOptions

typeRegistry.default:register(tbl1.UiScaledUDimProp_ConditionalOptions)

local UiScaledUDim2Prop = {}
UiScaledUDim2Prop.__index = UiScaledUDim2Prop

function UiScaledUDim2Prop.new(tbl94)
    return (setmetatable({ kind = if tbl94 == nil or tbl94.kind == nil then nil else tbl94.kind }, UiScaledUDim2Prop))
end

function UiScaledUDim2Prop:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledUDim2Prop.decode(buf1: buffer)
    local var1 = UiScaledUDim2Prop.new()
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
                    type = "literal",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.UiScaledUDim2Prop_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
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

function UiScaledUDim2Prop:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        elseif self.kind.type == "conditional" then
            result.conditional = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledUDim2Prop.jsonDecode(tbl94)
    local var1 = UiScaledUDim2Prop.new()

    if tbl94.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl94.literal
        }
    end
    if tbl94.token ~= nil then
        var1.kind = {
            type = "token",
            value = tbl94.token
        }
    end
    if tbl94.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.UiScaledUDim2Prop_ConditionalOptions.jsonDecode(tbl94.conditional)
        }
    end

    if tbl94.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl94.binding_path
        }
    end
    if tbl94.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl94.bindingPath
        }
    end
    return var1
end

UiScaledUDim2Prop.descriptor = {
    name = "UiScaledUDim2Prop",
    fullName = "roblox.apppageplatform.shared.v1beta1.UiScaledUDim2Prop"
}

tbl1.UiScaledUDim2Prop = UiScaledUDim2Prop

typeRegistry.default:register(tbl1.UiScaledUDim2Prop)

local UiScaledUDim2Prop_ConditionalOption = {}
UiScaledUDim2Prop_ConditionalOption.__index = UiScaledUDim2Prop_ConditionalOption

function UiScaledUDim2Prop_ConditionalOption.new(tbl95)
    return (setmetatable({
        condition = if tbl95 == nil or tbl95.condition == nil then nil else tbl95.condition,
        kind = if tbl95 == nil or tbl95.kind == nil then nil else tbl95.kind
    }, UiScaledUDim2Prop_ConditionalOption))
end

function UiScaledUDim2Prop_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "token" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UiScaledUDim2Prop_ConditionalOption.decode(buf1: buffer)
    local var1 = UiScaledUDim2Prop_ConditionalOption.new()
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
                    type = "token",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
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

function UiScaledUDim2Prop_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        elseif self.kind.type == "token" then
            result.token = self.kind.value
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function UiScaledUDim2Prop_ConditionalOption:jsonDecode()
    local var1 = UiScaledUDim2Prop_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = self.literal
        }
    end
    if self.token ~= nil then
        var1.kind = {
            type = "token",
            value = self.token
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

UiScaledUDim2Prop_ConditionalOption.descriptor = {
    name = "UiScaledUDim2Prop_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.UiScaledUDim2Prop_ConditionalOption = UiScaledUDim2Prop_ConditionalOption

typeRegistry.default:register(tbl1.UiScaledUDim2Prop_ConditionalOption)

local UiScaledUDim2Prop_ConditionalOptions = {}
UiScaledUDim2Prop_ConditionalOptions.__index = UiScaledUDim2Prop_ConditionalOptions

function UiScaledUDim2Prop_ConditionalOptions.new(tbl96)
    return (setmetatable(
        {
            options = (tbl96 == nil or tbl96.options == nil) and {} or tbl96.options
        },
        UiScaledUDim2Prop_ConditionalOptions
    ))
end

function UiScaledUDim2Prop_ConditionalOptions:encode(): buffer
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

function UiScaledUDim2Prop_ConditionalOptions.decode(buf1: buffer)
    local var1 = UiScaledUDim2Prop_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.UiScaledUDim2Prop_ConditionalOption.decode(var4))
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

function UiScaledUDim2Prop_ConditionalOptions:jsonEncode()
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

function UiScaledUDim2Prop_ConditionalOptions:jsonDecode()
    local var1 = UiScaledUDim2Prop_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UiScaledUDim2Prop_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UiScaledUDim2Prop_ConditionalOptions.descriptor = {
    name = "UiScaledUDim2Prop_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.UiScaledUDim2Prop_ConditionalOptions = UiScaledUDim2Prop_ConditionalOptions

typeRegistry.default:register(tbl1.UiScaledUDim2Prop_ConditionalOptions)

local AvatarConfigProp = {}
AvatarConfigProp.__index = AvatarConfigProp

function AvatarConfigProp.new(tbl97)
    return (setmetatable({
        user_id = if tbl97 == nil or tbl97.user_id == nil then nil else tbl97.user_id,
        user_presence = if tbl97 == nil or tbl97.user_presence == nil then nil else tbl97.user_presence
    }, AvatarConfigProp))
end

function AvatarConfigProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.user_id ~= nil then
        local buf = self.user_id:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.user_presence ~= nil then
        local buf = self.user_presence:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AvatarConfigProp.decode(buf1: buffer)
    local var1 = AvatarConfigProp.new()
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
                var1.user_id = tbl1.Int64Prop.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.user_presence = tbl1.StringProp.decode(var4)
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

function AvatarConfigProp:jsonEncode()
    local result = {}

    if self.user_id ~= nil then
        result.userId = self.user_id:jsonEncode()
    end

    if self.user_presence ~= nil then
        result.userPresence = self.user_presence:jsonEncode()
    end

    return result
end

function AvatarConfigProp:jsonDecode()
    local var1 = AvatarConfigProp.new()

    if self.user_id ~= nil then
        var1.user_id = tbl1.Int64Prop.jsonDecode(self.user_id)
    end

    if self.userId ~= nil then
        var1.user_id = tbl1.Int64Prop.jsonDecode(self.userId)
    end

    if self.user_presence ~= nil then
        var1.user_presence = tbl1.StringProp.jsonDecode(self.user_presence)
    end

    if self.userPresence ~= nil then
        var1.user_presence = tbl1.StringProp.jsonDecode(self.userPresence)
    end

    return var1
end

AvatarConfigProp.descriptor = {
    name = "AvatarConfigProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.AvatarConfigProp"
}

tbl1.AvatarConfigProp = AvatarConfigProp

typeRegistry.default:register(tbl1.AvatarConfigProp)

local AvatarProp = {}
AvatarProp.__index = AvatarProp

function AvatarProp.new(tbl98)
    return (setmetatable({ oneof_prop = if tbl98 == nil or tbl98.oneof_prop == nil then nil else tbl98.oneof_prop }, AvatarProp))
end

function AvatarProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "user_id" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "avatar_config" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AvatarProp.decode(buf1: buffer)
    local var1 = AvatarProp.new()
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
                    type = "user_id",
                    value = tbl1.Int64Prop.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "avatar_config",
                    value = tbl1.AvatarConfigProp.decode(var4)
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

function AvatarProp:jsonEncode()
    local result = {}

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "user_id" then
            result.userId = self.oneof_prop.value:jsonEncode()
            return result
        end

        if self.oneof_prop.type == "avatar_config" then
            result.avatarConfig = self.oneof_prop.value:jsonEncode()
        end
    end

    return result
end

function AvatarProp.jsonDecode(tbl98)
    local var1 = AvatarProp.new()

    if tbl98.user_id ~= nil then
        var1.oneof_prop = {
            type = "user_id",
            value = tbl1.Int64Prop.jsonDecode(tbl98.user_id)
        }
    end
    if tbl98.userId ~= nil then
        var1.oneof_prop = {
            type = "user_id",
            value = tbl1.Int64Prop.jsonDecode(tbl98.userId)
        }
    end
    if tbl98.avatar_config ~= nil then
        var1.oneof_prop = {
            type = "avatar_config",
            value = tbl1.AvatarConfigProp.jsonDecode(tbl98.avatar_config)
        }
    end
    if tbl98.avatarConfig ~= nil then
        var1.oneof_prop = {
            type = "avatar_config",
            value = tbl1.AvatarConfigProp.jsonDecode(tbl98.avatarConfig)
        }
    end
    return var1
end

AvatarProp.descriptor = {
    name = "AvatarProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.AvatarProp"
}

tbl1.AvatarProp = AvatarProp

typeRegistry.default:register(tbl1.AvatarProp)

local ArrayOfAvatarProp = {}
ArrayOfAvatarProp.__index = ArrayOfAvatarProp

function ArrayOfAvatarProp.new(tbl99)
    return (setmetatable({ kind = if tbl99 == nil or tbl99.kind == nil then nil else tbl99.kind }, ArrayOfAvatarProp))
end

function ArrayOfAvatarProp:encode(): buffer
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

function ArrayOfAvatarProp.decode(buf1: buffer)
    local var1 = ArrayOfAvatarProp.new()
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
                    value = tbl1.ArrayOfAvatarProp_ArrayOfAvatars.decode(var4)
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
                    value = tbl1.ArrayOfAvatarProp_ConditionalOptions.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "array_map",
                    value = tbl1.ArrayOfAvatarProp_ArrayMap.decode(var4)
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

function ArrayOfAvatarProp:jsonEncode()
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

function ArrayOfAvatarProp.jsonDecode(tbl99)
    local var1 = ArrayOfAvatarProp.new()

    if tbl99.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfAvatarProp_ArrayOfAvatars.jsonDecode(tbl99.literal)
        }
    end
    if tbl99.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl99.binding_path
        }
    end
    if tbl99.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl99.bindingPath
        }
    end
    if tbl99.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ArrayOfAvatarProp_ConditionalOptions.jsonDecode(tbl99.conditional)
        }
    end

    if tbl99.array_map ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfAvatarProp_ArrayMap.jsonDecode(tbl99.array_map)
        }
    end
    if tbl99.arrayMap ~= nil then
        var1.kind = {
            type = "array_map",
            value = tbl1.ArrayOfAvatarProp_ArrayMap.jsonDecode(tbl99.arrayMap)
        }
    end
    return var1
end

ArrayOfAvatarProp.descriptor = {
    name = "ArrayOfAvatarProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfAvatarProp"
}

tbl1.ArrayOfAvatarProp = ArrayOfAvatarProp

typeRegistry.default:register(tbl1.ArrayOfAvatarProp)

local ArrayOfAvatarProp_ConditionalOption = {}
ArrayOfAvatarProp_ConditionalOption.__index = ArrayOfAvatarProp_ConditionalOption

function ArrayOfAvatarProp_ConditionalOption.new(tbl100)
    return (setmetatable({
        condition = if tbl100 == nil or tbl100.condition == nil then nil else tbl100.condition,
        kind = if tbl100 == nil or tbl100.kind == nil then nil else tbl100.kind
    }, ArrayOfAvatarProp_ConditionalOption))
end

function ArrayOfAvatarProp_ConditionalOption:encode(): buffer
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

function ArrayOfAvatarProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ArrayOfAvatarProp_ConditionalOption.new()
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
                    value = tbl1.ArrayOfAvatarProp_ArrayOfAvatars.decode(var4)
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

function ArrayOfAvatarProp_ConditionalOption:jsonEncode()
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

function ArrayOfAvatarProp_ConditionalOption:jsonDecode()
    local var1 = ArrayOfAvatarProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ArrayOfAvatarProp_ArrayOfAvatars.jsonDecode(self.literal)
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

ArrayOfAvatarProp_ConditionalOption.descriptor = {
    name = "ArrayOfAvatarProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ArrayOfAvatarProp_ConditionalOption = ArrayOfAvatarProp_ConditionalOption

typeRegistry.default:register(tbl1.ArrayOfAvatarProp_ConditionalOption)

local ArrayOfAvatarProp_ConditionalOptions = {}
ArrayOfAvatarProp_ConditionalOptions.__index = ArrayOfAvatarProp_ConditionalOptions

function ArrayOfAvatarProp_ConditionalOptions.new(tbl101)
    return (setmetatable(
        {
            options = (tbl101 == nil or tbl101.options == nil) and {} or tbl101.options
        },
        ArrayOfAvatarProp_ConditionalOptions
    ))
end

function ArrayOfAvatarProp_ConditionalOptions:encode(): buffer
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

function ArrayOfAvatarProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ArrayOfAvatarProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ArrayOfAvatarProp_ConditionalOption.decode(var4))
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

function ArrayOfAvatarProp_ConditionalOptions:jsonEncode()
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

function ArrayOfAvatarProp_ConditionalOptions:jsonDecode()
    local var1 = ArrayOfAvatarProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ArrayOfAvatarProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ArrayOfAvatarProp_ConditionalOptions.descriptor = {
    name = "ArrayOfAvatarProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ArrayOfAvatarProp_ConditionalOptions = ArrayOfAvatarProp_ConditionalOptions

typeRegistry.default:register(tbl1.ArrayOfAvatarProp_ConditionalOptions)

local ArrayOfAvatarProp_ArrayOfAvatars = {}
ArrayOfAvatarProp_ArrayOfAvatars.__index = ArrayOfAvatarProp_ArrayOfAvatars

function ArrayOfAvatarProp_ArrayOfAvatars.new(tbl102)
    return (setmetatable(
        {
            array = (tbl102 == nil or tbl102.array == nil) and {} or tbl102.array
        },
        ArrayOfAvatarProp_ArrayOfAvatars
    ))
end

function ArrayOfAvatarProp_ArrayOfAvatars:encode(): buffer
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

function ArrayOfAvatarProp_ArrayOfAvatars.decode(buf1: buffer)
    local var1 = ArrayOfAvatarProp_ArrayOfAvatars.new()
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
                table.insert(var1.array, tbl1.AvatarProp.decode(var4))
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

function ArrayOfAvatarProp_ArrayOfAvatars:jsonEncode()
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

function ArrayOfAvatarProp_ArrayOfAvatars:jsonDecode()
    local var1 = ArrayOfAvatarProp_ArrayOfAvatars.new()

    if self.array ~= nil then
        local array = {}
        for _, value in self.array do
            table.insert(array, tbl1.AvatarProp.jsonDecode(value))
        end

        var1.array = array
    end

    return var1
end

ArrayOfAvatarProp_ArrayOfAvatars.descriptor = {
    name = "ArrayOfAvatarProp_ArrayOfAvatars",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayOfAvatars"
}

tbl1.ArrayOfAvatarProp_ArrayOfAvatars = ArrayOfAvatarProp_ArrayOfAvatars

typeRegistry.default:register(tbl1.ArrayOfAvatarProp_ArrayOfAvatars)

local ArrayOfAvatarProp_ArrayMap = {}
ArrayOfAvatarProp_ArrayMap.__index = ArrayOfAvatarProp_ArrayMap

function ArrayOfAvatarProp_ArrayMap.new(tbl103)
    return (setmetatable({
        kind = if tbl103 == nil or tbl103.kind == nil then nil else tbl103.kind,
        item_hydration_specs = (tbl103 == nil or tbl103.item_hydration_specs == nil) and {} or tbl103.item_hydration_specs,
        field_map = if tbl103 == nil or tbl103.field_map == nil then nil else tbl103.field_map
    }, ArrayOfAvatarProp_ArrayMap))
end

function ArrayOfAvatarProp_ArrayMap:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "binding_path" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
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

function ArrayOfAvatarProp_ArrayMap.decode(buf1: buffer)
    local var1 = ArrayOfAvatarProp_ArrayMap.new()
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
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.item_hydration_specs, hydration_data_spec.HydrationDataSpec.decode(var4))
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.field_map = tbl1.AvatarConfigProp.decode(var4)
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

function ArrayOfAvatarProp_ArrayMap:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "binding_path" then
        result.bindingPath = self.kind.value
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

function ArrayOfAvatarProp_ArrayMap:jsonDecode()
    local var1 = ArrayOfAvatarProp_ArrayMap.new()

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
        var1.field_map = tbl1.AvatarConfigProp.jsonDecode(self.field_map)
    end

    if self.fieldMap ~= nil then
        var1.field_map = tbl1.AvatarConfigProp.jsonDecode(self.fieldMap)
    end

    return var1
end

ArrayOfAvatarProp_ArrayMap.descriptor = {
    name = "ArrayOfAvatarProp_ArrayMap",
    fullName = "roblox.apppageplatform.shared.v1beta1.ArrayMap"
}

tbl1.ArrayOfAvatarProp_ArrayMap = ArrayOfAvatarProp_ArrayMap

typeRegistry.default:register(tbl1.ArrayOfAvatarProp_ArrayMap)

local ScaleBasisProp = {}
ScaleBasisProp.__index = ScaleBasisProp

function ScaleBasisProp.new(tbl104)
    return (setmetatable({ kind = if tbl104 == nil or tbl104.kind == nil then nil else tbl104.kind }, ScaleBasisProp))
end

function ScaleBasisProp:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ScaleBasis.toNumber(self.kind.value))
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

function ScaleBasisProp.decode(buf1: buffer)
    local var1 = ScaleBasisProp.new()
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
                    value = tbl1.ScaleBasis.fromNumber(var4) or var4
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
                    value = tbl1.ScaleBasisProp_ConditionalOptions.decode(var4)
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

function ScaleBasisProp:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ScaleBasis.toNumber(self.kind.value)
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

function ScaleBasisProp.jsonDecode(tbl104)
    local var1 = ScaleBasisProp.new()

    if tbl104.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(tbl104.literal) == "number" then tbl1.ScaleBasis.fromNumber(tbl104.literal) or tbl104.literal else tbl1.ScaleBasis.fromName(tbl104.literal) or tbl104.literal
        }
    end

    if tbl104.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl104.binding_path
        }
    end
    if tbl104.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl104.bindingPath
        }
    end
    if tbl104.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.ScaleBasisProp_ConditionalOptions.jsonDecode(tbl104.conditional)
        }
    end

    return var1
end

ScaleBasisProp.descriptor = {
    name = "ScaleBasisProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.ScaleBasisProp"
}

tbl1.ScaleBasisProp = ScaleBasisProp

typeRegistry.default:register(tbl1.ScaleBasisProp)

local ScaleBasisProp_ConditionalOption = {}
ScaleBasisProp_ConditionalOption.__index = ScaleBasisProp_ConditionalOption

function ScaleBasisProp_ConditionalOption.new(tbl105)
    return (setmetatable({
        condition = if tbl105 == nil or tbl105.condition == nil then nil else tbl105.condition,
        kind = if tbl105 == nil or tbl105.kind == nil then nil else tbl105.kind
    }, ScaleBasisProp_ConditionalOption))
end

function ScaleBasisProp_ConditionalOption:encode(): buffer
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
            buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.ScaleBasis.toNumber(self.kind.value))
        elseif self.kind.type == "binding_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ScaleBasisProp_ConditionalOption.decode(buf1: buffer)
    local var1 = ScaleBasisProp_ConditionalOption.new()
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
                    value = tbl1.ScaleBasis.fromNumber(var4) or var4
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

function ScaleBasisProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = if typeof(self.kind.value) == "number" then self.kind.value else tbl1.ScaleBasis.toNumber(self.kind.value)
            return result
        end

        if self.kind.type == "binding_path" then
            result.bindingPath = self.kind.value
        end
    end

    return result
end

function ScaleBasisProp_ConditionalOption:jsonDecode()
    local var1 = ScaleBasisProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = if typeof(self.literal) == "number" then tbl1.ScaleBasis.fromNumber(self.literal) or self.literal else tbl1.ScaleBasis.fromName(self.literal) or self.literal
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

ScaleBasisProp_ConditionalOption.descriptor = {
    name = "ScaleBasisProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.ScaleBasisProp_ConditionalOption = ScaleBasisProp_ConditionalOption

typeRegistry.default:register(tbl1.ScaleBasisProp_ConditionalOption)

local ScaleBasisProp_ConditionalOptions = {}
ScaleBasisProp_ConditionalOptions.__index = ScaleBasisProp_ConditionalOptions

function ScaleBasisProp_ConditionalOptions.new(tbl106)
    return (setmetatable(
        {
            options = (tbl106 == nil or tbl106.options == nil) and {} or tbl106.options
        },
        ScaleBasisProp_ConditionalOptions
    ))
end

function ScaleBasisProp_ConditionalOptions:encode(): buffer
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

function ScaleBasisProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = ScaleBasisProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.ScaleBasisProp_ConditionalOption.decode(var4))
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

function ScaleBasisProp_ConditionalOptions:jsonEncode()
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

function ScaleBasisProp_ConditionalOptions:jsonDecode()
    local var1 = ScaleBasisProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.ScaleBasisProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

ScaleBasisProp_ConditionalOptions.descriptor = {
    name = "ScaleBasisProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.ScaleBasisProp_ConditionalOptions = ScaleBasisProp_ConditionalOptions

typeRegistry.default:register(tbl1.ScaleBasisProp_ConditionalOptions)

local StringArrayProp = {}
StringArrayProp.__index = StringArrayProp

function StringArrayProp.new(tbl107)
    return (setmetatable({ kind = if tbl107 == nil or tbl107.kind == nil then nil else tbl107.kind }, StringArrayProp))
end

function StringArrayProp:encode(): buffer
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

function StringArrayProp.decode(buf1: buffer)
    local var1 = StringArrayProp.new()
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
                    value = tbl1.StringArrayProp_LiteralValue.decode(var4)
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
                    value = tbl1.StringArrayProp_ConditionalOptions.decode(var4)
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

function StringArrayProp:jsonEncode()
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

function StringArrayProp.jsonDecode(tbl107)
    local var1 = StringArrayProp.new()

    if tbl107.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.StringArrayProp_LiteralValue.jsonDecode(tbl107.literal)
        }
    end
    if tbl107.binding_path ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl107.binding_path
        }
    end
    if tbl107.bindingPath ~= nil then
        var1.kind = {
            type = "binding_path",
            value = tbl107.bindingPath
        }
    end
    if tbl107.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.StringArrayProp_ConditionalOptions.jsonDecode(tbl107.conditional)
        }
    end

    return var1
end

StringArrayProp.descriptor = {
    name = "StringArrayProp",
    fullName = "roblox.apppageplatform.shared.v1beta1.StringArrayProp"
}

tbl1.StringArrayProp = StringArrayProp

typeRegistry.default:register(tbl1.StringArrayProp)

local StringArrayProp_LiteralValue = {}
StringArrayProp_LiteralValue.__index = StringArrayProp_LiteralValue

function StringArrayProp_LiteralValue.new(tbl108)
    return (setmetatable({ items = (tbl108 == nil or tbl108.items == nil) and {} or tbl108.items }, StringArrayProp_LiteralValue))
end

function StringArrayProp_LiteralValue:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.items ~= nil and #self.items > 0 then
        for _, item in self.items do
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, item)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringArrayProp_LiteralValue.decode(buf1: buffer)
    local var1 = StringArrayProp_LiteralValue.new()
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
                table.insert(var1.items, buffer.tostring(var4))
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

function StringArrayProp_LiteralValue:jsonEncode()
    local result = {}

    if self.items ~= nil and #self.items > 0 then
        local items = {}
        for _, item in self.items do
            table.insert(items, item)
        end
        result.items = items
    end

    return result
end

function StringArrayProp_LiteralValue:jsonDecode()
    local var1 = StringArrayProp_LiteralValue.new()

    if self.items ~= nil then
        local items = {}
        for _, item in self.items do
            table.insert(items, item)
        end

        var1.items = items
    end

    return var1
end

StringArrayProp_LiteralValue.descriptor = {
    name = "StringArrayProp_LiteralValue",
    fullName = "roblox.apppageplatform.shared.v1beta1.LiteralValue"
}

tbl1.StringArrayProp_LiteralValue = StringArrayProp_LiteralValue

typeRegistry.default:register(tbl1.StringArrayProp_LiteralValue)

local StringArrayProp_ConditionalOption = {}
StringArrayProp_ConditionalOption.__index = StringArrayProp_ConditionalOption

function StringArrayProp_ConditionalOption.new(tbl109)
    return (setmetatable({
        condition = if tbl109 == nil or tbl109.condition == nil then nil else tbl109.condition,
        kind = if tbl109 == nil or tbl109.kind == nil then nil else tbl109.kind
    }, StringArrayProp_ConditionalOption))
end

function StringArrayProp_ConditionalOption:encode(): buffer
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
        elseif self.kind.type == "conditional" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function StringArrayProp_ConditionalOption.decode(buf1: buffer)
    local var1 = StringArrayProp_ConditionalOption.new()
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
                    value = tbl1.StringArrayProp_LiteralValue.decode(var4)
                }
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "binding_path",
                    value = buffer.tostring(buf)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "conditional",
                    value = tbl1.StringArrayProp_ConditionalOptions.decode(var4)
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

function StringArrayProp_ConditionalOption:jsonEncode()
    local result = {}

    if self.condition ~= nil then
        result.condition = self.condition:jsonEncode()
    end

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

function StringArrayProp_ConditionalOption:jsonDecode()
    local var1 = StringArrayProp_ConditionalOption.new()

    if self.condition ~= nil then
        var1.condition = prop_condition.PropCondition.jsonDecode(self.condition)
    end

    if self.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.StringArrayProp_LiteralValue.jsonDecode(self.literal)
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
    if self.conditional ~= nil then
        var1.kind = {
            type = "conditional",
            value = tbl1.StringArrayProp_ConditionalOptions.jsonDecode(self.conditional)
        }
    end

    return var1
end

StringArrayProp_ConditionalOption.descriptor = {
    name = "StringArrayProp_ConditionalOption",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOption"
}

tbl1.StringArrayProp_ConditionalOption = StringArrayProp_ConditionalOption

typeRegistry.default:register(tbl1.StringArrayProp_ConditionalOption)

local StringArrayProp_ConditionalOptions = {}
StringArrayProp_ConditionalOptions.__index = StringArrayProp_ConditionalOptions

function StringArrayProp_ConditionalOptions.new(tbl110)
    return (setmetatable(
        {
            options = (tbl110 == nil or tbl110.options == nil) and {} or tbl110.options
        },
        StringArrayProp_ConditionalOptions
    ))
end

function StringArrayProp_ConditionalOptions:encode(): buffer
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

function StringArrayProp_ConditionalOptions.decode(buf1: buffer)
    local var1 = StringArrayProp_ConditionalOptions.new()
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
                table.insert(var1.options, tbl1.StringArrayProp_ConditionalOption.decode(var4))
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

function StringArrayProp_ConditionalOptions:jsonEncode()
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

function StringArrayProp_ConditionalOptions:jsonDecode()
    local var1 = StringArrayProp_ConditionalOptions.new()

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.StringArrayProp_ConditionalOption.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

StringArrayProp_ConditionalOptions.descriptor = {
    name = "StringArrayProp_ConditionalOptions",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConditionalOptions"
}

tbl1.StringArrayProp_ConditionalOptions = StringArrayProp_ConditionalOptions

typeRegistry.default:register(tbl1.StringArrayProp_ConditionalOptions)

tbl1.ScaleBasis = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "SCALE_BASIS_INVALID" elseif num1 == 1 then "SCALE_BASIS_PARENT" elseif num1 == 2 then "SCALE_BASIS_VIEWPORT" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "SCALE_BASIS_INVALID" then 0 elseif arg1 == "SCALE_BASIS_PARENT" then 1 elseif arg1 == "SCALE_BASIS_VIEWPORT" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "SCALE_BASIS_INVALID" then "SCALE_BASIS_INVALID" elseif str1 == "SCALE_BASIS_PARENT" then "SCALE_BASIS_PARENT" elseif str1 == "SCALE_BASIS_VIEWPORT" then "SCALE_BASIS_VIEWPORT" else nil
    end
}

return {
    TranslationRef = tbl1.TranslationRef,
    StringFormat = tbl1.StringFormat,
    StringFormat_FormatArg = tbl1.StringFormat_FormatArg,
    StringFormat_FormatArg_Formatter = tbl1.StringFormat_FormatArg_Formatter,
    StringFormat_FormatArg_Formatter_DateConfig = tbl1.StringFormat_FormatArg_Formatter_DateConfig,
    StringFormat_FormatArg_Formatter_Type = tbl1.StringFormat_FormatArg_Formatter_Type,
    StringProp = tbl1.StringProp,
    StringProp_ConditionalOption = tbl1.StringProp_ConditionalOption,
    StringProp_ConditionalOptions = tbl1.StringProp_ConditionalOptions,
    FloatProp = tbl1.FloatProp,
    FloatProp_ConditionalOption = tbl1.FloatProp_ConditionalOption,
    FloatProp_ConditionalOptions = tbl1.FloatProp_ConditionalOptions,
    ArrayOfFloatProp = tbl1.ArrayOfFloatProp,
    ArrayOfFloatProp_ConditionalOption = tbl1.ArrayOfFloatProp_ConditionalOption,
    ArrayOfFloatProp_ConditionalOptions = tbl1.ArrayOfFloatProp_ConditionalOptions,
    ArrayOfFloatProp_ArrayOfFloats = tbl1.ArrayOfFloatProp_ArrayOfFloats,
    DoubleProp = tbl1.DoubleProp,
    DoubleProp_ConditionalOption = tbl1.DoubleProp_ConditionalOption,
    DoubleProp_ConditionalOptions = tbl1.DoubleProp_ConditionalOptions,
    Int32Prop = tbl1.Int32Prop,
    Int32Prop_ConditionalOption = tbl1.Int32Prop_ConditionalOption,
    Int32Prop_ConditionalOptions = tbl1.Int32Prop_ConditionalOptions,
    Int64Prop = tbl1.Int64Prop,
    Int64Prop_ConditionalOption = tbl1.Int64Prop_ConditionalOption,
    Int64Prop_ConditionalOptions = tbl1.Int64Prop_ConditionalOptions,
    BoolProp = tbl1.BoolProp,
    BoolProp_ConditionalOption = tbl1.BoolProp_ConditionalOption,
    BoolProp_ConditionalOptions = tbl1.BoolProp_ConditionalOptions,
    StructProp = tbl1.StructProp,
    StructProp_ConditionalOption = tbl1.StructProp_ConditionalOption,
    StructProp_ConditionalOptions = tbl1.StructProp_ConditionalOptions,
    ImageStringProp = tbl1.ImageStringProp,
    ImageStringProp_ConditionalOption = tbl1.ImageStringProp_ConditionalOption,
    ImageStringProp_ConditionalOptions = tbl1.ImageStringProp_ConditionalOptions,
    ImageSetProp = tbl1.ImageSetProp,
    ImageSetProp_ConditionalOption = tbl1.ImageSetProp_ConditionalOption,
    ImageSetProp_ConditionalOptions = tbl1.ImageSetProp_ConditionalOptions,
    ColorProp = tbl1.ColorProp,
    ColorProp_ConditionalOption = tbl1.ColorProp_ConditionalOption,
    ColorProp_ConditionalOptions = tbl1.ColorProp_ConditionalOptions,
    TypographyProp = tbl1.TypographyProp,
    TypographyProp_ConditionalOption = tbl1.TypographyProp_ConditionalOption,
    TypographyProp_ConditionalOptions = tbl1.TypographyProp_ConditionalOptions,
    TypographyFontProp = tbl1.TypographyFontProp,
    TypographyFontProp_ConditionalOption = tbl1.TypographyFontProp_ConditionalOption,
    TypographyFontProp_ConditionalOptions = tbl1.TypographyFontProp_ConditionalOptions,
    ColorStyleProp = tbl1.ColorStyleProp,
    ColorStyleProp_ConditionalOption = tbl1.ColorStyleProp_ConditionalOption,
    ColorStyleProp_ConditionalOptions = tbl1.ColorStyleProp_ConditionalOptions,
    FillBehaviorProp = tbl1.FillBehaviorProp,
    FillBehaviorProp_ConditionalOption = tbl1.FillBehaviorProp_ConditionalOption,
    FillBehaviorProp_ConditionalOptions = tbl1.FillBehaviorProp_ConditionalOptions,
    InputSizeProp = tbl1.InputSizeProp,
    InputSizeProp_ConditionalOption = tbl1.InputSizeProp_ConditionalOption,
    InputSizeProp_ConditionalOptions = tbl1.InputSizeProp_ConditionalOptions,
    UDimProp = tbl1.UDimProp,
    UDimProp_ConditionalOption = tbl1.UDimProp_ConditionalOption,
    UDimProp_ConditionalOptions = tbl1.UDimProp_ConditionalOptions,
    UDim2Prop = tbl1.UDim2Prop,
    UDim2Prop_ConditionalOption = tbl1.UDim2Prop_ConditionalOption,
    UDim2Prop_ConditionalOptions = tbl1.UDim2Prop_ConditionalOptions,
    Vector2Prop = tbl1.Vector2Prop,
    Vector2Prop_ConditionalOption = tbl1.Vector2Prop_ConditionalOption,
    Vector2Prop_ConditionalOptions = tbl1.Vector2Prop_ConditionalOptions,
    IconProp = tbl1.IconProp,
    IconProp_ConditionalOption = tbl1.IconProp_ConditionalOption,
    IconProp_ConditionalOptions = tbl1.IconProp_ConditionalOptions,
    FoundationIconConfigProp = tbl1.FoundationIconConfigProp,
    FoundationIconConfigProp_ConditionalOption = tbl1.FoundationIconConfigProp_ConditionalOption,
    FoundationIconConfigProp_ConditionalOptions = tbl1.FoundationIconConfigProp_ConditionalOptions,
    FoundationIconConfigProp_FoundationIconConfig = tbl1.FoundationIconConfigProp_FoundationIconConfig,
    IconSizeProp = tbl1.IconSizeProp,
    GradientProp = tbl1.GradientProp,
    GradientProp_ConditionalOption = tbl1.GradientProp_ConditionalOption,
    GradientProp_ConditionalOptions = tbl1.GradientProp_ConditionalOptions,
    GradientProp_GradientData = tbl1.GradientProp_GradientData,
    ArrayOfStructProp = tbl1.ArrayOfStructProp,
    ArrayOfStructProp_ConditionalOption = tbl1.ArrayOfStructProp_ConditionalOption,
    ArrayOfStructProp_ConditionalOptions = tbl1.ArrayOfStructProp_ConditionalOptions,
    ArrayOfStructProp_ArrayOfStructs = tbl1.ArrayOfStructProp_ArrayOfStructs,
    PymkItemData = tbl1.PymkItemData,
    ArrayOfPymkItemDataProp = tbl1.ArrayOfPymkItemDataProp,
    ArrayOfPymkItemDataProp_ConditionalOption = tbl1.ArrayOfPymkItemDataProp_ConditionalOption,
    ArrayOfPymkItemDataProp_ConditionalOptions = tbl1.ArrayOfPymkItemDataProp_ConditionalOptions,
    ArrayOfPymkItemDataProp_PymkItems = tbl1.ArrayOfPymkItemDataProp_PymkItems,
    UiScaledFloatProp = tbl1.UiScaledFloatProp,
    UiScaledFloatProp_ConditionalOption = tbl1.UiScaledFloatProp_ConditionalOption,
    UiScaledFloatProp_ConditionalOptions = tbl1.UiScaledFloatProp_ConditionalOptions,
    UiScaledUDimProp = tbl1.UiScaledUDimProp,
    UiScaledUDimProp_ConditionalOption = tbl1.UiScaledUDimProp_ConditionalOption,
    UiScaledUDimProp_ConditionalOptions = tbl1.UiScaledUDimProp_ConditionalOptions,
    UiScaledUDim2Prop = tbl1.UiScaledUDim2Prop,
    UiScaledUDim2Prop_ConditionalOption = tbl1.UiScaledUDim2Prop_ConditionalOption,
    UiScaledUDim2Prop_ConditionalOptions = tbl1.UiScaledUDim2Prop_ConditionalOptions,
    AvatarConfigProp = tbl1.AvatarConfigProp,
    AvatarProp = tbl1.AvatarProp,
    ArrayOfAvatarProp = tbl1.ArrayOfAvatarProp,
    ArrayOfAvatarProp_ConditionalOption = tbl1.ArrayOfAvatarProp_ConditionalOption,
    ArrayOfAvatarProp_ConditionalOptions = tbl1.ArrayOfAvatarProp_ConditionalOptions,
    ArrayOfAvatarProp_ArrayOfAvatars = tbl1.ArrayOfAvatarProp_ArrayOfAvatars,
    ArrayOfAvatarProp_ArrayMap = tbl1.ArrayOfAvatarProp_ArrayMap,
    ScaleBasisProp = tbl1.ScaleBasisProp,
    ScaleBasisProp_ConditionalOption = tbl1.ScaleBasisProp_ConditionalOption,
    ScaleBasisProp_ConditionalOptions = tbl1.ScaleBasisProp_ConditionalOptions,
    StringArrayProp = tbl1.StringArrayProp,
    StringArrayProp_LiteralValue = tbl1.StringArrayProp_LiteralValue,
    StringArrayProp_ConditionalOption = tbl1.StringArrayProp_ConditionalOption,
    StringArrayProp_ConditionalOptions = tbl1.StringArrayProp_ConditionalOptions,
    ScaleBasis = tbl1.ScaleBasis
}

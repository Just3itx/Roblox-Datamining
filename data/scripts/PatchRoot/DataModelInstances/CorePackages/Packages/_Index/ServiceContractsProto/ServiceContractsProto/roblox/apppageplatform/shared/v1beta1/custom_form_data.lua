-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local CustomFormData = {}
CustomFormData.__index = CustomFormData

function CustomFormData.new(tbl3)
    return (setmetatable({
        form_definition = if tbl3 == nil or tbl3.form_definition == nil then nil else tbl3.form_definition,
        viewer_response = if tbl3 == nil or tbl3.viewer_response == nil then nil else tbl3.viewer_response,
        results = if tbl3 == nil or tbl3.results == nil then nil else tbl3.results,
        is_editable = if tbl3 == nil or tbl3.is_editable == nil then nil else tbl3.is_editable,
        disabled_message = if tbl3 == nil or tbl3.disabled_message == nil then nil else tbl3.disabled_message
    }, CustomFormData))
end

function CustomFormData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.form_definition ~= nil then
        local buf = self.form_definition:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.viewer_response ~= nil then
        local buf = self.viewer_response:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.results ~= nil then
        local buf = self.results:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.is_editable ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_editable then 1 else 0)
    end

    if self.disabled_message ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.disabled_message)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormData.decode(buf1: buffer)
    local var1 = CustomFormData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_editable = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.form_definition = tbl1.CustomFormDefinitionData.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.viewer_response = tbl1.CustomFormResponseData.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.results = tbl1.CustomFormResultsData.decode(var4)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.disabled_message = buffer.tostring(buf)
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

function CustomFormData:jsonEncode()
    local result = {}

    if self.form_definition ~= nil then
        result.formDefinition = self.form_definition:jsonEncode()
    end

    if self.viewer_response ~= nil then
        result.viewerResponse = self.viewer_response:jsonEncode()
    end

    if self.results ~= nil then
        result.results = self.results:jsonEncode()
    end

    if self.is_editable ~= nil then
        result.isEditable = self.is_editable
    end

    if self.disabled_message ~= nil then
        result.disabledMessage = self.disabled_message
    end

    return result
end

function CustomFormData:jsonDecode()
    local var1 = CustomFormData.new()

    if self.form_definition ~= nil then
        var1.form_definition = tbl1.CustomFormDefinitionData.jsonDecode(self.form_definition)
    end

    if self.formDefinition ~= nil then
        var1.form_definition = tbl1.CustomFormDefinitionData.jsonDecode(self.formDefinition)
    end

    if self.viewer_response ~= nil then
        var1.viewer_response = tbl1.CustomFormResponseData.jsonDecode(self.viewer_response)
    end

    if self.viewerResponse ~= nil then
        var1.viewer_response = tbl1.CustomFormResponseData.jsonDecode(self.viewerResponse)
    end

    if self.results ~= nil then
        var1.results = tbl1.CustomFormResultsData.jsonDecode(self.results)
    end

    if self.is_editable ~= nil then
        var1.is_editable = self.is_editable
    end

    if self.isEditable ~= nil then
        var1.is_editable = self.isEditable
    end

    if self.disabled_message ~= nil then
        var1.disabled_message = self.disabled_message
    end

    if self.disabledMessage ~= nil then
        var1.disabled_message = self.disabledMessage
    end

    return var1
end

CustomFormData.descriptor = {
    name = "CustomFormData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormData"
}

tbl1.CustomFormData = CustomFormData

typeRegistry.default:register(tbl1.CustomFormData)

local CustomFormDefinitionData = {}
CustomFormDefinitionData.__index = CustomFormDefinitionData

function CustomFormDefinitionData.new(tbl4)
    return (setmetatable({
        form_id = if tbl4 == nil or tbl4.form_id == nil then "" else tbl4.form_id,
        title = if tbl4 == nil or tbl4.title == nil then nil else tbl4.title,
        description = if tbl4 == nil or tbl4.description == nil then nil else tbl4.description,
        sections = (tbl4 == nil or tbl4.sections == nil) and {} or tbl4.sections
    }, CustomFormDefinitionData))
end

function CustomFormDefinitionData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.form_id ~= nil and self.form_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.form_id)
    end

    if self.title ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    if self.description ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    if self.sections ~= nil and #self.sections > 0 then
        for _, section in self.sections do
            local buf = section:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormDefinitionData.decode(buf1: buffer)
    local var1 = CustomFormDefinitionData.new()
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
                var1.form_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.description = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.sections, tbl1.CustomFormSectionData.decode(var4))
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

function CustomFormDefinitionData:jsonEncode()
    local result = {}

    if self.form_id ~= nil and self.form_id ~= "" then
        result.formId = self.form_id
    end

    if self.title ~= nil then
        result.title = self.title
    end

    if self.description ~= nil then
        result.description = self.description
    end

    if self.sections ~= nil and #self.sections > 0 then
        local sections = {}
        for _, section in self.sections do
            table.insert(sections, section:jsonEncode())
        end
        result.sections = sections
    end

    return result
end

function CustomFormDefinitionData:jsonDecode()
    local var1 = CustomFormDefinitionData.new()

    if self.form_id ~= nil then
        var1.form_id = self.form_id
    end

    if self.formId ~= nil then
        var1.form_id = self.formId
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    if self.sections ~= nil then
        local sections = {}
        for _, section in self.sections do
            table.insert(sections, tbl1.CustomFormSectionData.jsonDecode(section))
        end

        var1.sections = sections
    end

    return var1
end

CustomFormDefinitionData.descriptor = {
    name = "CustomFormDefinitionData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormDefinitionData"
}

tbl1.CustomFormDefinitionData = CustomFormDefinitionData

typeRegistry.default:register(tbl1.CustomFormDefinitionData)

local CustomFormSectionData = {}
CustomFormSectionData.__index = CustomFormSectionData

function CustomFormSectionData.new(tbl5)
    return (setmetatable({
        id = if tbl5 == nil or tbl5.id == nil then "" else tbl5.id,
        header = if tbl5 == nil or tbl5.header == nil then nil else tbl5.header,
        fields = (tbl5 == nil or tbl5.fields == nil) and {} or tbl5.fields
    }, CustomFormSectionData))
end

function CustomFormSectionData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.header ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.header)
    end

    if self.fields ~= nil and #self.fields > 0 then
        for _, field in self.fields do
            local buf = field:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormSectionData.decode(buf1: buffer)
    local var1 = CustomFormSectionData.new()
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
                var1.id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.header = buffer.tostring(buf)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.fields, tbl1.CustomFormFieldData.decode(var4))
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

function CustomFormSectionData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.header ~= nil then
        result.header = self.header
    end

    if self.fields ~= nil and #self.fields > 0 then
        local fields = {}
        for _, field in self.fields do
            table.insert(fields, field:jsonEncode())
        end
        result.fields = fields
    end

    return result
end

function CustomFormSectionData:jsonDecode()
    local var1 = CustomFormSectionData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.header ~= nil then
        var1.header = self.header
    end

    if self.fields ~= nil then
        local fields = {}
        for _, field in self.fields do
            table.insert(fields, tbl1.CustomFormFieldData.jsonDecode(field))
        end

        var1.fields = fields
    end

    return var1
end

CustomFormSectionData.descriptor = {
    name = "CustomFormSectionData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormSectionData"
}

tbl1.CustomFormSectionData = CustomFormSectionData

typeRegistry.default:register(tbl1.CustomFormSectionData)

local CustomFormFieldData = {}
CustomFormFieldData.__index = CustomFormFieldData

function CustomFormFieldData.new(tbl6)
    local tbl7 = {
        field_id = if tbl6 == nil or tbl6.field_id == nil then "" else tbl6.field_id,
        field_type = if tbl6 == nil or tbl6.field_type == nil then assert(tbl1.CustomFormFieldType.fromNumber(0), "Enum has no 0 default") else tbl6.field_type,
        label = if tbl6 == nil or tbl6.label == nil then nil else tbl6.label,
        options = (tbl6 == nil or tbl6.options == nil) and {} or tbl6.options
    }
    return (setmetatable(tbl7, CustomFormFieldData))
end

function CustomFormFieldData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field_id ~= nil and self.field_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field_id)
    end

    if self.field_type ~= nil
        and (self.field_type ~= nil and self.field_type ~= 0 or self.field_type ~= tbl1.CustomFormFieldType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)

        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.CustomFormFieldType.toNumber(self.field_type))
    end

    if self.label ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.label)
    end

    if self.options ~= nil and #self.options > 0 then
        for _, option in self.options do
            local buf = option:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormFieldData.decode(buf1: buffer)
    local var1 = CustomFormFieldData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.field_type = tbl1.CustomFormFieldType.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.field_id = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.label = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.options, tbl1.CustomFormOptionData.decode(var4))
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

function CustomFormFieldData:jsonEncode()
    local result = {}

    if self.field_id ~= nil and self.field_id ~= "" then
        result.fieldId = self.field_id
    end

    if self.field_type ~= nil
        and (self.field_type ~= nil and self.field_type ~= 0 or self.field_type ~= tbl1.CustomFormFieldType.fromNumber(0))
    then
        result.fieldType = if typeof(self.field_type) == "number" then self.field_type else tbl1.CustomFormFieldType.toNumber(self.field_type)
    end

    if self.label ~= nil then
        result.label = self.label
    end

    if self.options ~= nil and #self.options > 0 then
        local options = {}
        for _, option in self.options do
            table.insert(options, option:jsonEncode())
        end
        result.options = options
    end

    return result
end

function CustomFormFieldData:jsonDecode()
    local var1 = CustomFormFieldData.new()

    if self.field_id ~= nil then
        var1.field_id = self.field_id
    end

    if self.fieldId ~= nil then
        var1.field_id = self.fieldId
    end

    if self.field_type ~= nil then
        var1.field_type = if typeof(self.field_type) == "number" then tbl1.CustomFormFieldType.fromNumber(self.field_type) or self.field_type else tbl1.CustomFormFieldType.fromName(self.field_type) or self.field_type
    end

    if self.fieldType ~= nil then
        var1.field_type = if typeof(self.fieldType) == "number" then tbl1.CustomFormFieldType.fromNumber(self.fieldType) or self.fieldType else tbl1.CustomFormFieldType.fromName(self.fieldType) or self.fieldType
    end

    if self.label ~= nil then
        var1.label = self.label
    end

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.CustomFormOptionData.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

CustomFormFieldData.descriptor = {
    name = "CustomFormFieldData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormFieldData"
}

tbl1.CustomFormFieldData = CustomFormFieldData

typeRegistry.default:register(tbl1.CustomFormFieldData)

local CustomFormOptionData = {}
CustomFormOptionData.__index = CustomFormOptionData

function CustomFormOptionData.new(tbl7)
    return (setmetatable({
        option_id = if tbl7 == nil or tbl7.option_id == nil then "" else tbl7.option_id,
        label = if tbl7 == nil or tbl7.label == nil then "" else tbl7.label
    }, CustomFormOptionData))
end

function CustomFormOptionData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.option_id ~= nil and self.option_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.option_id)
    end

    if self.label ~= nil and self.label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.label)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormOptionData.decode(buf1: buffer)
    local var1 = CustomFormOptionData.new()
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
                var1.option_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.label = buffer.tostring(buf)
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

function CustomFormOptionData:jsonEncode()
    local result = {}

    if self.option_id ~= nil and self.option_id ~= "" then
        result.optionId = self.option_id
    end

    if self.label ~= nil and self.label ~= "" then
        result.label = self.label
    end

    return result
end

function CustomFormOptionData:jsonDecode()
    local var1 = CustomFormOptionData.new()

    if self.option_id ~= nil then
        var1.option_id = self.option_id
    end

    if self.optionId ~= nil then
        var1.option_id = self.optionId
    end

    if self.label ~= nil then
        var1.label = self.label
    end

    return var1
end

CustomFormOptionData.descriptor = {
    name = "CustomFormOptionData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormOptionData"
}

tbl1.CustomFormOptionData = CustomFormOptionData

typeRegistry.default:register(tbl1.CustomFormOptionData)

local CustomFormResponseData = {}
CustomFormResponseData.__index = CustomFormResponseData

function CustomFormResponseData.new(tbl8)
    return (setmetatable({ answers = (tbl8 == nil or tbl8.answers == nil) and {} or tbl8.answers }, CustomFormResponseData))
end

function CustomFormResponseData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.answers ~= nil and #self.answers > 0 then
        for _, answer in self.answers do
            local buf = answer:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormResponseData.decode(buf1: buffer)
    local var1 = CustomFormResponseData.new()
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
                table.insert(var1.answers, tbl1.CustomFormAnswerData.decode(var4))
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

function CustomFormResponseData:jsonEncode()
    local result = {}

    if self.answers ~= nil and #self.answers > 0 then
        local answers = {}
        for _, answer in self.answers do
            table.insert(answers, answer:jsonEncode())
        end
        result.answers = answers
    end

    return result
end

function CustomFormResponseData:jsonDecode()
    local var1 = CustomFormResponseData.new()

    if self.answers ~= nil then
        local answers = {}
        for _, answer in self.answers do
            table.insert(answers, tbl1.CustomFormAnswerData.jsonDecode(answer))
        end

        var1.answers = answers
    end

    return var1
end

CustomFormResponseData.descriptor = {
    name = "CustomFormResponseData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormResponseData"
}

tbl1.CustomFormResponseData = CustomFormResponseData

typeRegistry.default:register(tbl1.CustomFormResponseData)

local CustomFormAnswerData = {}
CustomFormAnswerData.__index = CustomFormAnswerData

function CustomFormAnswerData.new(tbl9)
    return (setmetatable({
        field_id = if tbl9 == nil or tbl9.field_id == nil then "" else tbl9.field_id,
        option_ids = (tbl9 == nil or tbl9.option_ids == nil) and {} or tbl9.option_ids
    }, CustomFormAnswerData))
end

function CustomFormAnswerData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field_id ~= nil and self.field_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field_id)
    end

    if self.option_ids ~= nil and #self.option_ids > 0 then
        for _, optionId in self.option_ids do
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, optionId)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormAnswerData.decode(buf1: buffer)
    local var1 = CustomFormAnswerData.new()
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
                var1.field_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.option_ids, buffer.tostring(var4))
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

function CustomFormAnswerData:jsonEncode()
    local result = {}

    if self.field_id ~= nil and self.field_id ~= "" then
        result.fieldId = self.field_id
    end

    if self.option_ids ~= nil and #self.option_ids > 0 then
        local optionIds = {}
        for _, optionId in self.option_ids do
            table.insert(optionIds, optionId)
        end
        result.optionIds = optionIds
    end

    return result
end

function CustomFormAnswerData:jsonDecode()
    local var1 = CustomFormAnswerData.new()

    if self.field_id ~= nil then
        var1.field_id = self.field_id
    end

    if self.fieldId ~= nil then
        var1.field_id = self.fieldId
    end

    if self.option_ids ~= nil then
        local optionIds = {}
        for _, optionId in self.option_ids do
            table.insert(optionIds, optionId)
        end

        var1.option_ids = optionIds
    end

    if self.optionIds ~= nil then
        local optionIds = {}
        for _, optionId in self.optionIds do
            table.insert(optionIds, optionId)
        end

        var1.option_ids = optionIds
    end

    return var1
end

CustomFormAnswerData.descriptor = {
    name = "CustomFormAnswerData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormAnswerData"
}

tbl1.CustomFormAnswerData = CustomFormAnswerData

typeRegistry.default:register(tbl1.CustomFormAnswerData)

local CustomFormResultsData = {}
CustomFormResultsData.__index = CustomFormResultsData

function CustomFormResultsData.new(tbl10)
    return (setmetatable({
        total_responses = if tbl10 == nil or tbl10.total_responses == nil then 0 else tbl10.total_responses,
        field_results = (tbl10 == nil or tbl10.field_results == nil) and {} or tbl10.field_results
    }, CustomFormResultsData))
end

function CustomFormResultsData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.total_responses ~= nil and self.total_responses ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_responses)
    end

    if self.field_results ~= nil and #self.field_results > 0 then
        for _, fieldResult in self.field_results do
            local buf = fieldResult:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormResultsData.decode(buf1: buffer)
    local var1 = CustomFormResultsData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_responses = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.field_results, tbl1.CustomFormFieldResultData.decode(var4))
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

function CustomFormResultsData:jsonEncode()
    local result = {}

    if self.total_responses ~= nil and self.total_responses ~= 0 then
        result.totalResponses = self.total_responses
    end

    if self.field_results ~= nil and #self.field_results > 0 then
        local fieldResults = {}
        for _, fieldResult in self.field_results do
            table.insert(fieldResults, fieldResult:jsonEncode())
        end
        result.fieldResults = fieldResults
    end

    return result
end

function CustomFormResultsData:jsonDecode()
    local var1 = CustomFormResultsData.new()

    if self.total_responses ~= nil then
        var1.total_responses = self.total_responses
    end

    if self.totalResponses ~= nil then
        var1.total_responses = self.totalResponses
    end

    if self.field_results ~= nil then
        local fieldResults = {}
        for _, fieldResult in self.field_results do
            table.insert(fieldResults, tbl1.CustomFormFieldResultData.jsonDecode(fieldResult))
        end

        var1.field_results = fieldResults
    end

    if self.fieldResults ~= nil then
        local fieldResults = {}
        for _, fieldResult in self.fieldResults do
            table.insert(fieldResults, tbl1.CustomFormFieldResultData.jsonDecode(fieldResult))
        end

        var1.field_results = fieldResults
    end

    return var1
end

CustomFormResultsData.descriptor = {
    name = "CustomFormResultsData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormResultsData"
}

tbl1.CustomFormResultsData = CustomFormResultsData

typeRegistry.default:register(tbl1.CustomFormResultsData)

local CustomFormFieldResultData = {}
CustomFormFieldResultData.__index = CustomFormFieldResultData

function CustomFormFieldResultData.new(tbl11)
    return (setmetatable({
        field_id = if tbl11 == nil or tbl11.field_id == nil then "" else tbl11.field_id,
        option_results = (tbl11 == nil or tbl11.option_results == nil) and {} or tbl11.option_results
    }, CustomFormFieldResultData))
end

function CustomFormFieldResultData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.field_id ~= nil and self.field_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.field_id)
    end

    if self.option_results ~= nil and #self.option_results > 0 then
        for _, optionResult in self.option_results do
            local buf = optionResult:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormFieldResultData.decode(buf1: buffer)
    local var1 = CustomFormFieldResultData.new()
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
                var1.field_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.option_results, tbl1.CustomFormOptionResultData.decode(var4))
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

function CustomFormFieldResultData:jsonEncode()
    local result = {}

    if self.field_id ~= nil and self.field_id ~= "" then
        result.fieldId = self.field_id
    end

    if self.option_results ~= nil and #self.option_results > 0 then
        local optionResults = {}
        for _, optionResult in self.option_results do
            table.insert(optionResults, optionResult:jsonEncode())
        end
        result.optionResults = optionResults
    end

    return result
end

function CustomFormFieldResultData:jsonDecode()
    local var1 = CustomFormFieldResultData.new()

    if self.field_id ~= nil then
        var1.field_id = self.field_id
    end

    if self.fieldId ~= nil then
        var1.field_id = self.fieldId
    end

    if self.option_results ~= nil then
        local optionResults = {}
        for _, optionResult in self.option_results do
            table.insert(optionResults, tbl1.CustomFormOptionResultData.jsonDecode(optionResult))
        end

        var1.option_results = optionResults
    end

    if self.optionResults ~= nil then
        local optionResults = {}
        for _, optionResult in self.optionResults do
            table.insert(optionResults, tbl1.CustomFormOptionResultData.jsonDecode(optionResult))
        end

        var1.option_results = optionResults
    end

    return var1
end

CustomFormFieldResultData.descriptor = {
    name = "CustomFormFieldResultData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormFieldResultData"
}

tbl1.CustomFormFieldResultData = CustomFormFieldResultData

typeRegistry.default:register(tbl1.CustomFormFieldResultData)

local CustomFormOptionResultData = {}
CustomFormOptionResultData.__index = CustomFormOptionResultData

function CustomFormOptionResultData.new(tbl12)
    return (setmetatable({
        option_id = if tbl12 == nil or tbl12.option_id == nil then "" else tbl12.option_id,
        vote_count = if tbl12 == nil or tbl12.vote_count == nil then 0 else tbl12.vote_count,
        percentage = if tbl12 == nil or tbl12.percentage == nil then 0 else tbl12.percentage
    }, CustomFormOptionResultData))
end

function CustomFormOptionResultData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.option_id ~= nil and self.option_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.option_id)
    end

    if self.vote_count ~= nil and self.vote_count ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.vote_count)
    end

    if self.percentage ~= nil and self.percentage ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.percentage)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomFormOptionResultData.decode(buf1: buffer)
    local var1 = CustomFormOptionResultData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.vote_count = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.percentage = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.option_id = buffer.tostring(buf)
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

function CustomFormOptionResultData:jsonEncode()
    local result = {}

    if self.option_id ~= nil and self.option_id ~= "" then
        result.optionId = self.option_id
    end

    if self.vote_count ~= nil and self.vote_count ~= 0 then
        result.voteCount = self.vote_count
    end

    if self.percentage ~= nil and self.percentage ~= 0 then
        result.percentage = self.percentage
    end

    return result
end

function CustomFormOptionResultData:jsonDecode()
    local var1 = CustomFormOptionResultData.new()

    if self.option_id ~= nil then
        var1.option_id = self.option_id
    end

    if self.optionId ~= nil then
        var1.option_id = self.optionId
    end

    if self.vote_count ~= nil then
        var1.vote_count = self.vote_count
    end

    if self.voteCount ~= nil then
        var1.vote_count = self.voteCount
    end

    if self.percentage ~= nil then
        var1.percentage = self.percentage
    end

    return var1
end

CustomFormOptionResultData.descriptor = {
    name = "CustomFormOptionResultData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CustomFormOptionResultData"
}

tbl1.CustomFormOptionResultData = CustomFormOptionResultData

typeRegistry.default:register(tbl1.CustomFormOptionResultData)

tbl1.CustomFormFieldType = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "CUSTOM_FORM_FIELD_TYPE_INVALID" elseif num1 == 1 then "CUSTOM_FORM_FIELD_TYPE_RADIO" elseif num1 == 2 then "CUSTOM_FORM_FIELD_TYPE_CHECKBOX" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "CUSTOM_FORM_FIELD_TYPE_INVALID" then 0 elseif arg1 == "CUSTOM_FORM_FIELD_TYPE_RADIO" then 1 elseif arg1 == "CUSTOM_FORM_FIELD_TYPE_CHECKBOX" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "CUSTOM_FORM_FIELD_TYPE_INVALID" then "CUSTOM_FORM_FIELD_TYPE_INVALID" elseif str1 == "CUSTOM_FORM_FIELD_TYPE_RADIO" then "CUSTOM_FORM_FIELD_TYPE_RADIO" elseif str1 == "CUSTOM_FORM_FIELD_TYPE_CHECKBOX" then "CUSTOM_FORM_FIELD_TYPE_CHECKBOX" else nil
    end
}

return {
    CustomFormData = tbl1.CustomFormData,
    CustomFormDefinitionData = tbl1.CustomFormDefinitionData,
    CustomFormSectionData = tbl1.CustomFormSectionData,
    CustomFormFieldData = tbl1.CustomFormFieldData,
    CustomFormOptionData = tbl1.CustomFormOptionData,
    CustomFormResponseData = tbl1.CustomFormResponseData,
    CustomFormAnswerData = tbl1.CustomFormAnswerData,
    CustomFormResultsData = tbl1.CustomFormResultsData,
    CustomFormFieldResultData = tbl1.CustomFormFieldResultData,
    CustomFormOptionResultData = tbl1.CustomFormOptionResultData,
    CustomFormFieldType = tbl1.CustomFormFieldType
}

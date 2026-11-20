-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local client_capabilities = require(script.Parent.Parent.Parent.shared.v1beta1.client_capabilities)

local hydration_content = require(script.Parent.Parent.Parent.shared.v1beta1.hydration_content)

local page_entry_content = require(script.Parent.Parent.Parent.shared.v1beta1.page_entry_content)

local template_entry = require(script.Parent.Parent.Parent.shared.v1beta1.template_entry)

local CustomPrompt = {}
CustomPrompt.__index = CustomPrompt

function CustomPrompt.new(tbl3)
    return (setmetatable({
        parameters = (tbl3 == nil or tbl3.parameters == nil) and {} or tbl3.parameters,
        translations = (tbl3 == nil or tbl3.translations == nil) and {} or tbl3.translations
    }, CustomPrompt))
end

function CustomPrompt:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.parameters ~= nil and next(self.parameters) ~= nil then
        for k, parameter in self.parameters do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, parameter)
            local var9, var10 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.translations ~= nil and next(self.translations) ~= nil then
        for k, translation in self.translations do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, translation)
            local var9, var10 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomPrompt.decode(buf1: buffer)
    local var1 = CustomPrompt.new()
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

                local var5 = tbl1.CustomPrompt_ParametersEntry.decode(var4)

                var1.parameters[var5.key or ""] = var5.value or ""
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.CustomPrompt_TranslationsEntry.decode(var4)

                var1.translations[var5.key or ""] = var5.value or ""
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

function CustomPrompt:jsonEncode()
    local result = {}

    if self.parameters ~= nil and next(self.parameters) ~= nil then
        local parameters = ({})
        for k, parameter in self.parameters do
            parameters[k] = parameter
        end
        result.parameters = parameters
    end

    if self.translations ~= nil and next(self.translations) ~= nil then
        local translations = ({})
        for k, translation in self.translations do
            translations[k] = translation
        end
        result.translations = translations
    end

    return result
end

function CustomPrompt:jsonDecode()
    local var1 = CustomPrompt.new()

    if self.parameters ~= nil then
        local parameters = ({})
        for k, parameter in self.parameters do
            parameters[k] = parameter
        end

        var1.parameters = parameters
    end

    if self.translations ~= nil then
        local translations = ({})
        for k, translation in self.translations do
            translations[k] = translation
        end

        var1.translations = translations
    end

    return var1
end

CustomPrompt.descriptor = {
    name = "CustomPrompt",
    fullName = "roblox.apppageplatform.prompts.v1beta1.CustomPrompt"
}

tbl1.CustomPrompt = CustomPrompt

typeRegistry.default:register(tbl1.CustomPrompt)

local CustomPrompt_ParametersEntry = {}
CustomPrompt_ParametersEntry.__index = CustomPrompt_ParametersEntry

function CustomPrompt_ParametersEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = if tbl4 == nil or tbl4.value == nil then "" else tbl4.value
    }, CustomPrompt_ParametersEntry))
end

function CustomPrompt_ParametersEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomPrompt_ParametersEntry.decode(buf1: buffer)
    local var1 = CustomPrompt_ParametersEntry.new()
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.value = buffer.tostring(buf)
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

function CustomPrompt_ParametersEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function CustomPrompt_ParametersEntry:jsonDecode()
    local var1 = CustomPrompt_ParametersEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

CustomPrompt_ParametersEntry.descriptor = {
    name = "CustomPrompt_ParametersEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.ParametersEntry"
}

tbl1.CustomPrompt_ParametersEntry = CustomPrompt_ParametersEntry

typeRegistry.default:register(tbl1.CustomPrompt_ParametersEntry)

local CustomPrompt_TranslationsEntry = {}
CustomPrompt_TranslationsEntry.__index = CustomPrompt_TranslationsEntry

function CustomPrompt_TranslationsEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then "" else tbl5.value
    }, CustomPrompt_TranslationsEntry))
end

function CustomPrompt_TranslationsEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CustomPrompt_TranslationsEntry.decode(buf1: buffer)
    local var1 = CustomPrompt_TranslationsEntry.new()
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.value = buffer.tostring(buf)
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

function CustomPrompt_TranslationsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function CustomPrompt_TranslationsEntry:jsonDecode()
    local var1 = CustomPrompt_TranslationsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

CustomPrompt_TranslationsEntry.descriptor = {
    name = "CustomPrompt_TranslationsEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.TranslationsEntry"
}

tbl1.CustomPrompt_TranslationsEntry = CustomPrompt_TranslationsEntry

typeRegistry.default:register(tbl1.CustomPrompt_TranslationsEntry)

local GetEligiblePromptsRequest = {}
GetEligiblePromptsRequest.__index = GetEligiblePromptsRequest

function GetEligiblePromptsRequest.new(tbl6)
    return (setmetatable({
        entry_points = (tbl6 == nil or tbl6.entry_points == nil) and {} or tbl6.entry_points,
        deeplink_detected = not (tbl6 == nil or tbl6.deeplink_detected == nil) and tbl6.deeplink_detected,
        prompt_styles = (tbl6 == nil or tbl6.prompt_styles == nil) and {} or tbl6.prompt_styles,
        client_attributes = (tbl6 == nil or tbl6.client_attributes == nil) and {} or tbl6.client_attributes,
        client_capabilities = if tbl6 == nil or tbl6.client_capabilities == nil then nil else tbl6.client_capabilities
    }, GetEligiblePromptsRequest))
end

function GetEligiblePromptsRequest:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.entry_points ~= nil and #self.entry_points > 0 then
        for _, entryPoint in self.entry_points do
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, entryPoint)
        end
    end

    if self.deeplink_detected then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.deeplink_detected then 1 else 0)
    end

    if self.prompt_styles ~= nil and #self.prompt_styles > 0 then
        for _, value in self.prompt_styles do
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, value)
        end
    end

    if self.client_attributes ~= nil and next(self.client_attributes) ~= nil then
        for value, value2 in self.client_attributes do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, value2)
            local var9, var10 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.client_capabilities ~= nil then
        local buf = self.client_capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetEligiblePromptsRequest.decode(buf1: buffer)
    local var1 = GetEligiblePromptsRequest.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.deeplink_detected = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.entry_points, buffer.tostring(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.prompt_styles, buffer.tostring(var4))
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetEligiblePromptsRequest_ClientAttributesEntry.decode(var4)

                var1.client_attributes[var5.key or ""] = var5.value or ""
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.client_capabilities = client_capabilities.ClientCapabilities.decode(var4)
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

function GetEligiblePromptsRequest:jsonEncode()
    local result = {}

    if self.entry_points ~= nil and #self.entry_points > 0 then
        local entryPoints = {}
        for _, entryPoint in self.entry_points do
            table.insert(entryPoints, entryPoint)
        end
        result.entryPoints = entryPoints
    end

    if self.deeplink_detected then
        result.deeplinkDetected = self.deeplink_detected
    end

    if self.prompt_styles ~= nil and #self.prompt_styles > 0 then
        local promptStyles = {}
        for _, value in self.prompt_styles do
            table.insert(promptStyles, value)
        end
        result.promptStyles = promptStyles
    end

    if self.client_attributes ~= nil and next(self.client_attributes) ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.client_attributes do
            clientAttributes[value] = value2
        end
        result.clientAttributes = clientAttributes
    end

    if self.client_capabilities ~= nil then
        result.clientCapabilities = self.client_capabilities:jsonEncode()
    end

    return result
end

function GetEligiblePromptsRequest:jsonDecode()
    local var1 = GetEligiblePromptsRequest.new()

    if self.entry_points ~= nil then
        local entryPoints = {}
        for _, entryPoint in self.entry_points do
            table.insert(entryPoints, entryPoint)
        end

        var1.entry_points = entryPoints
    end

    if self.entryPoints ~= nil then
        local entryPoints = {}
        for _, entryPoint in self.entryPoints do
            table.insert(entryPoints, entryPoint)
        end

        var1.entry_points = entryPoints
    end

    if self.deeplink_detected ~= nil then
        var1.deeplink_detected = self.deeplink_detected
    end

    if self.deeplinkDetected ~= nil then
        var1.deeplink_detected = self.deeplinkDetected
    end

    if self.prompt_styles ~= nil then
        local promptStyles = {}
        for _, value in self.prompt_styles do
            table.insert(promptStyles, value)
        end

        var1.prompt_styles = promptStyles
    end

    if self.promptStyles ~= nil then
        local promptStyles = {}
        for _, value in self.promptStyles do
            table.insert(promptStyles, value)
        end

        var1.prompt_styles = promptStyles
    end

    if self.client_attributes ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.client_attributes do
            clientAttributes[value] = value2
        end

        var1.client_attributes = clientAttributes
    end

    if self.clientAttributes ~= nil then
        local clientAttributes = ({})
        for value, value2 in self.clientAttributes do
            clientAttributes[value] = value2
        end

        var1.client_attributes = clientAttributes
    end

    if self.client_capabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.client_capabilities)
    end

    if self.clientCapabilities ~= nil then
        var1.client_capabilities = client_capabilities.ClientCapabilities.jsonDecode(self.clientCapabilities)
    end

    return var1
end

GetEligiblePromptsRequest.descriptor = {
    name = "GetEligiblePromptsRequest",
    fullName = "roblox.apppageplatform.prompts.v1beta1.GetEligiblePromptsRequest"
}

tbl1.GetEligiblePromptsRequest = GetEligiblePromptsRequest

typeRegistry.default:register(tbl1.GetEligiblePromptsRequest)

local GetEligiblePromptsRequest_ClientAttributesEntry = {}
GetEligiblePromptsRequest_ClientAttributesEntry.__index = GetEligiblePromptsRequest_ClientAttributesEntry

function GetEligiblePromptsRequest_ClientAttributesEntry.new(tbl7)
    return (setmetatable({
        key = if tbl7 == nil or tbl7.key == nil then "" else tbl7.key,
        value = if tbl7 == nil or tbl7.value == nil then "" else tbl7.value
    }, GetEligiblePromptsRequest_ClientAttributesEntry))
end

function GetEligiblePromptsRequest_ClientAttributesEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetEligiblePromptsRequest_ClientAttributesEntry.decode(buf1: buffer)
    local var1 = GetEligiblePromptsRequest_ClientAttributesEntry.new()
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.value = buffer.tostring(buf)
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

function GetEligiblePromptsRequest_ClientAttributesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetEligiblePromptsRequest_ClientAttributesEntry:jsonDecode()
    local var1 = GetEligiblePromptsRequest_ClientAttributesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetEligiblePromptsRequest_ClientAttributesEntry.descriptor = {
    name = "GetEligiblePromptsRequest_ClientAttributesEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.ClientAttributesEntry"
}

tbl1.GetEligiblePromptsRequest_ClientAttributesEntry = GetEligiblePromptsRequest_ClientAttributesEntry

typeRegistry.default:register(tbl1.GetEligiblePromptsRequest_ClientAttributesEntry)

local GetEligiblePromptsResponse = {}
GetEligiblePromptsResponse.__index = GetEligiblePromptsResponse

function GetEligiblePromptsResponse.new(tbl8)
    return (setmetatable({
        page_entries = (tbl8 == nil or tbl8.page_entries == nil) and {} or tbl8.page_entries,
        hydration_data = if tbl8 == nil or tbl8.hydration_data == nil then nil else tbl8.hydration_data,
        templates = (tbl8 == nil or tbl8.templates == nil) and {} or tbl8.templates,
        custom_prompts = (tbl8 == nil or tbl8.custom_prompts == nil) and {} or tbl8.custom_prompts,
        localized_literals = (tbl8 == nil or tbl8.localized_literals == nil) and {} or tbl8.localized_literals
    }, GetEligiblePromptsResponse))
end

function GetEligiblePromptsResponse:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.page_entries ~= nil and #self.page_entries > 0 then
        for _, value in self.page_entries do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.hydration_data ~= nil then
        local buf = self.hydration_data:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.templates ~= nil and next(self.templates) ~= nil then
        for value, value2 in self.templates do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.custom_prompts ~= nil and next(self.custom_prompts) ~= nil then
        for k, customPrompt in self.custom_prompts do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local buf = customPrompt:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        for k, localizedLiteral in self.localized_literals do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, k)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeString(var5, var6, localizedLiteral)
            local var9, var10 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetEligiblePromptsResponse.decode(buf1: buffer)
    local var1 = GetEligiblePromptsResponse.new()
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
                table.insert(var1.page_entries, page_entry_content.UniversalPageEntry.decode(var4))
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.hydration_data = hydration_content.HydrationContent.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetEligiblePromptsResponse_TemplatesEntry.decode(var4)

                local templateEntry = template_entry.TemplateEntry.new()

                var1.templates[var5.key or ""] = var5.value or templateEntry
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetEligiblePromptsResponse_CustomPromptsEntry.decode(var4)

                local customPrompt = tbl1.CustomPrompt.new()

                var1.custom_prompts[var5.key or ""] = var5.value or customPrompt
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.GetEligiblePromptsResponse_LocalizedLiteralsEntry.decode(var4)

                var1.localized_literals[var5.key or ""] = var5.value or ""
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

function GetEligiblePromptsResponse:jsonEncode()
    local result = {}

    if self.page_entries ~= nil and #self.page_entries > 0 then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, value:jsonEncode())
        end
        result.pageEntries = pageEntries
    end

    if self.hydration_data ~= nil then
        result.hydrationData = self.hydration_data:jsonEncode()
    end

    if self.templates ~= nil and next(self.templates) ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = value2:jsonEncode()
        end
        result.templates = templates
    end

    if self.custom_prompts ~= nil and next(self.custom_prompts) ~= nil then
        local customPrompts = ({})
        for k, customPrompt in self.custom_prompts do
            customPrompts[k] = customPrompt:jsonEncode()
        end
        result.customPrompts = customPrompts
    end

    if self.localized_literals ~= nil and next(self.localized_literals) ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localized_literals do
            localizedLiterals[k] = localizedLiteral
        end
        result.localizedLiterals = localizedLiterals
    end

    return result
end

function GetEligiblePromptsResponse:jsonDecode()
    local var1 = GetEligiblePromptsResponse.new()

    if self.page_entries ~= nil then
        local pageEntries = {}
        for _, value in self.page_entries do
            table.insert(pageEntries, page_entry_content.UniversalPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.pageEntries ~= nil then
        local pageEntries = {}
        for _, value in self.pageEntries do
            table.insert(pageEntries, page_entry_content.UniversalPageEntry.jsonDecode(value))
        end

        var1.page_entries = pageEntries
    end

    if self.hydration_data ~= nil then
        var1.hydration_data = hydration_content.HydrationContent.jsonDecode(self.hydration_data)
    end

    if self.hydrationData ~= nil then
        var1.hydration_data = hydration_content.HydrationContent.jsonDecode(self.hydrationData)
    end

    if self.templates ~= nil then
        local templates = ({})
        for value, value2 in self.templates do
            templates[value] = template_entry.TemplateEntry.jsonDecode(value2)
        end

        var1.templates = templates
    end

    if self.custom_prompts ~= nil then
        local customPrompts = ({})
        for k, customPrompt in self.custom_prompts do
            customPrompts[k] = tbl1.CustomPrompt.jsonDecode(customPrompt)
        end

        var1.custom_prompts = customPrompts
    end

    if self.customPrompts ~= nil then
        local customPrompts = ({})
        for k, customPrompt in self.customPrompts do
            customPrompts[k] = tbl1.CustomPrompt.jsonDecode(customPrompt)
        end

        var1.custom_prompts = customPrompts
    end

    if self.localized_literals ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localized_literals do
            localizedLiterals[k] = localizedLiteral
        end

        var1.localized_literals = localizedLiterals
    end

    if self.localizedLiterals ~= nil then
        local localizedLiterals = ({})
        for k, localizedLiteral in self.localizedLiterals do
            localizedLiterals[k] = localizedLiteral
        end

        var1.localized_literals = localizedLiterals
    end

    return var1
end

GetEligiblePromptsResponse.descriptor = {
    name = "GetEligiblePromptsResponse",
    fullName = "roblox.apppageplatform.prompts.v1beta1.GetEligiblePromptsResponse"
}

tbl1.GetEligiblePromptsResponse = GetEligiblePromptsResponse

typeRegistry.default:register(tbl1.GetEligiblePromptsResponse)

local GetEligiblePromptsResponse_TemplatesEntry = {}
GetEligiblePromptsResponse_TemplatesEntry.__index = GetEligiblePromptsResponse_TemplatesEntry

function GetEligiblePromptsResponse_TemplatesEntry.new(tbl9)
    return (setmetatable({
        key = if tbl9 == nil or tbl9.key == nil then "" else tbl9.key,
        value = if tbl9 == nil or tbl9.value == nil then nil else tbl9.value
    }, GetEligiblePromptsResponse_TemplatesEntry))
end

function GetEligiblePromptsResponse_TemplatesEntry:encode(): buffer
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

function GetEligiblePromptsResponse_TemplatesEntry.decode(buf1: buffer)
    local var1 = GetEligiblePromptsResponse_TemplatesEntry.new()
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
                var1.value = template_entry.TemplateEntry.decode(var4)
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

function GetEligiblePromptsResponse_TemplatesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetEligiblePromptsResponse_TemplatesEntry:jsonDecode()
    local var1 = GetEligiblePromptsResponse_TemplatesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = template_entry.TemplateEntry.jsonDecode(self.value)
    end

    return var1
end

GetEligiblePromptsResponse_TemplatesEntry.descriptor = {
    name = "GetEligiblePromptsResponse_TemplatesEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.TemplatesEntry"
}

tbl1.GetEligiblePromptsResponse_TemplatesEntry = GetEligiblePromptsResponse_TemplatesEntry

typeRegistry.default:register(tbl1.GetEligiblePromptsResponse_TemplatesEntry)

local GetEligiblePromptsResponse_CustomPromptsEntry = {}
GetEligiblePromptsResponse_CustomPromptsEntry.__index = GetEligiblePromptsResponse_CustomPromptsEntry

function GetEligiblePromptsResponse_CustomPromptsEntry.new(tbl10)
    return (setmetatable({
        key = if tbl10 == nil or tbl10.key == nil then "" else tbl10.key,
        value = if tbl10 == nil or tbl10.value == nil then nil else tbl10.value
    }, GetEligiblePromptsResponse_CustomPromptsEntry))
end

function GetEligiblePromptsResponse_CustomPromptsEntry:encode(): buffer
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

function GetEligiblePromptsResponse_CustomPromptsEntry.decode(buf1: buffer)
    local var1 = GetEligiblePromptsResponse_CustomPromptsEntry.new()
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
                var1.value = tbl1.CustomPrompt.decode(var4)
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

function GetEligiblePromptsResponse_CustomPromptsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function GetEligiblePromptsResponse_CustomPromptsEntry:jsonDecode()
    local var1 = GetEligiblePromptsResponse_CustomPromptsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = tbl1.CustomPrompt.jsonDecode(self.value)
    end

    return var1
end

GetEligiblePromptsResponse_CustomPromptsEntry.descriptor = {
    name = "GetEligiblePromptsResponse_CustomPromptsEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.CustomPromptsEntry"
}

tbl1.GetEligiblePromptsResponse_CustomPromptsEntry = GetEligiblePromptsResponse_CustomPromptsEntry

typeRegistry.default:register(tbl1.GetEligiblePromptsResponse_CustomPromptsEntry)

local GetEligiblePromptsResponse_LocalizedLiteralsEntry = {}
GetEligiblePromptsResponse_LocalizedLiteralsEntry.__index = GetEligiblePromptsResponse_LocalizedLiteralsEntry

function GetEligiblePromptsResponse_LocalizedLiteralsEntry.new(tbl11)
    return (setmetatable({
        key = if tbl11 == nil or tbl11.key == nil then "" else tbl11.key,
        value = if tbl11 == nil or tbl11.value == nil then "" else tbl11.value
    }, GetEligiblePromptsResponse_LocalizedLiteralsEntry))
end

function GetEligiblePromptsResponse_LocalizedLiteralsEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil and self.value ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.value)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GetEligiblePromptsResponse_LocalizedLiteralsEntry.decode(buf1: buffer)
    local var1 = GetEligiblePromptsResponse_LocalizedLiteralsEntry.new()
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
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.value = buffer.tostring(buf)
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

function GetEligiblePromptsResponse_LocalizedLiteralsEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil and self.value ~= "" then
        result.value = self.value
    end

    return result
end

function GetEligiblePromptsResponse_LocalizedLiteralsEntry:jsonDecode()
    local var1 = GetEligiblePromptsResponse_LocalizedLiteralsEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

GetEligiblePromptsResponse_LocalizedLiteralsEntry.descriptor = {
    name = "GetEligiblePromptsResponse_LocalizedLiteralsEntry",
    fullName = "roblox.apppageplatform.prompts.v1beta1.LocalizedLiteralsEntry"
}

tbl1.GetEligiblePromptsResponse_LocalizedLiteralsEntry = GetEligiblePromptsResponse_LocalizedLiteralsEntry

typeRegistry.default:register(tbl1.GetEligiblePromptsResponse_LocalizedLiteralsEntry)

return {
    CustomPrompt = tbl1.CustomPrompt,
    GetEligiblePromptsRequest = tbl1.GetEligiblePromptsRequest,
    GetEligiblePromptsResponse = tbl1.GetEligiblePromptsResponse
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_content_type = require(script.Parent.hydration_content_type)

local HydrationDataSpec = {}
HydrationDataSpec.__index = HydrationDataSpec

function HydrationDataSpec.new(tbl3)
    local tbl4 = {
        content_type = if tbl3 == nil or tbl3.content_type == nil then assert(hydration_content_type.HydrationContentType.fromNumber(0), "Enum has no 0 default") else tbl3.content_type,
        id_binding = if tbl3 == nil or tbl3.id_binding == nil then nil else tbl3.id_binding,
        alias = if tbl3 == nil or tbl3.alias == nil then "" else tbl3.alias,
        client_fetch = not (tbl3 == nil or tbl3.client_fetch == nil) and tbl3.client_fetch,
        required_fields = (tbl3 == nil or tbl3.required_fields == nil) and {} or tbl3.required_fields,
        required = not (tbl3 == nil or tbl3.required == nil) and tbl3.required,
        client_hints = (tbl3 == nil or tbl3.client_hints == nil) and {} or tbl3.client_hints
    }
    return (setmetatable(tbl4, HydrationDataSpec))
end

function HydrationDataSpec:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.content_type ~= nil
        and (self.content_type ~= nil and self.content_type ~= 0
            or self.content_type ~= hydration_content_type.HydrationContentType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, hydration_content_type.HydrationContentType.toNumber(self.content_type))
    end

    if self.id_binding ~= nil then
        local buf = self.id_binding:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.alias ~= nil and self.alias ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.alias)
    end

    if self.client_fetch then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.client_fetch then 1 else 0)
    end

    if self.required_fields ~= nil and #self.required_fields > 0 then
        for _, requiredField in self.required_fields do
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, requiredField)
        end
    end

    if self.required then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.required then 1 else 0)
    end

    if self.client_hints ~= nil and #self.client_hints > 0 then
        for _, clientHint in self.client_hints do
            local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, clientHint)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function HydrationDataSpec.decode(buf1: buffer)
    local var1 = HydrationDataSpec.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.content_type = hydration_content_type.HydrationContentType.fromNumber(var4) or var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.client_fetch = var4 ~= 0
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.required = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.id_binding = tbl1.IdBinding.decode(var4)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.alias = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.required_fields, buffer.tostring(var4))
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.client_hints, buffer.tostring(var4))
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

function HydrationDataSpec:jsonEncode()
    local result = {}

    if self.content_type ~= nil
        and (self.content_type ~= nil and self.content_type ~= 0
            or self.content_type ~= hydration_content_type.HydrationContentType.fromNumber(0))
    then
        result.contentType = if typeof(self.content_type) == "number" then self.content_type else hydration_content_type.HydrationContentType.toNumber(self.content_type)
    end

    if self.id_binding ~= nil then
        result.idBinding = self.id_binding:jsonEncode()
    end

    if self.alias ~= nil and self.alias ~= "" then
        result.alias = self.alias
    end

    if self.client_fetch then
        result.clientFetch = self.client_fetch
    end

    if self.required_fields ~= nil and #self.required_fields > 0 then
        local requiredFields = {}
        for _, requiredField in self.required_fields do
            table.insert(requiredFields, requiredField)
        end
        result.requiredFields = requiredFields
    end

    if self.required then
        result.required = self.required
    end

    if self.client_hints ~= nil and #self.client_hints > 0 then
        local clientHints = {}
        for _, clientHint in self.client_hints do
            table.insert(clientHints, clientHint)
        end
        result.clientHints = clientHints
    end

    return result
end

function HydrationDataSpec:jsonDecode()
    local var1 = HydrationDataSpec.new()

    if self.content_type ~= nil then
        var1.content_type = if typeof(self.content_type) == "number" then hydration_content_type.HydrationContentType.fromNumber(self.content_type) or self.content_type else hydration_content_type.HydrationContentType.fromName(self.content_type) or self.content_type
    end

    if self.contentType ~= nil then
        var1.content_type = if typeof(self.contentType) == "number" then hydration_content_type.HydrationContentType.fromNumber(self.contentType) or self.contentType else hydration_content_type.HydrationContentType.fromName(self.contentType) or self.contentType
    end

    if self.id_binding ~= nil then
        var1.id_binding = tbl1.IdBinding.jsonDecode(self.id_binding)
    end

    if self.idBinding ~= nil then
        var1.id_binding = tbl1.IdBinding.jsonDecode(self.idBinding)
    end

    if self.alias ~= nil then
        var1.alias = self.alias
    end

    if self.client_fetch ~= nil then
        var1.client_fetch = self.client_fetch
    end

    if self.clientFetch ~= nil then
        var1.client_fetch = self.clientFetch
    end

    if self.required_fields ~= nil then
        local requiredFields = {}
        for _, requiredField in self.required_fields do
            table.insert(requiredFields, requiredField)
        end

        var1.required_fields = requiredFields
    end

    if self.requiredFields ~= nil then
        local requiredFields = {}
        for _, requiredField in self.requiredFields do
            table.insert(requiredFields, requiredField)
        end

        var1.required_fields = requiredFields
    end

    if self.required ~= nil then
        var1.required = self.required
    end

    if self.client_hints ~= nil then
        local clientHints = {}
        for _, clientHint in self.client_hints do
            table.insert(clientHints, clientHint)
        end

        var1.client_hints = clientHints
    end

    if self.clientHints ~= nil then
        local clientHints = {}
        for _, clientHint in self.clientHints do
            table.insert(clientHints, clientHint)
        end

        var1.client_hints = clientHints
    end

    return var1
end

HydrationDataSpec.descriptor = {
    name = "HydrationDataSpec",
    fullName = "roblox.apppageplatform.shared.v1beta1.HydrationDataSpec"
}

tbl1.HydrationDataSpec = HydrationDataSpec

typeRegistry.default:register(tbl1.HydrationDataSpec)

local IdBinding = {}
IdBinding.__index = IdBinding

function IdBinding.new(tbl4)
    return (setmetatable({ kind = if tbl4 == nil or tbl4.kind == nil then nil else tbl4.kind }, IdBinding))
end

function IdBinding:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        elseif self.kind.type == "input_path" then
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, self.kind.value)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function IdBinding.decode(buf1: buffer)
    local var1 = IdBinding.new()
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
                    type = "input_path",
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

function IdBinding:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "literal" then
            result.literal = self.kind.value
            return result
        end

        if self.kind.type == "input_path" then
            result.inputPath = self.kind.value
        end
    end

    return result
end

function IdBinding.jsonDecode(tbl4)
    local var1 = IdBinding.new()

    if tbl4.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl4.literal
        }
    end
    if tbl4.input_path ~= nil then
        var1.kind = {
            type = "input_path",
            value = tbl4.input_path
        }
    end
    if tbl4.inputPath ~= nil then
        var1.kind = {
            type = "input_path",
            value = tbl4.inputPath
        }
    end
    return var1
end

IdBinding.descriptor = {
    name = "IdBinding",
    fullName = "roblox.apppageplatform.shared.v1beta1.IdBinding"
}

tbl1.IdBinding = IdBinding

typeRegistry.default:register(tbl1.IdBinding)

return {
    HydrationDataSpec = tbl1.HydrationDataSpec,
    IdBinding = tbl1.IdBinding
}
